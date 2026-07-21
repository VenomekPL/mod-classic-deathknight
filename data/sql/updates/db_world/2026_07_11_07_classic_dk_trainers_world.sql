-- Classic DK world trainers (template 130)
-- Base spawns 910000-910012; capitals Darnassus/Exodar/Thunder Bluff/Silvermoon in 08.
DELETE FROM `creature_default_trainer` WHERE `CreatureId` BETWEEN 910000 AND 910099;
DELETE FROM `creature` WHERE `id` BETWEEN 910000 AND 910099;
DELETE FROM `creature_template` WHERE `entry` BETWEEN 910000 AND 910099;

INSERT INTO `creature_template`
SELECT 910000, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`,
    'Death Knight Initiate', 'Northshire', `IconName`, 0, 60, 60, `exp`, 35, 51,
    `speed_walk`, `speed_run`, `speed_swim`, `speed_flight`, `detection_range`, `rank`, `dmgschool`,
    `DamageModifier`, `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`,
    `unit_flags`, `unit_flags2`, `dynamicflags`, `family`, `type`, `type_flags`, `lootid`, `pickpocketloot`,
    `skinloot`, `PetSpellDataId`, `VehicleId`, `mingold`, `maxgold`, `AIName`, `MovementType`, `HoverHeight`,
    `HealthModifier`, `ManaModifier`, `ArmorModifier`, `ExperienceModifier`, `RacialLeader`, `movementId`,
    `RegenHealth`, `CreatureImmunitiesId`, `flags_extra`, `ScriptName`, `VerifiedBuild`
FROM `creature_template` WHERE `entry` = 28472;

INSERT INTO `creature_template`
SELECT 910001, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`,
    'Death Knight Initiate', 'Deathknell', `IconName`, 0, 60, 60, `exp`, 35, 51,
    `speed_walk`, `speed_run`, `speed_swim`, `speed_flight`, `detection_range`, `rank`, `dmgschool`,
    `DamageModifier`, `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`,
    `unit_flags`, `unit_flags2`, `dynamicflags`, `family`, `type`, `type_flags`, `lootid`, `pickpocketloot`,
    `skinloot`, `PetSpellDataId`, `VehicleId`, `mingold`, `maxgold`, `AIName`, `MovementType`, `HoverHeight`,
    `HealthModifier`, `ManaModifier`, `ArmorModifier`, `ExperienceModifier`, `RacialLeader`, `movementId`,
    `RegenHealth`, `CreatureImmunitiesId`, `flags_extra`, `ScriptName`, `VerifiedBuild`
FROM `creature_template` WHERE `entry` = 28472;

INSERT INTO `creature_template`
SELECT 910002, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`,
    'Death Knight Initiate', 'Valley of Trials', `IconName`, 0, 60, 60, `exp`, 35, 51,
    `speed_walk`, `speed_run`, `speed_swim`, `speed_flight`, `detection_range`, `rank`, `dmgschool`,
    `DamageModifier`, `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`,
    `unit_flags`, `unit_flags2`, `dynamicflags`, `family`, `type`, `type_flags`, `lootid`, `pickpocketloot`,
    `skinloot`, `PetSpellDataId`, `VehicleId`, `mingold`, `maxgold`, `AIName`, `MovementType`, `HoverHeight`,
    `HealthModifier`, `ManaModifier`, `ArmorModifier`, `ExperienceModifier`, `RacialLeader`, `movementId`,
    `RegenHealth`, `CreatureImmunitiesId`, `flags_extra`, `ScriptName`, `VerifiedBuild`
FROM `creature_template` WHERE `entry` = 28472;

INSERT INTO `creature_template`
SELECT 910003, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`,
    'Death Knight Initiate', 'Camp Narache', `IconName`, 0, 60, 60, `exp`, 35, 51,
    `speed_walk`, `speed_run`, `speed_swim`, `speed_flight`, `detection_range`, `rank`, `dmgschool`,
    `DamageModifier`, `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`,
    `unit_flags`, `unit_flags2`, `dynamicflags`, `family`, `type`, `type_flags`, `lootid`, `pickpocketloot`,
    `skinloot`, `PetSpellDataId`, `VehicleId`, `mingold`, `maxgold`, `AIName`, `MovementType`, `HoverHeight`,
    `HealthModifier`, `ManaModifier`, `ArmorModifier`, `ExperienceModifier`, `RacialLeader`, `movementId`,
    `RegenHealth`, `CreatureImmunitiesId`, `flags_extra`, `ScriptName`, `VerifiedBuild`
