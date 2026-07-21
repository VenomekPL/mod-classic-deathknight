-- Classic DK: allow runeforge without Acherus proximity
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 13 AND `SourceEntry` = 51769;

