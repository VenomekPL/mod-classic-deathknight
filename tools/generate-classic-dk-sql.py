#!/usr/bin/env python3
"""Generate custom SQL for Classic Death Knight (1-60) implementation."""
from __future__ import annotations

import os
from pathlib import Path

MODULE_ROOT = Path(__file__).resolve().parents[1]
OUT_DIR = MODULE_ROOT / "data" / "sql" / "updates" / "db_world"

# Gist stats (level -> str, agi, sta, int, spi)
GIST_STATS = [
    (1, 23, 20, 22, 20, 20), (2, 24, 21, 23, 20, 20), (3, 25, 21, 24, 20, 21),
    (4, 26, 22, 25, 20, 21), (5, 28, 23, 26, 20, 21), (6, 29, 24, 27, 21, 21),
    (7, 30, 24, 28, 21, 22), (8, 31, 25, 29, 21, 22), (9, 32, 26, 30, 21, 22),
    (10, 33, 26, 31, 21, 23), (11, 35, 27, 33, 21, 23), (12, 36, 28, 34, 21, 23),
    (13, 37, 29, 35, 21, 24), (14, 39, 30, 36, 22, 24), (15, 40, 30, 37, 22, 24),
    (16, 41, 31, 38, 22, 25), (17, 42, 32, 40, 22, 25), (18, 44, 33, 41, 22, 25),
    (19, 45, 34, 42, 22, 26), (20, 47, 35, 43, 22, 26), (21, 48, 35, 45, 23, 26),
    (22, 49, 36, 46, 23, 27), (23, 51, 37, 47, 23, 27), (24, 52, 38, 49, 23, 28),
    (25, 54, 39, 50, 23, 28), (26, 55, 40, 51, 23, 28), (27, 57, 41, 53, 23, 29),
    (28, 58, 42, 54, 24, 29), (29, 60, 43, 56, 24, 30), (30, 62, 44, 57, 24, 30),
    (31, 63, 45, 58, 24, 30), (32, 65, 46, 60, 24, 31), (33, 66, 47, 61, 24, 31),
    (34, 68, 48, 63, 25, 32), (35, 70, 49, 64, 25, 32), (36, 72, 50, 66, 25, 33),
    (37, 73, 51, 68, 25, 33), (38, 75, 52, 69, 25, 33), (39, 77, 53, 71, 26, 34),
    (40, 79, 54, 72, 26, 34), (41, 80, 56, 74, 26, 35), (42, 82, 57, 76, 26, 35),
    (43, 84, 58, 77, 26, 36), (44, 86, 59, 79, 26, 36), (45, 88, 60, 81, 27, 37),
    (46, 90, 61, 83, 27, 37), (47, 92, 63, 84, 27, 38), (48, 94, 64, 86, 27, 38),
    (49, 96, 65, 88, 28, 39), (50, 98, 66, 90, 28, 39), (51, 100, 68, 92, 28, 40),
    (52, 102, 69, 94, 28, 40), (53, 104, 70, 96, 28, 41), (54, 106, 72, 98, 29, 42),
]

# Warrior BaseHP from player_class_stats (class 1)
WARRIOR_HP = {
    1: 20, 2: 29, 3: 38, 4: 47, 5: 56, 6: 65, 7: 74, 8: 83, 9: 92, 10: 101,
    11: 110, 12: 119, 13: 128, 14: 137, 15: 146, 16: 155, 17: 164, 18: 173, 19: 182, 20: 191,
    21: 200, 22: 209, 23: 218, 24: 227, 25: 236, 26: 245, 27: 254, 28: 263, 29: 272, 30: 281,
    31: 290, 32: 299, 33: 308, 34: 317, 35: 326, 36: 335, 37: 344, 38: 353, 39: 362, 40: 371,
    41: 380, 42: 389, 43: 398, 44: 407, 45: 416, 46: 425, 47: 434, 48: 443, 49: 452, 50: 461,
    51: 470, 52: 479, 53: 488, 54: 497,
}