FROM `creature_template` WHERE `entry` = 28472;

INSERT INTO `creature_template`
SELECT 910004, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`,
    'Death Knight Initiate', 'Shadowglen', `IconName`, 0, 60, 60, `exp`, 35, 51,
    `speed_walk`, `speed_run`, `speed_swim`, `speed_flight`, `detection_range`, `rank`, `dmgschool`,
    `DamageModifier`, `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`,
    `unit_flags`, `unit_flags2`, `dynamicflags`, `family`, `type`, `type_flags`, `lootid`, `pickpocketloot`,
    `skinloot`, `PetSpellDataId`, `VehicleId`, `mingold`, `maxgold`, `AIName`, `MovementType`, `HoverHeight`,
    `HealthModifier`, `ManaModifier`, `ArmorModifier`, `ExperienceModifier`, `RacialLeader`, `movementId`,
    `RegenHealth`, `CreatureImmunitiesId`, `flags_extra`, `ScriptName`, `VerifiedBuild`
FROM `creature_template` WHERE `entry` = 28472;

INSERT INTO `creature_template`
SELECT 910005, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`,
    'Death Knight Initiate', 'Anvilmar', `IconName`, 0, 60, 60, `exp`, 35, 51,
    `speed_walk`, `speed_run`, `speed_swim`, `speed_flight`, `detection_range`, `rank`, `dmgschool`,
    `DamageModifier`, `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`,
    `unit_flags`, `unit_flags2`, `dynamicflags`, `family`, `type`, `type_flags`, `lootid`, `pickpocketloot`,
    `skinloot`, `PetSpellDataId`, `VehicleId`, `mingold`, `maxgold`, `AIName`, `MovementType`, `HoverHeight`,
    `HealthModifier`, `ManaModifier`, `ArmorModifier`, `ExperienceModifier`, `RacialLeader`, `movementId`,
    `RegenHealth`, `CreatureImmunitiesId`, `flags_extra`, `ScriptName`, `VerifiedBuild`
FROM `creature_template` WHERE `entry` = 28472;

INSERT INTO `creature_template`
SELECT 910006, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`,
    'Death Knight Initiate', 'Coldridge Valley', `IconName`, 0, 60, 60, `exp`, 35, 51,
    `speed_walk`, `speed_run`, `speed_swim`, `speed_flight`, `detection_range`, `rank`, `dmgschool`,
    `DamageModifier`, `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`,
    `unit_flags`, `unit_flags2`, `dynamicflags`, `family`, `type`, `type_flags`, `lootid`, `pickpocketloot`,
    `skinloot`, `PetSpellDataId`, `VehicleId`, `mingold`, `maxgold`, `AIName`, `MovementType`, `HoverHeight`,
    `HealthModifier`, `ManaModifier`, `ArmorModifier`, `ExperienceModifier`, `RacialLeader`, `movementId`,
    `RegenHealth`, `CreatureImmunitiesId`, `flags_extra`, `ScriptName`, `VerifiedBuild`
FROM `creature_template` WHERE `entry` = 28472;

INSERT INTO `creature_template`
SELECT 910007, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`,
    'Death Knight Initiate', 'Sunstrider Isle', `IconName`, 0, 60, 60, `exp`, 35, 51,
    `speed_walk`, `speed_run`, `speed_swim`, `speed_flight`, `detection_range`, `rank`, `dmgschool`,
    `DamageModifier`, `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`,
    `unit_flags`, `unit_flags2`, `dynamicflags`, `family`, `type`, `type_flags`, `lootid`, `pickpocketloot`,
    `skinloot`, `PetSpellDataId`, `VehicleId`, `mingold`, `maxgold`, `AIName`, `MovementType`, `HoverHeight`,
    `HealthModifier`, `ManaModifier`, `ArmorModifier`, `ExperienceModifier`, `RacialLeader`, `movementId`,
    `RegenHealth`, `CreatureImmunitiesId`, `flags_extra`, `ScriptName`, `VerifiedBuild`
