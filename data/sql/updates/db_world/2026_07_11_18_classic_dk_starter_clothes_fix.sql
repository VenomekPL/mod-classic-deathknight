-- Classic DK: fix Troll starter torso (item 37 is a weapon, not a shirt) and align harness naming.

DELETE FROM `playercreateinfo_item` WHERE `class` = 6 AND `race` = 8 AND `itemid` = 37;

INSERT INTO `playercreateinfo_item` (`race`, `class`, `itemid`, `amount`, `note`)
SELECT 8, 6, 6125, 1, 'Brawler''s Harness'
WHERE NOT EXISTS (
    SELECT 1 FROM `playercreateinfo_item` WHERE `class` = 6 AND `race` = 8 AND `itemid` = 6125
);

UPDATE `playercreateinfo_item`
SET `note` = 'Brawler''s Harness'
WHERE `class` = 6 AND `itemid` = 6125 AND `note` LIKE 'Brawler''s Shirt%';
