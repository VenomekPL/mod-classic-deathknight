-- Classic DK: strip remaining Acherus CharStartOutfit slots and grant level-1 starter kit.
-- Full outfit wipe happens in mod-classic-deathknight (ClearAcherusOutfits on startup).
-- amount -1 removes any leftover DBC slot that matches (one row per item id).

DELETE FROM `playercreateinfo_item` WHERE `class` = 6;

INSERT INTO `playercreateinfo_item` (`race`, `class`, `itemid`, `amount`, `note`) VALUES
(0, 6, 38145, -1, 'Remove Deathweave Bag'),
(0, 6, 34652, -1, 'Remove Acherus Knight''s Hood'),
(0, 6, 34655, -1, 'Remove Acherus Knight''s Pauldrons'),
(0, 6, 34659, -1, 'Remove Acherus Knight''s Shroud'),
(0, 6, 34650, -1, 'Remove Acherus Knight''s Tunic'),
(0, 6, 34653, -1, 'Remove Acherus Knight''s Wristguard'),
(0, 6, 34649, -1, 'Remove Acherus Knight''s Gauntlets'),
(0, 6, 34651, -1, 'Remove Acherus Knight''s Girdle'),
(0, 6, 34656, -1, 'Remove Acherus Knight''s Legplates'),
(0, 6, 34648, -1, 'Remove Acherus Knight''s Greaves'),
(0, 6, 34657, -1, 'Remove Choker of Damnation'),
(0, 6, 34658, -1, 'Remove Plague Band'),
(0, 6, 38147, -1, 'Remove Corrupted Band'),
(0, 6, 41751, -1, 'Remove Black Mushroom'),
(0, 6, 40582, -1, 'Remove Scourgestone'),
(0, 6, 34666, -1, 'Remove The Sunbreaker'),
(0, 6, 34667, -1, 'Remove Archmage''s Guile'),
(0, 6, 49778, 1, 'Worn Greatsword'),
(0, 6, 38, 1, 'Recruit''s Shirt'),
(0, 6, 39, 1, 'Recruit''s Pants'),
(0, 6, 40, 1, 'Recruit''s Boots'),
(0, 6, 159, 5, 'Refreshing Spring Water'),
(0, 6, 117, 5, 'Tough Jerky');
