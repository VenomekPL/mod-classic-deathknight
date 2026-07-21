-- Classic DK: ensure capital weapon masters teach trained mace proficiencies (54, 160).
-- Spells 198 = One-Handed Maces, 199 = Two-Handed Maces (weapon master trainer type 2).
-- Existing trainers 47/51/52 already include these; add to capitals that lack mace training.

INSERT IGNORE INTO `trainer_spell` (`TrainerId`, `SpellId`, `MoneyCost`, `ReqSkillLine`, `ReqSkillRank`, `ReqAbility1`, `ReqAbility2`, `ReqAbility3`, `ReqLevel`, `VerifiedBuild`) VALUES
(56, 198, 0, 0, 0, 0, 0, 0, 0, 0),
(56, 199, 0, 0, 0, 0, 0, 0, 0, 0),
(57, 198, 0, 0, 0, 0, 0, 0, 0, 0),
(57, 199, 0, 0, 0, 0, 0, 0, 0, 0);
