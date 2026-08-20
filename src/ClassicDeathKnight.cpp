#include "ClassicDeathKnight.h"
#include "Chat.h"
#include "Configuration/Config.h"
#include "DatabaseEnv.h"
#include "DBCStores.h"
#include "IndividualProgression.h"
#include "Item.h"
#include "Mail.h"
#include "Player.h"
#include "SpellInfo.h"
#include "SpellMgr.h"
#include "PlayerTaxi.h"
#include "StringConvert.h"
#include "Tokenize.h"
#include <sstream>

namespace
{
uint32 const AcherusStarterItemIds[] = {
    38145, 34652, 34655, 34659, 34650, 34653, 34649, 34651, 34656, 34648,
    34657, 34658, 38147, 41751, 40582, 34666, 34667,
};

uint16 const ImmediateDkWeaponSkills[] = {
    SKILL_POLEARMS,
    SKILL_SWORDS,
    SKILL_2H_SWORDS,
    SKILL_AXES,
    SKILL_2H_AXES,
};

// Stock core gates LFG (and similar) until a DK completes the post-Acherus finale.
uint32 const DkWorldAccessQuestIds[] = {
    13188, // Where Kings Walk (Alliance)
    13189, // Saurfang's Blessing (Horde)
};

// Skipped Acherus quest 12687 rewards this sigil. Credit that quest once so we never re-mail.
uint32 const ITEM_SIGIL_OF_THE_DARK_RIDER = 39208;
uint32 const QUEST_INTO_THE_REALM_OF_SHADOWS = 12687;
uint32 const NPC_SALANAR_THE_HORSEMAN = 28653;
uint8 const DARK_RIDER_SIGIL_LEVEL = 55;

// Talent Rank 1 IDs for DK abilities that have trainer rank upgrades.
// Used to strip orphan ranks when the talent was never spent.
uint32 const DkTalentChainFirstRanks[] = {
    49020, // Obliterate
    49143, // Frost Strike
    55050, // Heart Strike
    49158, // Corpse Explosion
    49184, // Howling Blast
    55090, // Scourge Strike
};

bool PlayerHasTalentSpell(Player const* player, uint32 spellId)
{
    for (uint8 spec = 0; spec < MAX_TALENT_SPECS; ++spec)
        if (player->HasTalent(spellId, spec))
            return true;

    return false;
}

bool IsTalentChainSpell(uint32 spellId)
{
    uint32 const firstId = sSpellMgr->GetFirstSpellInChain(spellId);
    return GetTalentSpellCost(firstId) > 0;
}

// Warrior-equivalent starter clothes per race (shirt/harness + pants + boots).
// Torso coverage uses the Shirt slot (6125 Brawler's Harness, Recruit's Shirt, etc.) — same as warriors.
std::vector<uint32> GetStarterClothItemIds(uint8 race)
{
    switch (race)
    {
        case RACE_HUMAN:
        case RACE_DWARF:
        case RACE_GNOME:
            return {38, 39, 40};
        case RACE_ORC:
        case RACE_UNDEAD_PLAYER:
        case RACE_TAUREN:
        case RACE_TROLL:
            return {6125, 139, 140};
        case RACE_NIGHTELF:
            return {6120, 6121, 6122};
        case RACE_BLOODELF:
            return {24143, 24145, 24146};
        case RACE_DRAENEI:
            return {23473, 23474, 23475};
        default:
            return {38, 39, 40};
    }
}

uint32 GetStarterWeaponForRace(uint8 race)
{
    switch (race)
    {
        case RACE_HUMAN:   return 49778;
        case RACE_ORC:     return 12282;
        case RACE_DWARF:   return 12282;
        case RACE_NIGHTELF: return 49778;
        case RACE_UNDEAD_PLAYER: return 49778;
        case RACE_TAUREN: return 49778;
        case RACE_GNOME:   return 49778;
        case RACE_TROLL:   return 12282;
        case RACE_BLOODELF: return 23346;
        case RACE_DRAENEI: return 23346;
        default:           return 49778;
    }
}

void ApplyClassicDkRaceStarterTaxiNodes(Player* player)
{
    if (!player)
        return;

    switch (player->getRace())
    {
        case RACE_HUMAN:
            player->m_taxi.SetTaximaskNode(2);
            break;
        case RACE_ORC:
            player->m_taxi.SetTaximaskNode(23);
            break;
        case RACE_DWARF:
            player->m_taxi.SetTaximaskNode(6);
            break;
        case RACE_NIGHTELF:
            player->m_taxi.SetTaximaskNode(26);
            player->m_taxi.SetTaximaskNode(27);
            break;
        case RACE_UNDEAD_PLAYER:
            player->m_taxi.SetTaximaskNode(11);
            break;
        case RACE_TAUREN:
            player->m_taxi.SetTaximaskNode(22);
            break;
        case RACE_GNOME:
            player->m_taxi.SetTaximaskNode(6);
            break;
        case RACE_TROLL:
            player->m_taxi.SetTaximaskNode(23);
            break;
        case RACE_BLOODELF:
            player->m_taxi.SetTaximaskNode(82);
            break;
        case RACE_DRAENEI:
            player->m_taxi.SetTaximaskNode(94);
            break;
        default:
            break;
    }

    switch (Player::TeamIdForRace(player->getRace()))
    {
        case TEAM_ALLIANCE:
            player->m_taxi.SetTaximaskNode(100);
            break;
        case TEAM_HORDE:
            player->m_taxi.SetTaximaskNode(99);
            break;
        default:
            break;
    }

    if (player->GetLevel() >= 68)
        player->m_taxi.SetTaximaskNode(213);
}
}

