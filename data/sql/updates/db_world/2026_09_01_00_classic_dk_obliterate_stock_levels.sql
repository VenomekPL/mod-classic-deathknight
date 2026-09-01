-- Obliterate is a baseline WotLK trainer spell, not a talent and not part of
-- the classic 1-60 auto-progression curve. Restore stock ranks on trainer 130.

DELETE FROM `classic_dk_spell_progression` WHERE `spell_id` IN (49020, 51423, 51424, 51425);

DELETE FROM `trainer_spell` WHERE `TrainerId` = 130 AND `SpellId` IN (49020, 51423, 51424, 51425);
INSERT INTO `trainer_spell` (`TrainerId`, `SpellId`, `MoneyCost`, `ReqSkillLine`, `ReqSkillRank`, `ReqAbility1`, `ReqAbility2`, `ReqAbility3`, `ReqLevel`, `VerifiedBuild`) VALUES
(130, 49020, 61000, 0, 0, 0, 0, 0, 61, 0),
(130, 51423, 67000, 0, 0, 49020, 0, 0, 67, 0),
(130, 51424, 360000, 0, 0, 51423, 0, 0, 73, 0),
(130, 51425, 360000, 0, 0, 51424, 0, 0, 79, 0);