# Manual spell progression overrides (spell_id -> (level, requires_progression))
# requires_progression: 0 = normal, 13 = WotLK tier
SPELL_PROGRESSION = {
    45477: (1, 0),   # Icy Touch
    45462: (1, 0),   # Plague Strike
    45902: (4, 0),   # Blood Strike
    47541: (6, 0),   # Death Coil
    49576: (8, 0),   # Death Grip
    674: (10, 0),   # Dual Wield (Acherus questline -> trainer @10)
    48266: (10, 0),  # Blood Presence
    46584: (12, 0),  # Raise Dead
    50842: (14, 0),  # Pestilence
    47528: (16, 0),  # Mind Freeze
    48263: (18, 0),  # Frost Presence
    45524: (20, 0),  # Chains of Ice
    47476: (22, 0),  # Strangulate
    49998: (24, 0),  # Death Strike
    48721: (26, 0),  # Blood Boil
    43265: (28, 0),  # Death and Decay
    3714: (30, 0),   # Path of Frost
    48792: (32, 0),  # Icebound Fortitude
    56222: (34, 0),  # Dark Command
    57330: (36, 0),  # Horn of Winter
    48743: (38, 0),  # Death Pact
    48707: (40, 0),  # Anti-Magic Shell
    48265: (42, 0),  # Unholy Presence
    47568: (44, 0),  # Empower Rune Weapon
    61999: (46, 0),  # Raise Ally
    53428: (48, 0),  # Runeforging
    53344: (50, 0),  # Rune of Swordbreaking (first rune spell)
    53341: (52, 0),  # Rune of Cinderglacier
    53343: (54, 0),  # Rune of Lichbane
    50977: (58, 13), # Death Gate - WotLK progression
    42650: (60, 13), # Army of the Dead
    # Acherus mount/riding quests skipped — grant at 60 (apprentice is a 33391 prerequisite)
    33388: (60, 0),  # Apprentice Riding
    33391: (60, 0),  # Journeyman Riding
    48778: (60, 0),  # Acherus Deathcharger (100%)
    # Rank upgrades spread 50-60
    49896: (50, 0),  # Icy Touch rank 2
    49903: (52, 0),
    49904: (54, 0),
    49917: (50, 0),  # Plague Strike rank 2
    49918: (52, 0),
    49919: (54, 0),
    49926: (50, 0),  # Blood Strike rank 2
    49927: (52, 0),
    49928: (54, 0),
    49892: (50, 0),  # Death Coil rank 2
    49893: (54, 0),
    49999: (50, 0),  # Death Strike rank 2
    49936: (52, 0),  # Death and Decay rank 2
    49939: (52, 0),  # Blood Boil rank 2
    54446: (54, 0),  # Rune Strike (baseline, not a talent)
    # Talent abilities / ranks are NEVER auto-granted — talent tree + trainer ReqAbility.
    # Do not add: Frost Strike, Obliterate, Heart Strike, Corpse Explosion, Howling Blast, Scourge Strike.
    53323: (54, 0),  # Rune of Spellbreaking
    53331: (50, 0),  # Rune of Spellshattering
    53342: (52, 0),  # Rune of Razorice
    54447: (54, 0),  # Rune of Swordshattering
}

# Talent Rank 1 spell IDs — exclude from trainer 130 (learned via talent tree only).
TALENT_RANK1_SPELLS = {
    49020,  # Obliterate
    49143,  # Frost Strike
    55050,  # Heart Strike
    49158,  # Corpse Explosion
    49184,  # Howling Blast
    55090,  # Scourge Strike
}

# Spells normally granted at DK creation or via Acherus questline (not on template 13)
TRAINER_EXTRA_SPELLS = [
    # (spell_id, money_cost, req_ability1, level)
    (45477, 10, 0, 1),    # Icy Touch
    (45462, 10, 0, 1),    # Plague Strike
    (45902, 100, 0, 4),   # Blood Strike
    (47541, 500, 0, 6),   # Death Coil
    (49576, 1000, 0, 8),  # Death Grip
    (48266, 2000, 0, 10), # Blood Presence
    (674, 300, 0, 10),    # Dual Wield (shaman class trainer uses 300c @10)
]

