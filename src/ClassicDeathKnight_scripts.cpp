#include "ClassicDeathKnight.h"
#include "AllSpellScript.h"
#include "AreaDefines.h"
#include "Chat.h"
#include "Configuration/Config.h"
#include "IndividualProgression.h"
#include "Player.h"
#include "ScriptMgr.h"
#include "Spell.h"
#include "SpellInfo.h"
#include "SpellMgr.h"
#include "UnitScript.h"
#include <cmath>

namespace
{
void ApplyClassicDkAmountScale(Unit const* attacker, int32& amount)
{
    if (amount <= 0)
        return;

    float mult = sClassicDeathKnight->GetDamageScaleMultiplier(attacker->GetLevel());
    amount = static_cast<int32>(std::lround(amount * mult));
    if (amount < 1)
        amount = 1;
}

void ApplyClassicDkAmountScale(Unit const* attacker, uint32& amount)
{
    int32 scaled = static_cast<int32>(amount);
    ApplyClassicDkAmountScale(attacker, scaled);
    amount = static_cast<uint32>(scaled);
}
}

enum ClassicDkSpells
{
    SPELL_DEATH_GATE         = 50977,
    SPELL_DEATH_GATE_TRIGGER = 52751,
};

class ClassicDeathKnight_PlayerScript : public PlayerScript
{
public:
    ClassicDeathKnight_PlayerScript() : PlayerScript("ClassicDeathKnight_PlayerScript") { }

    void OnPlayerCreate(Player* player) override
    {
        if (!sConfigMgr->GetOption<bool>("ClassicDeathKnight.Enable", true))
            return;

        sClassicDeathKnight->SanitizeStarterGear(player);
        sClassicDeathKnight->SanitizeFirstAid(player);
        sClassicDeathKnight->SanitizeTaxiNodes(player);
        sClassicDeathKnight->EnsureDkWorldAccessQuests(player);

        // Character is saved before OnPlayerCreate; persist create-time fixes.
        player->SaveToDB(false, false);
    }

    void OnPlayerLogin(Player* player) override
    {
        if (!sConfigMgr->GetOption<bool>("ClassicDeathKnight.Enable", true))
            return;

        sClassicDeathKnight->EnsureDkWorldAccessQuests(player);
        sClassicDeathKnight->ApplyProgression(player, true);
    }

    void OnPlayerLevelChanged(Player* player, uint8 /*oldLevel*/) override
    {
        if (!sConfigMgr->GetOption<bool>("ClassicDeathKnight.Enable", true))
            return;

        sClassicDeathKnight->ApplyProgression(player, false);
    }

    void OnPlayerMapChanged(Player* player) override
    {
        if (!sConfigMgr->GetOption<bool>("ClassicDeathKnight.Enable", true))
            return;

        if (!player || !player->IsClass(CLASS_DEATH_KNIGHT, CLASS_CONTEXT_INIT))
            return;

        if (player->GetMapId() != MAP_EBON_HOLD || player->IsGameMaster())
            return;

        if (sClassicDeathKnight->HasWotlkAccess(player))
            return;

        player->TeleportTo(player->m_homebindMapId, player->m_homebindX, player->m_homebindY,
            player->m_homebindZ, player->GetOrientation());
        ChatHandler(player->GetSession()).SendSysMessage(
            "The path to Acherus is sealed until you complete The Burning Crusade progression.");
    }
};

class ClassicDeathKnight_WorldScript : public WorldScript
{
public:
    ClassicDeathKnight_WorldScript() : WorldScript("ClassicDeathKnight_WorldScript") { }

    void OnStartup() override
    {
        if (!sConfigMgr->GetOption<bool>("ClassicDeathKnight.Enable", true))
            return;

        sClassicDeathKnight->ClearAcherusOutfits();
    }

    void OnAfterConfigLoad(bool /*reload*/) override
    {
        if (sConfigMgr->GetOption<bool>("ClassicDeathKnight.Enable", true))
            sClassicDeathKnight->LoadSpellProgression();
    }
};

class ClassicDeathKnight_AllSpellScript : public AllSpellScript
{
public:
    ClassicDeathKnight_AllSpellScript() : AllSpellScript("ClassicDeathKnight_AllSpellScript") { }

    void OnSpellCheckCast(Spell* spell, bool /*strict*/, SpellCastResult& res) override
    {
        if (!sConfigMgr->GetOption<bool>("ClassicDeathKnight.Enable", true))
            return;

        if (!spell || res != SPELL_CAST_OK)
            return;

        SpellInfo const* spellInfo = spell->GetSpellInfo();
        if (!spellInfo)
            return;

        uint32 spellId = spellInfo->Id;
        if (spellId != SPELL_DEATH_GATE && spellId != SPELL_DEATH_GATE_TRIGGER)
            return;

        Unit* caster = spell->GetCaster();
        if (!caster || !caster->IsPlayer())
            return;

        Player* player = caster->ToPlayer();
        if (player->IsGameMaster())
            return;

        if (!player->IsClass(CLASS_DEATH_KNIGHT, CLASS_CONTEXT_ABILITY))
            return;

        if (sClassicDeathKnight->HasWotlkAccess(player))
            return;

        ChatHandler(player->GetSession()).SendSysMessage(
            "The path to Acherus is sealed until you complete The Burning Crusade progression.");
        res = SPELL_FAILED_TRY_AGAIN;
    }
};

class ClassicDeathKnight_UnitScript : public UnitScript
{
public:
    ClassicDeathKnight_UnitScript() : UnitScript("ClassicDeathKnight_UnitScript", true,
        { UNITHOOK_MODIFY_SPELL_DAMAGE_TAKEN, UNITHOOK_MODIFY_PERIODIC_DAMAGE_AURAS_TICK, UNITHOOK_MODIFY_HEAL_RECEIVED }) { }

    void ModifySpellDamageTaken(Unit* /*target*/, Unit* attacker, int32& damage, SpellInfo const* spellInfo) override
    {
        if (!attacker || !spellInfo || !sClassicDeathKnight->ShouldScaleSpell(attacker, spellInfo))
            return;

        ApplyClassicDkAmountScale(attacker, damage);
    }

    void ModifyPeriodicDamageAurasTick(Unit* /*target*/, Unit* attacker, uint32& damage, SpellInfo const* spellInfo) override
    {
        if (!attacker || !spellInfo || !sClassicDeathKnight->ShouldScaleSpell(attacker, spellInfo))
            return;

        ApplyClassicDkAmountScale(attacker, damage);
    }

    void ModifyHealReceived(Unit* /*target*/, Unit* healer, uint32& heal, SpellInfo const* spellInfo) override
    {
        if (!healer || !spellInfo || !sClassicDeathKnight->ShouldScaleSpell(healer, spellInfo))
            return;

        ApplyClassicDkAmountScale(healer, heal);
    }
};

void AddClassicDeathKnightScripts()
{
    new ClassicDeathKnight_PlayerScript();
    new ClassicDeathKnight_WorldScript();
    new ClassicDeathKnight_AllSpellScript();
    new ClassicDeathKnight_UnitScript();
}
