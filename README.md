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

See `conf/classicDeathKnight.conf.dist` for knobs (`Enable`, WotLK progression stage, damage scaling, plate skill level, LFG credit).

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