ClassicDeathKnightMgr* ClassicDeathKnightMgr::instance()
{
    static ClassicDeathKnightMgr instance;
    return &instance;
}

void ClassicDeathKnightMgr::LoadSpellProgression()
{
    _spells.clear();
    _allSpellIds.clear();

    QueryResult result = WorldDatabase.Query(
        "SELECT spell_id, level, requires_progression FROM classic_dk_spell_progression");

    if (!result)
    {
        LOG_WARN("module", "ClassicDeathKnight: classic_dk_spell_progression table empty or missing");
        return;
    }

    do
    {
        Field* fields = result->Fetch();
        ClassicDkSpellEntry entry;
        entry.spellId = fields[0].Get<uint32>();
        entry.level = fields[1].Get<uint8>();
        entry.requiresProgression = fields[2].Get<uint8>();
        _spells[entry.spellId] = entry;
        _allSpellIds.push_back(entry.spellId);
    } while (result->NextRow());

    LOG_INFO("module", "ClassicDeathKnight: loaded {} spell progression entries", _spells.size());
}

void ClassicDeathKnightMgr::ClearAcherusOutfits()
{
    uint32 cleared = 0;
    for (CharStartOutfitEntry const* outfit : sCharStartOutfitStore)
    {
        if (!outfit || outfit->Class != CLASS_DEATH_KNIGHT)
            continue;

        CharStartOutfitEntry* mutableOutfit = const_cast<CharStartOutfitEntry*>(outfit);
        for (uint8 slot = 0; slot < MAX_OUTFIT_ITEMS; ++slot)
            mutableOutfit->ItemId[slot] = 0;

        ++cleared;
    }

    if (cleared)
        LOG_INFO("module", "ClassicDeathKnight: cleared Acherus CharStartOutfit for {} DK entries", cleared);
}

uint8 ClassicDeathKnightMgr::GetPlayerProgression(Player* player) const
{
    if (!player)
        return 0;

    if (sIndividualProgression && sIndividualProgression->enabled)
        return sIndividualProgression->GetPlayerProgressionFromQuests(player);

    return 0;
}

