# mod-classic-deathknight

Classic Death Knight experience for AzerothCore: level 1–60 in racial starting zones, remapped spell progression, world trainers, level-scaled ability damage, and WotLK-gated Death Gate / Acherus access.

## Requirements

- AzerothCore (WotLK)
- [mod-individual-progression](https://github.com/ZhengPeiRu21/mod-individual-progression) (Death Gate unlock stage)

## Install

```bash
cd modules
git submodule add https://github.com/VenomekPL/mod-classic-deathknight.git mod-classic-deathknight
# re-run CMake / rebuild worldserver
```

Copy `conf/classicDeathKnight.conf.dist` to your server `etc/modules/classicDeathKnight.conf` (CMake install usually does this).

## Configuration

Purpose: classic L1–60 DK experience with remapped spells, world trainers, level-scaled ability damage, and IP-gated Death Gate / Acherus.

See `conf/classicDeathKnight.conf.dist`:

| Key | Default | Meaning |
|-----|---------|---------|
| `ClassicDeathKnight.Enable` | 1 | Master switch |
| `ClassicDeathKnight.Announce` | 0 | Login announce for DK characters |
| `ClassicDeathKnight.WotlkProgressionStage` | 13 | IP stage required for Death Gate / Acherus (`PROGRESSION_TBC_TIER_5`) |
| `ClassicDeathKnight.PlateSkillLevel` | 40 | Level to learn plate |
| `ClassicDeathKnight.DamageScaleEnable` | 1 | Scale DK spell/DoT power by level |
| `ClassicDeathKnight.DamageScaleFullLevel` | 60 | Level at full WotLK damage |
| `ClassicDeathKnight.DamageScaleMinMultiplier` | 0.10 | Multiplier at level 1 |

Realm overlays may leave all keys at `.dist` when those defaults match the realm.

## SQL

World SQL lives under `data/sql/updates/db_world/` and is applied by AzerothCore’s module updater on worldserver start.

Regenerate from tools (optional):

```bash
python3 tools/generate-classic-dk-sql.py
```

## License

AGPL-3.0

## Catalogue

- Topics: `azerothcore`, `azerothcore-module`
- Author: VenomekPL / Aldrynth
