-- Capital city guards: Class Trainer → Death Knight marks custom DK trainers on the map.
-- POI / gossip / npc_text IDs use the 9100xx custom range (aligned with creature 910009-910016).

-- ---------------------------------------------------------------------------
-- Points of interest (Icon 7 / Flags 99 = capital class-trainer convention)
-- ---------------------------------------------------------------------------
DELETE FROM `points_of_interest` WHERE `ID` BETWEEN 910009 AND 910016;
INSERT INTO `points_of_interest` (`ID`, `PositionX`, `PositionY`, `Icon`, `Flags`, `Importance`, `Name`) VALUES
(910009, -8688.0,   325.0, 7, 99, 0, 'Stormwind City, Death Knight Trainer'),
(910010, -5035.0, -1234.0, 7, 99, 0, 'Ironforge, Death Knight Trainer'),
(910011,  1970.0, -4807.0, 7, 99, 0, 'Orgrimmar, Death Knight Trainer'),
(910012,  1633.0,   239.0, 7, 99, 0, 'Undercity, Death Knight Trainer'),
(910013,  9947.0,  2481.0, 7, 99, 0, 'Darnassus, Death Knight Trainer'),
(910014, -3965.0,-11653.0, 7, 99, 0, 'The Exodar, Death Knight Trainer'),
(910015, -2300.0,  -456.0, 7, 99, 0, 'Thunder Bluff, Death Knight Trainer'),
(910016,  9730.0, -7450.0, 7, 99, 0, 'Silvermoon City, Death Knight Trainer');

-- ---------------------------------------------------------------------------
-- Direction blurbs (shown after the player picks Death Knight)
-- ---------------------------------------------------------------------------
DELETE FROM `npc_text` WHERE `ID` BETWEEN 910100 AND 910107;
INSERT INTO `npc_text` (`ID`, `text0_0`, `Probability0`) VALUES
(910100, 'You''ll find a Death Knight Initiate near the class trainers in the northern part of the city. Look for the runeforged armor — they can teach you the ways of blood, frost, and unholy.', 1),
(910101, 'Seek the Death Knight Initiate in the Military Ward area. They stand ready to train those who walk the path of the death knight.', 1),
(910102, 'A Death Knight Initiate trains near the Valley of Strength. Ask them about blood, frost, and unholy techniques.', 1),
(910103, 'Look for the Death Knight Initiate in the War Quarter. They can instruct you in death knight abilities.', 1),
(910104, 'The Death Knight Initiate waits near the Warrior Terrace. They will mark the path of frost and unholy for you.', 1),
(910105, 'You''ll find a Death Knight Initiate among the trainers on the Exodar. They teach the death knight arts.', 1),
(910106, 'Seek the Death Knight Initiate on the lower rise near the other class trainers. They stand ready to instruct.', 1),
(910107, 'A Death Knight Initiate stands near the bank and Murder Row — by the mailbox on the walk between them. They can train death knights.', 1);

DELETE FROM `gossip_menu` WHERE `MenuID` BETWEEN 910100 AND 910107;
INSERT INTO `gossip_menu` (`MenuID`, `TextID`) VALUES
(910100, 910100), -- Stormwind
(910101, 910101), -- Ironforge
(910102, 910102), -- Orgrimmar
(910103, 910103), -- Undercity
(910104, 910104), -- Darnassus
(910105, 910105), -- Exodar
(910106, 910106), -- Thunder Bluff
(910107, 910107); -- Silvermoon

-- ---------------------------------------------------------------------------
-- Class Trainer submenus → Death Knight option
-- ---------------------------------------------------------------------------
DELETE FROM `gossip_menu_option` WHERE
    (`MenuID` = 401  AND `OptionID` = 9) OR  -- Stormwind
    (`MenuID` = 2144 AND `OptionID` = 8) OR  -- Ironforge
    (`MenuID` = 1949 AND `OptionID` = 8) OR  -- Orgrimmar
    (`MenuID` = 2848 AND `OptionID` = 6) OR  -- Undercity
    (`MenuID` = 2343 AND `OptionID` = 7) OR  -- Darnassus
    (`MenuID` = 7787 AND `OptionID` = 7) OR  -- Exodar
    (`MenuID` = 740  AND `OptionID` = 6) OR  -- Thunder Bluff
    (`MenuID` = 7649 AND `OptionID` = 7);    -- Silvermoon

INSERT INTO `gossip_menu_option`
(`MenuID`, `OptionID`, `OptionIcon`, `OptionText`, `OptionBroadcastTextID`, `OptionType`, `OptionNpcFlag`, `ActionMenuID`, `ActionPoiID`, `BoxCoded`, `BoxMoney`, `BoxText`, `BoxBroadcastTextID`, `VerifiedBuild`)
VALUES
(401,  9, 0, 'Death Knight', 0, 1, 1, 910100, 910009, 0, 0, '', 0, 0),
(2144, 8, 0, 'Death Knight', 0, 1, 1, 910101, 910010, 0, 0, '', 0, 0),
(1949, 8, 0, 'Death Knight', 0, 1, 1, 910102, 910011, 0, 0, '', 0, 0),
(2848, 6, 0, 'Death Knight', 0, 1, 1, 910103, 910012, 0, 0, '', 0, 0),
(2343, 7, 0, 'Death Knight', 0, 1, 1, 910104, 910013, 0, 0, '', 0, 0),
(7787, 7, 0, 'Death Knight', 0, 1, 1, 910105, 910014, 0, 0, '', 0, 0),
(740,  6, 0, 'Death Knight', 0, 1, 1, 910106, 910015, 0, 0, '', 0, 0),
(7649, 7, 0, 'Death Knight', 0, 1, 1, 910107, 910016, 0, 0, '', 0, 0);
