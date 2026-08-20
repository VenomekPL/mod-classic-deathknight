#ifndef MOD_CLASSIC_DEATH_KNIGHT_H
#define MOD_CLASSIC_DEATH_KNIGHT_H

#include "SharedDefines.h"
#include <unordered_map>
#include <vector>

class Player;
class Unit;

struct SpellInfo;

struct ClassicDkSpellEntry
{
    uint32 spellId;
    uint8 level;
    uint8 requiresProgression;
};

class ClassicDeathKnightMgr
{
public:
    static ClassicDeathKnightMgr* instance();

    void LoadSpellProgression();
    void ClearAcherusOutfits();
    void ApplyProgression(Player* player, bool onLogin);
    void EnsureImmediateWeaponProficiencies(Player* player);
    void SanitizeStarterGear(Player* player);
    void SanitizeFirstAid(Player* player);
    void SanitizeTaxiNodes(Player* player);
    void EnsureDkWorldAccessQuests(Player* player);
    void EnsureDarkRiderSigil(Player* player);
    bool HasWotlkAccess(Player* player) const;
    uint8 GetPlayerProgression(Player* player) const;
    float GetDamageScaleMultiplier(uint8 playerLevel) const;
    bool ShouldScaleSpell(Unit const* caster, SpellInfo const* spellInfo) const;

private:
    void PurgeOrphanTalentRanks(Player* player) const;

    std::unordered_map<uint32, ClassicDkSpellEntry> _spells;
    std::vector<uint32> _allSpellIds;
};

#define sClassicDeathKnight ClassicDeathKnightMgr::instance()

#endif