TRAINER_13_ROWS = """
(13,3714,61000,0,0,0,0,0,61,0),
(13,42650,360000,0,0,0,0,0,80,0),
(13,43265,6000,0,0,0,0,0,60,0),
(13,45463,63000,0,0,49999,0,0,70,0),
(13,45524,5800,0,0,0,0,0,58,0),
(13,45529,64000,0,0,0,0,0,64,0),
(13,46584,5600,0,0,0,0,0,56,0),
(13,47476,5900,0,0,0,0,0,59,0),
(13,47528,5700,0,0,0,0,0,57,0),
(13,47568,360000,0,0,0,0,0,75,0),
(13,48263,5700,0,0,0,0,0,57,0),
(13,48265,360000,0,0,0,0,0,70,0),
(13,48707,68000,0,0,0,0,0,68,0),
(13,48721,5800,0,0,0,0,0,58,0),
(13,48743,66000,0,0,0,0,0,66,0),
(13,48792,62000,0,0,0,0,0,62,0),
(13,49020,61000,0,0,0,0,0,61,0),
(13,49892,59000,0,0,47541,0,0,62,0),
(13,49893,68000,0,0,49892,0,0,68,0),
(13,49894,360000,0,0,49893,0,0,76,0),
(13,49895,360000,0,0,49894,0,0,80,0),
(13,49896,61000,0,0,45477,0,0,61,0),
(13,49903,67000,0,0,49896,0,0,67,0),
(13,49904,360000,0,0,49903,0,0,73,0),
(13,49909,360000,0,0,49904,0,0,78,0),
(13,49917,5800,0,0,45462,0,0,60,0),
(13,49918,65000,0,0,49917,0,0,65,0),
(13,49919,360000,0,0,49918,0,0,70,0),
(13,49920,360000,0,0,49919,0,0,75,0),
(13,49921,360000,0,0,49920,0,0,80,0),
(13,49923,360000,0,0,45463,0,0,75,0),
(13,49924,360000,0,0,49923,0,0,80,0),
(13,49926,5900,0,0,45902,0,0,59,0),
(13,49927,64000,0,0,49926,0,0,64,0),
(13,49928,69000,0,0,49927,0,0,69,0),
(13,49929,360000,0,0,49928,0,0,74,0),
(13,49930,360000,0,0,49929,0,0,80,0),
(13,49936,68000,0,0,43265,0,0,67,0),
(13,49937,360000,0,0,49936,0,0,73,0),
(13,49938,360000,0,0,49937,0,0,80,0),
(13,49939,66000,0,0,48721,0,0,66,0),
(13,49940,360000,0,0,49939,0,0,72,0),
(13,49941,360000,0,0,49940,0,0,78,0),
(13,49998,5600,0,0,0,0,0,56,0),
(13,49999,65000,0,0,49998,0,0,63,0),
(13,50842,5600,0,0,0,0,0,56,0),
(13,51325,300,0,0,49158,0,0,60,0),
(13,51326,18000,0,0,51325,0,0,70,0),
(13,51327,18000,0,0,51326,0,0,75,0),
(13,51328,18000,0,0,51327,0,0,80,0),
(13,51409,6500,0,0,49184,0,0,70,0),
(13,51410,10000,0,0,51409,0,0,75,0),
(13,51411,10000,0,0,51410,0,0,80,0),
(13,51416,6200,0,0,49143,0,0,60,0),
(13,51417,3250,0,0,51416,0,0,65,0),
(13,51418,18000,0,0,51417,0,0,70,0),
(13,51419,18000,0,0,51418,0,0,75,0),
(13,51423,67000,0,0,49020,0,0,67,0),
(13,51424,360000,0,0,51423,0,0,73,0),
(13,51425,360000,0,0,51424,0,0,79,0),
(13,53323,63000,0,0,0,0,0,63,0),
(13,53331,6000,0,0,0,0,0,60,0),
(13,53341,55000,0,0,0,0,0,55,0),
(13,53342,5700,0,0,0,0,0,57,0),
(13,53343,55000,0,0,0,0,0,55,0),
(13,53344,360000,0,0,0,0,0,70,0),
(13,54446,68000,0,0,0,0,0,63,0),
(13,54447,5700,0,0,0,0,0,57,0),
(13,55258,5900,0,0,55050,0,0,59,0),
(13,55259,3200,0,0,55258,0,0,64,0),
(13,55260,3450,0,0,55259,0,0,69,0),
(13,55261,18000,0,0,55260,0,0,74,0),
(13,55262,18000,0,0,55261,0,0,80,0),
(13,55265,18000,0,0,55090,0,0,67,0),
(13,55268,18000,0,0,51419,0,0,80,0),
(13,55270,18000,0,0,55265,0,0,73,0),
(13,55271,18000,0,0,55270,0,0,79,0),
(13,56222,65000,0,0,0,0,0,65,0),
(13,56815,67000,0,0,0,0,0,67,0),
(13,57330,65000,0,0,0,0,0,65,0),
(13,57623,360000,0,0,57330,0,0,75,0),
(13,61999,360000,0,0,0,0,0,72,0),
(13,62158,360000,0,0,0,0,0,72,0),
(13,70164,360000,0,0,0,0,0,72,0),
"""


