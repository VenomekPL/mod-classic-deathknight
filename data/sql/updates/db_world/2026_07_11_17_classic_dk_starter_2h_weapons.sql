-- Classic DK: default starter weapons are two-handed (immediate proficiencies only).

UPDATE `playercreateinfo_item`
SET `itemid` = 49778, `note` = 'Worn Greatsword'
WHERE `class` = 6 AND `itemid` = 25;

UPDATE `playercreateinfo_item`
SET `itemid` = 12282, `note` = 'Worn Battleaxe'
WHERE `class` = 6 AND `itemid` = 35;