bool ClassicDeathKnightMgr::HasWotlkAccess(Player* player) const
{
    if (!player)
        return false;

    if (player->IsGameMaster())
        return true;

    uint8 required = static_cast<uint8>(sConfigMgr->GetOption<int32>("ClassicDeathKnight.WotlkProgressionStage", 13));

    if (sIndividualProgression && sIndividualProgression->enabled)
        return sIndividualProgression->hasPassedProgression(player, static_cast<ProgressionState>(required));

    return GetPlayerProgression(player) >= required;
}

void ClassicDeathKnightMgr::ApplyProgression(Player* player, bool onLogin)
{
    if (!player || !player->IsInWorld())
        return;

    if (!player->IsClass(CLASS_DEATH_KNIGHT, CLASS_CONTEXT_INIT))
        return;

    if (!sConfigMgr->GetOption<bool>("ClassicDeathKnight.Enable", true))
        return;

    if (_spells.empty())
        LoadSpellProgression();

    uint8 level = player->GetLevel();
    uint8 progression = GetPlayerProgression(player);
    uint8 plateLevel = static_cast<uint8>(sConfigMgr->GetOption<int32>("ClassicDeathKnight.PlateSkillLevel", 40));

    if (level >= plateLevel && !player->HasSkill(SKILL_PLATE_MAIL))
        player->SetSkill(SKILL_PLATE_MAIL, 0, 1, player->GetMaxSkillValueForLevel());

    for (uint32 spellId : _allSpellIds)
    {
        ClassicDkSpellEntry const& entry = _spells[spellId];
        bool allowed = level >= entry.level && progression >= entry.requiresProgression;

        // Talent abilities / ranks are never auto-granted from the progression table.
        if (IsTalentChainSpell(spellId))
            allowed = false;

        if (allowed)
        {
            if (!player->HasSpell(spellId))
                player->learnSpell(spellId, false);
        }
        else if (player->HasSpell(spellId))
            player->removeSpell(spellId, SPEC_MASK_ALL, false);
    }

    PurgeOrphanTalentRanks(player);
    EnsureDarkRiderSigil(player);

    if (onLogin && sConfigMgr->GetOption<bool>("ClassicDeathKnight.Announce", false))
        ChatHandler(player->GetSession()).SendSysMessage("|cffC41E3AClassic Death Knight|r progression active.");
}

void ClassicDeathKnightMgr::EnsureDarkRiderSigil(Player* player)
{
    if (!player || player->GetLevel() < DARK_RIDER_SIGIL_LEVEL)
        return;

    if (player->IsQuestRewarded(QUEST_INTO_THE_REALM_OF_SHADOWS))
        return;

    // Already own one (quest, GM, or prior mail) — mark once so we never send again.
    if (player->HasItemCount(ITEM_SIGIL_OF_THE_DARK_RIDER, 1, true))
    {
        player->SetRewardedQuest(QUEST_INTO_THE_REALM_OF_SHADOWS);
        return;
    }

    Item* item = Item::CreateItem(ITEM_SIGIL_OF_THE_DARK_RIDER, 1, player);
    if (!item)
    {
        LOG_ERROR("module", "ClassicDeathKnight: failed to create Sigil of the Dark Rider for {}",
            player->GetGUID().ToString());
        return;
    }

    CharacterDatabaseTransaction trans = CharacterDatabase.BeginTransaction();
    item->SaveToDB(trans);

    MailDraft draft("Sigil of the Dark Rider",
        "Death knight,$B$BThe runeblade is only half of your armament. Take this sigil — "
        "the same gift the Dark Rider would have given you in the Realm of Shadows.$B$B"
        "It strengthens Blood Strike and Heart Strike.$B$BSalanar the Horseman");
    draft.AddItem(item);
    draft.SendMailTo(trans, MailReceiver(player, player->GetGUID().GetCounter()),
        MailSender(MAIL_CREATURE, NPC_SALANAR_THE_HORSEMAN), MAIL_CHECK_MASK_HAS_BODY);

    CharacterDatabase.CommitTransaction(trans);
    player->SetRewardedQuest(QUEST_INTO_THE_REALM_OF_SHADOWS);

    if (player->GetSession())
        ChatHandler(player->GetSession()).SendSysMessage(
            "|cffC41E3AClassic Death Knight|r A letter from Salanar the Horseman has arrived.");
}