def remap_trainer_level(old_level: int, spell_id: int) -> int:
    if spell_id in SPELL_PROGRESSION:
        return SPELL_PROGRESSION[spell_id][0]
    if old_level <= 54:
        return 1
    return min(60, max(1, round((old_level - 54) * 2.2)))


def parse_trainer_rows() -> list[tuple]:
    rows = []
    for line in TRAINER_13_ROWS.strip().splitlines():
        line = line.strip().rstrip(",")
        if not line.startswith("("):
            continue
        parts = line[1:-1].split(",")
        rows.append((
            int(parts[0]),  # trainer
            int(parts[1]),  # spell
            int(parts[2]),  # money
            int(parts[3]),  # req skill line
            int(parts[4]),  # req skill rank
            int(parts[5]),  # req ability 1
            int(parts[6]),  # req ability 2
            int(parts[7]),  # req ability 3
            int(parts[8]),  # req level
        ))
    return rows


def gen_stats_sql() -> str:
    lines = [
        "-- Classic DK: player_class_stats levels 1-54 for class 6",
        "DELETE FROM `player_class_stats` WHERE `Class` = 6 AND `Level` < 55;",
    ]
    values = []
    for level, s, a, st, i, sp in GIST_STATS:
        hp = WARRIOR_HP.get(level, 20 + (level - 1) * 9)
        values.append(f"(6,{level},{hp},0,{s},{a},{st},{i},{sp})")
    lines.append("INSERT INTO `player_class_stats` (`Class`, `Level`, `BaseHP`, `BaseMana`, "
                 "`Strength`, `Agility`, `Stamina`, `Intellect`, `Spirit`) VALUES")
    lines.append(",\n".join(values) + ";")
    return "\n".join(lines)


def gen_spawn_sql() -> str:
    # Copy warrior (class 1) or paladin spawn for each race with DK
    spawns = [
        (1, 0, 12, -8949.95, -132.493, 83.5312, 0),
        (2, 1, 14, -618.518, -4251.67, 38.718, 0),
        (3, 0, 1, -6240.32, 331.033, 382.758, 6.17716),
        (4, 1, 141, 10311.3, 832.463, 1326.41, 5.69632),
        (5, 0, 85, 1676.71, 1678.31, 121.67, 2.70526),
        (6, 1, 215, -2917.58, -257.98, 52.9968, 0),
        (7, 0, 1, -6240.32, 331.033, 382.758, 0),
        (8, 1, 14, -618.518, -4251.67, 38.718, 0),
        (10, 530, 3431, 10349.6, -6357.29, 33.4026, 5.31605),
        (11, 530, 3526, -3961.64, -13931.2, 100.615, 2.08364),
    ]
    lines = [
        "-- Classic DK: racial starting zone spawns (class 6)",
        "DELETE FROM `playercreateinfo` WHERE `class` = 6;",
    ]
    vals = [f"({r},{6},{m},{z},{x},{y},{z2},{o})" for r, m, z, x, y, z2, o in spawns]
    lines.append("INSERT INTO `playercreateinfo` (`race`, `class`, `map`, `zone`, "
                 "`position_x`, `position_y`, `position_z`, `orientation`) VALUES")
    lines.append(",\n".join(vals) + ";")
    return "\n".join(lines)


def gen_skills_actions_sql() -> str:
    return """-- Classic DK: starting skills (surgical delete; immediate weapon proficiencies)
DELETE FROM `playercreateinfo_skills`
WHERE `classMask` = 32 AND `skill` IN (129, 762, 293);

INSERT INTO `playercreateinfo_skills` (`raceMask`, `classMask`, `skill`, `rank`, `comment`) VALUES
(0, 32, 229, 0, 'Polearms'),
(0, 32, 43, 0, 'Death Knight - Swords'),
(0, 32, 55, 0, 'Death Knight - Two-Handed Swords'),
(0, 32, 44, 0, 'Death Knight - Axes'),
(0, 32, 172, 0, 'Death Knight - Two-Handed Axes'),
(0, 32, 770, 0, 'Death Knight - Blood'),
(0, 32, 771, 0, 'Death Knight - Frost'),
(0, 32, 772, 0, 'Death Knight - Unholy')
ON DUPLICATE KEY UPDATE `rank` = VALUES(`rank`), `comment` = VALUES(`comment`);

-- Classic DK: minimal level-1 action bar
DELETE FROM `playercreateinfo_action` WHERE `class` = 6;
INSERT INTO `playercreateinfo_action` (`race`, `class`, `button`, `action`, `type`) VALUES
(0, 6, 0, 6603, 0),
(0, 6, 1, 45477, 0),
(0, 6, 2, 45462, 0);

-- Remove Blood Presence auto-cast on creation
DELETE FROM `playercreateinfo_cast_spell` WHERE `classMask` = 32;
"""


