-- Classic DK world trainers cloned creature_template from Lord Thorval (28472)
-- but never copied creature_template_model, so they spawned invisible.
-- Display 25459 = Lord Thorval (Acherus DK look).

DELETE FROM `creature_template_model` WHERE `CreatureID` BETWEEN 910000 AND 910016;

INSERT INTO `creature_template_model` (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`)
SELECT `entry`, 0, 25459, 1, 1, 0
FROM `creature_template`
WHERE `entry` BETWEEN 910000 AND 910016;
