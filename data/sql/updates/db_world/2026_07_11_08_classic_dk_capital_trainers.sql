-- Classic DK trainers: remaining capital cities (TBC + Thunder Bluff)
-- Entries 910013-910016; does not modify existing 910000-910012 spawns.

DELETE FROM `creature_default_trainer` WHERE `CreatureId` BETWEEN 910013 AND 910016;
DELETE FROM `creature` WHERE `id` BETWEEN 910013 AND 910016;
DELETE FROM `creature_template` WHERE `entry` BETWEEN 910013 AND 910016;

INSERT INTO `creature_template`
SELECT 910013, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`,
    'Death Knight Initiate', 'Darnassus', `IconName`, 0, 60, 60, `exp`, 35, 51,
    `speed_walk`, `speed_run`, `speed_swim`, `speed_flight`, `detection_range`, `rank`, `dmgschool`,
    `DamageModifier`, `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`,
    `unit_flags`, `unit_flags2`, `dynamicflags`, `family`, `type`, `type_flags`, `lootid`, `pickpocketloot`,
    `skinloot`, `PetSpellDataId`, `VehicleId`, `mingold`, `maxgold`, `AIName`, `MovementType`, `HoverHeight`,
    `HealthModifier`, `ManaModifier`, `ArmorModifier`, `ExperienceModifier`, `RacialLeader`, `movementId`,
    `RegenHealth`, `CreatureImmunitiesId`, `flags_extra`, `ScriptName`, `VerifiedBuild`
FROM `creature_template` WHERE `entry` = 28472;

INSERT INTO `creature_template`
SELECT 910014, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`,
    'Death Knight Initiate', 'The Exodar', `IconName`, 0, 60, 60, `exp`, 35, 51,
    `speed_walk`, `speed_run`, `speed_swim`, `speed_flight`, `detection_range`, `rank`, `dmgschool`,
    `DamageModifier`, `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`,
    `unit_flags`, `unit_flags2`, `dynamicflags`, `family`, `type`, `type_flags`, `lootid`, `pickpocketloot`,
    `skinloot`, `PetSpellDataId`, `VehicleId`, `mingold`, `maxgold`, `AIName`, `MovementType`, `HoverHeight`,
    `HealthModifier`, `ManaModifier`, `ArmorModifier`, `ExperienceModifier`, `RacialLeader`, `movementId`,
    `RegenHealth`, `CreatureImmunitiesId`, `flags_extra`, `ScriptName`, `VerifiedBuild`
FROM `creature_template` WHERE `entry` = 28472;

INSERT INTO `creature_template`
SELECT 910015, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`,
    'Death Knight Initiate', 'Thunder Bluff', `IconName`, 0, 60, 60, `exp`, 35, 51,
    `speed_walk`, `speed_run`, `speed_swim`, `speed_flight`, `detection_range`, `rank`, `dmgschool`,
    `DamageModifier`, `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`,
    `unit_flags`, `unit_flags2`, `dynamicflags`, `family`, `type`, `type_flags`, `lootid`, `pickpocketloot`,
    `skinloot`, `PetSpellDataId`, `VehicleId`, `mingold`, `maxgold`, `AIName`, `MovementType`, `HoverHeight`,
    `HealthModifier`, `ManaModifier`, `ArmorModifier`, `ExperienceModifier`, `RacialLeader`, `movementId`,
    `RegenHealth`, `CreatureImmunitiesId`, `flags_extra`, `ScriptName`, `VerifiedBuild`
FROM `creature_template` WHERE `entry` = 28472;

INSERT INTO `creature_template`
SELECT 910016, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`,
    'Death Knight Initiate', 'Silvermoon City', `IconName`, 0, 60, 60, `exp`, 35, 51,
    `speed_walk`, `speed_run`, `speed_swim`, `speed_flight`, `detection_range`, `rank`, `dmgschool`,
    `DamageModifier`, `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`,
    `unit_flags`, `unit_flags2`, `dynamicflags`, `family`, `type`, `type_flags`, `lootid`, `pickpocketloot`,
    `skinloot`, `PetSpellDataId`, `VehicleId`, `mingold`, `maxgold`, `AIName`, `MovementType`, `HoverHeight`,
    `HealthModifier`, `ManaModifier`, `ArmorModifier`, `ExperienceModifier`, `RacialLeader`, `movementId`,
    `RegenHealth`, `CreatureImmunitiesId`, `flags_extra`, `ScriptName`, `VerifiedBuild`
FROM `creature_template` WHERE `entry` = 28472;

INSERT INTO `creature_default_trainer` (`CreatureId`, `TrainerId`) VALUES
(910013, 130),
(910014, 130),
(910015, 130),
(910016, 130);

INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `equipment_id`,
    `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`,
    `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`,
    `CreateObject`, `Comment`) VALUES
(910013, 910013, 1, 1657, 0, 1, 1, 0, 9947.0, 2481.0, 1316.0, 4.0, 300, 0, 0, 1, 0, 0, 0, 0, 0, '', 0, 0, NULL),
(910014, 910014, 530, 3557, 0, 1, 1, 0, -3965.0, -11653.0, -138.0, 2.0, 300, 0, 0, 1, 0, 0, 0, 0, 0, '', 0, 0, NULL),
(910015, 910015, 1, 1638, 0, 1, 1, 0, -2300.0, -456.0, -5.0, 4.0, 300, 0, 0, 1, 0, 0, 0, 0, 0, '', 0, 0, NULL),
(910016, 910016, 530, 3487, 0, 1, 1, 0, 9730.0, -7450.0, 14.0, 0.0, 300, 0, 0, 1, 0, 0, 0, 0, 0, '', 0, 0, NULL);