# Immediate at creation (playercreateinfo_skills); maces trained at weapon masters
DK_IMMEDIATE_WEAPON_SKILLS = [
    (229, "Polearms"),
    (43, "Death Knight - Swords"),
    (55, "Death Knight - Two-Handed Swords"),
    (44, "Death Knight - Axes"),
    (172, "Death Knight - Two-Handed Axes"),
]

# Items from CharStartOutfit.dbc for Death Knights (stripped with amount -1 at server load)
ACHERUS_OUTFIT_ITEMS = [
    38145,
    34652, 34655, 34659, 34650, 34653, 34649, 34651, 34656, 34648,
    34657, 34658, 38147, 41751, 40582, 34666, 34667,
]

# race -> list of (item_id, amount, note) positive starter rows
DK_STARTER_GEAR_BY_RACE: dict[int, list[tuple[int, int, str]]] = {
    1: [(38, 1, "Recruit's Shirt"), (39, 1, "Recruit's Pants"), (40, 1, "Recruit's Boots"),
        (49778, 1, "Worn Greatsword"), (117, 5, "Tough Jerky"), (159, 5, "Refreshing Spring Water")],
    2: [(6125, 1, "Brawler's Harness"), (139, 1, "Brawler's Pants"), (140, 1, "Brawler's Boots"),
        (12282, 1, "Worn Battleaxe"), (117, 5, "Tough Jerky"), (159, 5, "Refreshing Spring Water")],
    3: [(38, 1, "Recruit's Shirt"), (39, 1, "Recruit's Pants"), (40, 1, "Recruit's Boots"),
        (12282, 1, "Worn Battleaxe"), (117, 5, "Tough Jerky"), (159, 5, "Refreshing Spring Water")],
    4: [(6120, 1, "Squire's Shirt"), (6121, 1, "Squire's Pants"), (6122, 1, "Squire's Boots"),
        (49778, 1, "Worn Greatsword"), (117, 5, "Tough Jerky"), (159, 5, "Refreshing Spring Water")],
    5: [(6125, 1, "Brawler's Harness"), (139, 1, "Brawler's Pants"), (140, 1, "Brawler's Boots"),
        (49778, 1, "Worn Greatsword"), (117, 5, "Tough Jerky"), (159, 5, "Refreshing Spring Water")],
    6: [(6125, 1, "Brawler's Harness"), (139, 1, "Brawler's Pants"), (140, 1, "Brawler's Boots"),
        (49778, 1, "Worn Greatsword"), (117, 5, "Tough Jerky"), (159, 5, "Refreshing Spring Water")],
    7: [(38, 1, "Recruit's Shirt"), (39, 1, "Recruit's Pants"), (40, 1, "Recruit's Boots"),
        (49778, 1, "Worn Greatsword"), (117, 5, "Tough Jerky"), (159, 5, "Refreshing Spring Water")],
    8: [(6125, 1, "Brawler's Harness"), (139, 1, "Brawler's Pants"), (140, 1, "Brawler's Boots"),
        (12282, 1, "Worn Battleaxe"), (117, 5, "Tough Jerky"), (159, 5, "Refreshing Spring Water")],
    10: [(24143, 1, "Initiate's Shirt"), (24145, 1, "Initiate's Pants"), (24146, 1, "Initiate's Boots"),
         (23346, 1, "Battleworn Claymore"), (117, 5, "Tough Jerky"), (159, 5, "Refreshing Spring Water")],
    11: [(23473, 1, "Recruit's Shirt"), (23474, 1, "Recruit's Pants"), (23475, 1, "Recruit's Boots"),
         (23346, 1, "Battleworn Claymore"), (117, 5, "Tough Jerky"), (159, 5, "Refreshing Spring Water")],
}