FROM `creature_template` WHERE `entry` = 28472;

INSERT INTO `creature_template`
SELECT 910008, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`,
    'Death Knight Initiate', 'Ammen Vale', `IconName`, 0, 60, 60, `exp`, 35, 51,
    `speed_walk`, `speed_run`, `speed_swim`, `speed_flight`, `detection_range`, `rank`, `dmgschool`,
    `DamageModifier`, `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`,
    `unit_flags`, `unit_flags2`, `dynamicflags`, `family`, `type`, `type_flags`, `lootid`, `pickpocketloot`,
    `skinloot`, `PetSpellDataId`, `VehicleId`, `mingold`, `maxgold`, `AIName`, `MovementType`, `HoverHeight`,
    `HealthModifier`, `ManaModifier`, `ArmorModifier`, `ExperienceModifier`, `RacialLeader`, `movementId`,
    `RegenHealth`, `CreatureImmunitiesId`, `flags_extra`, `ScriptName`, `VerifiedBuild`
FROM `creature_template` WHERE `entry` = 28472;

INSERT INTO `creature_template`
SELECT 910009, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`,
    'Death Knight Initiate', 'Stormwind', `IconName`, 0, 60, 60, `exp`, 35, 51,
    `speed_walk`, `speed_run`, `speed_swim`, `speed_flight`, `detection_range`, `rank`, `dmgschool`,
    `DamageModifier`, `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`,
    `unit_flags`, `unit_flags2`, `dynamicflags`, `family`, `type`, `type_flags`, `lootid`, `pickpocketloot`,
    `skinloot`, `PetSpellDataId`, `VehicleId`, `mingold`, `maxgold`, `AIName`, `MovementType`, `HoverHeight`,
    `HealthModifier`, `ManaModifier`, `ArmorModifier`, `ExperienceModifier`, `RacialLeader`, `movementId`,
    `RegenHealth`, `CreatureImmunitiesId`, `flags_extra`, `ScriptName`, `VerifiedBuild`
FROM `creature_template` WHERE `entry` = 28472;

INSERT INTO `creature_template`
SELECT 910010, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`,
    'Death Knight Initiate', 'Ironforge', `IconName`, 0, 60, 60, `exp`, 35, 51,
    `speed_walk`, `speed_run`, `speed_swim`, `speed_flight`, `detection_range`, `rank`, `dmgschool`,
    `DamageModifier`, `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`,
    `unit_flags`, `unit_flags2`, `dynamicflags`, `family`, `type`, `type_flags`, `lootid`, `pickpocketloot`,
    `skinloot`, `PetSpellDataId`, `VehicleId`, `mingold`, `maxgold`, `AIName`, `MovementType`, `HoverHeight`,
    `HealthModifier`, `ManaModifier`, `ArmorModifier`, `ExperienceModifier`, `RacialLeader`, `movementId`,
    `RegenHealth`, `CreatureImmunitiesId`, `flags_extra`, `ScriptName`, `VerifiedBuild`
FROM `creature_template` WHERE `entry` = 28472;

INSERT INTO `creature_template`
SELECT 910011, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`,
    'Death Knight Initiate', 'Orgrimmar', `IconName`, 0, 60, 60, `exp`, 35, 51,
    `speed_walk`, `speed_run`, `speed_swim`, `speed_flight`, `detection_range`, `rank`, `dmgschool`,
    `DamageModifier`, `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`,
    `unit_flags`, `unit_flags2`, `dynamicflags`, `family`, `type`, `type_flags`, `lootid`, `pickpocketloot`,
    `skinloot`, `PetSpellDataId`, `VehicleId`, `mingold`, `maxgold`, `AIName`, `MovementType`, `HoverHeight`,
    `HealthModifier`, `ManaModifier`, `ArmorModifier`, `ExperienceModifier`, `RacialLeader`, `movementId`,
    `RegenHealth`, `CreatureImmunitiesId`, `flags_extra`, `ScriptName`, `VerifiedBuild`
FROM `creature_template` WHERE `entry` = 28472;

