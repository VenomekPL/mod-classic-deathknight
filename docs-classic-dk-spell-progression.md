# Classic Death Knight spell progression

Source of truth: `classic_dk_spell_progression` table (`data/sql/updates/db_world/`).

This module loads the table and learns/unlearns spells on login and level-up via `ApplyProgression()`.

## Designed cutoffs

| System | Ends | Notes |
|--------|------|-------|
| Dense baseline ranks in progression table | ~L54 | Icy Touch / Plague Strike / etc. rank upgrades |
| `mod-learn-spells` | MaxLevel **55** | 56–80 = class trainers only |
| Quest-skip specials | L55 / L60 | Death Gate + Runeforging at 55; Army, riding, Deathcharger at 60 |

World DK trainers (template **130**) are in racial starts and major capitals (Stormwind, Ironforge, Orgrimmar, Undercity, Darnassus, Thunder Bluff, Exodar, Silvermoon). They are **not** WotLK-gated.

## Talent abilities (never auto-granted)

Talent Rank 1 comes from the talent tree. Higher ranks are trained only after `ReqAbility1` on that talent Rank 1.

Do **not** put these (or their ranks) in `classic_dk_spell_progression`:

- Frost Strike, Obliterate, Heart Strike, Corpse Explosion, Howling Blast, Scourge Strike

`ApplyProgression` refuses talent-chain spells even if they appear in the table, and purges orphan ranks on login when the talent Rank 1 was never spent. Obliterate Rank 1 is also excluded from trainer 130 (talent only).

## Level 1–46 core abilities

| Level | Spell | ID |
|------:|-------|-----|
| 1 | Icy Touch, Plague Strike | 45477, 45462 |
| 4 | Blood Strike | 45902 |
| 6 | Death Coil | 47541 |
| 8 | Death Grip | 49576 |
| 10 | Blood Presence, Dual Wield | 48266, 674 |
| 12 | Raise Dead | 46584 |
| 14 | Pestilence | 50842 |
| 16 | Mind Freeze | 47528 |
| 18 | Frost Presence | 48263 |
| 20 | Chains of Ice | 45524 |
| 22 | Strangulate | 47476 |
| 24 | Death Strike | 49998 |
| 26 | Blood Boil | 48721 |
| 28 | Death and Decay | 43265 |
| 30 | Path of Frost | 3714 |
| 32 | Icebound Fortitude | 48792 |
| 34 | Dark Command | 56222 |
| 36 | Horn of Winter | 57330 |
| 38 | Death Pact | 48743 |
| 40 | Anti-Magic Shell | 48707 |
| 42 | Unholy Presence | 48265 |
| 44 | Empower Rune Weapon | 47568 |
| 46 | Raise Ally | 61999 |

## Level 60 mount and riding (Acherus quests skipped)

Stand-ins for skipped quest **12687** (Deathcharger + Journeyman Riding). Runeforging at L55 stands in for quest **12619** (same level as Death Gate).

| Level | Spell | ID |
|------:|-------|-----|
| 60 | Apprentice Riding (prerequisite for Journeyman) | 33388 |
| 60 | Journeyman Riding | 33391 |
| 60 | Acherus Deathcharger (100% class mount) | 48778 |

## Death Gate and Acherus (level 55)

Acherus is not IP-gated (`ClassicDeathKnight.GateAcherus = 0`). The citadel is in the world; dying nearby already spirit-rezzes there. Runeforging and Death Gate are auto-taught together at 55.

| Level | Spell / item | ID |
|------:|--------------|-----|
| 55 | Runeforging (quest **12619** stand-in) | 53428 |
| 55 | Death Gate (quest **12801** stand-in) | 50977 |
| 55 | Sigil of the Dark Rider mailed once (quest **12687** stand-in) | 39208 |

The sigil mail is sent on login or level-up at 55+. Once-only is stored by crediting quest 12687 (no XP/mount). Existing 55+ DKs who never completed that quest get the letter on next login. Effect: +90 Blood Strike / Heart Strike damage.

## Progression-gated (requires Individual Progression stage 13)

`ClassicDeathKnight.WotlkProgressionStage = 13` still gates Army of the Dead. World trainers remain available earlier.

| Level | Spell | ID |
|------:|-------|-----|
| 60 | Army of the Dead (remapped trainer spell, not a quest reward) | 42650 |

## Damage scaling

WotLK Death Knight spell IDs are balanced for level 55+ heroes. Classic DKs learn them from level 1, so `mod-classic-deathknight` scales spell damage, DoT ticks, and DK heals by player level:

- Level 1: ~10% of stock damage (configurable via `ClassicDeathKnight.DamageScaleMinMultiplier`)
- Level 60: 100% (full WotLK values, `ClassicDeathKnight.DamageScaleFullLevel`)

Baseline rank upgrades for strikes, coils, and runes are mapped to levels 50–54 in the same table. Trainer template **130** mirrors these levels for manual training.

Regenerate SQL: `python3 tools/generate-classic-dk-sql.py`.
