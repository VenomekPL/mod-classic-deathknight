# Classic Death Knight spell progression

Source of truth: `classic_dk_spell_progression` table (see `data/sql/custom/db_world/2026_07_11_04_classic_dk_spell_progression.sql`).

The `mod-classic-deathknight` module (source: `custom-modules/mod-classic-deathknight/`) loads this table and learns/unlearns spells on login and level-up.

## Level 1–48 core abilities

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
| 48 | Runeforging | 53428 |

## Level 60 mount and riding (Acherus quests skipped)

| Level | Spell | ID |
|------:|-------|-----|
| 60 | Apprentice Riding (prerequisite for Journeyman) | 33388 |
| 60 | Journeyman Riding | 33391 |
| 60 | Acherus Deathcharger (100% class mount) | 48778 |

Granted automatically on login or level-up via `ApplyProgression()`, same as other class spells.

## Progression-gated (requires Individual Progression stage 13)

| Level | Spell | ID |
|------:|-------|-----|
| 58 | Death Gate | 50977 |
| 60 | Army of the Dead | 42650 |

## Damage scaling

WotLK Death Knight spell IDs are balanced for level 55+ heroes. Classic DKs learn them from level 1, so `mod-classic-deathknight` scales spell damage, DoT ticks, and DK heals by player level:

- Level 1: ~10% of stock damage (configurable via `ClassicDeathKnight.DamageScaleMinMultiplier`)
- Level 60: 100% (full WotLK values, `ClassicDeathKnight.DamageScaleFullLevel`)

Rank upgrades for strikes, coils, and runes are mapped to levels 50–54 in the same table.

Trainer template **130** mirrors these levels for manual training at world NPCs.

Regenerate SQL: `python3 scripts/generate-classic-dk-sql.py`