INSERT INTO `creature_template`
SELECT 910012, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`,
    'Death Knight Initiate', 'Undercity', `IconName`, 0, 60, 60, `exp`, 35, 51,
    `speed_walk`, `speed_run`, `speed_swim`, `speed_flight`, `detection_range`, `rank`, `dmgschool`,
    `DamageModifier`, `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`,
    `unit_flags`, `unit_flags2`, `dynamicflags`, `family`, `type`, `type_flags`, `lootid`, `pickpocketloot`,
    `skinloot`, `PetSpellDataId`, `VehicleId`, `mingold`, `maxgold`, `AIName`, `MovementType`, `HoverHeight`,
    `HealthModifier`, `ManaModifier`, `ArmorModifier`, `ExperienceModifier`, `RacialLeader`, `movementId`,
    `RegenHealth`, `CreatureImmunitiesId`, `flags_extra`, `ScriptName`, `VerifiedBuild`
FROM `creature_template` WHERE `entry` = 28472;

INSERT INTO `creature_default_trainer` (`CreatureId`, `TrainerId`) VALUES
(910000, 130), (910001, 130), (910002, 130), (910003, 130), (910004, 130),
(910005, 130), (910006, 130), (910007, 130), (910008, 130), (910009, 130),
(910010, 130), (910011, 130), (910012, 130);

INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `equipment_id`,
    `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`,
    `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`,
    `CreateObject`, `Comment`) VALUES
(910000, 910000, 0, 12, 0, 1, 1, 0, -8914.0, -137.0, 80.5, 5.0, 300, 0, 0, 1, 0, 0, 0, 0, 0, '', 0, 0, NULL),
(910001, 910001, 0, 85, 0, 1, 1, 0, 1676.0, 1678.0, 121.0, 2.7, 300, 0, 0, 1, 0, 0, 0, 0, 0, '', 0, 0, NULL),
(910002, 910002, 1, 14, 0, 1, 1, 0, -618.0, -4250.0, 38.7, 0.0, 300, 0, 0, 1, 0, 0, 0, 0, 0, '', 0, 0, NULL),
(910003, 910003, 1, 215, 0, 1, 1, 0, -2917.0, -258.0, 53.0, 0.0, 300, 0, 0, 1, 0, 0, 0, 0, 0, '', 0, 0, NULL),
(910004, 910004, 1, 141, 0, 1, 1, 0, 10311.0, 832.0, 1326.0, 5.7, 300, 0, 0, 1, 0, 0, 0, 0, 0, '', 0, 0, NULL),
(910005, 910005, 0, 1, 0, 1, 1, 0, -6240.0, 331.0, 383.0, 6.2, 300, 0, 0, 1, 0, 0, 0, 0, 0, '', 0, 0, NULL),
(910006, 910006, 0, 1, 0, 1, 1, 0, -6238.0, 333.0, 383.0, 0.0, 300, 0, 0, 1, 0, 0, 0, 0, 0, '', 0, 0, NULL),
(910007, 910007, 530, 3431, 0, 1, 1, 0, 10349.0, -6357.0, 33.4, 5.3, 300, 0, 0, 1, 0, 0, 0, 0, 0, '', 0, 0, NULL),
(910008, 910008, 530, 3526, 0, 1, 1, 0, -3961.0, -13931.0, 100.6, 2.1, 300, 0, 0, 1, 0, 0, 0, 0, 0, '', 0, 0, NULL),
(910009, 910009, 0, 1519, 0, 1, 1, 0, -8688.0, 325.0, 109.0, 5.0, 300, 0, 0, 1, 0, 0, 0, 0, 0, '', 0, 0, NULL),
(910010, 910010, 0, 1537, 0, 1, 1, 0, -5035.0, -1234.0, 508.0, 5.0, 300, 0, 0, 1, 0, 0, 0, 0, 0, '', 0, 0, NULL),
(910011, 910011, 1, 1637, 0, 1, 1, 0, 1970.0, -4807.0, 24.0, 1.0, 300, 0, 0, 1, 0, 0, 0, 0, 0, '', 0, 0, NULL),
(910012, 910012, 0, 1497, 0, 1, 1, 0, 1633.0, 239.0, -43.0, 1.0, 300, 0, 0, 1, 0, 0, 0, 0, 0, '', 0, 0, NULL);