def gen_gear_sql() -> str:
    lines = [
        "-- Classic DK: per-race starter gear (clothes + immediate-proficiency weapons)",
        "DELETE FROM `playercreateinfo_item` WHERE `class` = 6;",
        "INSERT INTO `playercreateinfo_item` (`race`, `class`, `itemid`, `amount`, `note`) VALUES",
    ]
    vals = []
    for item_id in ACHERUS_OUTFIT_ITEMS:
        vals.append(f"(0, 6, {item_id}, -1, 'Remove Acherus outfit item {item_id}')")
    for race in sorted(DK_STARTER_GEAR_BY_RACE):
        for item_id, amount, note in DK_STARTER_GEAR_BY_RACE[race]:
            safe = note.replace("'", "''")
            vals.append(f"({race}, 6, {item_id}, {amount}, '{safe}')")
    lines.append(",\n".join(vals) + ";")
    return "\n".join(lines)


def gen_weapon_skills_sql() -> str:
    lines = [
        "-- Classic DK: restore standard immediate weapon proficiencies (IP DK set)",
        "DELETE FROM `playercreateinfo_skills`",
        "WHERE `classMask` = 32 AND `skill` IN (129, 762, 293);",
        "",
        "INSERT INTO `playercreateinfo_skills` (`raceMask`, `classMask`, `skill`, `rank`, `comment`) VALUES",
    ]
    skill_vals = [f"(0, 32, {sid}, 0, '{comment}')" for sid, comment in DK_IMMEDIATE_WEAPON_SKILLS]
    skill_vals += [
        "(0, 32, 770, 0, 'Death Knight - Blood')",
        "(0, 32, 771, 0, 'Death Knight - Frost')",
        "(0, 32, 772, 0, 'Death Knight - Unholy')",
    ]
    lines.append(",\n".join(skill_vals))
    lines.append("ON DUPLICATE KEY UPDATE `rank` = VALUES(`rank`), `comment` = VALUES(`comment`);")
    return "\n".join(lines)


def gen_weapon_master_maces_sql() -> str:
    return """-- Classic DK: ensure capital weapon masters teach mace proficiencies (trained skills)
INSERT IGNORE INTO `trainer_spell` (`TrainerId`, `SpellId`, `MoneyCost`, `ReqSkillLine`, `ReqSkillRank`, `ReqAbility1`, `ReqAbility2`, `ReqAbility3`, `ReqLevel`, `VerifiedBuild`) VALUES
(56, 198, 0, 0, 0, 0, 0, 0, 0, 0),
(56, 199, 0, 0, 0, 0, 0, 0, 0, 0),
(57, 198, 0, 0, 0, 0, 0, 0, 0, 0),
(57, 199, 0, 0, 0, 0, 0, 0, 0, 0);
"""


def gen_starter_2h_weapons_sql() -> str:
    return """-- Classic DK: default starter weapons are two-handed (immediate proficiencies only).

UPDATE `playercreateinfo_item`
SET `itemid` = 49778, `note` = 'Worn Greatsword'
WHERE `class` = 6 AND `itemid` = 25;

UPDATE `playercreateinfo_item`
SET `itemid` = 12282, `note` = 'Worn Battleaxe'
WHERE `class` = 6 AND `itemid` = 35;
"""


def gen_starter_clothes_fix_sql() -> str:
    return """-- Classic DK: fix Troll starter torso (item 37 is a weapon, not a shirt) and align harness naming.

DELETE FROM `playercreateinfo_item` WHERE `class` = 6 AND `race` = 8 AND `itemid` = 37;

INSERT INTO `playercreateinfo_item` (`race`, `class`, `itemid`, `amount`, `note`)
SELECT 8, 6, 6125, 1, 'Brawler''s Harness'
WHERE NOT EXISTS (
    SELECT 1 FROM `playercreateinfo_item` WHERE `class` = 6 AND `race` = 8 AND `itemid` = 6125
);

UPDATE `playercreateinfo_item`
SET `note` = 'Brawler''s Harness'
WHERE `class` = 6 AND `itemid` = 6125 AND `note` LIKE 'Brawler''s Shirt%';
"""