void ClassicDeathKnightMgr::PurgeOrphanTalentRanks(Player* player) const
{
    if (!player)
        return;

    for (uint32 firstId : DkTalentChainFirstRanks)
    {
        if (PlayerHasTalentSpell(player, firstId))
            continue;

        for (uint32 spellId = firstId; spellId; spellId = sSpellMgr->GetNextSpellInChain(spellId))
        {
            if (player->HasSpell(spellId))
                player->removeSpell(spellId, SPEC_MASK_ALL, false);
        }
    }
}

float ClassicDeathKnightMgr::GetDamageScaleMultiplier(uint8 playerLevel) const
{
    if (!sConfigMgr->GetOption<bool>("ClassicDeathKnight.Enable", true))
        return 1.0f;

    if (!sConfigMgr->GetOption<bool>("ClassicDeathKnight.DamageScaleEnable", true))
        return 1.0f;

    uint8 fullLevel = static_cast<uint8>(sConfigMgr->GetOption<int32>("ClassicDeathKnight.DamageScaleFullLevel", 60));
    float minMult = sConfigMgr->GetOption<float>("ClassicDeathKnight.DamageScaleMinMultiplier", 0.10f);

    if (fullLevel <= 1)
        return 1.0f;

    if (playerLevel >= fullLevel)
        return 1.0f;

    if (playerLevel <= 1)
        return minMult;

    float progress = float(playerLevel - 1) / float(fullLevel - 1);
    return minMult + (1.0f - minMult) * progress;
}

bool ClassicDeathKnightMgr::ShouldScaleSpell(Unit const* caster, SpellInfo const* spellInfo) const
{
    if (!spellInfo || spellInfo->SpellFamilyName != SPELLFAMILY_DEATHKNIGHT)
        return false;

    if (!caster || !caster->IsPlayer())
        return false;

    Player const* player = caster->ToPlayer();
    if (!player->IsClass(CLASS_DEATH_KNIGHT, CLASS_CONTEXT_ABILITY))
        return false;

    if (player->GetLevel() > 60)
        return false;

    return sConfigMgr->GetOption<bool>("ClassicDeathKnight.Enable", true)
        && sConfigMgr->GetOption<bool>("ClassicDeathKnight.DamageScaleEnable", true);
}

void ClassicDeathKnightMgr::EnsureImmediateWeaponProficiencies(Player* player)
{
    if (!player || !player->IsClass(CLASS_DEATH_KNIGHT, CLASS_CONTEXT_INIT))
        return;

    if (player->GetLevel() > 60)
        return;

    for (uint16 skill : ImmediateDkWeaponSkills)
    {
        if (!player->HasSkill(skill))
            player->SetSkill(skill, 0, 1, player->GetMaxSkillValueForLevel());
    }
}

void ClassicDeathKnightMgr::SanitizeStarterGear(Player* player)
{
    if (!player)
        return;

    if (!player->IsClass(CLASS_DEATH_KNIGHT, CLASS_CONTEXT_INIT))
        return;

    if (player->GetLevel() > 60)
        return;

    for (uint32 itemId : AcherusStarterItemIds)
    {
        uint32 count = player->GetItemCount(itemId, true);
        if (count)
            player->DestroyItemCount(itemId, count, true);
    }

    EnsureImmediateWeaponProficiencies(player);

    // Only fill empty equipment slots — do not duplicate pants/boots when the player wears real gear.
    static uint8 const starterClothSlots[] = {
        EQUIPMENT_SLOT_BODY,
        EQUIPMENT_SLOT_LEGS,
        EQUIPMENT_SLOT_FEET,
    };

    std::vector<uint32> const& starterClothes = GetStarterClothItemIds(player->getRace());
    size_t const slotCount = sizeof(starterClothSlots) / sizeof(starterClothSlots[0]);
    for (size_t i = 0; i < starterClothes.size() && i < slotCount; ++i)
    {
        if (player->GetItemByPos(INVENTORY_SLOT_BAG_0, starterClothSlots[i]))
            continue;

        uint32 itemId = starterClothes[i];
        if (!player->GetItemCount(itemId, true))
            player->StoreNewItemInBestSlots(itemId, 1);
    }

    if (!player->GetItemByPos(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_MAINHAND))
    {
        uint32 weaponId = GetStarterWeaponForRace(player->getRace());
        if (weaponId)
            player->StoreNewItemInBestSlots(weaponId, 1);
    }
}

