-- Classic DK: restore standard immediate weapon proficiencies (IP DK set).
-- Surgical delete only — do not wipe all classMask=32 rows.

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
