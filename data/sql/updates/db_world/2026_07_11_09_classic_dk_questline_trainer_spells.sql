-- Classic DK: questline / creation spells on trainer 130 + progression (Dual Wield @10)

INSERT INTO `classic_dk_spell_progression` (`spell_id`, `level`, `requires_progression`) VALUES
(674, 10, 0)
ON DUPLICATE KEY UPDATE `level` = 10, `requires_progression` = 0;

INSERT INTO `trainer_spell` (`TrainerId`, `SpellId`, `MoneyCost`, `ReqSkillLine`, `ReqSkillRank`, `ReqAbility1`, `ReqAbility2`, `ReqAbility3`, `ReqLevel`, `VerifiedBuild`) VALUES
(130, 45477, 10, 0, 0, 0, 0, 0, 1, 0),
(130, 45462, 10, 0, 0, 0, 0, 0, 1, 0),
(130, 45902, 100, 0, 0, 0, 0, 0, 4, 0),
(130, 47541, 500, 0, 0, 0, 0, 0, 6, 0),
(130, 49576, 1000, 0, 0, 0, 0, 0, 8, 0),
(130, 48266, 2000, 0, 0, 0, 0, 0, 10, 0),
(130, 674, 300, 0, 0, 0, 0, 0, 10, 0)
ON DUPLICATE KEY UPDATE
    `MoneyCost` = VALUES(`MoneyCost`),
    `ReqLevel` = VALUES(`ReqLevel`);