def gen_spell_table_sql() -> str:
    lines = [
        "-- Classic DK spell progression (module reads this table)",
        "DROP TABLE IF EXISTS `classic_dk_spell_progression`;",
        """CREATE TABLE `classic_dk_spell_progression` (
  `spell_id` INT UNSIGNED NOT NULL,
  `level` TINYINT UNSIGNED NOT NULL,
  `requires_progression` TINYINT UNSIGNED NOT NULL DEFAULT 0 COMMENT '0=none, 13=WotLK tier',
  PRIMARY KEY (`spell_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;""",
        "DELETE FROM `classic_dk_spell_progression`;",
        "INSERT INTO `classic_dk_spell_progression` (`spell_id`, `level`, `requires_progression`) VALUES",
    ]
    vals = [f"({sid},{lvl},{prog})" for sid, (lvl, prog) in sorted(SPELL_PROGRESSION.items())]
    lines.append(",\n".join(vals) + ";")
    return "\n".join(lines)


def gen_trainer_sql() -> str:
    rows = parse_trainer_rows()
    lines = [
        "-- Classic DK trainer template 130 (remapped 1-60 levels)",
        "DELETE FROM `trainer` WHERE `Id` = 130;",
        "INSERT INTO `trainer` (`Id`, `Type`, `Requirement`, `Greeting`, `VerifiedBuild`) VALUES",
        "(130, 0, 6, 'Greetings, death knight. Ready to train?', 0);",
        "DELETE FROM `trainer_spell` WHERE `TrainerId` = 130;",
        "INSERT INTO `trainer_spell` (`TrainerId`, `SpellId`, `MoneyCost`, `ReqSkillLine`, "
        "`ReqSkillRank`, `ReqAbility1`, `ReqAbility2`, `ReqAbility3`, `ReqLevel`, `VerifiedBuild`) VALUES",
    ]
    vals = []
    seen_spells: set[int] = set()
    for _, spell_id, money, rsl, rsr, ra1, ra2, ra3, old_lvl in rows:
        new_lvl = remap_trainer_level(old_lvl, spell_id)
        if spell_id in (42650, 70164, 62158):  # WotLK-only from classic trainer
            continue
        if spell_id == 50977:
            continue
        if spell_id in TALENT_RANK1_SPELLS:
            continue  # talent tree only; higher ranks keep ReqAbility1 on R1
        vals.append(f"(130,{spell_id},{money},{rsl},{rsr},{ra1},{ra2},{ra3},{new_lvl},0)")
        seen_spells.add(spell_id)
    for spell_id, money, ra1, level in TRAINER_EXTRA_SPELLS:
        if spell_id in seen_spells:
            continue
        vals.append(f"(130,{spell_id},{money},0,0,{ra1},0,0,{level},0)")
        seen_spells.add(spell_id)
    lines.append(",\n".join(vals) + ";")
    return "\n".join(lines)


def gen_runeforge_sql() -> str:
    return """-- Classic DK: allow runeforge without Acherus proximity
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 13 AND `SourceEntry` = 51769;
"""


# Trainer NPC entry 910000, spawns use guids 910000+
TRAINER_SPAWNS = [
    # (name_suffix, map, zone, x, y, z, o, entry_offset)
    ("Northshire", 0, 12, -8914.0, -137.0, 80.5, 5.0, 0),
    ("Deathknell", 0, 85, 1676.0, 1678.0, 121.0, 2.7, 1),
    ("ValleyOfTrials", 1, 14, -618.0, -4250.0, 38.7, 0.0, 2),
    ("CampNarache", 1, 215, -2917.0, -258.0, 53.0, 0.0, 3),
    ("Shadowglen", 1, 141, 10311.0, 832.0, 1326.0, 5.7, 4),
    ("Anvilmar", 0, 1, -6240.0, 331.0, 383.0, 6.2, 5),
    ("Coldridge", 0, 1, -6240.0, 331.0, 383.0, 0.0, 6),
    ("Sunstrider", 530, 3431, 10349.0, -6357.0, 33.4, 5.3, 7),
    ("AmmenVale", 530, 3526, -3961.0, -13931.0, 100.6, 2.1, 8),
    ("Stormwind", 0, 1519, -8688.0, 325.0, 109.0, 5.0, 9),
    ("Ironforge", 0, 1537, -5035.0, -1234.0, 508.0, 5.0, 10),
    ("Darnassus", 1, 1657, 9947.0, 2481.0, 1316.0, 4.0, 11),
    ("Exodar", 530, 3557, -3965.0, -11653.0, -138.0, 2.0, 12),
    ("Orgrimmar", 1, 1637, 1970.0, -4807.0, 24.0, 1.0, 13),
    ("Undercity", 0, 1497, 1633.0, 239.0, -43.0, 1.0, 14),
    ("ThunderBluff", 1, 1638, -2300.0, -456.0, -5.0, 4.0, 15),
    ("Silvermoon", 530, 3487, 9730.0, -7450.0, 14.0, 0.0, 16),
    ("Crossroads", 1, 17, -450.0, -2650.0, 96.0, 0.5, 17),
    ("Theramore", 1, 15, -3618.0, -4470.0, 14.0, 0.5, 18),
    ("Stonard", 0, 8, -10440.0, -3280.0, 21.0, 3.0, 19),
    ("Gadgetzan", 1, 440, -7150.0, -3840.0, 8.0, 5.0, 20),
    ("Feathermoon", 1, 357, -4375.0, 3280.0, 12.0, 4.0, 21),
    ("ChillwindCamp", 0, 28, 928.0, -1430.0, 64.0, 5.0, 22),
]