void ClassicDeathKnightMgr::SanitizeFirstAid(Player* player)
{
    if (!player)
        return;

    if (!player->IsClass(CLASS_DEATH_KNIGHT, CLASS_CONTEXT_INIT))
        return;

    if (player->GetLevel() > 60)
        return;

    constexpr uint16 skillId = SKILL_FIRST_AID;

    // WotLK DK bootstrap grants artisan First Aid; classic DKs must learn it from scratch.
    for (SkillLineAbilityEntry const* ability : GetSkillLineAbilitiesBySkillLine(skillId))
    {
        if (!ability || !ability->Spell)
            continue;

        uint32 spellId = sSpellMgr->GetFirstSpellInChain(ability->Spell);
        if (player->HasSpell(spellId))
            player->removeSpell(spellId, SPEC_MASK_ALL, false);
    }

    if (player->HasSkill(skillId))
        player->SetSkill(skillId, 0, 0, 0);
}

void ClassicDeathKnightMgr::SanitizeTaxiNodes(Player* player)
{
    if (!player)
        return;

    if (!player->IsClass(CLASS_DEATH_KNIGHT, CLASS_CONTEXT_INIT))
        return;

    if (player->GetLevel() > 60)
        return;

    std::ostringstream currentMask;
    currentMask << player->m_taxi;

    TaxiMask cleaned{};
    cleaned.fill(0);

    std::string maskString = currentMask.str();
    std::vector<std::string_view> tokens = Acore::Tokenize(maskString, ' ', false);
    for (uint8 i = 0; i < TaxiMaskSize; ++i)
    {
        uint32 value = 0;
        if (i < tokens.size())
            value = Acore::StringTo<uint32>(tokens[i]).value_or(0);

        cleaned[i] = value & ~sOldContinentsNodesMask[i];
    }

    std::ostringstream cleanedMask;
    for (uint8 i = 0; i < TaxiMaskSize; ++i)
        cleanedMask << cleaned[i] << ' ';

    std::string cleanedMaskString = cleanedMask.str();
    player->m_taxi.LoadTaxiMask(cleanedMaskString);
    ApplyClassicDkRaceStarterTaxiNodes(player);
}

void ClassicDeathKnightMgr::EnsureDkWorldAccessQuests(Player* player)
{
    if (!player || player->IsGameMaster())
        return;

    if (!sConfigMgr->GetOption<bool>("ClassicDeathKnight.Enable", true))
        return;

    if (!player->IsClass(CLASS_DEATH_KNIGHT, CLASS_CONTEXT_INIT))
        return;

    uint8 classicCap = static_cast<uint8>(sConfigMgr->GetOption<int32>("ClassicDeathKnight.DamageScaleFullLevel", 60));
    if (player->GetLevel() > classicCap)
        return;

    for (uint32 questId : DkWorldAccessQuestIds)
    {
        if (!sConfigMgr->GetOption<bool>("ClassicDeathKnight.AllowDungeonFinder", true))
            break;

        if (player->IsQuestRewarded(questId))
            continue;

        // Credit only — no XP, gold, or items (RewardQuest would grant rewards).
        player->SetRewardedQuest(questId);
    }
}
