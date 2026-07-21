-- Classic DK: starting skills (surgical delete; immediate weapon proficiencies)
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