BASE_NPC = 910000


def gen_trainers_sql() -> str:
    lines = [
        "-- Classic DK world trainers (template 130)",
        f"DELETE FROM `creature_default_trainer` WHERE `CreatureId` BETWEEN {BASE_NPC} AND {BASE_NPC + 99};",
        f"DELETE FROM `creature` WHERE `id` BETWEEN {BASE_NPC} AND {BASE_NPC + 99};",
        f"DELETE FROM `creature_template` WHERE `entry` BETWEEN {BASE_NPC} AND {BASE_NPC + 99};",
    ]
    ct_vals = []
    cd_vals = []
    c_vals = []
    for i, (label, mmap, zone, x, y, z, o, _off) in enumerate(TRAINER_SPAWNS):
        entry = BASE_NPC + i
        sub = label.replace("_", " ")
        ct_vals.append(
            f"({entry},0,0,0,0,0,'Death Knight Initiate','{sub}','',0,60,60,0,35,51,1,1.14286,1,1,20,0,0,7.5,2000,2000,1,1,1,"
            f"0,2048,0,0,0,0,0,0,0,0,0,0,0,'',0,1,10,1,1,1,0,0,1,0,0,'',12340)"
        )
        cd_vals.append(f"({entry},130)")
        guid = 910000 + i
        c_vals.append(
            f"({guid},{entry},{mmap},0,0,1,1,0,{x},{y},{z},{o},300,0,0,1,0,0,0,0,0,'',0,0,NULL)"
        )
    lines.append("INSERT INTO `creature_template` VALUES")
    lines.append(",\n".join(ct_vals) + ";")
    lines.append("INSERT INTO `creature_default_trainer` (`CreatureId`, `TrainerId`) VALUES")
    lines.append(",\n".join(cd_vals) + ";")
    lines.append("INSERT INTO `creature` VALUES")
    lines.append(",\n".join(c_vals) + ";")
    return "\n".join(lines)


def main() -> None:
    OUT_DIR.mkdir(parents=True, exist_ok=True)
    files = {
        "2026_07_11_00_classic_dk_stats.sql": gen_stats_sql(),
        "2026_07_11_01_classic_dk_spawn.sql": gen_spawn_sql(),
        "2026_07_11_02_classic_dk_skills_actions.sql": gen_skills_actions_sql(),
        "2026_07_11_03_classic_dk_gear.sql": gen_gear_sql(),
        "2026_07_11_14_classic_dk_weapon_armor_skills.sql": gen_weapon_skills_sql(),
        "2026_07_11_15_classic_dk_racial_starter_gear.sql": gen_gear_sql(),
        "2026_07_11_16_classic_dk_weapon_master_maces.sql": gen_weapon_master_maces_sql(),
        "2026_07_11_17_classic_dk_starter_2h_weapons.sql": gen_starter_2h_weapons_sql(),
        "2026_07_11_18_classic_dk_starter_clothes_fix.sql": gen_starter_clothes_fix_sql(),
        "2026_07_11_04_classic_dk_spell_progression.sql": gen_spell_table_sql(),
        "2026_07_11_05_classic_dk_trainer.sql": gen_trainer_sql(),
        "2026_07_11_06_classic_dk_runeforge.sql": gen_runeforge_sql(),
        "2026_07_11_07_classic_dk_trainers_world.sql": gen_trainers_sql(),
    }
    for name, content in files.items():
        path = OUT_DIR / name
        path.write_text(content + "\n", encoding="utf-8")
        print(f"Wrote {path}")


if __name__ == "__main__":
    main()
