UPDATE `spell_proc` SET `SpellPhaseMask`=0x4 WHERE `SpellId`=70803;

-- Fix Halazzi texts id
UPDATE `creature_text` SET `CreatureID`=23577 WHERE `CreatureID`=23557;

--
DELETE FROM `gameobject_queststarter` WHERE `id` = 156561;
INSERT INTO `gameobject_queststarter` (`id`, `quest`) VALUES
(156561, 176);

--
UPDATE `item_template_locale` SET `Description`='' WHERE `ID`=9173;

--
DELETE FROM `trinity_string` WHERE `entry` IN (395, 396);
INSERT INTO `trinity_string` (`entry`,`content_default`) VALUES
(395, '### USAGE: .bg start
Skips battleground preparation time and starts the battle.'),
(396, '### USAGE: .bg stop
Immediately ends the battleground.');

-- Use Dash only when in Cat Form
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=17 AND `SourceGroup`=0 AND `SourceEntry` IN (1850, 9821, 33357);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(17, 0, 1850, 0, 0, 1, 0, 768, 0, 0, 0, 172, 32, '', 'Use Dash Rank1 only when in Cat Form'),
(17, 0, 9821, 0, 0, 1, 0, 768, 0, 0, 0, 172, 32, '', 'Use Dash Rank2 only when in Cat Form'),
(17, 0, 33357, 0, 0, 1, 0, 768, 0, 0, 0, 172, 32, '', 'Use Dash Rank3 only when in Cat Form');

-- Delete two cata texts from db
DELETE FROM `npc_text` WHERE `ID` IN (18268,17425);
DELETE FROM `broadcast_text` WHERE `ID` IN (52965,48369);
DELETE FROM `broadcast_text_locale` WHERE `ID` IN (52965,48369);

--
DELETE FROM `areatrigger_tavern` WHERE `id` = 5309;
INSERT INTO `areatrigger_tavern` (`id`, `name`) VALUES (5309, 'Shadow Vault');

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 30 AND `SourceEntry` = 5309;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(30, 0, 5309, 0, 0, 26, 0, 1, 0, 0, 0, 0, 0, '', 'Shadow Vault tavern requires phase 1.');

--
DELETE FROM `trinity_string` WHERE `entry` IN (216, 1126);

--
UPDATE `quest_template_addon` SET `RequiredMinRepValue`=3000 WHERE `ID` IN (25247,24822,24821,24820,24819);

--
UPDATE `quest_template_addon` SET `SpecialFlags`=1 WHERE `ID` IN (12618,12656);

-- Add repair flag Quartermaster Vaskess
UPDATE `creature_template` SET `npcflag`=`npcflag`|4096 WHERE `entry` = 31115;

UPDATE `smart_scripts` SET `target_type`=8 WHERE
    (`entryorguid`=137300 AND `source_type`=9 AND `id`=19 AND `link`=0) OR
    (`entryorguid`=137300 AND `source_type`=9 AND `id`=20 AND `link`=0) OR
    (`entryorguid`=1433800 AND `source_type`=9 AND `id`=4 AND `link`=0) OR
    (`entryorguid`=2129100 AND `source_type`=9 AND `id`=1 AND `link`=0) OR
    (`entryorguid`=2129100 AND `source_type`=9 AND `id`=13 AND `link`=0) OR
    (`entryorguid`=2711300 AND `source_type`=9 AND `id`=1 AND `link`=0) OR
    (`entryorguid`=2711300 AND `source_type`=9 AND `id`=3 AND `link`=0) OR
    (`entryorguid`=2711400 AND `source_type`=9 AND `id`=1 AND `link`=0) OR
    (`entryorguid`=2711400 AND `source_type`=9 AND `id`=3 AND `link`=0) OR
    (`entryorguid`=2711500 AND `source_type`=9 AND `id`=1 AND `link`=0) OR
    (`entryorguid`=2711600 AND `source_type`=9 AND `id`=3 AND `link`=0) OR
    (`entryorguid`=2875000 AND `source_type`=9 AND `id`=3 AND `link`=0) OR
    (`entryorguid`=3019000 AND `source_type`=9 AND `id`=13 AND `link`=0);

--
DELETE FROM `quest_request_items` WHERE `ID` = 14488;
INSERT INTO `quest_request_items` (`ID`, `EmoteOnComplete`, `EmoteOnIncomplete`, `CompletionText`, `VerifiedBuild`) VALUES
(14488, 1, 0, "I don't remember ordering a cleaning service... why yes, I am Apothecary Hummel.$B$B...wait, what is the meaning of this? You think these meaningless papers can stop me? Hah!", 12340);

DELETE FROM `quest_offer_reward` WHERE `ID` = 14488;
INSERT INTO `quest_offer_reward` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `RewardText`, `VerifiedBuild`) VALUES
(14488, 1, 0, 0, 0, 0, 0, 0, 0, "What we do here is none of your business...", 12340);

-- Quest "Abandoned Mail" should have "Autocomplete" flag
UPDATE `quest_template` SET `Flags`=`Flags`| 65536 WHERE `ID`=12711;

-- Fix quest Cleansing the Scar by updating Eversong Ranger PvpFlags with retail 10.2.5.53262 build: V10_2_5_53262 sniffed value.
UPDATE `creature_template_addon` SET `PvpFlags`=1 WHERE `entry`=15938; -- 15938 (Eversong Ranger)

-- Fix some dberrors
UPDATE `creature` SET `MovementType`=0 WHERE `guid` IN (43202,43203);

-- Honor Hold Archer
UPDATE `creature_template_addon` SET `SheathState`=2, `PvpFlags`=1 WHERE `entry`=16896;
UPDATE `creature_addon` SET `SheathState`=2, `PvpFlags`=1 WHERE `guid` IN (SELECT `guid` FROM `creature` WHERE `id` = 16896);

UPDATE `creature_addon` SET `SheathState`=0 WHERE `guid` =58446;

DELETE FROM `creature_addon` WHERE `guid` IN (58443, 58444, 58445, 58447);
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `MountCreatureID`, `StandState`, `AnimTier`, `VisFlags`, `SheathState`, `PvPFlags`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(58443, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, NULL),
(58444, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, NULL),
(58445, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, NULL),
(58447, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, NULL);

-- SAI
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = -58454);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(-58454, 0, 0, 0, 1, 0, 100, 0, 6000, 6000, 6000, 6000, 0, 11, 33796, 0, 0, 0, 0, 0, 10, 69107, 19376, 0, 0, 0, 0, 0, 0, "Honor Hold Archer - Out of Combat - Cast 'Shoot Bow'");

-- Delete wrong condition
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 13 AND `SourceGroup` = 1 AND `ConditionValue2` = 16898 AND `SourceEntry` = 33796;

-- ConditionTarget
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 13 AND `SourceGroup` = 1 AND `ConditionValue2` = 19376 AND `SourceEntry` = 33796;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(13, 1, 33796, 0, 0, 31, 0, 3, 19376, 0, 0, 0, 0, '', 'Spell 33796 targets Honor Hold Target Dummy Tower');

-- small correction
DELETE FROM `npc_vendor` WHERE `item` IN (21829,21833);
DELETE FROM `game_event_npc_vendor` WHERE `guid` IN (42755,21575,24772,4661,22681,79841,38407,199,14139,14986,28340,9460,46341,17865,7671,28304,80346,66978,6889,42181,33073,54188,15287,41839,1745,690,46343,32451,537,13550,29233,50060,11273,15326,28474,30676,10076,8219,37069,24774,4208,31947,50059,92923,92884,29239) AND `item`=21829;
DELETE FROM `game_event_npc_vendor` WHERE `guid` IN (42755,21575,24772,4661,22681,79841,38407,199,14139,14986,28340,9460,46341,17865,7671,28304,80346,66978,6889,42181,33073,54188,15287,41839,1745,690,46343,32451,537,13550,29233,50060,11273,15326,28474,30676,10076,8219,37069,24774,4208,31947,50059,92923,92884,29239) AND `item`=21833;
INSERT INTO `game_event_npc_vendor` (`eventEntry`, `guid`, `slot`, `item`, `maxcount`, `incrtime`, `ExtendedCost`) VALUES 
(8, 42755, 0, 21829, 0, 0, 0),
(8, 42755, 1, 21833, 0, 0, 0),
(8, 21575, 0, 21829, 0, 0, 0),
(8, 21575, 1, 21833, 0, 0, 0),
(8, 24772, 0, 21829, 0, 0, 0),
(8, 24772, 1, 21833, 0, 0, 0),
(8, 4661, 0, 21829, 0, 0, 0),
(8, 4661, 1, 21833, 0, 0, 0),
(8, 22681, 0, 21829, 0, 0, 0),
(8, 22681, 1, 21833, 0, 0, 0),
(8, 79841, 0, 21829, 0, 0, 0),
(8, 79841, 1, 21833, 0, 0, 0),
(8, 38407, 0, 21829, 0, 0, 0),
(8, 38407, 1, 21833, 0, 0, 0),
(8, 199, 0, 21829, 0, 0, 0),
(8, 199, 1, 21833, 0, 0, 0),
(8, 14139, 0, 21829, 0, 0, 0),
(8, 14139, 1, 21833, 0, 0, 0),
(8, 14986, 0, 21829, 0, 0, 0),
(8, 14986, 1, 21833, 0, 0, 0),
(8, 28340, 0, 21829, 0, 0, 0),
(8, 28340, 1, 21833, 0, 0, 0),
(8, 9460, 0, 21829, 0, 0, 0),
(8, 9460, 1, 21833, 0, 0, 0),
(8, 46341, 0, 21829, 0, 0, 0),
(8, 46341, 1, 21833, 0, 0, 0),
(8, 17865, 0, 21829, 0, 0, 0),
(8, 17865, 1, 21833, 0, 0, 0),
(8, 7671, 0, 21829, 0, 0, 0),
(8, 7671, 1, 21833, 0, 0, 0),
(8, 28304, 0, 21829, 0, 0, 0),
(8, 28304, 1, 21833, 0, 0, 0),
(8, 80346, 0, 21829, 0, 0, 0),
(8, 80346, 1, 21833, 0, 0, 0),
(8, 66978, 0, 21829, 0, 0, 0),
(8, 66978, 1, 21833, 0, 0, 0),
(8, 6889, 0, 21829, 0, 0, 0),
(8, 6889, 1, 21833, 0, 0, 0),
(8, 42181, 0, 21829, 0, 0, 0),
(8, 42181, 1, 21833, 0, 0, 0),
(8, 33073, 0, 21829, 0, 0, 0),
(8, 33073, 1, 21833, 0, 0, 0),
(8, 54188, 0, 21829, 0, 0, 0),
(8, 54188, 1, 21833, 0, 0, 0),
(8, 15287, 0, 21829, 0, 0, 0),
(8, 15287, 1, 21833, 0, 0, 0),
(8, 41839, 0, 21829, 0, 0, 0),
(8, 41839, 1, 21833, 0, 0, 0),
(8, 1745, 0, 21829, 0, 0, 0),
(8, 1745, 1, 21833, 0, 0, 0),
(8, 690, 0, 21829, 0, 0, 0),
(8, 690, 1, 21833, 0, 0, 0),
(8, 46343, 0, 21829, 0, 0, 0),
(8, 46343, 1, 21833, 0, 0, 0),
(8, 32451, 0, 21829, 0, 0, 0),
(8, 32451, 1, 21833, 0, 0, 0),
(8, 537, 0, 21829, 0, 0, 0),
(8, 537, 1, 21833, 0, 0, 0),
(8, 13550, 0, 21829, 0, 0, 0),
(8, 13550, 1, 21833, 0, 0, 0),
(8, 29233, 0, 21829, 0, 0, 0),
(8, 29233, 1, 21833, 0, 0, 0),
(8, 50060, 0, 21829, 0, 0, 0),
(8, 50060, 1, 21833, 0, 0, 0),
(8, 11273, 0, 21829, 0, 0, 0),
(8, 11273, 1, 21833, 0, 0, 0),
(8, 15326, 0, 21829, 0, 0, 0),
(8, 15326, 1, 21833, 0, 0, 0),
(8, 28474, 0, 21829, 0, 0, 0),
(8, 28474, 1, 21833, 0, 0, 0),
(8, 30676, 0, 21829, 0, 0, 0),
(8, 30676, 1, 21833, 0, 0, 0),
(8, 10076, 0, 21829, 0, 0, 0),
(8, 10076, 1, 21833, 0, 0, 0),
(8, 8219, 0, 21829, 0, 0, 0),
(8, 8219, 1, 21833, 0, 0, 0),
(8, 37069, 0, 21829, 0, 0, 0),
(8, 37069, 1, 21833, 0, 0, 0),
(8, 24774, 0, 21829, 0, 0, 0),
(8, 24774, 1, 21833, 0, 0, 0),
(8, 4208, 0, 21829, 0, 0, 0),
(8, 4208, 1, 21833, 0, 0, 0),
(8, 31947, 0, 21829, 0, 0, 0),
(8, 31947, 1, 21833, 0, 0, 0),
(8, 50059, 0, 21829, 0, 0, 0),
(8, 50059, 1, 21833, 0, 0, 0),
(8, 92923, 0, 21829, 0, 0, 0),
(8, 92923, 1, 21833, 0, 0, 0),
(8, 92884, 0, 21829, 0, 0, 0),
(8, 92884, 1, 21833, 0, 0, 0),
(8, 29239, 0, 21829, 0, 0, 0),
(8, 29239, 1, 21833, 0, 0, 0);

-- Gondria https://www.wowhead.com/wotlk/npc=33776/gondria#abilities
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 33776;
DELETE FROM `smart_scripts` WHERE `entryorguid` = 33776 AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(33776, 0, 0, 0, 0, 0, 100, 0, 3000, 7000, 12000, 15000, 0, 11, 61184, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, "Gondria - In Combat - Cast 'Pounce'"),
(33776, 0, 1, 0, 0, 0, 100, 0, 5000, 9000, 8000, 13000, 0, 11, 61186, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, "Gondria - In Combat - Cast 'Frozen Bite'");

-- Loque'nahak added again missing frozen bite https://www.wowhead.com/wotlk/npc=32517/loquenahak#abilities
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 32517;
DELETE FROM `smart_scripts` WHERE `entryorguid` = 32517 AND `source_type` = 0 AND `id` = 1;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(32517, 0, 1, 0, 0, 0, 100, 0, 1000, 5000, 8000, 13000, 0, 11, 61186, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, "Loque\'nahak - In Combat - Cast 'Frozen Bite'");

-- Skoll added again missing frozen bite https://www.wowhead.com/wotlk/npc=35189/skoll#abilities
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 35189;
DELETE FROM `smart_scripts` WHERE `entryorguid` = 35189 AND `source_type` = 0 AND `id` = 1;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(35189, 0, 1, 0, 0, 0, 100, 0, 1000, 5000, 8000, 13000, 0, 11, 61186, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, "Skoll - In Combat - Cast 'Frozen Bite'");

-- Azurous rename wrong comment and correct sai order id https://www.wowhead.com/wotlk/npc=10202/azurous#abilities
UPDATE `smart_scripts` SET `id` = 0, `comment` = "Azurous - In Combat - Cast 'Frost Breath'" WHERE `entryorguid` = 10202 AND `source_type` = 0 AND `id` = 1;

-- Avruu https://www.wowhead.com/wotlk/npc=17084/avruu#abilities
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=17084;
DELETE FROM `smart_scripts` WHERE `entryorguid`=17084 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(17084, 0, 0, 0, 74, 0, 100, 0, 0, 40, 15000, 18000, 30, 11, 16588, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, "Avruu - On Friendly Between 0-40% Health - Cast 'Dark Mending'"),
(17084, 0, 1, 0, 0, 0, 100, 0, 0, 0, 8000, 8000, 0, 11, 34112, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, "Avruu - In Combat - Cast 'Judgement of Darkness'");

-- Warmaul Brute https://www.wowhead.com/wotlk/npc=18065/warmaul-brute#abilities;mode:normal
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=18065;
DELETE FROM `smart_scripts` WHERE `entryorguid`=18065 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(18065, 0, 0, 0, 0, 0, 100, 0, 4000, 7000, 9000, 12000, 0, 11, 10966, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, "Warmaul Brute  - In Combat - Cast 'Uppercut'");

-- Warp Monstrosity https://www.wowhead.com/wotlk/npc=20516/warp-monstrosity#abilities
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 20516;
DELETE FROM `smart_scripts` WHERE `entryorguid` = 20516 AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(20516, 0, 0, 0, 0, 0, 100, 0, 3000, 7000, 12000, 15000, 0, 11, 13901, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, "Warp Monstrosity - In Combat - Cast 'Arcane Bolt'"),
(20516, 0, 1, 0, 0, 0, 100, 1, 5000, 9000, 8000, 13000, 0, 11, 36577, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, "Warp Monstrosity - In Combat - Cast 'Warp Storm'");

-- Onyx Blaze Mistress
SET @ENTRY := 30681;
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `source_type`=0 AND `entryorguid`=@ENTRY;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,0,0,100,2,5000,5000,12000,13000,11,39529,0,0,0,0,0,2,0,0,0,0,0,0,0,'Cast Flame Shock'),
(@ENTRY,0,1,0,0,0,100,4,5000,5000,12000,13000,11,58940,0,0,0,0,0,2,0,0,0,0,0,0,0,'Cast Flame Shock'),
(@ENTRY,0,2,0,0,0,100,2,8000,8000,19000,22000,11,57757,0,0,0,0,0,5,0,0,0,0,0,0,0,'Cast Rain of Fire'),
(@ENTRY,0,3,0,0,0,100,4,8000,8000,19000,22000,11,58936,0,0,0,0,0,5,0,0,0,0,0,0,0,'Cast Rain of Fire'),
(@ENTRY,0,4,0,0,0,100,6,3000,11000,8000,15000,11,57753,0,0,0,0,0,5,0,0,0,0,0,0,0,'Cast Conjure Flame Orb');

-- Onyx Brood General
SET @ENTRY := 30680;
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `source_type`=0 AND `entryorguid`=@ENTRY;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,4,0,100,3,0,0,0,0,11,57740,0,0,0,0,0,1,0,0,0,0,0,0,0,'Cast Devotion Aura on Aggro'),
(@ENTRY,0,1,0,4,0,100,5,0,0,0,0,11,58944,0,0,0,0,0,1,0,0,0,0,0,0,0,'Cast Devotion Aura on Aggro'),
(@ENTRY,0,2,0,0,0,100,6,4500,4500,11500,13500,11,13737,0,0,0,0,0,2,0,0,0,0,0,0,0,'Cast Mortal Strike Shock'),
(@ENTRY,0,3,0,0,0,100,7,6000,6000,0,0,11,57742,0,0,0,0,0,1,0,0,0,0,0,0,0,'Cast Avenging Fury Shock'),
(@ENTRY,0,4,0,2,0,100,3,0,30,0,0,11,57733,0,0,0,0,0,1,0,0,0,0,0,0,0,'Cast Draconic Rage at 30% HP'),
(@ENTRY,0,5,0,2,0,100,5,0,30,0,0,11,58942,0,0,0,0,0,1,0,0,0,0,0,0,0,'Cast Draconic Rage at 30% HP'),
(@ENTRY,0,6,0,37,0,100,0,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,' Onyx Brood General -  On init -  say text');

DELETE FROM `creature_text` WHERE `CreatureID`=@ENTRY;
INSERT INTO `creature_text` (`CreatureID`, `groupid`, `id`, `text`, `type`, `language`, `probability`, `emote`, `duration`, `sound`, `comment`, `BroadcastTextId`) VALUES
(@ENTRY,0,0, 'Brood Guardians reporting in!',14,0,100,0,0,0, 'Onyx Brood General', 31397);

-- Onyx Flight Captain
SET @ENTRY := 30682;
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `source_type`=0 AND `entryorguid`=@ENTRY;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,13,0,100,6,12000,14000,0,0,11,58953,0,0,0,0,0,2,0,0,0,0,0,0,0,'Cast Pummel'),
(@ENTRY,0,1,0,0,0,100,6,8000,9000,15000,21000,11,57759,0,0,0,0,0,2,0,0,0,0,0,0,0,'Cast Hammer Drop');

-- Onyx Sanctum Guardian
SET @ENTRY := 30453;
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `source_type`=0 AND `entryorguid`=@ENTRY;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,0,0,100,2,4000,5500,25000,31000,11,58948,0,0,0,0,0,5,0,0,0,0,0,0,0,'Cast Curse of Mending'),
(@ENTRY,0,1,0,0,0,100,4,4000,5500,25000,31000,11,39647,0,0,0,0,0,5,0,0,0,0,0,0,0,'Cast Curse of Mending'),
(@ENTRY,0,2,0,0,0,100,2,9000,9000,17800,19300,11,57728,0,0,0,0,0,2,0,0,0,0,0,0,0,'Cast Shockwave'),
(@ENTRY,0,3,0,0,0,100,4,9000,9000,17800,19300,11,58947,0,0,0,0,0,2,0,0,0,0,0,0,0,'Cast Shockwave'),
(@ENTRY,0,4,0,2,0,100,7,0,30,0,0,11,53801,0,0,0,0,0,1,0,0,0,0,0,0,0,'Cast Frenzy at 30% HP'),
(@ENTRY,0,5,0,2,0,100,7,0,30,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Say Text at 30% HP'),
(@ENTRY,0,6,0,37,0,100,0,0,0,0,0,1,1,0,0,0,0,0,1,0,0,0,0,0,0,0,' Onyx Sanctum Guardian -  On init -  say text');

-- NPC talk text insert
SET @ENTRY := 30453;
DELETE FROM `creature_text` WHERE `CreatureID`=@ENTRY;
INSERT INTO `creature_text` (`CreatureID`, `groupid`, `id`, `text`, `type`, `language`, `probability`, `emote`, `duration`, `sound`, `comment`, `BroadcastTextId`) VALUES
(@ENTRY,0,0, '%s goes into a frenzy!',16,0,100,0,0,0, 'Onyx Sanctum Guardian', 38630),
(@ENTRY,1,0, 'Sanctum Guardians reporting in!',14,0,100,0,0,0, 'Onyx Sanctum Guardian', 31398);

DELETE FROM `spell_scripts` WHERE `id`=57753;
INSERT INTO `spell_scripts` (`id`,`effIndex`,`delay`,`command`,`datalong`,`datalong2`,`dataint`,`x`,`y`,`z`,`o`) VALUES
(57753,0,0,15,57752,1,0,0,0,0,0);

UPDATE `creature_template` SET `minlevel`=80, `maxlevel`=80, `flags_extra` = `flags_extra` | 128 WHERE `entry`=30702;
DELETE FROM `creature_template_movement` WHERE `CreatureId`=30702;
INSERT INTO `creature_template_movement` (`CreatureId`, `Ground`, `Swim`, `Flight`, `Rooted`, `Chase`, `Random`) VALUES
(30702, 1, 0, 1, 0, 0, 0);

SET @ENTRY := 30702;
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `source_type`=0 AND `entryorguid`=@ENTRY;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,54,0,100,2,0,0,0,0,11,57750,0,0,0,0,0,1,0,0,0,0,0,0,0,'Flame Orb - On just summoned cast Flame Orb Periodic'),
(@ENTRY,0,1,0,54,0,100,4,0,0,0,0,11,58937,0,0,0,0,0,1,0,0,0,0,0,0,0,'Flame Orb - On just summoned cast Flame Orb Periodic');

-- Obsidian Sanctum waypoints
UPDATE `creature` SET `position_x`=3350.9028, `position_y`=605.6205, `position_z`=81.4778, `orientation`=5.927615 WHERE `guid`=126408;
UPDATE `creature` SET `MovementType`=0, `wander_distance`=0 WHERE `id` IN (30682, 30681, 30680, 30453);
UPDATE `creature` SET `MovementType`=2, `wander_distance`=0 WHERE `guid` IN (126400, 126416, 126419, 126397, 126420);
DELETE FROM `waypoint_data` WHERE `id` IN (1264000, 1263970, 1264190, 1264200, 1264160);
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `action_chance`) VALUES
(1264190, 1, 3332.0102, 429.091, 78.794, 1.5062, 100),
(1264190, 2, 3343.9570, 452.438, 85.929, 1.0978, 100),
(1264190, 3, 3369.7429, 476.040, 89.712, 0.7208, 100),
(1264190, 4, 3382.5805, 500.874, 95.542, 1.1017, 100),
(1264190, 5, 3383.0485, 527.715, 97.365, 1.5533, 100),
(1264190, 6, 3388.1821, 558.191, 93.693, 1.4002, 100),
(1264190, 7, 3393.3735, 595.698, 89.438, 1.4512, 100),
(1264190, 8, 3373.2280, 612.496, 86.898, 2.4644, 100),
(1264190, 9, 3342.7526, 637.813, 84.871, 2.4487, 100),
(1264190, 10, 3301.7080, 670.548, 84.361, 2.468, 100),
(1264190, 11, 3270.8374, 685.738, 90.816, 2.684, 100),
(1264190, 12, 3237.6757, 683.316, 90.025, 3.214, 100),
(1264190, 13, 3207.4113, 681.106, 90.128, 3.214, 100),
(1264190, 14, 3174.1948, 682.600, 83.377, 3.096, 100),
(1264190, 15, 3141.6208, 648.341, 75.023, 3.952, 100),
(1264190, 16, 3114.3566, 607.690, 74.483, 4.121, 100),
(1264190, 17, 3141.6208, 648.341, 75.023, 3.952, 100),
(1264190, 18, 3174.1948, 682.600, 83.377, 3.096, 100),
(1264190, 19, 3207.4113, 681.106, 90.128, 3.214, 100),
(1264190, 20, 3237.6757, 683.316, 90.025, 3.214, 100),
(1264190, 21, 3270.8374, 685.738, 90.816, 2.684, 100),
(1264190, 22, 3301.7080, 670.548, 84.361, 2.468, 100),
(1264190, 23, 3342.7526, 637.813, 84.871, 2.448, 100),
(1264190, 24, 3373.2280, 612.496, 86.898, 2.464, 100),
(1264190, 25, 3393.3735, 595.698, 89.438, 1.451, 100),
(1264190, 26, 3388.1821, 558.191, 93.693, 1.400, 100),
(1264190, 27, 3383.0485, 527.715, 97.365, 1.553, 100),
(1264190, 28, 3382.5805, 500.874, 95.542, 1.101, 100),
(1264190, 29, 3369.7429, 476.040, 89.712, 0.720, 100),
(1264190, 30, 3343.9570, 452.438, 85.929, 1.097, 100),
(1264190, 31, 3332.0102, 429.091, 78.794, 1.506, 100),
(1263970, 1, 3372.50, 598.436, 86.154, 5.66, 100),
(1263970, 2, 3391.99, 584.598, 88.329, 5.55, 100),
(1263970, 3, 3385.81, 556.752, 93.731, 4.49, 100),
(1263970, 4, 3380.11, 519.343, 97.941, 4.72, 100),
(1263970, 5, 3376.38, 486.877, 92.088, 4.62, 100),
(1263970, 6, 3383.20, 517.591, 97.957, 1.39, 100),
(1263970, 7, 3388.67, 556.848, 94.038, 1.37, 100),
(1263970, 8, 3391.25, 595.820, 88.642, 1.52, 100),
(1263970, 9, 3356.48, 624.187, 85.876, 2.46, 100),
(1263970, 10,3321.08, 643.297, 82.100, 2.69, 100),
(1263970, 11,3294.79, 668.056, 84.307, 2.39, 100),
(1263970, 12,3268.38, 681.741, 90.226, 2.66, 100),
(1263970, 13,3219.20, 687.871, 91.717, 3.01, 100),
(1263970, 14,3183.79, 691.095, 88.156, 3.05, 100),
(1263970, 15,3149.17, 654.760, 75.371, 3.94, 100),
(1263970, 16,3183.79, 691.095, 88.156, 3.05, 100),
(1263970, 17,3219.20, 687.871, 91.717, 3.01, 100),
(1263970, 18,3268.38, 681.741, 90.226, 2.66, 100),
(1263970, 19,3294.79, 668.056, 84.307, 2.39, 100),
(1263970, 20,3321.08, 643.297, 82.100, 2.69, 100),
(1263970, 21,3356.48, 624.187, 85.876, 2.46, 100),
(1263970, 22,3391.25, 595.820, 88.642, 1.52, 100),
(1263970, 23,3388.67, 556.848, 94.038, 1.37, 100),
(1263970, 24,3383.20, 517.591, 97.957, 1.39, 100),
(1263970, 25,3376.38, 486.877, 92.088, 4.62, 100),
(1263970, 26,3380.11, 519.343, 97.941, 4.72, 100),
(1263970, 27,3385.81, 556.752, 93.731, 4.49, 100),
(1263970, 28,3391.99, 584.598, 88.329, 5.55, 100),
(1263970, 29,3372.50, 598.436, 86.154, 5.66, 100),
(1264200, 1, 3267.378, 698.5934, 92.354, 5.718285, 100),
(1264200, 2, 3302.062, 672.2496, 84.765, 5.522720, 100),
(1264200, 3, 3333.458, 652.1536, 84.932, 5.457532, 100),
(1264200, 4, 3352.582, 626.3783, 85.136, 5.350718, 100),
(1264200, 5, 3373.487, 611.5072, 86.704, 5.664877, 100),
(1264200, 6, 3391.500, 594.7894, 88.706, 4.840994, 100),
(1264200, 7, 3384.716, 561.2724, 92.617, 4.339125, 100),
(1264200, 8, 3374.466, 534.5934, 96.967, 4.600662, 100),
(1264200, 9, 3391.568, 567.7532, 90.748, 1.094646, 100),
(1264200, 10,3391.582, 594.7891, 88.731, 1.762235, 100),
(1264200, 11,3363.784, 617.0189, 86.301, 2.468308, 100),
(1264200, 12,3324.081, 648.6863, 83.291, 2.468308, 100),
(1264200, 13,3288.948, 676.7089, 87.241, 2.468308, 100),
(1264200, 14,3263.845, 694.3148, 91.789, 2.939547, 100),
(1264200, 15,3213.507, 690.4353, 92.251, 3.079348, 100),
(1264200, 16,3182.588, 679.6979, 84.685, 3.670753, 100),
(1264200, 17,3158.388, 665.5455, 76.847, 3.670753, 100),
(1264200, 18,3137.634, 639.5677, 74.070, 4.038320, 100),
(1264200, 19,3119.810, 617.2574, 74.045, 4.038320, 100),
(1264200, 20,3102.376, 593.9634, 78.290, 4.862988, 100),
(1264200, 21,3110.314, 567.3189, 88.657, 5.100964, 100),
(1264200, 22,3115.361, 539.7775, 87.775, 4.893619, 100),
(1264200, 23,3110.314, 567.3189, 88.657, 5.100964, 100),
(1264200, 24,3102.376, 593.9634, 78.290, 4.862988, 100),
(1264200, 25,3119.810, 617.2574, 74.045, 4.038320, 100),
(1264200, 26,3137.634, 639.5677, 74.070, 4.038320, 100),
(1264200, 27,3158.388, 665.5455, 76.847, 3.670753, 100),
(1264200, 28,3182.588, 679.6979, 84.685, 3.670753, 100),
(1264200, 29,3213.507, 690.4353, 92.251, 3.079348, 100),
(1264200, 30,3263.845, 694.3148, 91.789, 2.939547, 100),
(1264200, 31,3288.948, 676.7089, 87.241, 2.468308, 100),
(1264200, 32,3324.081, 648.6863, 83.291, 2.468308, 100),
(1264200, 33,3363.784, 617.0189, 86.301, 2.468308, 100),
(1264200, 34,3391.582, 594.7891, 88.731, 1.762235, 100),
(1264200, 35,3391.568, 567.7532, 90.748, 1.094646, 100),
(1264200, 36,3374.466, 534.5934, 96.967, 4.600662, 100),
(1264200, 37,3384.716, 561.2724, 92.617, 4.339125, 100),
(1264200, 38,3391.500, 594.7894, 88.706, 4.840994, 100),
(1264200, 39,3373.487, 611.5072, 86.704, 5.664877, 100),
(1264200, 40,3352.582, 626.3783, 85.136, 5.350718, 100),
(1264200, 41,3333.458, 652.1536, 84.932, 5.457532, 100),
(1264200, 42,3302.062, 672.2496, 84.765, 5.522720, 100),
(1264200, 43,3267.378, 698.5934, 92.354, 5.718285, 100),
(1264000, 1, 3105.902, 624.807, 77.330, 1.0742, 100),
(1264000, 2, 3105.188, 574.659, 84.079, 4.7302, 100),
(1264000, 3, 3113.553, 547.966, 89.451, 5.0090, 100),
(1264000, 4, 3124.773, 514.301, 88.815, 5.0247, 100),
(1264000, 5, 3121.065, 479.498, 85.652, 4.6085, 100),
(1264000, 6, 3150.509, 448.767, 74.152, 5.4763, 100),
(1264000, 7, 3123.917, 476.544, 84.755, 2.3112, 100),
(1264000, 8, 3126.805, 516.656, 88.732, 1.5022, 100),
(1264000, 9, 3124.108, 554.401, 89.366, 1.6436, 100),
(1264000, 10,3112.344, 567.310, 88.989, 2.3112, 100),
(1264000, 11,3105.551, 601.957, 76.657, 1.5651, 100),
(1264000, 12,3120.267, 631.088, 75.817, 1.0389, 100),
(1264000, 13,3145.446, 657.818, 76.254, 0.8150, 100),
(1264000, 14,3172.876, 676.411, 81.777, 0.6108, 100),
(1264000, 15,3214.683, 691.091, 92.328, 0.3399, 100),
(1264000, 16,3172.876, 676.411, 81.777, 0.6108, 100),
(1264000, 17,3145.446, 657.818, 76.254, 0.8150, 100),
(1264000, 18,3120.267, 631.088, 75.817, 1.0389, 100),
(1264000, 19,3105.551, 601.957, 76.657, 1.5651, 100),
(1264000, 20,3112.344, 567.310, 88.989, 2.3112, 100),
(1264000, 21,3124.108, 554.401, 89.366, 1.6436, 100),
(1264000, 22,3126.805, 516.656, 88.732, 1.5022, 100),
(1264000, 23,3123.917, 476.544, 84.755, 2.3112, 100),
(1264000, 24,3150.509, 448.767, 74.152, 5.4763, 100),
(1264000, 25,3121.065, 479.498, 85.652, 4.6085, 100),
(1264000, 26,3124.773, 514.301, 88.815, 5.0247, 100),
(1264000, 27,3113.553, 547.966, 89.451, 5.0090, 100),
(1264000, 28,3105.188, 574.659, 84.079, 4.7302, 100),
(1264000, 29,3105.902, 624.807, 77.330, 1.0742, 100),
(1264160, 1, 3116.570, 545.821, 89.641, 2.33874, 100),
(1264160, 2, 3107.309, 567.170, 88.081, 1.96174, 100),
(1264160, 3, 3100.440, 583.835, 80.126, 1.96174, 100),
(1264160, 4, 3107.502, 609.043, 75.329, 1.29111, 100),
(1264160, 5, 3139.049, 641.823, 74.297, 0.81201, 100),
(1264160, 6, 3169.191, 674.250, 80.787, 0.82772, 100),
(1264160, 7, 3190.718, 691.628, 89.769, 0.61174, 100),
(1264160, 8, 3217.072, 686.743, 91.574, 6.09775, 100),
(1264160, 9, 3251.472, 680.290, 90.060, 6.09775, 100),
(1264160, 10,3280.618, 680.097, 89.147, 6.27445, 100),
(1264160, 11,3314.501, 656.239, 83.067, 5.66970, 100),
(1264160, 12,3338.522, 626.918, 82.767, 5.39874, 100),
(1264160, 13,3372.639, 598.328, 86.184, 5.28485, 100),
(1264160, 14,3395.046, 570.734, 89.737, 5.17490, 100),
(1264160, 15,3381.180, 541.152, 96.536, 4.47196, 100),
(1264160, 16,3380.853, 495.767, 94.225, 4.66046, 100),
(1264160, 17,3381.180, 541.152, 96.536, 4.47196, 100),
(1264160, 18,3395.046, 570.734, 89.737, 5.17490, 100),
(1264160, 19,3372.639, 598.328, 86.184, 5.28485, 100),
(1264160, 20,3338.522, 626.918, 82.767, 5.39874, 100),
(1264160, 21,3314.501, 656.239, 83.067, 5.66970, 100),
(1264160, 22,3280.618, 680.097, 89.147, 6.27445, 100),
(1264160, 23,3251.472, 680.290, 90.060, 6.09775, 100),
(1264160, 24,3217.072, 686.743, 91.574, 6.09775, 100),
(1264160, 25,3190.718, 691.628, 89.769, 0.61174, 100),
(1264160, 26,3169.191, 674.250, 80.787, 0.82772, 100),
(1264160, 27,3139.049, 641.823, 74.297, 0.81201, 100),
(1264160, 28,3107.502, 609.043, 75.329, 1.29111, 100),
(1264160, 29,3100.440, 583.835, 80.126, 1.96174, 100),
(1264160, 30,3107.309, 567.170, 88.081, 1.96174, 100),
(1264160, 31,3116.570, 545.821, 89.641, 2.33874, 100);

DELETE FROM `creature_template_addon` WHERE `entry` IN (30882, 31539);
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `MountCreatureID`, `StandState`, `AnimTier`, `VisFlags`, `SheathState`, `PvPFlags`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(30882, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3, "58547"),
(31539, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3, "58547");

DELETE FROM `creature_addon` WHERE `guid` IN (126400, 126416, 126419, 126397, 126420);
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `MountCreatureID`, `StandState`, `AnimTier`, `VisFlags`, `SheathState`, `PvPFlags`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(126400, 1264000, 0, 0, 0, 0, 0, 1, 0, 0, 3, ""),
(126416, 1264160, 0, 0, 0, 0, 0, 1, 0, 0, 3, ""),
(126419, 1264190, 0, 0, 0, 0, 0, 1, 0, 0, 3, ""),
(126397, 1263970, 0, 0, 0, 0, 0, 1, 0, 0, 3, ""),
(126420, 1264200, 0, 0, 0, 0, 0, 1, 0, 0, 3, "");

DELETE FROM `creature_formations` WHERE `leaderGUID`=126396;

DELETE FROM `creature_formations` WHERE `leaderGUID` IN (126400, 126416, 126419, 126397, 126420);
INSERT INTO `creature_formations` (`leaderGUID`,`memberGUID`,`dist`,`angle`,`groupAI`, `point_1`, `point_2`) VALUES
(126400, 126400, 0, 0, 515, 0, 0),
(126400, 126406, 10, 90, 515, 2, 7),
(126400, 126412, 15, 0, 515, 2, 7),
(126400, 126405, 10, 270, 515, 2, 7),
(126397, 126397, 0, 0, 515, 0, 0),
(126397, 126408, 10, 90, 515, 2, 7),
(126397, 126401, 15, 0, 515, 2, 7),
(126397, 126407, 10, 270, 515, 2, 7),
(126416, 126416, 0, 0, 515, 0, 0),
(126416, 126417, 15, 0, 515, 0, 0),
(126419, 126419, 0, 0, 515, 0, 0),
(126419, 126418, 15, 0, 515, 0, 0),
(126420, 126420, 0, 0, 515, 0, 0),
(126420, 126421, 15, 0, 515, 0, 0);

-- Correct respawn time for Wild Turkey
UPDATE `creature` SET `spawntimesecs` = 300 WHERE `id` = 32820;

-- Unlink unrelated MFF gamobject
DELETE FROM `game_event_gameobject` WHERE `guid`=17176 AND `eventEntry`=1;
-- Delete unrelated MFF gameobject
DELETE FROM `gameobject` WHERE `id`=181300 AND `guid`=17176;
DELETE FROM `gameobject_addon` WHERE `guid`=17176;

-- Unlink unrelated box gamobject
DELETE FROM `game_event_gameobject` WHERE `guid`=43692 AND `eventEntry`=8;
-- Delete unrelated box gameobject
DELETE FROM `gameobject` WHERE `id`=181015 AND `guid`=43692;
DELETE FROM `gameobject_addon` WHERE `guid`=43692;

-- The Brothers Bronzebeard must have The Master Explorer
UPDATE `quest_template_addon` SET `PrevQuestID`=12880 WHERE id IN (12973,13417);

-- 
UPDATE `conditions` SET `ConditionValue1`=13160 WHERE `SourceTypeOrReferenceId`=15 AND `SourceGroup`=10111 AND `ConditionValue1`=13147 AND `ElseGroup`=3;

-- Bodley - Pieces of Lord Valthalak's Amulet: Set correct spellID for recover gossips
UPDATE `smart_scripts` SET `action_param1`=27542,`comment`='Bodley - On Gossip Select - Cast Add Item Top' WHERE `entryorguid`=16033 AND `source_type`=0 AND `event_param1`=57015 AND `event_param2`=0;
UPDATE `smart_scripts` SET `action_param1`=27544,`comment`='Bodley - On Gossip Select - Cast Add Item Left' WHERE `entryorguid`=16033 AND `source_type`=0 AND `event_param1`=57015 AND `event_param2`=1;

-- Proto-Drake Whelp
DELETE FROM `creature_template_addon` WHERE `entry` =32592;
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `MountCreatureID`, `StandState`, `AnimTier`, `VisFlags`, `SheathState`, `PvPFlags`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(32592, 0, 0, 0, 0, 3, 0, 1, 0, 0, 0, "52970");

DELETE FROM `creature_template_movement` WHERE `CreatureId`=32592;
INSERT INTO `creature_template_movement` (`CreatureId`, `Ground`, `Swim`, `Flight`, `Rooted`, `Chase`, `Random`, `InteractionPauseTimer`) VALUES
(32592, 0, 0, 1, 0, 0, 0, NULL);

-- Update Proto-Drake Handler SAI
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 24082;
DELETE FROM `smart_scripts` WHERE `entryorguid` = 24082 AND `source_type` = 0 AND `id` IN (4, 5);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(24082, 0, 4, 0, 0, 0, 100, 2, 5000, 10000, 35000, 40000, 0, 11, 43664, 0, 0, 0, 0, 0, 11, 24083, 0, 1, 0, 0, 0, 0, 0, "Proto-Drake Handler - In Combat - Cast 'Unholy Rage' Target Enslaved Proto-Drake (Normal Dungeon)"),
(24082, 0, 5, 0, 0, 0, 100, 4, 5000, 10000, 35000, 40000, 0, 11, 59694, 0, 0, 0, 0, 0, 11, 24083, 0, 1, 0, 0, 0, 0, 0, "Proto-Drake Handler - In Combat - Cast 'Unholy Rage' Target Enslaved Proto-Drake (Heroic Dungeon)");

-- ConditionTarget thanks @Nyr97
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=13 AND `SourceEntry`IN (43664, 59694) AND `SourceId`=0 AND `ElseGroup`=0 AND `ConditionTypeOrReference`=31 AND `ConditionTarget`=0 AND `ConditionValue1`=3 AND `ConditionValue2`=24083 AND `ConditionValue3`=0;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES 
(13, 3, 43664, 0, 0, 31, 0, 3, 24083, 0, 0, 0, 0, '', 'Unholy Rage - Target Enslaved Proto-Drake'),
(13, 3, 59694, 0, 0, 31, 0, 3, 24083, 0, 0, 0, 0, '', 'Unholy Rage - Target Enslaved Proto-Drake');

-- update target_type only for Stillpine Ancestor Vark - On Script - Say Line 0 (following Stillpine Ancestor Yor scripts)
UPDATE `smart_scripts` SET `target_type`=23 WHERE `entryorguid`=1741000 AND `source_type`=9 AND `action_type`=1;

-- Fix credit cmangos
UPDATE `quest_template_addon` SET `ExclusiveGroup`=0, `NextQuestId`=0 WHERE `ID`=12008;

-- Duggan Wildhammer
-- Add random movement
UPDATE `creature` SET `wander_distance` = 10, `MovementType` = 1 WHERE `id` = 10817;
-- Correct walk speed
UPDATE `creature_template` SET `speed_walk` = 1 WHERE `entry` = 10817;

-- Creature text
DELETE FROM `smart_scripts` WHERE `entryorguid`= 10817 AND `source_type`=0 AND `id`>2;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(10817, 0, 3, 0, 0, 0, 100, 1, 0, 0, 0, 0, 0, 1, 9, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, "Duggan Wildhammer - In Combat - Say Line 9"),
(10817, 0, 4, 0, 1, 0, 100, 0, 3000, 3000, 180000, 180000, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "Duggan Wildhammer - Out of Combat - Say Line 0"),
(10817, 0, 5, 0, 1, 0, 100, 0, 15000, 15000, 180000, 180000, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "Duggan Wildhammer - Out of Combat - Say Line 1"),
(10817, 0, 6, 0, 1, 0, 100, 0, 25000, 25000, 80000, 80000, 0, 1, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "Duggan Wildhammer - Out of Combat - Say Line 2"),
(10817, 0, 7, 0, 1, 0, 100, 0, 40000, 40000, 180000, 180000, 0, 1, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "Duggan Wildhammer - Out of Combat - Say Line 3"),
(10817, 0, 8, 0, 1, 0, 100, 0, 50000, 50000, 180000, 180000, 0, 1, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "Duggan Wildhammer - Out of Combat - Say Line 4"),
(10817, 0, 9, 0, 1, 0, 100, 0, 70000, 70000, 120000, 120000, 0, 1, 5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "Duggan Wildhammer - Out of Combat - Say Line 5"),
(10817, 0, 10, 0, 1, 0, 100, 0, 90000, 90000, 180000, 180000, 0, 1, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "Duggan Wildhammer - Out of Combat - Say Line 6"),
(10817, 0, 11, 0, 1, 0, 100, 0, 100000, 100000, 120000, 120000, 0, 1, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "Duggan Wildhammer - Out of Combat - Say Line 7"),
(10817, 0, 12, 0, 1, 0, 100, 0, 120000, 120000, 120000, 120000, 0, 1, 8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "Duggan Wildhammer - Out of Combat - Say Line 8");

DELETE FROM `creature_text` WHERE `creatureid`= 10817;
INSERT INTO `creature_text` (`creatureid`, `groupid`, `id`, `text`, `type`, `language`, `probability`, `emote`, `duration`, `sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES 
(10817, 0, 0, "Ooooooooh...", 12, 0, 100, 15, 0, 0, 50906, 0, "Duggan Wildhammer - Line 0"),
(10817, 1, 0, "To the plaguelands went old Duggan, ta' send them Scourge back inta' th' groun'.", 12, 0, 100, 1, 0, 0, 50907, 0, "Duggan Wildhammer - Line 1"),
(10817, 2, 0, "Where th' scent of death is on th' wind and everythin' is mostly brown.", 12, 0, 100, 6, 0, 0, 50908, 0, "Duggan Wildhammer - Line 2"),
(10817, 3, 0, "An' when he did arrive there, what'd his dwarf eyes see?", 12, 0, 100, 25, 0, 0, 50909, 0, "Duggan Wildhammer - Line 3"),
(10817, 4, 0, "A hundred crates of barley there ta' be makin' inta' mead!", 12, 0, 100, 5, 0, 0, 50910, 0, "Duggan Wildhammer - Line 4"),
(10817, 5, 0, "But tha' mead was cursed with th' plague o' death, and now old Duggan, too.", 12, 0, 100, 18, 0, 0, 50911, 0, "Duggan Wildhammer - Line 5"),
(10817, 6, 0, "An' surrounded by the Lich King's beasts, what could old Duggan do?", 12, 0, 100, 430, 0, 0, 50912, 0, "Duggan Wildhammer - Line 6"),
(10817, 7, 0, "But though I feel the plague within, my hopes 'ave not yet sunk.", 12, 0, 100, 274, 0, 0, 50913, 0, "Duggan Wildhammer - Line 7"),
(10817, 8, 0, "If'n I'm gonna be Scourge anyway, I might as well be drunk!", 12, 0, 100, 11, 0, 0, 50914, 0, "Duggan Wildhammer - Line 8"),
(10817, 9, 0, "Ah ken see very well through this haze, but I'd know tha' smell anywhere! Die ye foul ogre!", 12, 0, 100, 0, 0, 0, 50905, 0, "Duggan Wildhammer - Line 9");

-- Add one spell_target_position for future need (The Purification of Quel'Delar)
DELETE FROM `spell_target_position` WHERE `ID`=70746;
INSERT INTO `spell_target_position` (`ID`, `EffectIndex`, `MapID`, `PositionX`, `PositionY`, `PositionZ`, `Orientation`, `VerifiedBuild`) VALUES
(70746, 0, 580, 1766.94, 683.09, 71.2, 2.268928, 15354);

--
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 17 AND `SourceEntry` = 47604;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`SourceId`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionTarget`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`NegativeCondition`,`ErrorType`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(17,0,47604,0,0,31,1,3,26417,0,0,0,0,'',"Group 0: Spell 'Gavrock's Runebreaker' targets creature 'Runed Giant'"),
(17,0,47604,0,1,31,1,3,26872,0,0,0,0,'',"Group 1: Spell 'Gavrock's Runebreaker' targets creature 'Weakened Giant'");

-- Jol Intro fix for quest "Redemption" (9598) 
-- Jol Creature Text
DELETE FROM `creature_text` WHERE `CreatureID`=17509;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(17509,0,0,"Read the tome of divinity I have given you, $n.  When you have learned from the book, speak with me again.",12,7,100,1,0,0,19811,0,"Jol");

-- Jol SAI Script
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=17509;
DELETE FROM `smart_scripts` WHERE `entryorguid`=17509 AND `event_type` IN (19,61);
DELETE FROM `smart_scripts` WHERE `entryorguid`=1750900 AND `source_type`=9;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`event_param5`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_param4`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(17509,0,0,1,19,0,100,0,9598,0,0,0,0,83,19,0,0,0,0,0,1,0,0,0,0,0,0,0,0,"Jol - On Quest 'Redemption' Accepted - Remove Npc Flag Questgiver+Trainer+Gossip"),
(17509,0,1,0,61,0,100,0,0,0,0,0,0,80,1750900,0,0,0,0,0,1,0,0,0,0,0,0,0,0,"Jol - On Link - Run Script"),
(1750900,9,0,0,0,0,100,0,0,0,0,0,0,66,0,0,0,0,0,0,7,0,0,0,0,0,0,0,0,"Jol - On Script - Set Orientation Invoker"),
(1750900,9,1,0,0,0,100,0,0,0,0,0,0,1,0,0,0,0,0,0,7,0,0,0,0,0,0,0,0,"Jol - On Script - Say Line 0"),
(1750900,9,2,0,0,0,100,0,6000,6000,0,0,0,66,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,"Jol - On Script - Set Orientation Home Position"),
(1750900,9,3,0,0,0,100,0,1000,1000,0,0,0,82,19,0,0,0,0,0,1,0,0,0,0,0,0,0,0,"Jol - On Script - Add Npc Flag Questgiver+Trainer+Gossip");

-- Anchorite Fateema outro script for quest "Medicinal Purpose" (9463)
DELETE FROM `smart_scripts` WHERE `entryorguid`=17214 AND `id`=1;
DELETE FROM `smart_scripts` WHERE `entryorguid`=1721400 AND `source_type`=9;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`event_param5`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_param4`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(17214,0,1,0,20,0,100,0,9463,0,0,0,0,80,1721400,0,0,0,0,0,1,0,0,0,0,0,0,0,0,"Anchorite Fateema - On Quest 'Medicinal Purposes' Rewarded - Run Script"),
(1721400,9,0,0,0,0,100,0,0,0,0,0,0,83,19,0,0,0,0,0,1,0,0,0,0,0,0,0,0,"Daedal - On Script - Remove Npc Flag Questgiver+Trainer"),
(1721400,9,1,0,0,0,100,0,1000,1000,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,"Anchorite Fateema - On Script - Say Line 1"),
(1721400,9,2,0,0,0,100,0,4000,4000,0,0,0,5,16,0,0,0,0,0,1,0,0,0,0,0,0,0,0,"Anchorite Fateema - On Script - Play Emote"),
(1721400,9,3,0,0,0,100,0,6000,6000,0,0,0,1,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,"Anchorite Fateema - On Script - Say Line 2"),
(1721400,9,4,0,0,0,100,0,2000,2000,0,0,0,82,19,0,0,0,0,0,1,0,0,0,0,0,0,0,0,"Daedal - On Script - Add Npc Flag Questgiver+Trainer"),
(1721400,9,5,0,0,0,100,0,2000,2000,0,0,0,1,0,0,0,0,0,0,19,17215,0,0,0,0,0,0,0,"Anchorite Fateema - On Script - Say Line 1 (Daedal)");

SET @GUID := 11011; -- (unused GUID from TDB 335.24011)

DELETE FROM `gameobject` WHERE `guid` = @GUID;
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `VerifiedBuild`) VALUES 
(@GUID, 149431, 109, 0, 0, 1, 1, -518.154, -85.2353, -74.488, 3.14159, -0, -0, -1, -0.00000126759, 43200, 100, 1, '', 0);

-- Creature - 33200 - Elwynn Lamb
DELETE FROM `creature_template_addon` WHERE `entry` = 33200;
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `StandState`, `AnimTier`, `VisFlags`, `SheathState`, `PvpFlags`, `emote`, `auras`) VALUES
(33200, 0, 0, 0, 0, 0, 1, 0, 0, '62703');

UPDATE `creature_model_info` SET `BoundingRadius` = 0.65, `CombatReach` = 0.65 WHERE `DisplayID` = 16205;

-- Creature - 33286 - Elwynn Forest Wolf
UPDATE `creature_template` SET `unit_flags` = 768, `AIName` = '', `ScriptName` = 'npc_elwynn_forest_wolf' WHERE `entry` = 33286;
UPDATE `creature_model_info` SET `BoundingRadius` = 0.85 WHERE `DisplayID` = 28545;

-- Spell - 62701 - Elwynn Forest Wolf
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 13 AND `SourceEntry` = 62701;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(13, 1, 62701, 0, 0, 31, 0, 3, 33200, 0, 0, 0, 0, '', 'Spell \'Elwynn Forest Wolf\' only targets NPC \'Elwynn Lamb\'');

DELETE FROM `spell_script_names` WHERE `ScriptName` = 'spell_gen_elwynn_forest_wolf';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(62701, 'spell_gen_elwynn_forest_wolf');

-- Spell - 62703 - Elwynn Lamb
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'spell_gen_elwynn_lamb';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(62703, 'spell_gen_elwynn_lamb');

DELETE FROM `game_event_gameobject` WHERE `guid`=28704;
INSERT INTO `game_event_gameobject` (eventEntry, guid) VALUES
(27,28704),
(28,28704),
(29,28704),
(30,28704);

UPDATE `gameobject_template` SET `ScriptName`='go_brazier_of_madness' WHERE `entry`=180327;

-- Velaada is missing npc text
DELETE FROM `npc_text` WHERE `ID`=8957;
INSERT INTO `npc_text` (`ID`,`text0_1`,`Probability0`,`Emote0_0`,`Probability1`,`Probability2`,`Probability3`,`Probability4`,`Probability5`,`Probability6`,`Probability7`,`BroadcastTextId0`,`BroadcastTextId1`,`BroadcastTextId2`,`BroadcastTextId3`,`BroadcastTextId4`,`BroadcastTextId5`,`BroadcastTextId6`,`BroadcastTextId7`,`VerifiedBuild`) VALUES
(8957,"Susurrus is expecting you, $n.",1,1,0,0,0,0,0,0,0,14014,0,0,0,0,0,0,0,0);

-- Velaada is missing gossip_menu text
DELETE FROM `gossip_menu` WHERE `MenuID`=7416 AND `TextID` IN (8957,8959);
INSERT INTO `gossip_menu` (`MenuID`, `TextID`, `VerifiedBuild`) VALUES
(7416,8957,0),
(7416,8959,0);

-- Velaada Conditions
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=14 AND `SourceGroup`=7416;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(14,7416,8959,0,0,47,0,9552,10,0,0,0,0,"","Show gossip dialog text 8959 if Quest Call of Air (9552) is taken (active)"),
(14,7416,8957,0,0,47,0,9553,10,0,0,0,0,"","Show gossip dialog text 8957 if Quest Call of Air (9553) is taken (active)");

-- CompletionText
UPDATE `quest_request_items` SET `CompletionText`= '$BThe "Holly Preserver" machine looks like some sort of still at first, but a careful examination of it reveals some goblin-esque changes to it.  Still, your skill at cooking seems to allow you to understand how the machine works.$B$BThere is already fresh holly in the machine - you simply need to provide some deeprock salt and five gold coins to get the machine working.' WHERE `ID` IN (8763, 8799);

-- reward entries
DELETE FROM `quest_offer_reward` WHERE `ID` IN (8763, 8799);
INSERT INTO `quest_offer_reward` (`ID`,`Emote1`,`Emote2`,`Emote3`,`Emote4`,`EmoteDelay1`,`EmoteDelay2`,`EmoteDelay3`,`EmoteDelay4`,`RewardText`,`VerifiedBuild`) VALUES
(8763,0,0,0,0,0,0,0,0,"$BThe machine lets off a little rumble and a small amount of steam as it starts working.$B$BIt is not too long thereafter until it stops, heralded by another small jet of steam erupting from it.$B$BA door hatch opens, revealing a batch of preserved holly!$B",12340),
(8799,0,0,0,0,0,0,0,0,"$BThe machine lets off a little rumble and a small amount of steam as it starts working.$B$BIt is not too long thereafter until it stops, heralded by another small jet of steam erupting from it.$B$BA door hatch opens, revealing a batch of preserved holly!$B",12340);

-- The Return of Quel'Delar quest chain

-- Quest request items / CompletionText
DELETE FROM `quest_request_items` WHERE `ID` IN 
(14443,14457,20438,24454,24554,24557,24556,24558,24461,24476,24480,24522,24535,24559,24560,24561,24562,24563,24553,24564,24594,24595,24596,24598,24795,24796,24798,24799,24800,24801);
INSERT INTO `quest_request_items` (`ID`,`EmoteOnComplete`,`EmoteOnIncomplete`,`CompletionText`,`VerifiedBuild`) VALUES
-- The Battered Hilt quest chain
(14443, 0, 0, "What is it that you have there?", 12340),                           -- The Battered Hilt (A)
(14457, 0, 0, "Did you find anything of use on that agent?", 12340),               -- The Sunreaver Plan (A)
(20438, 0, 0, "Was Shandy able to help you get a Sunreaver tabard?", 12340),       -- A Suitable Disguise (A)
(24454, 0, 0, "We've been expecting your return. What has kept you?", 12340),      -- Return To Caladis Brightspear
(24554, 0, 0, "What have you discovered?", 12340),                                 -- The Battered Hilt (H)
(24557, 0, 0, "Did you find anything of use on that agent?", 12340),               -- The Silver Covenant's Scheme (H)
(24556, 0, 0, "Was Shandy able to help you get a Silver Covenant tabard?", 12340), -- A Suitable Disguise (H)
(24558, 0, 0, "We've been expecting your return. What has kept you?", 12340),      -- Return To Myralion Sunblaze
-- Reforging The Sword quest chain
(24461, 0, 0, "Were you able to reconstruct Quel'Delar?", 12340),                             -- Reforging The Sword (A)
(24476, 0, 0, "Until the sword is tempered, it will be useless.", 12340),                     -- Tempering The Blade (A)
(24480, 0, 0, "What happened inside the Halls of Reflection?", 12340),                        -- The Halls Of Reflection (A)
(24522, 0, 0, "What brings you here?", 12340),                                                -- Journey To The Sunwell (A)
(24535, 0, 0, "Did you visit the ground where Thalorien fell defending the Sunwell?", 12340), -- Thalorien Dawnseeker (A)
(24559, 0, 0, "Were you able to reconstruct Quel'Delar?", 12340),                             -- Reforging The Sword (H)
(24560, 0, 0, "Until the sword is tempered, it will be useless.", 12340),                     -- Tempering The Blade (H)
(24561, 0, 0, "What happened inside the Halls of Reflection?", 12340),                        -- The Halls Of Reflection (H)
(24562, 0, 0, "What brings you here?", 12340),                                                -- Journey To The Sunwell (H)
(24563, 0, 0, "Did you visit the ground where Thalorien fell defending the Sunwell?", 12340), -- Thalorien Dawnseeker (H)
-- The Purification of Quel'Delar
(24553, 0, 0, "What happened during your time in the Sunwell?", 12340),  -- Alliance { Warrior | Paladin | Hunter | Rogue | Death Knight | Mage | Warlock }
(24564, 0, 0, "What happened inside the Sunwell?", 12340),               -- Orc, Undead, Tauren, Troll { Warrior | Paladin | Hunter | Rogue | Death Knight | Mage | Warlock }
(24594, 0, 0, "You have returned from the Sunwell?", 12340),             -- Blood Elf { Warrior | Paladin | Hunter | Rogue | Death Knight | Mage | Warlock }
(24595, 0, 0, "Tell me of what happened in the Sunwell, $n.", 12340),    -- Alliance { Priest | Shaman | Druid }
(24596, 0, 0, "What happened during your visit to the Sunwell?", 12340), -- Blood Elf (Priest)
(24598, 0, 0, "What news do you bring from the Sunwell?", 12340),        -- Orc, Undead, Tauren, Troll {Priest | Shaman | Druid}
-- A Victory For The { Silver Covenant | Sunreavers }
(24795, 0, 0, "Is it true that you have restored Quel'Delar?", 12340),   -- Alliance { Priest | Shaman | Druid }
(24796, 0, 0, "Is it true that you have restored Quel'Delar?", 12340),   -- Alliance { Warrior | Paladin | Hunter | Rogue | Death Knight | Mage | Warlock }
(24798, 0, 0, "Is it true that you have restored Quel'Delar?", 12340),   -- Blood Elf (Priest)
(24799, 0, 0, "Is it true that you have restored Quel'Delar?", 12340),   -- Orc, Undead, Tauren, Troll { Priest | Shaman | Druid }
(24800, 0, 0, "Is it true that you have restored Quel'Delar?", 12340),   -- Blood Elf { Warrior | Paladin | Hunter | Rogue | Death Knight | Mage | Warlock }
(24801, 0, 0, "Is it true that you have restored Quel'Delar?", 12340);   -- Orc, Undead, Tauren, Troll { Warrior | Paladin | Hunter | Rogue | Death Knight | Mage | Warlock }

-- Quest 20439 "A Meeting With The Magister" and 24451 "An Audience With The Arcanist" contain text, but with errata and copypasta
UPDATE `quest_request_items` SET `CompletionText`= "Did you recover the book from Wyrmrest?" WHERE `ID` = 24451;
UPDATE `quest_offer_reward` SET `RewardText`= "Excellent work. Now that this is in our hands, we must get it to Caladis Brightspear as soon as possible. We can't risk the book falling back into Sunreaver hands.$B$BI'll ensure that Shandy Glossgleam gets his tabard back without incident, along with a healthy reward for his help." WHERE `ID` = 20439;
UPDATE `quest_offer_reward` SET `RewardText`= "Excellent work. Now that this is in our hands, we must get it to Myralion Sunblaze as soon as possible. We can't risk the Silver Covenant taking the book from us again.$B$BI'll get that tabard back to Shandy and see that he's well compensated for his assistance. Once the book is in Myralion's hands, the Silver Covenant won't be a threat anymore." WHERE `ID` = 24451;

-- Arcanist Tybalin has wrong gossip_menu_option text, because 1) OptionBroadcastTextID 36824 is the Alliance Player gossip option text, and 2) copypasta + name change:
UPDATE `gossip_menu_option` SET `OptionBroadcastTextID` = 36829, `OptionText`="I'll deliver the tome to our contacts in Icecrown, arcanist." WHERE `MenuID` = 10858 AND `OptionID` = 0;

-- Magister Hathorel gossip_menu_option text is correct from broadcast_text, but has different content (copypasta + name change) in the gossip_menu_option table:
UPDATE `gossip_menu_option` SET `OptionText`="Would you renew my Silver Covenant disguise, Magister Hathorel?" WHERE `MenuID` = 10857 AND `OptionID` = 1;

-- Quest offer reward / RewardText
DELETE FROM `quest_offer_reward` WHERE `ID` IN 
(14443,14444,14457,20438,24454,24554,24555,24557,24556,24558,24461,24476,24480,24522,24535,24559,24560,24561,24562,24563,24553,24564,24594,24595,24596,24598,24795,24796,24798,24799,24800,24801);
INSERT INTO `quest_offer_reward` (`ID`,`Emote1`,`Emote2`,`Emote3`,`Emote4`,`EmoteDelay1`,`EmoteDelay2`,`EmoteDelay3`,`EmoteDelay4`,`RewardText`,`VerifiedBuild`) VALUES
-- The Battered Hilt quest chain
(14443, 0,0,0,0,0,0,0,0, "<Caladis takes the hilt from you and slowly turns it over in his hands.>$B$BThis seems somehow familiar, as though I should know its origins. You say you recovered this in the citadel? Most intriguing.$B$BThere are few who possess the ability to make such a blade. Perhaps they can tell us something about your find.", 12340),
(14444, 0,0,0,0,0,0,0,0, "We can't let that book remain in Sunreaver hands. If we hope to identify the sword and use it to our advantage, we have to find a way to capture the book Krasus lent them.", 12340),
(14457, 0,0,0,0,0,0,0,0, "<Arcanist Tybalin examines the captured orders.>$B$B$BThe agent you intercepted was supposed to transport the Wyrmrest Tome to Icecrown, after meeting with one Magister Hathorel in Sunreaver's Sanctuary. We have to get that book, $n, and this is our chance. It's not going to be easy, though.", 12340),
(20438, 0,0,0,0,0,0,0,0, "I knew Shandy would find a way to come through for us. Let me get this enchanted and ready for you to use. The sooner you get done with the tabard, the sooner we can get it back to Shandy and the better the chances that its owner will never have missed it.", 12340),
(24454, 0,0,0,0,0,0,0,0, "<Caladis accepts the heavy book and begins leafing through it.>$B$BI knew the symbols on the blade were familiar. The weapon was most certainly forged by the dragons and gifted to one of the mortal races, but which blade is this, and how did it come to rest in Icecrown?", 12340),
(24554, 0,0,0,0,0,0,0,0, "<Myralion takes the hilt from you and scrutinizes the artifact.>$B$BThis came from the citadel? What was it doing there? This blade is certainly not of Scourge manufacture.$B$BWeapons of this quality can only be crafted by a few of Azeroth's creatures. We will have to consult them and see if they can help us identify it.", 12340),
(24555, 0,0,0,0,0,0,0,0, "We must recover that book from the Silver Covenant. Without that book from Krasus, we stand little chance of solving the mystery of the sword in Icecrown or unlocking its power.", 12340),
(24557, 0,0,0,0,0,0,0,0, "<Magister Hathorel reads the captured orders.>$B$BThe agent you intercepted was supposed to deliver the Wyrmrest tome to Icecrown, after meeting with one Arcanist Tybalin inside the Silver Enclave. We have to reclaim that book, $n, and we only have one chance before it leaves the city. We have to work quickly.", 12340),
(24556, 0,0,0,0,0,0,0,0, "I knew Shandy would find a way to make it work. Let me get this enchanted and ready for you to use. With any luck, the tabard's owner won't even know it's missing and Shandy will cover the rest of our tracks.", 12340),
(24558, 0,0,0,0,0,0,0,0, "<Myralion accepts the heavy book and begins leafing through it.>$B$BThose symbols on the blade seemed familiar and now there's little wonder why. This is certainly a dragon blade, gifted to one of the mortal races, but which blade is this, and how did it come to rest in Icecrown?", 12340),
-- Reforging the Sword / Journey To The Sunwell quest chain
(24461, 0,0,0,0,0,0,0,0, "You have remade the blade of Quel'Delar, although Blood-Queen Lana'thel proclaimed we could not! The blade must still be tempered, but she and her master will not stand in our way!", 12340),
(24476, 0,0,0,0,0,0,0,0, "I... I don't understand. Tempering the sword should've restored the blade to its original condition. What has happened here?", 12340),
(24480, 0,0,0,0,0,0,0,0, "I had not thought it possible for evil to take hold in such a sword, but I suppose it was naive of me. If the greatest of dragonkind's creations could be corrupted and turned against them, why not a mere sword?$B$BUther's advice is wise, $n, and I would urge you to heed it quickly.", 12340),
(24522, 0,0,0,0,0,0,0,0, "Admit you to the Sunwell? That's impossible! The Sunwell is the most sacred and important site of our people. We have only recently reclaimed it with the help of the Shattered Sun Offensive. It is not a place for tourists or travelers.", 12340),
(24535, 0,0,0,0,0,0,0,0, "I confess that I did not expect Thalorien's spirit to recognize you as the heir to Quel'Delar, but I defer to his judgment. You may enter the Sunwell, but I remind you that you are a guest in our most sacred of precincts, and you should act accordingly.", 12340),
(24559, 0,0,0,0,0,0,0,0, "You have remade the blade of Quel'Delar in defiance of that Blood-Queen Lana'thel's pronouncement! Now, the blade must be tempered before we can show her the folly of her words.", 0),
(24560, 0,0,0,0,0,0,0,0, "Tempering the sword should've restored the blade. Why hasn't it worked?", 12340),
(24561, 0,0,0,0,0,0,0,0, "How can evil take root in such a sword? I would not have thought it possible if the evidence wasn't here before my eyes. If the greatest of dragonkind's creations could be corrupted and turned against them, why not a mere sword?$B$BI believe Uther is right. You must heed his advice quickly, $n.", 12340),
(24562, 0,0,0,0,0,0,0,0, "I hope you understand that I can't just admit you to the Sunwell, $n. This is the most sacred place known to the sin'dorei and we have only recently regained control over it.$B$BYou would raise the hopes of our people with tales of Quel'Delar? Without proof of the truth of your claims, I see no reason to take you at your word.", 12340),
(24563, 0,0,0,0,0,0,0,0, "You truly do carry Quel'Delar. This is a great day for all of Quel'Thalas and the sin'dorei. You have my leave to enter the Sunwell and finish the sword's restoration. Keep your head high, $n. The children of Silvermoon have dreamt of this day for years.", 12340),
-- The Purification of Quel'Delar
(24553, 0,0,0,0,0,0,0,0, "This is unbelievable, $n. You've really done it! All of the quel'dorei have heard of Thalorien Dawnseeker and Quel'Delar, but no one ever thought the sword would be restored.", 12340), -- Alliance { Warrior | Paladin | Hunter | Rogue | Death Knight | Mage | Warlock }
(24564, 0,0,0,0,0,0,0,0, "Am I truly laying my eyes upon the weapon of Thalorien Dawnseeker? This is a wondrous day for the Sunreavers and for all sin'dorei!", 12340), -- Orc, Undead, Tauren, Troll { Warrior | Paladin | Hunter | Rogue | Death Knight | Mage | Warlock }
(24594, 0,0,0,0,0,0,0,0, "Am I truly laying my eyes upon the weapon of Thalorien Dawnseeker? This is a wondrous day for the Sunreavers and for all sin'dorei!", 12340), -- Blood Elf { Warrior | Paladin | Hunter | Rogue | Death Knight | Mage | Warlock }
(24595, 0,0,0,0,0,0,0,0, "This is unbelievable, $n. You've really done it! All of the quel'dorei have heard of Thalorien Dawnseeker and Quel'Delar, but no one ever thought the sword would be restored.", 12340), -- Alliance { Priest | Shaman | Druid }
(24596, 0,0,0,0,0,0,0,0, "Am I truly laying my eyes upon the weapon of Thalorien Dawnseeker? This is a wondrous day for the Sunreavers and for all sin'dorei!", 12340), -- Blood Elf (Priest)
(24598, 0,0,0,0,0,0,0,0, "Am I truly laying my eyes upon the weapon of Thalorien Dawnseeker? This is a wondrous day for the Sunreavers and for all sin'dorei!", 12340), -- Orc, Undead, Tauren, Troll { Priest | Shaman | Druid }
-- A Victory For The { Silver Covenant | Sunreavers }
(24795, 0,0,0,0,0,0,0,0, "That a weapon of such power has been redeemed from the clutches of evil is a great omen in these times, $n. With Quel'Delar and staunch Silver Covenant allies at our side, the Lich King will have good reason to fear.$B$BThe crusade maintains an arsenal of exceptional weapons for our strongest allies. Allow me to offer you your choice from among them in return for entrusting us with the care of Quel'Delar.", 12340), -- Alliance { Priest | Shaman | Druid }
(24796, 0,0,0,0,0,0,0,0, "This is nothing short of an amazing accomplishment, $n. The day that Thalorien and Anasterian fell, the same day that Quel'Delar was lost, was one of the darkest of my life. To see Quel'Delar restored... it is beyond words.$B$BWithout a doubt, you are meant to be the true bearer of the blade. Quel'Delar's magic is already adapting the blade to your skills and your strengths.", 12340), -- Alliance { Warrior | Paladin | Hunter | Rogue | Death Knight | Mage | Warlock }
(24798, 0,0,0,0,0,0,0,0, "That a weapon of such power has been redeemed from the clutches of evil is a great omen in these times, $n. With Quel'Delar and staunch Sunreaver allies at our side, the Lich King will have good reason to fear.$B$BThe crusade maintains an arsenal of exceptional weapons for our strongest allies. Allow me to offer you your choice from among them in return for entrusting us with the care of Quel'Delar.", 12340), -- Blood Elf (Priest)
(24799, 0,0,0,0,0,0,0,0, "That a weapon of such power has been redeemed from the clutches of evil is a great omen in these times, $n. With Quel'Delar and staunch Sunreaver allies at our side, the Lich King will have good reason to fear.$B$BThe crusade maintains an arsenal of exceptional weapons for our strongest allies. Allow me to offer you your choice from among them in return for entrusting us with the care of Quel'Delar.", 12340), -- Orc, Undead, Tauren, Troll { Priest | Shaman | Druid }
(24800, 0,0,0,0,0,0,0,0, "Quel'Delar rises again, as we sin'dorei have risen from the ashes of defeat and betrayal. The heart and the weapon of Thalorien Dawnseeker are both with you, $n.$B$BI see the blade has already started adapting itself to your strengths, $n. Hold your head high and always keep Quel'Delar at your side.", 12340), -- Blood Elf { Warrior | Paladin | Hunter | Rogue | Death Knight | Mage | Warlock }
(24801, 0,0,0,0,0,0,0,0, "Quel'Delar rises again, as the sin'dorei have risen from the ashes of defeat and betrayal. Yet, somehow, the weapon of Thalorien Dawnseeker has chosen to serve an outsider.$B$BBe at ease, $n. I do not mean to diminish your accomplishment, for you have done what none of my brothers could, although I do not know why. You are clearly meant to be its bearer; the blade is already adapting itself to your abilities. Wield Quel'Delar proudly against our common foes.", 12340); -- Orc, Undead, Tauren, Troll { Warrior | Paladin | Hunter | Rogue | Death Knight | Mage | Warlock }

-- Add AnimTier Hover for two npc
UPDATE `creature_template_addon` SET `AnimTier`=2 WHERE `entry` IN (19152,26471);

DELETE FROM `creature_template_movement` WHERE `CreatureId` IN (19152,26471);
INSERT INTO `creature_template_movement` (`CreatureId`, `Ground`, `Swim`, `Flight`, `Rooted`, `Chase`, `Random`, `InteractionPauseTimer`) VALUES
(19152, 0, 0, 1, 0, 0, 0, NULL), -- 19152 (Interrogator Khan)
(26471, 0, 0, 1, 1, 0, 0, NULL); -- 26471 (Image of Archmage Aethas Sunreaver)

-- Remove stun immunity from Captain Balinda Stonehearth and Captain Galvangar
UPDATE `creature_template` SET `mechanic_immune_mask`=`mechanic_immune_mask`&~2048 WHERE `entry` IN (11949,11947);

-- King Varian Wrynn gossip menu changes when quest "Where Kings Walk" (13188) is active
-- Gossip Menu
DELETE FROM `gossip_menu` WHERE `MenuID`=9834 AND `TextID`=13905;
INSERT INTO `gossip_menu` (`MenuID`, `TextID`, `VerifiedBuild`) VALUES
(9834,13905,0);

-- Condition
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=14 AND `SourceGroup`=9834;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(14,9834,13905,0,0,47,0,13188,10,0,0,0,0,"","Show gossip dialog text 13905 if Quest 'Where Kings Walk' is taken (active)");

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=17 AND `SourceEntry`=32037;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(17,0,32037,0,0,29,0,18185,40,0,1,0,0,"","Place Feralfen Totem");

-- Fix wrong quest item condition for Dr. Terrible's "Building a Better Flesh Giant"
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 1 AND `SourceGroup` = 30409 AND `SourceEntry` = 42772;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(1, 30409, 42772, 0, 0, 47, 0, 13042, 74, 0, 0, 0, 0, '', 'Dr. Terribles "Building a Better Flesh Giant" only drops if player has state_mask 74 Deep in the Bowels of The Underhalls'),
(1, 30409, 42772, 0, 0, 2, 0, 42772, 1, 1, 1, 0, 0, '', 'Dr. Terribles "Building a Better Flesh Giant" will drop only if the player doesn\'t have it already');

-- Quest: The Bloodsail Buccaneers (1) (595)
UPDATE `quest_offer_reward` SET `RewardText` = "On top of the barrel, you discover a map with some hastily written text on it along with some coins." WHERE `ID` = 595;

-- Quest 3122 "Return to Witch Doctor Uzer'i"
UPDATE `quest_request_items` SET `CompletionText`= "Have you spoken to Xerash?" WHERE `ID` = 3122;

-- Update gossip text for Darnassus Sentinel for Mage & Paladin directions
SET @text="You will find a pair of draenei conversing with Tyrande Whisperwind in the upper level of The Temple of the Moon.$B$BThey will know how to help you.";
UPDATE `npc_text` SET `text0_0`=@text, `text0_1`=@text,`BroadcastTextID0`=0, `VerifiedBuild`=49705 WHERE `ID`=15906;

-- Crystalline Ice Giant
DELETE FROM `creature` WHERE `guid`=74033;
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`) VALUES
(74033, 26291, 571, 0, 0, 1, 1, 0, 1, 5001.1665, 292.13882, 156.07475, 0.994837641716003417, 300, 0, 0, 29820, 0, 0, 0, 0, 0, '', 53262);

-- Emote OneShotAttackUnarmed
DELETE FROM `creature_addon` WHERE `guid`=74033;
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `StandState`, `AnimTier`, `VisFlags`, `SheathState`, `PvpFlags`, `emote`, `auras`) VALUES
(74033, 0, 0, 0, 0, 0, 1, 0, 35, ''); -- Crystalline Ice Giant

-- Tavara should spawn with a HP pool of 68/102
UPDATE `creature` SET `curhealth`=68 WHERE `id`=17551;

-- Blizz like respawn time for "Tavara" (Timed it on WotLK Classic)
UPDATE `creature` SET `spawntimesecs`=10 WHERE `ID`=17551;

-- Tavara Script after she gets healed during "Help Tavara" (9586)
DELETE FROM `creature_text` WHERE `CreatureID`=17551;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(17551,0,0,"Thank you, kind $gsir:lady;!",12,35,100,2,0,0,17578,0,"Tavara"),
(17551,1,0,"Please tell Guvan that I'll be fine, thanks to you.",12,35,100,3,0,0,14224,0,"Tavara");

DELETE FROM `waypoints` WHERE `entry`=17551;
INSERT INTO `waypoints` (`entry`, `pointid`, `position_x`, `position_y`, `position_z`, `point_comment`) VALUES 
(17551,1,-4101.234,-12806.457,6.095,'Tavara'),
(17551,2,-4073.742,-12840.701,1.473,'Tavara'),
(17551,3,-4071.070,-12850.257,2.570,'Tavara'),
(17551,4,-4074.439,-12862.463,2.199,'Tavara');

DELETE FROM `smart_scripts` WHERE `entryorguid`=17551 AND `event_type` IN (8,40);
DELETE FROM `smart_scripts` WHERE `entryorguid`=1755100 AND `source_type`=9;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`event_param5`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_param4`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(17551,0,0,0,40,0,100,0,4,17551,0,0,0,41,1000,0,0,0,0,0,1,0,0,0,0,0,0,0,0,"Tavara - On Waypoint 4 Reached - Despawn"),
(17551,0,1,0,8,0,100,0,2050,0,0,0,0,33,17551,0,0,0,0,0,7,0,0,0,0,0,0,0,0,"Tavara - On Spellhit - Give Quest Credit"),
(17551,0,2,0,8,0,100,0,2052,0,0,0,0,33,17551,0,0,0,0,0,7,0,0,0,0,0,0,0,0,"Tavara - On Spellhit - Give Quest Credit"),
(17551,0,3,0,8,0,100,0,59544,0,0,0,0,33,17551,0,0,0,0,0,7,0,0,0,0,0,0,0,0,"Tavara - On Spellhit - Give Quest Credit"),
(17551,0,4,0,8,0,100,0,139,0,0,0,0,33,17551,0,0,0,0,0,7,0,0,0,0,0,0,0,0,"Tavara - On Spellhit - Give Quest Credit"),
(17551,0,5,0,8,0,100,1,2050,0,0,0,0,80,1755100,0,0,0,0,0,1,0,0,0,0,0,0,0,0,"Tavara - On Spellhit - Run Script"),
(17551,0,6,0,8,0,100,1,2052,0,0,0,0,80,1755100,0,0,0,0,0,1,0,0,0,0,0,0,0,0,"Tavara - On Spellhit - Run Script"),
(17551,0,7,0,8,0,100,1,59544,0,0,0,0,80,1755100,0,0,0,0,0,1,0,0,0,0,0,0,0,0,"Tavara - On Spellhit - Run Script"),
(17551,0,8,0,8,0,100,1,139,0,0,0,0,80,1755100,0,0,0,0,0,1,0,0,0,0,0,0,0,0,"Tavara - On Spellhit - Run Script"),
(1755100,9,0,0,0,0,100,0,500,500,0,0,0,91,8,0,0,0,0,0,1,0,0,0,0,0,0,0,0,"Tavara - On Script - Remove Flag Standstate 'Kneel'"),
(1755100,9,1,0,0,0,100,0,2000,2000,0,0,0,66,0,0,0,0,0,0,7,0,0,0,0,0,0,0,0,"Tavara - On Script - Set Orientation Invoker"),
(1755100,9,2,0,0,0,100,0,1000,1000,0,0,0,1,0,0,0,0,0,0,7,0,0,0,0,0,0,0,0,"Tavara - On Script - Say Line 0"),
(1755100,9,3,0,0,0,100,0,3000,3000,0,0,0,1,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,"Tavara - On Script - Say Line 1"),
(1755100,9,4,0,0,0,100,0,4000,4000,0,0,0,53,1,17551,0,0,0,2,1,0,0,0,0,0,0,0,0,"Tavara - On Script - Start Waypoint");

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=22 AND `SourceEntry`=17551;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(22,2,17551,0,0,47,0,9586,10,0,0,0,0,"","Smart Event 1 for creature Tavara only executes if player has quest 'Help Tavara' in progress or completed"),
(22,3,17551,0,0,47,0,9586,10,0,0,0,0,"","Smart Event 2 for creature Tavara only executes if player has quest 'Help Tavara' in progress or completed"),
(22,4,17551,0,0,47,0,9586,10,0,0,0,0,"","Smart Event 3 for creature Tavara only executes if player has quest 'Help Tavara' in progress or completed"),
(22,5,17551,0,0,47,0,9586,10,0,0,0,0,"","Smart Event 4 for creature Tavara only executes if player has quest 'Help Tavara' in progress or completed"),
(22,6,17551,0,0,47,0,9586,10,0,0,0,0,"","Smart Event 5 for creature Tavara only executes if player has quest 'Help Tavara' in progress or completed"),
(22,7,17551,0,0,47,0,9586,10,0,0,0,0,"","Smart Event 6 for creature Tavara only executes if player has quest 'Help Tavara' in progress or completed"),
(22,8,17551,0,0,47,0,9586,10,0,0,0,0,"","Smart Event 7 for creature Tavara only executes if player has quest 'Help Tavara' in progress or completed"),
(22,9,17551,0,0,47,0,9586,10,0,0,0,0,"","Smart Event 8 for creature Tavara only executes if player has quest 'Help Tavara' in progress or completed");

-- Fix Daedal's Outro for quest "An Alternative Alternative" (9473)
-- Daedal's Waypoints
DELETE FROM `waypoints` WHERE `entry`=17215;
INSERT INTO `waypoints` (`entry`, `pointid`, `position_x`, `position_y`, `position_z`, `point_comment`) VALUES 
(17215,1,-4193.0980,-12475.6787,45.8185,"Daedal"),
(17215,2,-4195.5728,-12477.2754,45.7839,"Daedal"),
(17215,3,-4198.7573,-12476.4922,45.7583,"Daedal"),
(17215,4,-4200.5928,-12472.1885,45.6273,"Daedal"),
(17215,5,-4196.8164,-12473.2051,45.6863,"Daedal"),
(17215,6,-4193.4995,-12472.7910,45.6340,"Daedal"),
(17215,7,-4191.1499,-12470.0,45.6375,"Daedal");

-- Daedal's Script
DELETE FROM `smart_scripts` WHERE `entryorguid`=17215 AND `id` IN (4,5,6,7);
DELETE FROM `smart_scripts` WHERE `entryorguid`=17117 AND `source_type`=0;
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (1721500,1711700) AND `source_type`=9;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`event_param5`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_param4`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(17215,0,4,5,20,0,100,0,9473,0,0,0,0,83,18,0,0,0,0,0,1,0,0,0,0,0,0,0,0,"Daedal - On Quest 'An Alternative Alternative' Rewarded - Remove Npc Flag Questgiver+Trainer"),
(17215,0,5,0,61,0,100,0,0,0,0,0,0,53,0,17215,0,0,0,0,1,0,0,0,0,0,0,0,0,"Daedal - On Link - Start WP"),
(17215,0,6,0,40,0,100,0,4,17215,0,0,0,80,1721500,0,0,0,0,0,1,0,0,0,0,0,0,0,0,"Daedal - On Waypoint 4 Reached - Run Script"),
(1721500,9,0,0,0,0,100,0,0,0,0,0,0,54,26000,0,0,0,0,0,1,0,0,0,0,0,0,0,0,"Daedal - On Script - Pause Waypoint"),
(1721500,9,1,0,0,0,100,0,1000,1000,0,0,0,66,0,0,0,0,0,0,19,17117,0,0,0,0,0,0,0,"Daedal - On Script - Set Orientation"),
(1721500,9,2,0,0,0,100,0,0,0,0,0,0,1,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,"Daedal - On Script - Say Line 1"),
(1721500,9,3,0,0,0,100,0,0,0,0,0,0,17,133,0,0,0,0,0,1,0,0,0,0,0,0,0,0,"Daedal - On Script - Set Emote State"),
(1721500,9,4,0,0,0,100,0,4000,4000,0,0,0,17,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,"Daedal - On Script - Set Emote State"),
(1721500,9,5,0,0,0,100,0,1000,1000,0,0,0,5,16,0,0,0,0,0,1,0,0,0,0,0,0,0,0,"Daedal - On Script - Play Emote"),
(1721500,9,6,0,0,0,100,0,3000,3000,0,0,0,1,2,0,0,0,0,0,1,0,0,0,0,0,0,0,0,"Daedal - On Script - Say Line 2"),
(1721500,9,7,0,0,0,100,0,4000,4000,0,0,0,1,0,0,0,0,0,0,19,17117,0,0,0,0,0,0,0,"Daedal - On Script - Say Line 0 (Injured Night Elf Priestess)"),
(1721500,9,8,0,0,0,100,0,3000,3000,0,0,0,1,1,0,0,0,0,0,19,17117,0,0,0,0,0,0,0,"Daedal - On Script - Say Line 1 (Injured Night Elf Priestess)"),
(1721500,9,9,0,0,0,100,0,0,0,0,0,0,45,1,1,0,0,0,0,9,17117,0,10,0,0,0,0,0,"Daedal - On Script - Set Data 1 1 To Injured Night Elf Priestess"),
(1721500,9,10,0,0,0,100,0,2000,2000,0,0,0,1,2,0,0,0,0,0,19,17117,0,0,0,0,0,0,0,"Daedal - On Script - Say Line 2 (Injured Night Elf Priestess)"),
(1721500,9,11,0,0,0,100,0,5000,5000,0,0,0,1,3,0,0,0,0,0,19,17117,0,0,0,0,0,0,0,"Daedal - On Script - Say Line 3 (Injured Night Elf Priestess)"),
(1721500,9,12,0,0,0,100,0,6000,6000,0,0,0,1,4,0,0,0,0,0,19,17117,0,0,0,0,0,0,0,"Daedal - On Script - Say Line 4 (Injured Night Elf Priestess)"),
(1721500,9,13,0,0,0,100,0,2000,2000,0,0,0,1,2,0,0,0,0,0,19,17214,0,0,0,0,0,0,0,"Daedal - On Script - Say Line 2 (Anchorite Fateema)"),
(1721500,9,14,0,0,0,100,0,500,500,0,0,0,66,0,0,0,0,0,0,8,0,0,0,0,0,0,0,4.1765,"Daedal - On Script - Set Orientation"),
(1721500,9,15,0,0,0,100,0,0,0,0,0,0,82,18,0,0,0,0,0,1,0,0,0,0,0,0,0,0,"Daedal - On Script - Add Npc Flag Questgiver+Trainer"),

-- Injured Night Elf Priestess Script
(17117,0,0,1,54,0,100,0,0,0,0,0,0,91,3,0,0,0,0,0,1,0,0,0,0,0,0,0,0,"Injured Night Elf Priestess - On Just Summoned - Remove Flag Standstate Sleep"),
(17117,0,1,0,61,0,100,0,0,0,0,0,0,82,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,"Injured Night Elf Priestess - On Link - Add Npc Flag Gossip"),
(17117,0,2,0,64,0,100,0,0,0,0,0,0,1,5,0,0,0,0,0,1,0,0,0,0,0,0,0,0,"Injured Night Elf Priestess - On Gossip Hello - Say Line 5"),
(17117,0,3,0,38,0,100,0,1,1,0,0,0,80,1711700,0,0,0,0,0,1,0,0,0,0,0,0,0,0,"Injured Night Elf Priestess - On Data Set 1 1 - Run Script"),
(1711700,9,1,0,0,0,100,0,0,0,0,0,0,91,3,0,0,0,0,0,1,0,0,0,0,0,0,0,0,"Injured Night Elf Priestess - On Script - Set Stand State"),
(1711700,9,2,0,0,0,100,0,400,400,0,0,0,90,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,"Injured Night Elf Priestess - On Script - Set Stand State"),
(1711700,9,3,0,0,0,100,0,10000,10000,0,0,0,5,25,0,0,0,0,0,1,0,0,0,0,0,0,0,0,"Injured Night Elf Priestess - On Script - Play Emote"),
(1711700,9,4,0,0,0,100,0,3000,3000,0,0,0,91,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,"Injured Night Elf Priestess - On Script - Set Stand State"),
(1711700,9,5,0,0,0,100,0,400,400,0,0,0,90,3,0,0,0,0,0,1,0,0,0,0,0,0,0,0,"Injured Night Elf Priestess - On Script - Set Stand State");

-- Outro for quest "Where Kings Walk" (13188)
-- Text
DELETE FROM `creature_text` WHERE `CreatureID`=29611 AND `GroupID` IN (0,1,2,3);
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(29611,0,0,"People of Stormwind! Citizens of the Alliance! Your king speaks!",14,7,100,22,0,0,31675,0,"King Varian Wrynn"),
(29611,1,0,"Today marks the first of many defeats for the Scourge! Death knights, once in service of the Lich King, have broken free of his grasp and formed a new alliance against his tyranny!",14,7,100,22,0,0,31676,0,"King Varian Wrynn"),
(29611,2,0,"You will welcome these former heroes of the Alliance and treat them with the respect that you would give to any ally of Stormwind!",14,7,100,22,0,0,31677,0,"King Varian Wrynn"),
(29611,3,0,"Glory to the Alliance!",14,7,100,4,0,0,31678,0,"King Varian Wrynn");

-- Script
DELETE FROM `smart_scripts` WHERE `entryorguid`=29611 AND `id`=2;
DELETE FROM `smart_scripts` WHERE `entryorguid`=2961100 AND `source_type`=9;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`event_param5`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_param4`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(29611,0,2,0,20,0,100,0,13188,0,0,0,0,80,2961100,0,0,0,0,0,1,0,0,0,0,0,0,0,0,"King Varian Wrynn - On Quest 'Where Kings Walk' Rewarded - Run Script"),

(2961100,9,0,0,0,0,100,0,2000,2000,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,"King Varian Wrynn - On Script - Say Line 0"),
(2961100,9,1,0,0,0,100,0,5000,5000,0,0,0,1,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,"King Varian Wrynn - On Script - Say Line 1"),
(2961100,9,2,0,0,0,100,0,8000,8000,0,0,0,1,2,0,0,0,0,0,1,0,0,0,0,0,0,0,0,"King Varian Wrynn - On Script - Say Line 2"),
(2961100,9,3,0,0,0,100,0,9000,9000,0,0,0,1,3,0,0,0,0,0,1,0,0,0,0,0,0,0,0,"King Varian Wrynn - On Script - Say Line 3");

--
-- https://www.wowhead.com/wotlk/fr/item=4432/lettre-de-sully-balloo
UPDATE page_text_locale SET `Text`='Mais, ô ma Sara, si les morts peuvent revenir à Azeroth et entourer, invisibles, ceux qu\'ils aiment, je serai toujours à vos côtés dans les jours heureux comme dans les nuits les plus sombres, partageant vos heures de joie comme vos moments de tristesse. Si jamais vous sentez une douce brise sur votre joue, ce sera mon souffle ; si l\'air rafraîchit vos tempes, ce sera mon esprit qui passe.$B$BSara, ne me pleurez pas, pensez que je suis parti et que je vous attends, car nous nous reverrons.$B$B--Sully' WHERE ID=332 AND locale='frFR';

-- Control (9595)
UPDATE `quest_request_items` SET `EmoteOnIncomplete`=6 WHERE `ID`=9595;

-- Mage Training (9290)
UPDATE `quest_offer_reward` SET `Emote2`=6 WHERE `ID`=9290;

-- Help Tavara (9586)
DELETE FROM `quest_details` WHERE `ID`=9586;
INSERT INTO `quest_details` (`ID`,`Emote1`,`Emote2`,`Emote3`,`Emote4`,`EmoteDelay1`,`EmoteDelay2`,`EmoteDelay3`,`EmoteDelay4`,`VerifiedBuild`) VALUES
(9586,1,1,1,0,0,0,0,0,0);
UPDATE `quest_request_items` SET `EmoteOnIncomplete`=6 WHERE `ID`=9586;
UPDATE `quest_offer_reward` SET `Emote1`=1,`Emote2`=1 WHERE `ID`=9586;

-- Priest Training (9291)
UPDATE `quest_offer_reward` SET `Emote1`=1,`Emote2`=1,`Emote3`=1 WHERE `ID`=9291;

-- Beast Training (9675)
UPDATE `quest_offer_reward` SET `Emote2`=1 WHERE `ID`=9675;

-- Taming the Beast (9593)
UPDATE `quest_offer_reward` SET `Emote2`=1 WHERE `ID`=9593;
UPDATE `quest_details` SET `Emote2`=1 WHERE `ID`=9593;

-- Taming the Beast (9592)
UPDATE `quest_offer_reward` SET `Emote1`=1,`Emote2`=5 WHERE `ID`=9592;

-- Taming the Beast (9591)
UPDATE `quest_details` SET `Emote2`=1,`Emote3`=1 WHERE `ID`=9591;

-- Hunter Training (9288)
UPDATE `quest_offer_reward` SET `Emote2`=1,`Emote3`=6 WHERE `ID`=9288;

-- Redemption (9600)
UPDATE `quest_request_items` SET `EmoteOnIncomplete`=6 WHERE `ID`=9600;

-- Redemption (9598)
UPDATE `quest_offer_reward` SET `Emote3`=1 WHERE `ID`=9598;
UPDATE `quest_request_items` SET `EmoteOnIncomplete`=1 WHERE `ID`=9598;

-- Behomat (10350)
UPDATE `quest_offer_reward` SET `Emote1`=2,`Emote2`=1 WHERE `ID`=10350;
UPDATE `quest_details` SET `Emote2`=1 WHERE `ID`=10350;

-- Strength of One (9582)
UPDATE `quest_details` SET `Emote2`=1 WHERE `ID`=9582;
UPDATE `quest_offer_reward` SET `Emote2`=1 WHERE `ID`=9582;

-- A Cry For Help
DELETE FROM `quest_details` WHERE `ID`=9528;
INSERT INTO `quest_details` (`ID`,`Emote1`,`Emote2`,`Emote3`,`Emote4`,`EmoteDelay1`,`EmoteDelay2`,`EmoteDelay3`,`EmoteDelay4`,`VerifiedBuild`) VALUES
(9528,1,1,1,6,0,0,0,0,0);
UPDATE `quest_offer_reward` SET `Emote1`=6,`Emote2`=1,`Emote3`=1,`Emote2`=1 WHERE `ID`=9528;

-- A Hearty Thanks! (9612)
UPDATE `quest_offer_reward` SET `Emote1`=1,`Emote2`=4 WHERE `ID`=9612;

-- Call of Water (9501)
DELETE FROM `quest_details` WHERE `ID`=9501;
INSERT INTO `quest_details` (`ID`,`Emote1`,`Emote2`,`Emote3`,`Emote4`,`EmoteDelay1`,`EmoteDelay2`,`EmoteDelay3`,`EmoteDelay4`,`VerifiedBuild`) VALUES
(9501,1,1,1,0,0,0,0,0,0);

-- Call of Water (9500)
DELETE FROM `quest_details` WHERE `ID`=9500;
INSERT INTO `quest_details` (`ID`,`Emote1`,`Emote2`,`Emote3`,`Emote4`,`EmoteDelay1`,`EmoteDelay2`,`EmoteDelay3`,`EmoteDelay4`,`VerifiedBuild`) VALUES
(9500,1,1,0,0,0,0,0,0,0);
UPDATE `quest_offer_reward` SET `Emote1`=1,`Emote2`=1 WHERE `ID`=9500;

-- The Unwritten Prophecy (9762)
UPDATE `quest_offer_reward` SET `Emote1`=1,`Emote2`=1,`Emote3`=1,`Emote4`=1 WHERE `ID`=9762;

-- Truth or Fiction (9699)
DELETE FROM `quest_details` WHERE `ID`=9699;
INSERT INTO `quest_details` (`ID`,`Emote1`,`Emote2`,`Emote3`,`Emote4`,`EmoteDelay1`,`EmoteDelay2`,`EmoteDelay3`,`EmoteDelay4`,`VerifiedBuild`) VALUES
(9699,1,1,1,0,0,0,0,0,0);
UPDATE `quest_request_items` SET `EmoteOnIncomplete`=6 WHERE `ID`=9699;
UPDATE `quest_offer_reward` SET `Emote1`=1,`Emote2`=1 WHERE `ID`=9699;

-- The Way to Auberdine (9633)
DELETE FROM `quest_details` WHERE `ID`=9633;
INSERT INTO `quest_details` (`ID`,`Emote1`,`Emote2`,`Emote3`,`Emote4`,`EmoteDelay1`,`EmoteDelay2`,`EmoteDelay3`,`EmoteDelay4`,`VerifiedBuild`) VALUES
(9633,1,0,0,0,0,0,0,0,0);
UPDATE `quest_offer_reward` SET `Emote1`=1 WHERE `ID`=9633;

-- Return to Topher Loaal (9606)
DELETE FROM `quest_details` WHERE `ID`=9606;
INSERT INTO `quest_details` (`ID`,`Emote1`,`Emote2`,`Emote3`,`Emote4`,`EmoteDelay1`,`EmoteDelay2`,`EmoteDelay3`,`EmoteDelay4`,`VerifiedBuild`) VALUES
(9606,1,0,0,0,0,0,0,0,0);
UPDATE `quest_offer_reward` SET `Emote1`=1 WHERE `ID`=9606;

-- Hippogryph Master Stephanos (9605)
DELETE FROM `quest_details` WHERE `ID`=9605;
INSERT INTO `quest_details` (`ID`,`Emote1`,`Emote2`,`Emote3`,`Emote4`,`EmoteDelay1`,`EmoteDelay2`,`EmoteDelay3`,`EmoteDelay4`,`VerifiedBuild`) VALUES
(9605,1,0,0,0,0,0,0,0,0);
UPDATE `quest_offer_reward` SET `Emote1`=1 WHERE `ID`=9605;

-- Call of Fire (9555)
DELETE FROM `quest_details` WHERE `ID`=9555;
INSERT INTO `quest_details` (`ID`,`Emote1`,`Emote2`,`Emote3`,`Emote4`,`EmoteDelay1`,`EmoteDelay2`,`EmoteDelay3`,`EmoteDelay4`,`VerifiedBuild`) VALUES
(9555,1,1,1,0,0,0,0,0,0);
UPDATE `quest_offer_reward` SET `Emote1`=1,`Emote2`=1 WHERE `ID`=9555;

-- Elekks Are Serious Business (9625)
DELETE FROM `quest_details` WHERE `ID`=9625;
INSERT INTO `quest_details` (`ID`,`Emote1`,`Emote2`,`Emote3`,`Emote4`,`EmoteDelay1`,`EmoteDelay2`,`EmoteDelay3`,`EmoteDelay4`,`VerifiedBuild`) VALUES
(9625,5,1,1,0,0,0,0,0,0);

-- Call of Fire (9461)
DELETE FROM `quest_details` WHERE `ID`=9461;
INSERT INTO `quest_details` (`ID`,`Emote1`,`Emote2`,`Emote3`,`Emote4`,`EmoteDelay1`,`EmoteDelay2`,`EmoteDelay3`,`EmoteDelay4`,`VerifiedBuild`) VALUES
(9461,1,1,5,0,0,0,0,0,0);
UPDATE `quest_offer_reward` SET `Emote1`=1 WHERE `ID`=9461;

-- Call of Fire (9468)
UPDATE `quest_request_items` SET `EmoteOncomplete`=6 WHERE `ID`=9468;
UPDATE `quest_offer_reward` SET `Emote1`=1,`Emote2`=1 WHERE `ID`=9468;

-- Call of Fire (9464)
DELETE FROM `quest_details` WHERE `ID`=9464;
INSERT INTO `quest_details` (`ID`,`Emote1`,`Emote2`,`Emote3`,`Emote4`,`EmoteDelay1`,`EmoteDelay2`,`EmoteDelay3`,`EmoteDelay4`,`VerifiedBuild`) VALUES
(9464,1,1,1,0,0,0,0,0,0);

-- Call of Fire (9462)
DELETE FROM `quest_details` WHERE `ID`=9462;
INSERT INTO `quest_details` (`ID`,`Emote1`,`Emote2`,`Emote3`,`Emote4`,`EmoteDelay1`,`EmoteDelay2`,`EmoteDelay3`,`EmoteDelay4`,`VerifiedBuild`) VALUES
(9462,1,1,0,0,0,0,0,0,0);
UPDATE `quest_offer_reward` SET `Emote1`=1 WHERE `ID`=9462;

-- Volatile Mutations (10302)
UPDATE `quest_request_items` SET `EmoteOnIncomplete`=1 WHERE `ID`=10302;

-- Call of Earth (9451)
UPDATE `quest_offer_reward` SET `Emote2`=1,`Emote3`=1 WHERE `ID`=9451;

-- Call of Earth (9449)
UPDATE `quest_details` SET `Emote2`=1,`Emote3`=1 WHERE `ID`=9449;

-- Shaman Training (9421)
UPDATE `quest_offer_reward` SET `Emote2`=1,`Emote3`=1 WHERE `ID`=9421;

-- Urgent Delivery! (9409)
UPDATE `quest_offer_reward` SET `Emote2`=6 WHERE `ID`=9409;

-- The Emblazoned Runeblade (12619)
UPDATE `quest_request_items` SET `EmoteOnIncomplete`=5 WHERE `ID`=12619;

-- Runeforging: Preparation For Battle (12842)
UPDATE `quest_request_items` SET `EmoteOnIncomplete`=5 WHERE `ID`=12842;

-- The Endless Hunger (12848)
UPDATE `quest_request_items` SET `EmoteOnIncomplete`=1 WHERE `ID`=12848;

-- The Eye Of Acherus (12636)
UPDATE `quest_offer_reward` SET `Emote1`=1,`Emote2`=1,`Emote3`=1 WHERE `ID`=12636;

-- Death Comes From On High (12641)
UPDATE `quest_request_items` SET `EmoteOnIncomplete`=1 WHERE `ID`=12641;
UPDATE `quest_offer_reward` SET `Emote1`=1,`Emote2`=1,`Emote3`=1 WHERE `ID`=12641;

-- Report To Scourge Commander Thalanor (12850)
UPDATE `quest_details` SET `Emote1`=1,`Emote2`=1,`Emote3`=1,`Emote4`=5 WHERE `ID`=12850;

-- If Chaos Drives, Let Suffering Hold The Reins (12678)
UPDATE `quest_request_items` SET `EmoteOnIncomplete`=1 WHERE `ID`=12678;

-- Grand Theft Palomino (12680)
UPDATE `quest_request_items` SET `EmoteOnIncomplete`=6 WHERE `ID`=12680;

-- Tonight We Dine In Havenshire (12679)
UPDATE `quest_details` SET `Emote1`=396,`Emote2`=396,`Emote3`=396,`EmoteDelay1`=25 WHERE `ID`=12679; 
UPDATE `quest_offer_reward` SET `Emote1`=396,`EmoteDelay1`=25 WHERE `ID`=12679;

-- Into the Realm of Shadows (12687)
UPDATE `quest_request_items` SET `EmoteOnIncomplete`=5 WHERE `ID`=12687;

-- Gothik the Harvester (12697)
UPDATE `quest_details` SET `Emote1`=1,`Emote2`=1,`Emote3`=1,`Emote4`=1 WHERE `ID`=12697;

-- The Gift That Keeps On Giving (12698)
UPDATE `quest_details` SET `Emote1`=5,`Emote2`=25,`Emote3`=1,`Emote4`=1 WHERE `ID`=12698;
UPDATE `quest_request_items` SET `EmoteOnIncomplete`=1 WHERE `ID`=12698;

-- An Attack Of Opportunity (12700)
UPDATE `quest_details` SET `Emote1`=5,`Emote2`=1,`Emote3`=1,`Emote4`=1 WHERE `ID`=12700;

-- Massacre At Light's Point (12701)
UPDATE `quest_details` SET `Emote1`=274,`Emote2`=1,`Emote3`=1,`Emote4`=1 WHERE `ID`=12701;
UPDATE `quest_request_items` SET `EmoteOnIncomplete`=1 WHERE `ID`=12701;

-- Victory At Death's Breach! (12706)
UPDATE `quest_details` SET `Emote1`=1,`Emote2`=1,`Emote3`=1 WHERE `ID`=12706;

-- The Will Of The Lich King (12714)
UPDATE `quest_details` SET `Emote1`=1,`Emote2`=1,`Emote3`=273,`Emote4`=25 WHERE `ID`=12714;

-- The Crypt of Remembrance (12715)
UPDATE `quest_details` SET `Emote1`=1,`Emote2`=1,`Emote3`=1,`Emote4`=1 WHERE `ID`=12715;

-- The Plaguebringer's Request (12716)
UPDATE `quest_details` SET `Emote1`=1,`Emote2`=5,`Emote3`=1,`Emote4`=6 WHERE `ID`=12716;
UPDATE `quest_request_items` SET `EmoteOnIncomplete`=6 WHERE `ID`=12716;

-- Noth's Special Brew (12717)
UPDATE `quest_details` SET `Emote1`=1,`Emote2`=1,`Emote3`=1 WHERE `ID`=12717;

-- Nowhere To Run And Nowhere To Hide (12719)
UPDATE `quest_details` SET `Emote1`=1,`Emote2`=1,`Emote3`=1 WHERE `ID`=12719;
UPDATE `quest_request_items` SET `EmoteOnIncomplete`=1 WHERE `ID`=12719;

-- Lambs To The Slaughter (12722)
UPDATE `quest_details` SET `Emote1`=0 WHERE `ID`=12722;

-- How To Win Friends And Influence Enemies (12720)
UPDATE `quest_details` SET `Emote1`=1,`Emote2`=1,`Emote3`=1 WHERE `ID`=12720;

-- Behind Scarlet Lines (12723)
UPDATE `quest_details` SET `Emote1`=1,`Emote2`=1,`Emote3`=1 WHERE `ID`=12723;

-- The Path Of The Righteous Crusader (12724)
UPDATE `quest_details` SET `Emote1`=1,`Emote2`=1,`Emote3`=1 WHERE `ID`=12724;
UPDATE `quest_request_items` SET `EmoteOnIncomplete`=5 WHERE `ID`=12724;

-- Brothers In Death (12725)
UPDATE `quest_details` SET `Emote1`=1,`Emote2`=1,`Emote3`=1,`Emote4`=5 WHERE `ID`=12725;

-- A Cry For Vengeance! (12738)
UPDATE `quest_details` SET `Emote1`=1,`Emote2`=1,`Emote3`=1 WHERE `ID`=12738;

-- A Special Surprise (For all races)
DELETE FROM `quest_details` WHERE `ID` IN (12739,12742,12743,12744,12745,12746,12747,12748,12749,12750);
INSERT INTO `quest_details` (`ID`,`Emote1`,`Emote2`,`Emote3`,`Emote4`,`EmoteDelay1`,`EmoteDelay2`,`EmoteDelay3`,`EmoteDelay4`,`VerifiedBuild`) VALUES
(12739,1,1,1,1,0,0,0,0,0),
(12742,1,1,1,1,0,0,0,0,0),
(12743,1,1,1,1,0,0,0,0,0),
(12744,1,1,1,1,0,0,0,0,0),
(12745,1,1,1,1,0,0,0,0,0),
(12746,1,1,1,1,0,0,0,0,0),
(12747,1,1,1,1,0,0,0,0,0),
(12748,1,1,1,1,0,0,0,0,0),
(12749,1,1,1,1,0,0,0,0,0),
(12750,1,1,1,1,0,0,0,0,0);

-- A Sort Of Homecoming (12751)
UPDATE `quest_details` SET `Emote1`=1,`Emote2`=1,`Emote3`=1,`Emote4`=66 WHERE `ID`=12751;

-- Ambush At The Overlook (12754)
UPDATE `quest_details` SET `Emote1`=1,`Emote2`=1,`Emote3`=1,`Emote4`=25 WHERE `ID`=12754;
UPDATE `quest_request_items` SET `EmoteOnIncomplete`=5 WHERE `ID`=12754;

-- A Meeting With Fate (12755)
UPDATE `quest_details` SET `Emote1`=1,`Emote2`=1,`Emote3`=1,`Emote4`=1 WHERE `ID`=12755;

-- The Scarlet Onslaught Emerges (12756)
UPDATE `quest_details` SET `Emote1`=1,`Emote2`=1,`Emote3`=1,`Emote4`=15 WHERE `ID`=12756;

-- Scarlet Armies Approach... (12757)
UPDATE `quest_details` SET `Emote1`=1,`Emote2`=1,`Emote3`=1 WHERE `ID`=12757;

-- The Scarlet Apocalypse (12778)
UPDATE `quest_details` SET `Emote1`=1,`Emote2`=1,`Emote3`=1,`Emote4`=1 WHERE `ID`=12778;
UPDATE `quest_offer_reward` SET `Emote1`=1,`Emote2`=1 WHERE `ID`=12778;

-- An End To All Things... (12779)
UPDATE `quest_details` SET `Emote1`=1,`Emote2`=1,`Emote3`=1,`Emote4`=25 WHERE `ID`=12779;
UPDATE `quest_offer_reward` SET `Emote1`=25,`Emote2`=1,`Emote3`=1 WHERE `ID`=12779;

-- The Lich King's Command (12800)
UPDATE `quest_details` SET `Emote1`=1,`Emote2`=1,`Emote3`=1,`Emote4`=25 WHERE `ID`=12800;

-- The Light of Dawn (12801)
UPDATE `quest_details` SET `Emote1`=1,`Emote2`=1,`Emote3`=1,`Emote4`=15 WHERE `ID`=12801;

-- Taking Back Acherus (13165)
UPDATE `quest_details` SET `Emote1`=1,`Emote2`=1,`Emote3`=1 WHERE `ID`=13165;

-- The Battle For The Ebon Hold (13166)
UPDATE `quest_details` SET `Emote1`=1,`Emote2`=1,`Emote3`=1 WHERE `ID`=13166;
UPDATE `quest_request_items` SET `EmoteOnIncomplete`=5 WHERE `ID`=13166;

-- Where Kings Walk (13188)
UPDATE `quest_details` SET `Emote1`=1,`Emote2`=1,`Emote3`=1 WHERE `ID`=13188;

-- Add proper auras for Chaotic Rift
UPDATE `creature_template_addon` SET `auras`='48019 47687 47732 63577' WHERE `entry`=26918; -- 26918 (Chaotic Rift) - Arcaneform, Chaotic Rift Aura, Chaotic Rift Summon Aura, Chaotic Rift Aggro Proc

-- Quest "What We Don't Know..." (9756) is missing "CompletionText".
UPDATE `quest_request_items` SET `CompletionText`="Do not return until you have succeeded!" WHERE `ID`=9756;

-- Quest "Matis the Cruel" (9711) is missing "CompletionText"
UPDATE `quest_request_items` SET `CompletionText`="A soldier of Matis' stature won't be traveling alone. Be careful out there." WHERE `ID`=9711;

-- Call of Water (9509)
UPDATE `quest_offer_reward` SET `Emote1`=2,`Emote2`=1,`Emote3`=1 WHERE `ID`=9509;

-- Cruelfin's Necklace (9576)
UPDATE `quest_offer_reward` SET `Emote1`=1 WHERE `ID`=9576;

-- Signs of the Legion (9594)
UPDATE `quest_offer_reward` SET `Emote1`=1 WHERE `ID`=9594;

-- Razormaw (9689)
UPDATE `quest_offer_reward` SET `Emote1`=6,`Emote2`=1,`Emote3`=1,`Emote4`=2 WHERE `ID`=9689;

-- Ending Their World (9759)
DELETE FROM `quest_details` WHERE `ID`=9759;
INSERT INTO `quest_details` (`ID`,`Emote1`,`Emote2`,`Emote3`,`Emote4`,`EmoteDelay1`,`EmoteDelay2`,`EmoteDelay3`,`EmoteDelay4`,`VerifiedBuild`) VALUES
(9759,274,1,1,6,0,0,0,0,0);
UPDATE `quest_offer_reward` SET `Emote1`=1,`Emote2`=1,`Emote3`=5,`Emote4`=1 WHERE `ID`=9759;

-- Clearing the Way (9761)
DELETE FROM `quest_details` WHERE `ID`=9761;
INSERT INTO `quest_details` (`ID`,`Emote1`,`Emote2`,`Emote3`,`Emote4`,`EmoteDelay1`,`EmoteDelay2`,`EmoteDelay3`,`EmoteDelay4`,`VerifiedBuild`) VALUES
(9761,1,1,1,1,0,0,0,0,0);

-- Vindicator's Rest (9760)
DELETE FROM `quest_details` WHERE `ID`=9760;
INSERT INTO `quest_details` (`ID`,`Emote1`,`Emote2`,`Emote3`,`Emote4`,`EmoteDelay1`,`EmoteDelay2`,`EmoteDelay3`,`EmoteDelay4`,`VerifiedBuild`) VALUES
(9760,1,1,0,0,0,0,0,0,0);
UPDATE `quest_offer_reward` SET `Emote1`=1,`Emote2`=1 WHERE `ID`=9760;

-- What We Don't Know... (9756)
UPDATE `quest_offer_reward` SET `Emote1`=5,`Emote2`=6 WHERE `ID`=9756;

-- What We Know... (9753)
DELETE FROM `quest_details` WHERE `ID`=9753;
INSERT INTO `quest_details` (`ID`,`Emote1`,`Emote2`,`Emote3`,`Emote4`,`EmoteDelay1`,`EmoteDelay2`,`EmoteDelay3`,`EmoteDelay4`,`VerifiedBuild`) VALUES
(9753,1,1,1,0,0,0,0,0,0);

-- The Sun Gate (9740)
DELETE FROM `quest_details` WHERE `ID`=9740;
INSERT INTO `quest_details` (`ID`,`Emote1`,`Emote2`,`Emote3`,`Emote4`,`EmoteDelay1`,`EmoteDelay2`,`EmoteDelay3`,`EmoteDelay4`,`VerifiedBuild`) VALUES
(9740,1,1,1,5,0,0,0,0,0);
UPDATE `quest_offer_reward` SET `Emote1`=4,`Emote2`=1,`Emote3`=5 WHERE `ID`=9740;

-- Limits of Physical Exhaustion (9746)
DELETE FROM `quest_details` WHERE `ID`=9746;
INSERT INTO `quest_details` (`ID`,`Emote1`,`Emote2`,`Emote3`,`Emote4`,`EmoteDelay1`,`EmoteDelay2`,`EmoteDelay3`,`EmoteDelay4`,`VerifiedBuild`) VALUES
(9746,1,1,1,0,0,0,0,0,0);
UPDATE `quest_offer_reward` SET `Emote1`=1,`Emote2`=1 WHERE `ID`=9746;

-- Don't Drink the Water (9748)
DELETE FROM `quest_details` WHERE `ID`=9748;
INSERT INTO `quest_details` (`ID`,`Emote1`,`Emote2`,`Emote3`,`Emote4`,`EmoteDelay1`,`EmoteDelay2`,`EmoteDelay3`,`EmoteDelay4`,`VerifiedBuild`) VALUES
(9748,1,1,1,1,0,0,0,0,0);
UPDATE `quest_request_items` SET `EmoteOnIncomplete`=5 WHERE `ID`=9748;
UPDATE `quest_offer_reward` SET `Emote1`=5,`Emote2`=1,`Emote3`=1 WHERE `ID`=9748;

-- The Cryo-Core (9703)
DELETE FROM `quest_details` WHERE `ID`=9703;
INSERT INTO `quest_details` (`ID`,`Emote1`,`Emote2`,`Emote3`,`Emote4`,`EmoteDelay1`,`EmoteDelay2`,`EmoteDelay3`,`EmoteDelay4`,`VerifiedBuild`) VALUES
(9703,1,1,1,1,0,0,0,0,0);
UPDATE `quest_request_items` SET `EmoteOnIncomplete`=6 WHERE `ID`=9703;
UPDATE `quest_offer_reward` SET `Emote1`=6 WHERE `ID`=9703;

-- They're Alive! Maybe... (9670)
DELETE FROM `quest_details` WHERE `ID`=9670;
INSERT INTO `quest_details` (`ID`,`Emote1`,`Emote2`,`Emote3`,`Emote4`,`EmoteDelay1`,`EmoteDelay2`,`EmoteDelay3`,`EmoteDelay4`,`VerifiedBuild`) VALUES
(9670,1,1,1,5,0,0,0,0,0);
UPDATE `quest_request_items` SET `EmoteOnComplete`=6,`EmoteOnIncomplete`=6 WHERE `ID`=9670;
UPDATE `quest_offer_reward` SET `Emote1`=5,`Emote2`=1 WHERE `ID`=9670;

-- Critters of the Void (9741)
DELETE FROM `quest_details` WHERE `ID`=9741;
INSERT INTO `quest_details` (`ID`,`Emote1`,`Emote2`,`Emote3`,`Emote4`,`EmoteDelay1`,`EmoteDelay2`,`EmoteDelay3`,`EmoteDelay4`,`VerifiedBuild`) VALUES
(9741,1,1,1,0,0,0,0,0,0);

-- I Shoot Magic Into the Darkness (9700)
DELETE FROM `quest_details` WHERE `ID`=9700;
INSERT INTO `quest_details` (`ID`,`Emote1`,`Emote2`,`Emote3`,`Emote4`,`EmoteDelay1`,`EmoteDelay2`,`EmoteDelay3`,`EmoteDelay4`,`VerifiedBuild`) VALUES
(9700,1,1,1,1,0,0,0,0,0);
UPDATE `quest_offer_reward` SET `Emote1`=1,`Emote2`=6,`Emote3`=1 WHERE `ID`=9700;

-- More Irradiated Crystal Shards (9642)
UPDATE `quest_offer_reward` SET `Emote1`=1 WHERE `ID`=9642;

-- Into the Dream (9688)
DELETE FROM `quest_details` WHERE `ID`=9688;
INSERT INTO `quest_details` (`ID`,`Emote1`,`Emote2`,`Emote3`,`Emote4`,`EmoteDelay1`,`EmoteDelay2`,`EmoteDelay3`,`EmoteDelay4`,`VerifiedBuild`) VALUES
(9688,1,1,1,5,0,0,0,0,0);

-- Matis the Cruel (9711)
DELETE FROM `quest_details` WHERE `ID`=9711;
INSERT INTO `quest_details` (`ID`,`Emote1`,`Emote2`,`Emote3`,`Emote4`,`EmoteDelay1`,`EmoteDelay2`,`EmoteDelay3`,`EmoteDelay4`,`VerifiedBuild`) VALUES
(9711,1,25,0,0,0,0,0,0,0);
UPDATE `quest_request_items` SET `EmoteOnIncomplete`=1 WHERE `ID`=9711;
UPDATE `quest_offer_reward` SET `Emote1`=1,`Emote2`=1 WHERE `ID`=9711;

-- Newfound Allies (9632)
UPDATE `quest_offer_reward` SET `Emote1`=1 WHERE `ID`=9632;

-- Galaen's Journal - The Fate of Vindicator Saruan (9706)
UPDATE `quest_offer_reward` SET `Emote1`=18,`Emote2`=1,`Emote3`=15 WHERE `ID`=9706;

-- Galaen's Fate (9579)
UPDATE `quest_offer_reward` SET `Emote1`=1,`Emote2`=1 WHERE `ID`=9579;

-- Fouled Water Spirits (10067)
DELETE FROM `quest_details` WHERE `ID`=10067;
INSERT INTO `quest_details` (`ID`,`Emote1`,`Emote2`,`Emote3`,`Emote4`,`EmoteDelay1`,`EmoteDelay2`,`EmoteDelay3`,`EmoteDelay4`,`VerifiedBuild`) VALUES
(10067,1,1,1,0,0,0,0,0,0);
UPDATE `quest_offer_reward` SET `Emote1`=1,`Emote2`=1,`Emote3`=1 WHERE `ID`=10067;

-- Oh, the Tangled Webs They Weave (10066)
DELETE FROM `quest_details` WHERE `ID`=10066;
INSERT INTO `quest_details` (`ID`,`Emote1`,`Emote2`,`Emote3`,`Emote4`,`EmoteDelay1`,`EmoteDelay2`,`EmoteDelay3`,`EmoteDelay4`,`VerifiedBuild`) VALUES
(10066,1,1,1,0,0,0,0,0,0);
UPDATE `quest_offer_reward` SET `Emote1`=1,`Emote2`=1,`Emote3`=1 WHERE `ID`=10066;

-- The Missing Expedition (9669)
DELETE FROM `quest_details` WHERE `ID`=9669;
INSERT INTO `quest_details` (`ID`,`Emote1`,`Emote2`,`Emote3`,`Emote4`,`EmoteDelay1`,`EmoteDelay2`,`EmoteDelay3`,`EmoteDelay4`,`VerifiedBuild`) VALUES
(9669,1,1,1,0,0,0,0,0,0);
UPDATE `quest_request_items` SET `EmoteOnIncomplete`=1 WHERE `ID`=9669;

-- Talk to the Hand (10064)
DELETE FROM `quest_details` WHERE `ID`=10064;
INSERT INTO `quest_details` (`ID`,`Emote1`,`Emote2`,`Emote3`,`Emote4`,`EmoteDelay1`,`EmoteDelay2`,`EmoteDelay3`,`EmoteDelay4`,`VerifiedBuild`) VALUES
(10064,1,1,1,0,0,0,0,0,0);

-- The Final Sample (9585)
DELETE FROM `quest_details` WHERE `ID`=9585;
INSERT INTO `quest_details` (`ID`,`Emote1`,`Emote2`,`Emote3`,`Emote4`,`EmoteDelay1`,`EmoteDelay2`,`EmoteDelay3`,`EmoteDelay4`,`VerifiedBuild`) VALUES
(9585,1,0,0,0,0,0,0,0,0);
UPDATE `quest_request_items` SET `EmoteOnIncomplete`=1 WHERE `ID`=9585;
UPDATE `quest_offer_reward` SET `Emote1`=1 WHERE `ID`=9585;

-- Nolkai's Words (9561)
DELETE FROM `quest_details` WHERE `ID`=9561;
INSERT INTO `quest_details` (`ID`,`Emote1`,`Emote2`,`Emote3`,`Emote4`,`EmoteDelay1`,`EmoteDelay2`,`EmoteDelay3`,`EmoteDelay4`,`VerifiedBuild`) VALUES
(9561,1,0,0,0,0,0,0,0,0);

-- Deciphering the Book (9557)
UPDATE `quest_offer_reward` SET `Emote1`=1 WHERE `ID`=9557;

-- Culling the Flutterers (9647)
DELETE FROM `quest_details` WHERE `ID`=9647;
INSERT INTO `quest_details` (`ID`,`Emote1`,`Emote2`,`Emote3`,`Emote4`,`EmoteDelay1`,`EmoteDelay2`,`EmoteDelay3`,`EmoteDelay4`,`VerifiedBuild`) VALUES
(9647,1,0,0,0,0,0,0,0,0);
UPDATE `quest_offer_reward` SET `Emote1`=1 WHERE `ID`=9647;

-- Restoring Sanctity (9687)
DELETE FROM `quest_details` WHERE `ID`=9687;
INSERT INTO `quest_details` (`ID`,`Emote1`,`Emote2`,`Emote3`,`Emote4`,`EmoteDelay1`,`EmoteDelay2`,`EmoteDelay3`,`EmoteDelay4`,`VerifiedBuild`) VALUES
(9687,1,1,1,0,0,0,0,0,0);
UPDATE `quest_request_items` SET `EmoteOnIncomplete`=1 WHERE `ID`=9687;
UPDATE `quest_offer_reward` SET `Emote1`=6,`Emote2`=1,`Emote3`=274 WHERE `ID`=9687;

-- Ending the Bloodcurse (9683)
DELETE FROM `quest_details` WHERE `ID`=9683;
INSERT INTO `quest_details` (`ID`,`Emote1`,`Emote2`,`Emote3`,`Emote4`,`EmoteDelay1`,`EmoteDelay2`,`EmoteDelay3`,`EmoteDelay4`,`VerifiedBuild`) VALUES
(9683,1,1,1,0,0,0,0,0,0);

-- The Hopeless Ones... (9682)
UPDATE `quest_request_items` SET `EmoteOnIncomplete`=1 WHERE `ID`=9682;

-- The Bloodcursed Naga (9674)
DELETE FROM `quest_details` WHERE `ID`=9674;
INSERT INTO `quest_details` (`ID`,`Emote1`,`Emote2`,`Emote3`,`Emote4`,`EmoteDelay1`,`EmoteDelay2`,`EmoteDelay3`,`EmoteDelay4`,`VerifiedBuild`) VALUES
(9674,1,1,1,1,0,0,0,0,0);
UPDATE `quest_request_items` SET `EmoteOnIncomplete`=1 WHERE `ID`=9674;
UPDATE `quest_offer_reward` SET `Emote1`=1 WHERE `ID`=9674;

-- Artifacts of the Blacksilt (9549)
DELETE FROM `quest_details` WHERE `ID`=9549;
INSERT INTO `quest_details` (`ID`,`Emote1`,`Emote2`,`Emote3`,`Emote4`,`EmoteDelay1`,`EmoteDelay2`,`EmoteDelay3`,`EmoteDelay4`,`VerifiedBuild`) VALUES
(9549,1,0,0,0,0,0,0,0,0);
UPDATE `quest_request_items` SET `EmoteOnIncomplete`=1 WHERE `ID`=9549;
UPDATE `quest_offer_reward` SET `Emote1`=4 WHERE `ID`=9549;

-- Pilfered Equipment (9548)
DELETE FROM `quest_details` WHERE `ID`=9548;
INSERT INTO `quest_details` (`ID`,`Emote1`,`Emote2`,`Emote3`,`Emote4`,`EmoteDelay1`,`EmoteDelay2`,`EmoteDelay3`,`EmoteDelay4`,`VerifiedBuild`) VALUES
(9548,1,0,0,0,0,0,0,0,0);
UPDATE `quest_request_items` SET `EmoteOnIncomplete`=1 WHERE `ID`=9548;
UPDATE `quest_offer_reward` SET `Emote1`=1 WHERE `ID`=9548;

-- Audience with the Prophet (9698)
DELETE FROM `quest_details` WHERE `ID`=9698;
INSERT INTO `quest_details` (`ID`,`Emote1`,`Emote2`,`Emote3`,`Emote4`,`EmoteDelay1`,`EmoteDelay2`,`EmoteDelay3`,`EmoteDelay4`,`VerifiedBuild`) VALUES
(9698,1,1,1,0,0,0,0,0,0);
UPDATE `quest_offer_reward` SET `Emote1`=1,`Emote2`=1 WHERE `ID`=9698;

-- Newfound Allies (9632)
DELETE FROM `quest_details` WHERE `ID`=9632;
INSERT INTO `quest_details` (`ID`,`Emote1`,`Emote2`,`Emote3`,`Emote4`,`EmoteDelay1`,`EmoteDelay2`,`EmoteDelay3`,`EmoteDelay4`,`VerifiedBuild`) VALUES
(9632,1,0,0,0,0,0,0,0,0);

-- Searching for Galaen (9578)
DELETE FROM `quest_details` WHERE `ID`=9578;
INSERT INTO `quest_details` (`ID`,`Emote1`,`Emote2`,`Emote3`,`Emote4`,`EmoteDelay1`,`EmoteDelay2`,`EmoteDelay3`,`EmoteDelay4`,`VerifiedBuild`) VALUES
(9578,1,0,0,0,0,0,0,0,0);

-- Urgent Delivery (9671)
UPDATE `quest_offer_reward` SET `Emote1`=6,`Emote2`=1,`Emote3`=5 WHERE `ID`=9671;

-- The Bear Necessities (9580)
DELETE FROM `quest_details` WHERE `ID`=9580;
INSERT INTO `quest_details` (`ID`,`Emote1`,`Emote2`,`Emote3`,`Emote4`,`EmoteDelay1`,`EmoteDelay2`,`EmoteDelay3`,`EmoteDelay4`,`VerifiedBuild`) VALUES
(9580,1,0,0,0,0,0,0,0,0);
UPDATE `quest_request_items` SET `EmoteOnIncomplete`=1 WHERE `ID`=9580;
UPDATE `quest_offer_reward` SET `Emote1`=1 WHERE `ID`=9580;

-- Constrictor Vines (9643)
DELETE FROM `quest_details` WHERE `ID`=9643;
INSERT INTO `quest_details` (`ID`,`Emote1`,`Emote2`,`Emote3`,`Emote4`,`EmoteDelay1`,`EmoteDelay2`,`EmoteDelay3`,`EmoteDelay4`,`VerifiedBuild`) VALUES
(9643,1,0,0,0,0,0,0,0,0);
UPDATE `quest_request_items` SET `EmoteOnIncomplete`=1 WHERE `ID`=9643;
UPDATE `quest_offer_reward` SET `Emote1`=1 WHERE `ID`=9643;

-- Ysera's Tears (9649)
DELETE FROM `quest_details` WHERE `ID`=9649;
INSERT INTO `quest_details` (`ID`,`Emote1`,`Emote2`,`Emote3`,`Emote4`,`EmoteDelay1`,`EmoteDelay2`,`EmoteDelay3`,`EmoteDelay4`,`VerifiedBuild`) VALUES
(9649,1,1,1,0,0,0,0,0,0);
UPDATE `quest_request_items` SET `EmoteOnIncomplete`=1 WHERE `ID`=9649;

-- Translations... (9696)
DELETE FROM `quest_details` WHERE `ID`=9696;
INSERT INTO `quest_details` (`ID`,`Emote1`,`Emote2`,`Emote3`,`Emote4`,`EmoteDelay1`,`EmoteDelay2`,`EmoteDelay3`,`EmoteDelay4`,`VerifiedBuild`) VALUES
(9696,1,1,0,0,0,0,0,0,0);
UPDATE `quest_offer_reward` SET `Emote1`=1,`Emote2`=1 WHERE `ID`=9696;

-- The Second Sample (9584)
DELETE FROM `quest_details` WHERE `ID`=9584;
INSERT INTO `quest_details` (`ID`,`Emote1`,`Emote2`,`Emote3`,`Emote4`,`EmoteDelay1`,`EmoteDelay2`,`EmoteDelay3`,`EmoteDelay4`,`VerifiedBuild`) VALUES
(9584,1,0,0,0,0,0,0,0,0);
UPDATE `quest_request_items` SET `EmoteOnIncomplete`=1 WHERE `ID`=9584;
UPDATE `quest_offer_reward` SET `Emote1`=1 WHERE `ID`=9584;

-- Salvaging the Data (9628)
UPDATE `quest_offer_reward` SET `Emote1`=1 WHERE `ID`=9628;

-- The Missing Survey Team (9620)
DELETE FROM `quest_details` WHERE `ID`=9620;
INSERT INTO `quest_details` (`ID`,`Emote1`,`Emote2`,`Emote3`,`Emote4`,`EmoteDelay1`,`EmoteDelay2`,`EmoteDelay3`,`EmoteDelay4`,`VerifiedBuild`) VALUES
(9620,1,0,0,0,0,0,0,0,0);

-- Intercepting the Message (9779)
DELETE FROM `quest_details` WHERE `ID`=9779;
INSERT INTO `quest_details` (`ID`,`Emote1`,`Emote2`,`Emote3`,`Emote4`,`EmoteDelay1`,`EmoteDelay2`,`EmoteDelay3`,`EmoteDelay4`,`VerifiedBuild`) VALUES
(9779,1,1,1,1,0,0,0,0,0);
UPDATE `quest_request_items` SET `EmoteOnComplete`=6,`EmoteOnIncomplete`=6 WHERE `ID`=9779;
UPDATE `quest_offer_reward` SET `Emote1`=1,`Emote2`=1 WHERE `ID`=9779;

-- Containing the Threat (9569)
DELETE FROM `quest_details` WHERE `ID`=9569;
INSERT INTO `quest_details` (`ID`,`Emote1`,`Emote2`,`Emote3`,`Emote4`,`EmoteDelay1`,`EmoteDelay2`,`EmoteDelay3`,`EmoteDelay4`,`VerifiedBuild`) VALUES
(9569,15,0,0,0,0,0,0,0,0);
UPDATE `quest_request_items` SET `EmoteOnIncomplete`=1 WHERE `ID`=9569;
UPDATE `quest_offer_reward` SET `Emote1`=1 WHERE `ID`=9569;

-- Blood Watch (9694)
DELETE FROM `quest_details` WHERE `ID`=9694;
INSERT INTO `quest_details` (`ID`,`Emote1`,`Emote2`,`Emote3`,`Emote4`,`EmoteDelay1`,`EmoteDelay2`,`EmoteDelay3`,`EmoteDelay4`,`VerifiedBuild`) VALUES
(9694,1,1,1,1,0,0,0,0,0);
UPDATE `quest_request_items` SET `EmoteOnIncomplete`=1 WHERE `ID`=9694;
UPDATE `quest_offer_reward` SET `Emote1`=5,`Emote2`=1,`Emote1`=3,`Emote4`=1 WHERE `ID`=9694;

-- Learning from the Crystals (9581)
DELETE FROM `quest_details` WHERE `ID`=9581;
INSERT INTO `quest_details` (`ID`,`Emote1`,`Emote2`,`Emote3`,`Emote4`,`EmoteDelay1`,`EmoteDelay2`,`EmoteDelay3`,`EmoteDelay4`,`VerifiedBuild`) VALUES
(9581,1,0,0,0,0,0,0,0,0);
UPDATE `quest_request_items` SET `EmoteOnIncomplete`=1 WHERE `ID`=9581;
UPDATE `quest_offer_reward` SET `Emote1`=1 WHERE `ID`=9581;

-- WANTED: Deathclaw (9646)
UPDATE `quest_request_items` SET `EmoteOnIncomplete`=1 WHERE `ID`=9646;
UPDATE `quest_offer_reward` SET `Emote1`=1 WHERE `ID`=9646;

-- What Argus Means to Me (9693)
DELETE FROM `quest_details` WHERE `ID`=9693;
INSERT INTO `quest_details` (`ID`,`Emote1`,`Emote2`,`Emote3`,`Emote4`,`EmoteDelay1`,`EmoteDelay2`,`EmoteDelay3`,`EmoteDelay4`,`VerifiedBuild`) VALUES
(9693,6,1,1,1,0,0,0,0,0);

-- Victims of Corruption (9574)
DELETE FROM `quest_details` WHERE `ID`=9574;
INSERT INTO `quest_details` (`ID`,`Emote1`,`Emote2`,`Emote3`,`Emote4`,`EmoteDelay1`,`EmoteDelay2`,`EmoteDelay3`,`EmoteDelay4`,`VerifiedBuild`) VALUES
(9574,1,0,0,0,0,0,0,0,0);
UPDATE `quest_request_items` SET `EmoteOnIncomplete`=1 WHERE `ID`=9574;
UPDATE `quest_offer_reward` SET `Emote1`=1 WHERE `ID`=9574;

-- On the Wings of a Hippogryph (9604)
DELETE FROM `quest_details` WHERE `ID`=9604;
INSERT INTO `quest_details` (`ID`,`Emote1`,`Emote2`,`Emote3`,`Emote4`,`EmoteDelay1`,`EmoteDelay2`,`EmoteDelay3`,`EmoteDelay4`,`VerifiedBuild`) VALUES
(9604,1,0,0,0,0,0,0,0,0);
UPDATE `quest_offer_reward` SET `Emote1`=1 WHERE `ID`=9604;

-- Explorers' League, Is That Something for Gnomes? (10063)
DELETE FROM `quest_details` WHERE `ID`=10063;
INSERT INTO `quest_details` (`ID`,`Emote1`,`Emote2`,`Emote3`,`Emote4`,`EmoteDelay1`,`EmoteDelay2`,`EmoteDelay3`,`EmoteDelay4`,`VerifiedBuild`) VALUES
(10063,1,1,1,1,0,0,0,0,0);
UPDATE `quest_offer_reward` SET `Emote1`=1,`Emote2`=1 WHERE `ID`=10063;

-- Mac'Aree Mushroom Menagerie (9648)
DELETE FROM `quest_details` WHERE `ID`=9648;
INSERT INTO `quest_details` (`ID`,`Emote1`,`Emote2`,`Emote3`,`Emote4`,`EmoteDelay1`,`EmoteDelay2`,`EmoteDelay3`,`EmoteDelay4`,`VerifiedBuild`) VALUES
(9648,1,1,1,1,0,0,0,0,0);
UPDATE `quest_request_items` SET `EmoteOnIncomplete`=1 WHERE `ID`=9648;
UPDATE `quest_offer_reward` SET `Emote1`=1,`Emote2`=1 WHERE `ID`=9648;

-- Irradiated Crystal Shards (9641)
DELETE FROM `quest_details` WHERE `ID`=9641;
INSERT INTO `quest_details` (`ID`,`Emote1`,`Emote2`,`Emote3`,`Emote4`,`EmoteDelay1`,`EmoteDelay2`,`EmoteDelay3`,`EmoteDelay4`,`VerifiedBuild`) VALUES
(9641,1,0,0,0,0,0,0,0,0);
UPDATE `quest_request_items` SET `EmoteOnIncomplete`=1 WHERE `ID`=9641;
UPDATE `quest_offer_reward` SET `Emote1`=1 WHERE `ID`=9641;

-- Catch and Release (9629)
DELETE FROM `quest_details` WHERE `ID`=9629;
INSERT INTO `quest_details` (`ID`,`Emote1`,`Emote2`,`Emote3`,`Emote4`,`EmoteDelay1`,`EmoteDelay2`,`EmoteDelay3`,`EmoteDelay4`,`VerifiedBuild`) VALUES
(9629,1,0,0,0,0,0,0,0,0);
UPDATE `quest_offer_reward` SET `Emote1`=4 WHERE `ID`=9629;

-- Know Thine Enemy (9567)
DELETE FROM `quest_details` WHERE `ID`=9567;
INSERT INTO `quest_details` (`ID`,`Emote1`,`Emote2`,`Emote3`,`Emote4`,`EmoteDelay1`,`EmoteDelay2`,`EmoteDelay3`,`EmoteDelay4`,`VerifiedBuild`) VALUES
(9567,1,0,0,0,0,0,0,0,0);
UPDATE `quest_request_items` SET `EmoteOnIncomplete`=1 WHERE `ID`=9567;
UPDATE `quest_offer_reward` SET `Emote1`=1 WHERE `ID`=9567;

-- Beds, Bandages, and Beyond (9603)
DELETE FROM `quest_details` WHERE `ID`=9603;
INSERT INTO `quest_details` (`ID`,`Emote1`,`Emote2`,`Emote3`,`Emote4`,`EmoteDelay1`,`EmoteDelay2`,`EmoteDelay3`,`EmoteDelay4`,`VerifiedBuild`) VALUES
(9603,1,0,0,0,0,0,0,0,0);
UPDATE `quest_details` SET `Emote2`=1,`Emote3`=1 WHERE `ID`=9603;
UPDATE `quest_offer_reward` SET `Emote1`=1 WHERE `ID`=9603;

-- Report to Exarch Admetius (9668)
DELETE FROM `quest_details` WHERE `ID`=9668;
INSERT INTO `quest_details` (`ID`,`Emote1`,`Emote2`,`Emote3`,`Emote4`,`EmoteDelay1`,`EmoteDelay2`,`EmoteDelay3`,`EmoteDelay4`,`VerifiedBuild`) VALUES
(9668,1,1,274,0,0,0,0,0,0);
UPDATE `quest_offer_reward` SET `Emote1`=1,`Emote2`=1,`Emote3`=1 WHERE `ID`=9668;

-- Declaration of Power (9666)
UPDATE `quest_request_items` SET `EmoteOnIncomplete`=6 WHERE `ID`=9666;
UPDATE `quest_offer_reward` SET `Emote1`=1,`Emote2`=1,`Emote3`=1 WHERE `ID`=9666;

-- The Kessel Run (9663)
DELETE FROM `quest_details` WHERE `ID`=9663;
INSERT INTO `quest_details` (`ID`,`Emote1`,`Emote2`,`Emote3`,`Emote4`,`EmoteDelay1`,`EmoteDelay2`,`EmoteDelay3`,`EmoteDelay4`,`VerifiedBuild`) VALUES
(9663,1,1,1,5,0,0,0,0,0);
UPDATE `quest_request_items` SET `EmoteOnComplete`=5,`EmoteOnIncomplete`=5 WHERE `ID`=9663;
UPDATE `quest_offer_reward` SET `Emote1`=21,`Emote2`=1,`Emote3`=1 WHERE `ID`=9663;

-- A Favorite Treat (9624)
DELETE FROM `quest_details` WHERE `ID`=9624;
INSERT INTO `quest_details` (`ID`,`Emote1`,`Emote2`,`Emote3`,`Emote4`,`EmoteDelay1`,`EmoteDelay2`,`EmoteDelay3`,`EmoteDelay4`,`VerifiedBuild`) VALUES
(9624,1,0,0,0,0,0,0,0,0);
UPDATE `quest_request_items` SET `EmoteOnIncomplete`=1 WHERE `ID`=9624;
UPDATE `quest_offer_reward` SET `Emote1`=1 WHERE `ID`=9624;

-- Alien Predators (9634)
DELETE FROM `quest_details` WHERE `ID`=9634;
INSERT INTO `quest_details` (`ID`,`Emote1`,`Emote2`,`Emote3`,`Emote4`,`EmoteDelay1`,`EmoteDelay2`,`EmoteDelay3`,`EmoteDelay4`,`VerifiedBuild`) VALUES
(9634,1,0,0,0,0,0,0,0,0);
UPDATE `quest_request_items` SET `EmoteOnIncomplete`=1 WHERE `ID`=9634;
UPDATE `quest_offer_reward` SET `Emote1`=1 WHERE `ID`=9634;

--
DELETE FROM `areatrigger_scripts` WHERE `entry`IN(5685,5684);
INSERT INTO `areatrigger_scripts` (`entry`, `ScriptName`) VALUES 
(5684, 'SmartTrigger'),
(5685, 'SmartTrigger');

DELETE FROM `creature_text` WHERE `CreatureID`=37781 AND `GroupID`=2;
DELETE FROM `creature_text` WHERE `CreatureID`=37764 AND `GroupID`=2;
DELETE FROM `creature_text` WHERE `CreatureID`=37764 AND `GroupID`=3;
DELETE FROM `creature_text` WHERE `CreatureID`=37763 AND `GroupID`=5;
DELETE FROM `creature_text` WHERE `CreatureID`=37763 AND `GroupID`=6;
DELETE FROM `creature_text` WHERE `CreatureID`=37763 AND `GroupID`=7;
DELETE FROM `creature_text` WHERE `CreatureID`=37765 AND `GroupID`=3;
DELETE FROM `creature_text` WHERE `CreatureID`=37765 AND `GroupID`=4;
DELETE FROM `creature_text` WHERE `CreatureID`=37763 AND `GroupID`=8;
DELETE FROM `creature_text` WHERE `CreatureID`IN(38052,38047);

INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES 
(38052, 0, 0, "My brothers and sisters, words cannot describe what I felt upon seeing the Sunwell rekindled.", 12, 0, 100, 1, 0, 0, 37809, 0, 'Lady Liadrin'),
(38052, 1, 0, "In that moment, the Light revealed to me the truth of the terrible things I had done.", 12, 0, 100, 1, 0, 0, 37811, 0, 'Lady Liadrin'),
(38052, 2, 0, "Our people had walked a dark path and mine was among the darkest of them all.", 12, 0, 100, 1, 0, 0, 37813, 0, 'Lady Liadrin'),
(38052, 3, 0, "But the Light showed me that I was not lost. It helped me to find the strength to survive in spite of all that had happened and all the evil I had wrought.", 12, 0, 100, 1, 0, 0, 37814, 0, 'Lady Liadrin'),
(38052, 4, 0, "It is a strength that we sin'dorei all share. It is a strength we will need to free ourselves of the addiction ravaging our people.", 12, 0, 100, 1, 0, 0, 37815, 0, 'Lady Liadrin'),
(38052, 5, 0, "It will be the most difficult battle we have ever faced, but our resolve and the power of the Sunwell will sustain us until we have been restored to our greatness.", 12, 0, 100, 1, 0, 0, 37816, 0, 'Lady Liadrin'),
(38047, 0, 0, "Well said, my lady. We sin'dorei will be free and we shall be great again!", 12, 0, 100, 1, 0, 0, 37817, 0, 'Blood Elf Pilgrim'),
(37781, 2, 0, "Can that really be Quel'Delar?", 12, 0, 100, 1, 0, 0, 37441, 0, 'Sunwell Honor Guard'),
(37764, 2, 0, "It is indeed Quel'Delar. I had not thought I'd live to see the day when Thalorien Dawnseeker's legendary sword would be restored to us.", 12, 0, 100, 1, 0, 0, 37449, 0, 'Lor themar Theron'),
(37764, 3, 0, "You are a hero and an inspiration to the sin'dorei, $n, a symbol of our endurance in the face of tragedy and treachery.", 12, 0, 100, 1, 0, 0, 37450, 0, 'Lor themar Theron'),
(37763, 5, 0, "The regent speaks truly, $n. Thalorien's sacrifice could not prevent the fall of this very Sunwell.", 12, 0, 100, 1, 0, 0, 37451, 0, 'Grand Magister Rommat'),
(37763, 6, 0, "When you found the sword, it was broken and abandoned, much like Silvermoon after Kael'thas's betrayal.", 12, 0, 100, 1, 0, 0, 37452, 0, 'Grand Magister Rommat'),
(37763, 7, 0, "Let Quel'Delar be a sign that we will never give up, that we will face any enemy without fear.", 12, 0, 100, 1, 0, 0, 37453, 0, 'Grand Magister Rommat'),
(37765, 3, 0, "Quel'Delar is not held in high esteem by the sin'dorei alone. It holds a place in the heart of all children of Silvermoon.", 12, 0, 100, 1, 0, 0, 37454, 0, 'Captain Auric Sunchaser'),
(37765, 4, 0, "This blade has been returned to us for a reason, my lords. Now is the time to rally behind the bearer of Quel'Delar and avenge the destruction of Silvermoon and the Sunwell.", 12, 0, 100, 1, 0, 0, 37455, 0, 'Captain Auric Sunchaser'),
(37763, 8, 0, "Reclaim the sword, $n, and bear it through that portal to Dalaran. Archmage Aethas Sunreaver will be waiting to congratulate you.", 12, 0, 100, 1, 0, 0, 37456, 0, 'Grand Magister Rommat');


DELETE FROM `smart_scripts` WHERE `entryorguid`IN(5684,5685) AND `source_type`=2;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES 
(5684, 2, 0, 1, 46, 0, 100, 0, 5684, 0, 0, 0, 0, 64, 1, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'On Trigger - Store Target List'),
(5684, 2, 1, 2, 61, 0, 100, 0, 0, 0, 0, 0, 0, 100, 1, 0, 0, 0, 0, 0, 10, 123012, 38056, 0, 0, 0, 0, 0, 0, 'On Trigger - Send Target List to Chamberlain Galiros'),
(5684, 2, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 45, 1, 1, 0, 0, 0, 0, 10, 123012, 38056, 0, 0, 0, 0, 0, 0, 'On Trigger - Set Data on Chamberlain Galiros'),
(5685, 2, 0, 1, 46, 0, 100, 0, 5685, 0, 0, 0, 0, 64, 1, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'On Trigger - Store Target List'),
(5685, 2, 1, 2, 61, 0, 100, 0, 0, 0, 0, 0, 0, 100, 1, 0, 0, 0, 0, 0, 10, 123012, 38056, 0, 0, 0, 0, 0, 0, 'On Trigger - Send Target List to Chamberlain Galiros'),
(5685, 2, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 45, 1, 1, 0, 0, 0, 0, 10, 123012, 38056, 0, 0, 0, 0, 0, 0, 'On Trigger - Set Data on Chamberlain Galiros');

DELETE FROM `spell_area` WHERE `spell`=70193 AND `area`IN(4094,4075);
INSERT INTO `spell_area` (`spell`, `area`, `quest_start`, `quest_end`, `aura_spell`, `racemask`, `gender`, `autocast`, `quest_start_status`, `quest_end_status`) VALUES 
(70193, 4094, 24522, 24535, 0, 0, 2, 1, 74, 11),
(70193, 4094, 24562, 24563, 0, 0, 2, 1, 74, 11),
(70193, 4094, 24553, 24553, 0, 0, 2, 1, 74, 11),
(70193, 4094, 24564, 24564, 0, 0, 2, 1, 74, 11),
(70193, 4094, 24594, 24594, 0, 0, 2, 1, 74, 11),
(70193, 4094, 24595, 24595, 0, 0, 2, 1, 74, 11),
(70193, 4094, 24596, 24596, 0, 0, 2, 1, 74, 11),
(70193, 4094, 24598, 24598, 0, 0, 2, 1, 74, 11),
(70193, 4075, 24553, 24553, 0, 0, 2, 1, 74, 11),
(70193, 4075, 24564, 24564, 0, 0, 2, 1, 74, 11),
(70193, 4075, 24594, 24594, 0, 0, 2, 1, 74, 11),
(70193, 4075, 24595, 24595, 0, 0, 2, 1, 74, 11),
(70193, 4075, 24596, 24596, 0, 0, 2, 1, 74, 11),
(70193, 4075, 24598, 24598, 0, 0, 2, 1, 74, 11);

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=13 AND `SourceEntry`=70466;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES 
(13, 1, 70466, 0, 0, 31, 0, 3, 37745, 0, 0, 0, 0, '', 'Sunwell Light Ray targets Quel delar');


DELETE FROM `gameobject` WHERE `guid`=9897;
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `VerifiedBuild`) VALUES 
(9897, 201796, 580, 0, 0, 1, 2048, 1698.92, 628.188, 27.6144, 0.334681, -0, -0, -0.166561, -0.986031, 300, 255, 1, '', 0);

DELETE FROM `event_scripts` WHERE `id`IN(22833,22854);
INSERT INTO `event_scripts` (`id`, `delay`, `command`, `datalong`, `datalong2`, `dataint`, `x`, `y`, `z`, `o`) VALUES 
(22833, 0, 10, 37745, 1800000, 0, 0, 0, 0, 0), -- Blood Elf
(22833, 1, 10, 39691, 1800000, 0, 0, 0, 0, 0), -- Blood Elf
(22854, 0, 10, 37745, 1800000, 0, 0, 0, 0, 0), -- Non Blood Elf
(22854, 1, 10, 39692, 1800000, 0, 0, 0, 0, 0); -- Non Blood Elf

UPDATE `creature_template` SET `AIName`='SmartAI' WHERE  `entry`IN(37745,37746,37763,37764,37765,38056,37781,37527,37523,39691,39692,38052,38047);
DELETE FROM `smart_scripts` WHERE `entryorguid` IN(37745,37746,37763,37764,37765,38056,37781,-122985,-122777,-122953,37527,37523,39691,39692,38052,38047,-122624) AND `source_type`=0;
DELETE FROM `smart_scripts` WHERE `entryorguid` IN(3774500,3774501,3776500,3776400,3805200) AND `source_type`=9;

INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(-122624,0,0,0,11,0,100,0,0,0,0,0,1,0,12000,0,0,0,0,19,38052,0,0,0,0,0,0,"Lady Liadrin - On Spawn - Say Line 0"),
(-122624,0,1,0,52,0,100,0,0,38052,0,0,1,1,12000,0,0,0,0,19,38052,0,0,0,0,0,0,"Lady Liadrin - On Text Over - Say Line 1"),
(-122624,0,2,0,52,0,100,0,1,38052,0,0,1,2,12000,0,0,0,0,19,38052,0,0,0,0,0,0,"Lady Liadrin - On Text Over - Say Line 2"),
(-122624,0,3,0,52,0,100,0,2,38052,0,0,1,3,12000,0,0,0,0,19,38052,0,0,0,0,0,0,"Lady Liadrin - On Text Over - Say Line 3"),
(-122624,0,4,0,52,0,100,0,3,38052,0,0,1,4,12000,0,0,0,0,19,38052,0,0,0,0,0,0,"Lady Liadrin - On Text Over - Say Line 4"),
(-122624,0,5,0,52,0,100,0,4,38052,0,0,1,5,8000,0,0,0,0,19,38052,0,0,0,0,0,0,"Lady Liadrin - On Text Over - Say Line 5"),
(-122624,0,6,0,52,0,100,0,5,38052,0,0,1,0,240000,0,0,0,0,1,0,0,0,0,0,0,0,"Lady Liadrin - On Text Over - Say Line 5"),
(-122624,0,7,0,52,0,100,0,0,38047,0,0,1,0,12000,0,0,0,0,19,38052,0,0,0,0,0,0,"Lady Liadrin - On Text Over - Say Line 0"),
(39691,0,0,0,54,0,100,0,0,0,0,0,45,1,1,0,0,0,0,19,37745,0,0,0,0,0,0,"Bunny Set Data"),
(39692,0,0,0,54,0,100,0,0,0,0,0,45,2,2,0,0,0,0,19,37745,0,0,0,0,0,0,"Bunny Set Data"),
(37523,0,0,1,62,0,100,0,10963,0,0,0,72,0,0,0,0,0,0,7,0,0,0,0,0,0,0,"Warden of the Sunwell - On Gossip Option selected - close gossip'"),
(37523,0,1,0,61,0,100,0,0,0,0,0,134,70746,0,0,0,0,0,7,0,0,0,0,0,0,0,"Warden of the Sunwell - On Gossip Option selected - Invoker cast 70746'"),
(37763,0,0,0,38,0,100,0,1,1,0,0,53,0,37763,0,0,0,0,1,0,0,0,0,0,0,0,"Grand Magister Rommath - Data Set - Start WP'"),
(37763,0,1,0,38,0,100,0,2,2,0,0,11,70540,0,0,0,0,0,12,1,0,0,0,0,0,0,"Grand Magister Rommath - Data Set - Cast spell 70540 at player"),
(37763,0,2,0,38,0,100,0,3,3,0,0,1,4,0,0,0,0,0,12,1,0,0,0,0,0,0,"Grand Magister Rommath - Data Set - Say Line 4"),
(37763,0,3,0,38,0,100,0,8,8,0,0,53,0,3776300,0,0,0,0,1,0,0,0,0,0,0,0,"Grand Magister Rommath - Data Set - Start WP'"),
(37763,0,4,0,38,0,100,0,2,2,0,0,1,0,0,0,0,0,0,12,1,0,0,0,0,0,0,"Lor'themar Theron - Data Set - Say Line 0'"),
(37763,0,5,0,38,0,100,0,8,2,0,0,1,5,0,0,0,0,0,12,1,0,0,0,0,0,0,"Lor'themar Theron - Data Set - Say Line 5'"),
(37763,0,6,0,38,0,100,0,8,3,0,0,1,8,0,0,0,0,0,12,1,0,0,0,0,0,0,"Lor'themar Theron - Data Set - Say Line 5'"),
(37763,0,7,0,38,0,100,0,8,4,0,0,53,0,3776300,0,0,0,0,1,0,0,0,0,0,0,0,"Lor'themar Theron - Data Set - Say Line 5'"),
(37764,0,0,0,38,0,100,0,1,1,0,0,53,0,37764,0,0,0,0,1,0,0,0,0,0,0,0,"Lor'themar Theron - Data Set - Start WP'"),
(37764,0,2,0,38,0,100,0,3,3,0,0,71,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"Lor'themar Theron - Data Set - Set Equipment"),
(37764,0,3,5,38,0,100,0,4,4,0,0,11,70493,0,0,0,0,0,1,0,0,0,0,0,0,0,"Lor'themar Theron - Data Set - Cast spell 70493"),
(37764,0,4,0,38,0,100,0,6,6,900000,900000,1,0,0,0,0,0,0,12,1,0,0,0,0,0,0,"Lor'themar Theron - Data Set - Say Line 0'"),
(37764,0,5,0,61,0,100,0,4,4,0,0,80,3776400,0,0,0,0,0,1,0,0,0,0,0,0,0,"Lor'themar Theron - Data Set - Run Script"),
(37764,0,6,0,40,0,100,0,4,37764,4,0,69,0,0,0,0,0,0,19,37745,0,0,0,0,0,0,"Lor'themar Theron - On WP4 Reached - Move to Quel delar"),
(37764,0,7,0,38,0,100,0,9,9,0,0,53,0,3776400,0,0,0,0,1,0,0,0,0,0,0,0,"Lor'themar Theron - Data Set - Start WP"),
(37764,0,8,0,38,0,100,0,8,1,0,0,1,3,0,0,0,0,0,12,1,0,0,0,0,0,0,"Lor'themar Theron - Data Set  3- Say Line"),
(37764,0,9,0,38,0,100,0,8,4,0,0,53,0,3776400,0,0,0,0,1,0,0,0,0,0,0,0,"Lor'themar Theron - Data Set - Say Line 5'"),
(37781,0,0,1,38,0,100,0,2,2,0,0,59,1,0,0,0,0,0,1,0,0,0,0,0,0,0,"Sunwell Honor Guard - Data Set - Turn Run On'"),
(37781,0,1,0,61,0,100,0,0,0,0,0,69,1,0,0,0,0,0,8,0,0,0,1650.221, 606.6376, 30.59028,0,"Sunwell Honor Guard - Data Set - Move to Position'"),
(-122985,0,2,3,38,0,100,0,3,3,0,0,17,333,0,0,0,0,0,1,0,0,0,0,0,0,0,"Sunwell Honor Guard - Data Set - Set Emotestate 333'"),
(-122985,0,3,0,61,0,100,0,0,0,0,0,69,0,0,0,0,0,0,12,1,0,0,-5, -5, 0,0,"Sunwell Honor Guard - Data Set - Follow'"),
(-122985,0,4,0,38,0,100,0,4,4,0,0,17,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"Sunwell Honor Guard - Data Set - Set Emotestate 333'"),
(-122985,0,5,0,38,0,100,0,5,5,0,0,5,66,0,0,0,0,0,1,0,0,0,0,0,0,0,"Sunwell Honor Guard - Data Set - Play Emote One Shot Salute'"),
(-122985,0,6,0,38,0,100,0,6,6,0,0,24,0,2,0,0,0,0,1,0,0,0,0, 0, 0,0,"Sunwell Honor Guard - Data Set - Stop Follow'"),
(-122985,0,7,0,38,0,100,0,7,7,0,0,66,0,2,0,0,0,0,12,1,0,0,0, 0, 0,0,"Sunwell Honor Guard - Data Set - Face Player'"),
(-122777,0,2,3,38,0,100,0,3,3,0,0,17,333,0,0,0,0,0,1,0,0,0,0,0,0,0,"Sunwell Honor Guard - Data Set - Set Emotestate 333'"),
(-122777,0,3,0,61,0,100,0,0,0,0,0,69,0,0,0,0,0,0,12,1,0,0,-5, 0, 0,0,"Sunwell Honor Guard - Data Set - Follow'"),
(-122777,0,4,0,38,0,100,0,4,4,0,0,17,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"Sunwell Honor Guard - Data Set - Set Emotestate 333'"),
(-122777,0,5,0,38,0,100,0,5,5,0,0,5,66,0,0,0,0,0,1,0,0,0,0,0,0,0,"Sunwell Honor Guard - Data Set - Play Emote One Shot Salute'"),
(-122777,0,6,0,38,0,100,0,6,6,0,0,24,0,0,0,0,0,0,1,0,0,0,0, 0, 0,0,"Sunwell Honor Guard - Data Set - Stop Follow'"),
(-122777,0,7,0,38,0,100,0,7,7,0,0,66,0,2,0,0,0,0,12,1,0,0,0, 0, 0,0,"Sunwell Honor Guard - Data Set - Face Player'"),
(-122953,0,2,3,38,0,100,0,3,3,0,0,17,333,0,0,0,0,0,1,0,0,0,0,0,0,0,"Sunwell Honor Guard - Data Set - Set Emotestate 333'"),
(-122953,0,3,0,61,0,100,0,0,0,0,0,69,0,0,0,0,0,0,12,1,0,0,0, -5, 0,0,"Sunwell Honor Guard - Data Set - Follow'"),
(-122953,0,4,0,38,0,100,0,4,4,0,0,17,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"Sunwell Honor Guard - Data Set - Set Emotestate 333'"),
(-122953,0,5,0,38,0,100,0,5,5,0,0,5,66,0,0,0,0,0,1,0,0,0,0,0,0,0,"Sunwell Honor Guard - Data Set - Play Emote One Shot Salute'"),
(-122953,0,6,0,38,0,100,0,6,6,0,0,24,0,0,0,0,0,0,12,1,0,0,-5, -5, 0,0,"Sunwell Honor Guard - Data Set - Stop Follow'"),
(-122953,0,7,0,38,0,100,0,7,7,0,0,66,0,2,0,0,0,0,12,1,0,0,0, 0, 0,0,"Sunwell Honor Guard - Data Set - Face Player'"),
(37765,0,0,0,38,0,100,0,1,1,0,0,53,0,37765,0,0,0,0,1,0,0,0,0,0,0,0,"Captain Auric Sunchaser - Data Set - Start WP'"),
(37765,0,1,0,38,0,100,0,8,8,0,0,80,3776500,0,0,0,0,0,1,0,0,0,0,0,0,0,"Captain Auric Sunchaser - Data Set - Run Script"),
(37765,0,2,0,38,0,100,0,8,4,0,0,53,0,3776500,0,0,0,0,1,0,0,0,0,0,0,0,"Lor'themar Theron - Data Set - Say Line 5'"),
(38056,0,0,0,38,0,100,1,1,1,0,0,1,0,0,0,0,0,0,12,1,0,0,0,0,0,0,"Chamberlain Galiros - Data Set - Say Line 0 (No Repeat'"),
(37745,0,0,1,38,0,100,0,2,2,0,0,64,1,0,0,0,0,0,23,0,0,0,0,0,0,0,"Quel'Delar - On Just Summoned - Store Target'"),
(37745,0,1,2,61,0,100,0,0,0,0,0,100,1,0,0,0,0,0,19,37763,0,0,0,0,0,0,"Quel'Delar - On Just Summoned - Send Target'"),
(37745,0,2,3,61,0,100,0,0,0,0,0,100,1,0,0,0,0,0,19,37764,0,0,0,0,0,0,"Quel'Delar - On Just Summoned - Send Target'"),
(37745,0,3,4,61,0,100,0,0,0,0,0,100,1,0,0,0,0,0,19,37765,0,0,0,0,0,0,"Quel'Delar - On Just Summoned - Send Target'"),
(37745,0,4,0,61,0,100,0,0,0,0,0,80,3774500,2,0,0,0,0,1,0,0,0,0,0,0,0,"Quel'Delar - On Just Summoned - Run Script'"),
(37745,0,5,6,38,0,100,0,1,1,0,0,64,1,0,0,0,0,0,23,0,0,0,0,0,0,0,"Quel'Delar - On Just Summoned - Store Target'"),
(37745,0,6,7,61,0,100,0,0,0,0,0,100,1,0,0,0,0,0,19,37763,0,0,0,0,0,0,"Quel'Delar - On Just Summoned - Send Target'"),
(37745,0,7,8,61,0,100,0,0,0,0,0,100,1,0,0,0,0,0,19,37764,0,0,0,0,0,0,"Quel'Delar - On Just Summoned - Send Target'"),
(37745,0,8,9,61,0,100,0,0,0,0,0,100,1,0,0,0,0,0,19,37765,0,0,0,0,0,0,"Quel'Delar - On Just Summoned - Send Target'"),
(37745,0,9,10,61,0,100,0,0,0,0,0,80,3774501,2,0,0,0,0,1,0,0,0,0,0,0,0,"Quel'Delar - On Just Summoned - Run Script'"),
(37745,0,10,0,61,0,100,0,0,0,0,0,100,1,0,0,0,0,0,9,37781,0,200,0,0,0,0,"Quel Delar On spawn - Send Target"), -- 23:17:10.900
(37746,0,1,0,38,0,100,0,2,2,0,0,11,70466,0,0,0,0,0,19,37745,0,0,0,0,0,0,"Sunwell Caster Bunny - On Data Set 2 2 - Cast Sunwell Light Ray'"),
(3774500,9,0,0,0,0,100,0,0,0,0,0,45,1,1,0,0,0,0,9,37746,0,200,0,0,0,0,"Quel'Delar - Script - Set Data 1 1 to Sunwell Caster Bunny"), -- 23:16:34.326
(3774500,9,1,0,0,0,100,0,2000,2000,0,0,45,2,2,0,0,0,0,9,37746,0,200,0,0,0,0,"Quel'Delar - Script - Set Data 2 2 to Sunwell Caster Bunny"), -- 23:16:36.338
(3774500,9,2,0,0,0,100,0,1000,1000,0,0,45,1,1,0,0,0,0,9,37746,0,200,0,0,0,0,"Quel'Delar - Script - Set Data 2 2 to Sunwell Caster Bunny"), -- 23:16:37.744
(3774500,9,3,0,0,0,100,0,1000,1000,0,0,45,2,2,0,0,0,0,9,37746,0,200,0,0,0,0,"Quel'Delar - Script - Set Data 2 2 to Sunwell Caster Bunny"), -- 23:16:38.304
(3774500,9,4,0,0,0,100,0,1000,1000,0,0,45,2,2,0,0,0,0,9,37746,0,200,0,0,0,0,"Quel'Delar - Script - Set Data 2 2 to Sunwell Caster Bunny"), -- 23:16:40.316 
(3774500,9,5,0,0,0,100,0,400,400,0,0,45,2,2,0,0,0,0,9,37746,0,200,0,0,0,0,"Quel'Delar - Script - Set Data 2 2 to Sunwell Caster Bunny"), -- 23:16:40.722 
(3774500,9,6,0,0,0,100,0,800,800,0,0,45,2,2,0,0,0,0,9,37746,0,200,0,0,0,0,"Quel'Delar - Script - Set Data 2 2 to Sunwell Caster Bunny"), -- 23:16:41.533 
(3774500,9,7,0,0,0,100,0,800,800,0,0,45,2,2,0,0,0,0,9,37746,0,200,0,0,0,0,"Quel'Delar - Script - Set Data 2 2 to Sunwell Caster Bunny"), -- 23:16:42.328 
(3774500,9,8,0,0,0,100,0,0,0,0,0,45,1,1,0,0,0,0,19,37763,0,0,0,0,0,0,"Quel'Delar - Script - Set Data 1 1 to Grand Magister Rommath"), -- 23:16:42.328 
(3774500,9,9,0,0,0,100,0,0,0,0,0,45,1,1,0,0,0,0,19,37764,0,0,0,0,0,0,"Quel'Delar - Script - Set Data 1 1 to Lor'themar Theron"), -- 23:16:42.328 
(3774500,9,10,0,0,0,100,0,0,0,0,0,45,1,1,0,0,0,0,19,37765,0,0,0,0,0,0,"Quel'Delar - Script - Set Data 1 1 to Captain Auric Sunchaser"), -- 23:16:42.328 
(3774500,9,11,0,0,0,100,0,400,400,0,0,45,2,2,0,0,0,0,9,37746,0,200,0,0,0,0,"Quel'Delar - Script - Set Data 2 2 to Sunwell Caster Bunny"), -- 23:16:42.734 
(3774500,9,12,0,0,0,100,0,800,800,0,0,45,2,2,0,0,0,0,9,37746,0,200,0,0,0,0,"Quel'Delar - Script - Set Data 2 2 to Sunwell Caster Bunny"), -- 23:16:43.514 
(3774500,9,13,0,0,0,100,0,800,800,0,0,45,2,2,0,0,0,0,9,37746,0,200,0,0,0,0,"Quel'Delar - Script - Set Data 2 2 to Sunwell Caster Bunny"), -- 23:16:44.325 
(3774500,9,14,0,0,0,100,0,400,400,0,0,45,2,2,0,0,0,0,9,37746,0,200,0,0,0,0,"Quel'Delar - Script - Set Data 2 2 to Sunwell Caster Bunny"), -- 23:16:44.731 
(3774500,9,15,0,0,0,100,0,800,800,0,0,45,2,2,0,0,0,0,9,37746,0,200,0,0,0,0,"Quel'Delar - Script - Set Data 2 2 to Sunwell Caster Bunny"), -- 23:16:45.526 
(3774500,9,16,0,0,0,100,0,800,800,0,0,45,2,2,0,0,0,0,9,37746,0,200,0,0,0,0,"Quel'Delar - Script - Set Data 2 2 to Sunwell Caster Bunny"), -- 23:16:46.338 
(3774500,9,17,0,0,0,100,0,400,400,0,0,45,2,2,0,0,0,0,9,37746,0,200,0,0,0,0,"Quel'Delar - Script - Set Data 2 2 to Sunwell Caster Bunny"), -- 23:16:46.743 
(3774500,9,18,0,0,0,100,0,800,800,0,0,45,2,2,0,0,0,0,9,37746,0,200,0,0,0,0,"Quel'Delar - Script - Set Data 2 2 to Sunwell Caster Bunny"), -- 23:16:47.523 
(3774500,9,19,0,0,0,100,0,800,800,0,0,45,2,2,0,0,0,0,9,37746,0,200,0,0,0,0,"Quel'Delar - Script - Set Data 2 2 to Sunwell Caster Bunny"), -- 23:16:48.334 
(3774500,9,20,0,0,0,100,0,400,400,0,0,45,2,2,0,0,0,0,9,37746,0,200,0,0,0,0,"Quel'Delar - Script - Set Data 2 2 to Sunwell Caster Bunny"), -- 23:16:48.740 
(3774500,9,21,0,0,0,100,0,400,400,0,0,1,0,0,0,0,0,0,19,37763,0,0,0,0,0,0,"Quel'Delar - Script - Say Line 0"), -- 23:16:49.177 
(3774500,9,22,0,0,0,100,0,400,400,0,0,45,2,2,0,0,0,0,9,37746,0,200,0,0,0,0,"Quel'Delar - Script - Set Data 2 2 to Sunwell Caster Bunny"), -- 23:16:49.536 
(3774500,9,23,0,0,0,100,0,800,800,0,0,45,2,2,0,0,0,0,9,37746,0,200,0,0,0,0,"Quel'Delar - Script - Set Data 2 2 to Sunwell Caster Bunny"), -- 23:16:50.331 
(3774500,9,24,0,0,0,100,0,400,400,0,0,45,2,2,0,0,0,0,9,37746,0,200,0,0,0,0,"Quel'Delar - Script - Set Data 2 2 to Sunwell Caster Bunny"), -- 23:16:50.721 
(3774500,9,25,0,0,0,100,0,800,800,0,0,45,2,2,0,0,0,0,9,37746,0,200,0,0,0,0,"Quel'Delar - Script - Set Data 2 2 to Sunwell Caster Bunny"), -- 23:16:51.548 
(3774500,9,26,0,0,0,100,0,800,800,0,0,45,2,2,0,0,0,0,9,37746,0,200,0,0,0,0,"Quel'Delar - Script - Set Data 2 2 to Sunwell Caster Bunny"), -- 23:16:52.344 
(3774500,9,27,0,0,0,100,0,400,400,0,0,45,2,2,0,0,0,0,9,37746,0,200,0,0,0,0,"Quel'Delar - Script - Set Data 2 2 to Sunwell Caster Bunny"), -- 23:16:52.749 
(3774500,9,28,0,0,0,100,0,500,500,0,0,45,2,2,0,0,0,0,19,37764,0,0,0,0,0,0,"Quel'Delar - Script - Say Line 0"), -- 23:16:53.264 
(3774500,9,29,0,0,0,100,0,300,300,0,0,45,2,2,0,0,0,0,9,37746,0,200,0,0,0,0,"Quel'Delar - Script - Set Data 2 2 to Sunwell Caster Bunny"), -- 23:16:53.545 
(3774500,9,30,0,0,0,100,0,800,800,0,0,45,2,2,0,0,0,0,9,37746,0,200,0,0,0,0,"Quel'Delar - Script - Set Data 2 2 to Sunwell Caster Bunny"), -- 23:16:54.325 
(3774500,9,31,0,0,0,100,0,1200,1200,0,0,45,2,2,0,0,0,0,9,37746,0,200,0,0,0,0,"Quel'Delar - Script - Set Data 2 2 to Sunwell Caster Bunny"), -- 23:16:55.526 
(3774500,9,32,0,0,0,100,0,400,400,0,0,45,2,2,0,0,0,0,9,37746,0,200,0,0,0,0,"Quel'Delar - Script - Set Data 2 2 to Sunwell Caster Bunny"), -- 23:16:54.731 
(3774500,9,33,0,0,0,100,0,800,800,0,0,45,2,2,0,0,0,0,9,37746,0,200,0,0,0,0,"Quel'Delar - Script - Set Data 2 2 to Sunwell Caster Bunny"), -- 23:16:56.322 
(3774500,9,34,0,0,0,100,0,1200,1200,0,0,45,2,2,0,0,0,0,9,37746,0,200,0,0,0,0,"Quel'Delar - Script - Set Data 2 2 to Sunwell Caster Bunny"), -- 23:16:57.523 
(3774500,9,35,0,0,0,100,0,800,800,0,0,45,2,2,0,0,0,0,9,37746,0,200,0,0,0,0,"Quel'Delar - Script - Set Data 2 2 to Sunwell Caster Bunny"), -- 23:16:58.319 
(3774500,9,36,0,0,0,100,0,400,400,0,0,45,2,2,0,0,0,0,9,37746,0,200,0,0,0,0,"Quel'Delar - Script - Set Data 2 2 to Sunwell Caster Bunny"), -- 23:16:58.740 
(3774500,9,37,0,0,0,100,0,0,0,0,0,45,3,3,0,0,0,0,19,37764,0,0,0,0,0,0,"Quel'Delar - Script - Virtual Item Slot 0 (0)"), -- 23:16:58.740 
(3774500,9,38,0,0,0,100,0,800,800,0,0,45,2,2,0,0,0,0,9,37746,0,200,0,0,0,0,"Quel'Delar - Script - Set Data 2 2 to Sunwell Caster Bunny"), -- 23:16:59.535 
(3774500,9,39,0,0,0,100,0,800,800,0,0,45,2,2,0,0,0,0,9,37746,0,200,0,0,0,0,"Quel'Delar - Script - Set Data 2 2 to Sunwell Caster Bunny"), -- 23:17:00.315 
(3774500,9,40,0,0,0,100,0,200,200,0,0,45,2,2,0,0,0,0,9,37746,0,200,0,0,0,0,"Quel'Delar - Script - Set Data 2 2 to Sunwell Caster Bunny"), -- 23:17:00.581  
(3774500,9,41,0,0,0,100,0,1000,1000,0,0,45,2,2,0,0,0,0,9,37746,0,200,0,0,0,0,"Quel'Delar - Script - Set Data 2 2 to Sunwell Caster Bunny"), -- 23:17:01.517  
(3774500,9,42,0,0,0,100,0,800,800,0,0,45,2,2,0,0,0,0,9,37746,0,200,0,0,0,0,"Quel'Delar - Script - Set Data 2 2 to Sunwell Caster Bunny"), -- 23:17:02.312  
(3774500,9,43,0,0,0,100,0,400,400,0,0,45,2,2,0,0,0,0,9,37746,0,200,0,0,0,0,"Quel'Delar - Script - Set Data 2 2 to Sunwell Caster Bunny"), -- 23:17:02.718  
(3774500,9,44,0,0,0,100,0,800,800,0,0,45,2,2,0,0,0,0,9,37746,0,200,0,0,0,0,"Quel'Delar - Script - Set Data 2 2 to Sunwell Caster Bunny"), -- 23:17:03.513  
(3774500,9,45,0,0,0,100,0,800,800,0,0,45,2,2,0,0,0,0,9,37746,0,200,0,0,0,0,"Quel'Delar - Script - Set Data 2 2 to Sunwell Caster Bunny"), -- 23:17:04.325   
(3774500,9,46,0,0,0,100,0,400,400,0,0,45,2,2,0,0,0,0,9,37746,0,200,0,0,0,0,"Quel'Delar - Script - Set Data 2 2 to Sunwell Caster Bunny"), -- 23:17:04.715  
(3774500,9,47,0,0,0,100,0,800,800,0,0,45,2,2,0,0,0,0,9,37746,0,200,0,0,0,0,"Quel'Delar - Script - Set Data 2 2 to Sunwell Caster Bunny"), -- 23:17:05.510  
(3774500,9,48,0,0,0,100,0,400,400,0,0,45,4,4,0,0,0,0,19,37764,0,0,0,0,0,0,"Quel'Delar - Script - Cast Spell 70493 (Self)"), -- 23:17:05.900 
(3774500,9,49,0,0,0,100,0,400,400,0,0,45,2,2,0,0,0,0,9,37746,0,200,0,0,0,0,"Quel'Delar - Script - Set Data 2 2 to Sunwell Caster Bunny"), -- 23:17:06.321  
(3774500,9,50,0,0,0,100,0,400,400,0,0,45,2,2,0,0,0,0,9,37746,0,200,0,0,0,0,"Quel'Delar - Script - Set Data 2 2 to Sunwell Caster Bunny"), -- 23:17:06.727   
(3774500,9,51,0,0,0,100,0,800,800,0,0,45,2,2,0,0,0,0,9,37746,0,200,0,0,0,0,"Quel'Delar - Script - Set Data 2 2 to Sunwell Caster Bunny"), -- 23:17:07.523   
(3774500,9,52,0,0,0,100,0,800,800,0,0,45,2,2,0,0,0,0,9,37746,0,200,0,0,0,0,"Quel'Delar - Script - Set Data 2 2 to Sunwell Caster Bunny"), -- 23:17:08.318   
(3774500,9,53,0,0,0,100,0,400,400,0,0,45,2,2,0,0,0,0,9,37746,0,200,0,0,0,0,"Quel'Delar - Script - Set Data 2 2 to Sunwell Caster Bunny"), -- 23:17:08.739  
(3774500,9,54,0,0,0,100,0,100,100,0,0,1,0,9,0,0,0,0,10,122983,37781,0,0,0,0,0,"Quel'Delar - Script - Say Line 0"), -- text 23:17:08.864  
(3774500,9,55,0,0,0,100,0,700,700,0,0,45,2,2,0,0,0,0,9,37746,0,200,0,0,0,0,"Quel'Delar - Script - Set Data 2 2 to Sunwell Caster Bunny"), -- 23:17:09.535  
(3774500,9,56,0,0,0,100,0,800,800,0,0,45,2,2,0,0,0,0,9,37746,0,200,0,0,0,0,"Quel'Delar - Script - Set Data 2 2 to Sunwell Caster Bunny"), -- 23:17:10.315  
(3774500,9,57,0,0,0,100,0,400,400,0,0,45,2,2,0,0,0,0,9,37746,0,200,0,0,0,0,"Quel'Delar - Script - Set Data 2 2 to Sunwell Caster Bunny"), -- 23:17:10.721  
(3774500,9,58,0,0,0,100,0,800,800,0,0,45,2,2,0,0,0,0,9,37746,0,200,0,0,0,0,"Quel'Delar - Script - Set Data 2 2 to Sunwell Caster Bunny"), -- 23:17:11.516  
(3774500,9,59,0,0,0,100,0,500,500,0,0,45,2,2,0,0,0,0,19,37763,0,0,0,0,0,0,"Quel'Delar - Script - Cast 70540 at player"), -- 23:17:12.078 
(3774500,9,60,0,0,0,100,0,15,15,0,0,1,1,0,0,0,0,0,19,37763,0,0,0,0,0,0,"Quel'Delar - Script - Say Line 1"), -- 23:17:12.093 
(3774500,9,61,0,0,0,100,0,385,385,0,0,45,2,2,0,0,0,0,9,37746,0,200,0,0,0,0,"Quel'Delar - Script - Set Data 2 2 to Sunwell Caster Bunny"), -- 23:17:12.312  
(3774500,9,62,0,0,0,100,0,400,400,0,0,45,2,2,0,0,0,0,9,37746,0,200,0,0,0,0,"Quel'Delar - Script - Set Data 2 2 to Sunwell Caster Bunny"), -- 23:17:12.733  
(3774500,9,63,0,0,0,100,0,800,800,0,0,45,2,2,0,0,0,0,9,37746,0,200,0,0,0,0,"Quel'Delar - Script - Set Data 2 2 to Sunwell Caster Bunny"), -- 23:17:13.544  
(3774500,9,64,0,0,0,100,0,600,600,0,0,45,2,2,0,0,0,0,9,37746,0,200,0,0,0,0,"Quel'Delar - Script - Set Data 2 2 to Sunwell Caster Bunny"), -- 23:17:14.121  
(3774500,9,65,0,0,0,100,0,600,600,0,0,45,2,2,0,0,0,0,9,37746,0,200,0,0,0,0,"Quel'Delar - Script - Set Data 2 2 to Sunwell Caster Bunny"), -- 23:17:14.761
(3774500,9,66,0,0,0,100,0,800,800,0,0,45,2,2,0,0,0,0,9,37746,0,200,0,0,0,0,"Quel'Delar - Script - Set Data 2 2 to Sunwell Caster Bunny"), -- 23:17:15.338  
(3774500,9,67,0,0,0,100,0,800,800,0,0,1,1,0,0,0,0,0,19,37781,0,0,0,0,0,0,"Quel'Delar - Script - Say Line 1"), -- 23:17:16.103  
(3774500,9,68,0,0,0,100,0,0,0,0,0,45,2,2,0,0,0,0,9,37746,0,200,0,0,0,0,"Quel'Delar - Script - Set Data 2 2 to Sunwell Caster Bunny"), -- 23:17:16.118  
(3774500,9,69,0,0,0,100,0,400,400,0,0,45,2,2,0,0,0,0,9,37746,0,200,0,0,0,0,"Quel'Delar - Script - Set Data 2 2 to Sunwell Caster Bunny"), -- 23:17:16.539  
(3774500,9,70,0,0,0,100,0,800,800,0,0,45,2,2,0,0,0,0,9,37746,0,200,0,0,0,0,"Quel'Delar - Script - Set Data 2 2 to Sunwell Caster Bunny"), -- 23:17:17.335  
(3774500,9,71,0,0,0,100,0,800,800,0,0,45,2,2,0,0,0,0,9,37746,0,200,0,0,0,0,"Quel'Delar - Script - Set Data 2 2 to Sunwell Caster Bunny"), -- 23:17:18.146  
(3774500,9,72,0,0,0,100,0,400,400,0,0,1,0,0,0,0,0,0,19,37765,0,0,0,0,0,0,"Quel'Delar - Script - Say Line 0"), -- 23:17:18.536  
(3774500,9,73,0,0,0,100,0,0,0,0,0,45,2,2,0,0,0,0,9,37746,0,200,0,0,0,0,"Quel'Delar - Script - Set Data 2 2 to Sunwell Caster Bunny"), -- 23:17:18.536  
(3774500,9,74,0,0,0,100,0,1000,1000,0,0,45,2,2,0,0,0,0,9,37746,0,200,0,0,0,0,"Quel'Delar - Script - Set Data 2 2 to Sunwell Caster Bunny"), -- 23:17:19.535  
(3774500,9,75,0,0,0,100,0,600,600,0,0,45,2,2,0,0,0,0,9,37746,0,200,0,0,0,0,"Quel'Delar - Script - Set Data 2 2 to Sunwell Caster Bunny"), -- 23:17:20.127
(3774500,9,76,0,0,0,100,0,600,600,0,0,45,2,2,0,0,0,0,9,37746,0,200,0,0,0,0,"Quel'Delar - Script - Set Data 2 2 to Sunwell Caster Bunny"), -- 23:17:20.736
(3774500,9,77,0,0,0,100,0,600,600,0,0,45,2,2,0,0,0,0,9,37746,0,200,0,0,0,0,"Quel'Delar - Script - Set Data 2 2 to Sunwell Caster Bunny"), -- 23:17:21.344
(3774500,9,78,0,0,0,100,0,800,800,0,0,45,2,2,0,0,0,0,9,37746,0,200,0,0,0,0,"Quel'Delar - Script - Set Data 2 2 to Sunwell Caster Bunny"), -- 23:17:22.124  
(3774500,9,79,0,0,0,100,0,600,600,0,0,45,2,2,0,0,0,0,9,37746,0,200,0,0,0,0,"Quel'Delar - Script - Set Data 2 2 to Sunwell Caster Bunny"), -- 23:17:22.717
(3774500,9,80,0,0,0,100,0,600,600,0,0,45,2,2,0,0,0,0,9,37746,0,200,0,0,0,0,"Quel'Delar - Script - Set Data 2 2 to Sunwell Caster Bunny"), -- 23:17:23.341
(3774500,9,81,0,0,0,100,0,1000,1000,0,0,45,2,2,0,0,0,0,9,37746,0,200,0,0,0,0,"Quel'Delar - Script - Set Data 2 2 to Sunwell Caster Bunny"), -- 23:17:24.308  
(3774500,9,82,0,0,0,100,0,200,200,0,0,45,2,2,0,0,0,0,9,37746,0,200,0,0,0,0,"Quel'Delar - Script - Set Data 2 2 to Sunwell Caster Bunny"), -- 23:17:24.542  
(3774500,9,83,0,0,0,100,0,0,0,0,0,1,1,0,0,0,0,0,19,37765,0,0,0,0,0,0,"Quel'Delar - Script - Say Line 1"), -- 23:17:24.542  
(3774500,9,84,0,0,0,100,0,1000,1000,0,0,45,2,2,0,0,0,0,9,37746,0,200,0,0,0,0,"Quel'Delar - Script - Set Data 2 2 to Sunwell Caster Bunny"), -- 23:17:25.525  
(3774500,9,85,0,0,0,100,0,600,600,0,0,45,2,2,0,0,0,0,9,37746,0,200,0,0,0,0,"Quel'Delar - Script - Set Data 2 2 to Sunwell Caster Bunny"), -- 23:17:26.149
(3774500,9,86,0,0,0,100,0,600,600,0,0,45,2,2,0,0,0,0,9,37746,0,200,0,0,0,0,"Quel'Delar - Script - Set Data 2 2 to Sunwell Caster Bunny"), -- 23:17:26.742
(3774500,9,87,0,0,0,100,0,600,600,0,0,45,2,2,0,0,0,0,9,37746,0,200,0,0,0,0,"Quel'Delar - Script - Set Data 2 2 to Sunwell Caster Bunny"), -- 23:17:27.366
(3774500,9,88,0,0,0,100,0,800,800,0,0,45,2,2,0,0,0,0,9,37746,0,200,0,0,0,0,"Quel'Delar - Script - Set Data 2 2 to Sunwell Caster Bunny"), -- 23:17:28.162  
(3774500,9,89,0,0,0,100,0,400,400,0,0,45,2,2,0,0,0,0,9,37746,0,200,0,0,0,0,"Quel'Delar - Script - Set Data 2 2 to Sunwell Caster Bunny"), -- 23:17:28.567  
(3774500,9,90,0,0,0,100,0,1000,1000,0,0,45,2,2,0,0,0,0,9,37746,0,200,0,0,0,0,"Quel'Delar - Script - Set Data 2 2 to Sunwell Caster Bunny"), -- 23:17:29.503  
(3774500,9,91,0,0,0,100,0,800,800,0,0,45,2,2,0,0,0,0,9,37746,0,200,0,0,0,0,"Quel'Delar - Script - Set Data 2 2 to Sunwell Caster Bunny"), -- 23:17:30.330  
(3774500,9,92,0,0,0,100,0,200,200,0,0,45,2,2,0,0,0,0,9,37746,0,200,0,0,0,0,"Quel'Delar - Script - Set Data 2 2 to Sunwell Caster Bunny"), -- 23:17:30.580  
(3774500,9,93,0,0,0,100,0,800,800,0,0,45,2,2,0,0,0,0,9,37746,0,200,0,0,0,0,"Quel'Delar - Script - Set Data 2 2 to Sunwell Caster Bunny"), -- 23:17:31.391  
(3774500,9,94,0,0,0,100,0,800,800,0,0,45,2,2,0,0,0,0,9,37746,0,200,0,0,0,0,"Quel'Delar - Script - Set Data 2 2 to Sunwell Caster Bunny"), -- 23:17:32.124  
(3774500,9,95,0,0,0,100,0,600,600,0,0,45,2,2,0,0,0,0,9,37746,0,200,0,0,0,0,"Quel'Delar - Script - Set Data 2 2 to Sunwell Caster Bunny"), -- 23:17:32.732
(3774500,9,96,0,0,0,100,0,600,600,0,0,45,2,2,0,0,0,0,9,37746,0,200,0,0,0,0,"Quel'Delar - Script - Set Data 2 2 to Sunwell Caster Bunny"), -- 23:17:33.388
(3774500,9,97,0,0,0,100,0,800,800,0,0,45,2,2,0,0,0,0,9,37746,0,200,0,0,0,0,"Quel'Delar - Script - Set Data 2 2 to Sunwell Caster Bunny"), -- 23:17:34.183  
(3774500,9,98,0,0,0,100,0,400,400,0,0,45,2,2,0,0,0,0,9,37746,0,200,0,0,0,0,"Quel'Delar - Script - Set Data 2 2 to Sunwell Caster Bunny"), -- 23:17:34.589  
(3774500,9,99,0,0,0,100,0,500,500,0,0,1,2,0,0,0,0,0,19,37763,0,0,0,0,0,0,"Quel'Delar - Script - Say Line 2"), -- 23:17:35.041 
(3774500,9,100,0,0,0,100,0,500,500,0,0,1,3,0,0,0,0,0,19,37763,0,0,0,0,0,0,"Quel'Delar - Script - Say Line 3"), -- 23:17:35.041 
(3774500,9,101,0,0,0,100,0,400,400,0,0,45,2,2,0,0,0,0,9,37746,0,200,0,0,0,0,"Quel'Delar - Script - Set Data 2 2 to Sunwell Caster Bunny"), -- 23:17:35.416  
(3774500,9,102,0,0,0,100,0,900,900,0,0,45,2,2,0,0,0,0,9,37746,0,200,0,0,0,0,"Quel'Delar - Script - Set Data 2 2 to Sunwell Caster Bunny"), -- 23:17:36.336  
(3774500,9,103,0,0,0,100,0,300,300,0,0,45,2,2,0,0,0,0,9,37746,0,200,0,0,0,0,"Quel'Delar - Script - Set Data 2 2 to Sunwell Caster Bunny"), -- 23:17:36.648  
(3774500,9,104,0,0,0,100,0,900,900,0,0,45,2,2,0,0,0,0,9,37746,0,200,0,0,0,0,"Quel'Delar - Script - Set Data 2 2 to Sunwell Caster Bunny"), -- 23:17:37.537   
(3774500,9,105,0,0,0,100,0,700,700,0,0,45,2,2,0,0,0,0,9,37746,0,200,0,0,0,0,"Quel'Delar - Script - Set Data 2 2 to Sunwell Caster Bunny"), -- 23:17:38.255   
(3774500,9,106,0,0,0,100,0,400,400,0,0,45,2,2,0,0,0,0,9,37746,0,200,0,0,0,0,"Quel'Delar - Script - Set Data 2 2 to Sunwell Caster Bunny"), -- 23:17:38.629  
(3774500,9,107,0,0,0,100,0,800,800,0,0,45,2,2,0,0,0,0,9,37746,0,200,0,0,0,0,"Quel'Delar - Script - Set Data 2 2 to Sunwell Caster Bunny"), -- 23:17:39.440  
(3774500,9,108,0,0,0,100,0,800,800,0,0,45,2,2,0,0,0,0,9,37746,0,200,0,0,0,0,"Quel'Delar - Script - Set Data 2 2 to Sunwell Caster Bunny"), -- 23:17:40.236  
(3774500,9,109,0,0,0,100,0,400,400,0,0,45,2,2,0,0,0,0,9,37746,0,200,0,0,0,0,"Quel'Delar - Script - Set Data 2 2 to Sunwell Caster Bunny"), -- 23:17:40.626  
(3774500,9,110,0,0,0,100,0,800,800,0,0,45,2,2,0,0,0,0,9,37746,0,200,0,0,0,0,"Quel'Delar - Script - Set Data 2 2 to Sunwell Caster Bunny"), -- 23:17:41.437  
(3774500,9,111,0,0,0,100,0,800,800,0,0,45,2,2,0,0,0,0,9,37746,0,200,0,0,0,0,"Quel'Delar - Script - Set Data 2 2 to Sunwell Caster Bunny"), -- 23:17:42.248  
(3774500,9,112,0,0,0,100,0,500,500,0,0,45,2,2,0,0,0,0,9,37746,0,200,0,0,0,0,"Quel'Delar - Script - Set Data 2 2 to Sunwell Caster Bunny"), -- 23:17:42.732  
(3774500,9,113,0,0,0,100,0,900,900,0,0,45,2,2,0,0,0,0,9,37746,0,200,0,0,0,0,"Quel'Delar - Script - Set Data 2 2 to Sunwell Caster Bunny"), -- 23:17:43.403  
(3774500,9,114,0,0,0,100,0,800,800,0,0,45,2,2,0,0,0,0,9,37746,0,200,0,0,0,0,"Quel'Delar - Script - Set Data 2 2 to Sunwell Caster Bunny"), -- 23:17:44.245  
(3774500,9,115,0,0,0,100,0,500,500,0,0,45,2,2,0,0,0,0,9,37746,0,200,0,0,0,0,"Quel'Delar - Script - Set Data 2 2 to Sunwell Caster Bunny"), -- 23:17:44.729  
(3774500,9,116,0,0,0,100,0,900,900,0,0,45,2,2,0,0,0,0,9,37746,0,200,0,0,0,0,"Quel'Delar - Script - Set Data 2 2 to Sunwell Caster Bunny"), -- 23:17:45.462  
(3774500,9,117,0,0,0,100,0,400,400,0,0,45,3,3,0,0,0,0,19,37763,0,0,0,0,0,0,"Quel'Delar - Script - Say Line 4"), -- 23:17:45.883 
(3774500,9,118,0,0,0,100,0,400,400,0,0,45,2,2,0,0,0,0,9,37746,0,200,0,0,0,0,"Quel'Delar - Script - Set Data 2 2 to Sunwell Caster Bunny"), -- 23:17:46.258  
(3774500,9,119,0,0,0,100,0,400,400,0,0,45,2,2,0,0,0,0,9,37746,0,200,0,0,0,0,"Quel'Delar - Script - Set Data 2 2 to Sunwell Caster Bunny"), -- 23:17:46.663  
(3774500,9,120,0,0,0,100,0,800,800,0,0,45,2,2,0,0,0,0,9,37746,0,200,0,0,0,0,"Quel'Delar - Script - Set Data 2 2 to Sunwell Caster Bunny"), -- 23:17:47.459  
(3774500,9,121,0,0,0,100,0,800,800,0,0,45,2,2,0,0,0,0,9,37746,0,200,0,0,0,0,"Quel'Delar - Script - Set Data 2 2 to Sunwell Caster Bunny"), -- 23:17:48.270  
(3774500,9,122,0,0,0,100,0,400,400,0,0,45,2,2,0,0,0,0,9,37746,0,200,0,0,0,0,"Quel'Delar - Script - Set Data 2 2 to Sunwell Caster Bunny"), -- 23:17:48.676  
(3774500,9,123,0,0,0,100,0,800,800,0,0,45,2,2,0,0,0,0,9,37746,0,200,0,0,0,0,"Quel'Delar - Script - Set Data 2 2 to Sunwell Caster Bunny"), -- 23:17:49.487  
(3774500,9,124,0,0,0,100,0,800,800,0,0,45,2,2,0,0,0,0,9,37746,0,200,0,0,0,0,"Quel'Delar - Script - Set Data 2 2 to Sunwell Caster Bunny"), -- 23:17:50.282  
(3774500,9,125,0,0,0,100,0,500,500,0,0,45,2,2,0,0,0,0,9,37746,0,200,0,0,0,0,"Quel'Delar - Script - Set Data 2 2 to Sunwell Caster Bunny"), -- 23:17:50.735  
(3774500,9,126,0,0,0,100,0,900,900,0,0,50,201794,900,0,0,0,0,1,0,0,0,0,0,0,0.0,"Quel'Delar - Script - Spawn GO"), -- 23:17:51.484  
(3774500,9,127,0,0,0,100,0,0,0,0,0,45,2,2,0,0,0,0,9,37746,0,200,0,0,0,0,"Quel'Delar - Script - Set Data 2 2 to Sunwell Caster Bunny"), -- 23:17:51.484  
(3774500,9,128,0,0,0,100,0,400,400,0,0,45,8,8,0,0,0,0,19,37763,0,0,0,0,0,0,"Quel'Delar - Script - Set Data 8 8"),  
(3774500,9,129,0,0,0,100,0,400,400,0,0,45,8,8,0,0,0,0,19,37764,0,0,0,0,0,0,"Quel'Delar - Script - Set Data 8 8"),  
(3774500,9,130,0,0,0,100,0,400,400,0,0,45,8,8,0,0,0,0,19,37765,0,0,0,0,0,0,"Quel'Delar - Script - Set Data 8 8"),  
(3774500,9,131,0,0,0,100,0,800,800,0,0,44,8,0,0,0,0,0,1,0,0,0,0,0,0,0,"Quel'Delar - Script - Despawn"), -- 23:17:52.279  
(3774501,9,0,0,0,0,100,0,0,0,0,0,45,1,1,0,0,0,0,9,37746,0,200,0,0,0,0,"Quel'Delar - Script - Set Data 1 1 to Sunwell Caster Bunny"), -- 23:16:34.326
(3774501,9,1,0,0,0,100,0,2000,2000,0,0,45,2,2,0,0,0,0,9,37746,0,200,0,0,0,0,"Quel'Delar - Script - Set Data 2 2 to Sunwell Caster Bunny"), -- 23:16:36.338
(3774501,9,2,0,0,0,100,0,1000,1000,0,0,45,1,1,0,0,0,0,9,37746,0,200,0,0,0,0,"Quel'Delar - Script - Set Data 2 2 to Sunwell Caster Bunny"), -- 23:16:37.744
(3774501,9,3,0,0,0,100,0,1000,1000,0,0,45,2,2,0,0,0,0,9,37746,0,200,0,0,0,0,"Quel'Delar - Script - Set Data 2 2 to Sunwell Caster Bunny"), -- 23:16:38.304
(3774501,9,4,0,0,0,100,0,1000,1000,0,0,45,2,2,0,0,0,0,9,37746,0,200,0,0,0,0,"Quel'Delar - Script - Set Data 2 2 to Sunwell Caster Bunny"), -- 23:16:40.316 
(3774501,9,5,0,0,0,100,0,400,400,0,0,45,2,2,0,0,0,0,9,37746,0,200,0,0,0,0,"Quel'Delar - Script - Set Data 2 2 to Sunwell Caster Bunny"), -- 23:16:40.722 
(3774501,9,6,0,0,0,100,0,800,800,0,0,45,2,2,0,0,0,0,9,37746,0,200,0,0,0,0,"Quel'Delar - Script - Set Data 2 2 to Sunwell Caster Bunny"), -- 23:16:41.533 
(3774501,9,7,0,0,0,100,0,800,800,0,0,45,2,2,0,0,0,0,9,37746,0,200,0,0,0,0,"Quel'Delar - Script - Set Data 2 2 to Sunwell Caster Bunny"), -- 23:16:42.328 
(3774501,9,8,0,0,0,100,0,0,0,0,0,45,1,1,0,0,0,0,19,37763,0,0,0,0,0,0,"Quel'Delar - Script - Set Data 1 1 to Grand Magister Rommath"), -- 23:16:42.328 
(3774501,9,9,0,0,0,100,0,0,0,0,0,45,1,1,0,0,0,0,19,37764,0,0,0,0,0,0,"Quel'Delar - Script - Set Data 1 1 to Lor'themar Theron"), -- 23:16:42.328 
(3774501,9,10,0,0,0,100,0,0,0,0,0,45,1,1,0,0,0,0,19,37765,0,0,0,0,0,0,"Quel'Delar - Script - Set Data 1 1 to Captain Auric Sunchaser"), -- 23:16:42.328 
(3774501,9,11,0,0,0,100,0,400,400,0,0,45,2,2,0,0,0,0,9,37746,0,200,0,0,0,0,"Quel'Delar - Script - Set Data 2 2 to Sunwell Caster Bunny"), -- 23:16:42.734 
(3774501,9,12,0,0,0,100,0,800,800,0,0,45,2,2,0,0,0,0,9,37746,0,200,0,0,0,0,"Quel'Delar - Script - Set Data 2 2 to Sunwell Caster Bunny"), -- 23:16:43.514 
(3774501,9,13,0,0,0,100,0,800,800,0,0,45,2,2,0,0,0,0,9,37746,0,200,0,0,0,0,"Quel'Delar - Script - Set Data 2 2 to Sunwell Caster Bunny"), -- 23:16:44.325 
(3774501,9,14,0,0,0,100,0,400,400,0,0,45,2,2,0,0,0,0,9,37746,0,200,0,0,0,0,"Quel'Delar - Script - Set Data 2 2 to Sunwell Caster Bunny"), -- 23:16:44.731 
(3774501,9,15,0,0,0,100,0,800,800,0,0,45,2,2,0,0,0,0,9,37746,0,200,0,0,0,0,"Quel'Delar - Script - Set Data 2 2 to Sunwell Caster Bunny"), -- 23:16:45.526 
(3774501,9,16,0,0,0,100,0,800,800,0,0,45,2,2,0,0,0,0,9,37746,0,200,0,0,0,0,"Quel'Delar - Script - Set Data 2 2 to Sunwell Caster Bunny"), -- 23:16:46.338 
(3774501,9,17,0,0,0,100,0,400,400,0,0,45,2,2,0,0,0,0,9,37746,0,200,0,0,0,0,"Quel'Delar - Script - Set Data 2 2 to Sunwell Caster Bunny"), -- 23:16:46.743 
(3774501,9,18,0,0,0,100,0,800,800,0,0,45,2,2,0,0,0,0,9,37746,0,200,0,0,0,0,"Quel'Delar - Script - Set Data 2 2 to Sunwell Caster Bunny"), -- 23:16:47.523 
(3774501,9,19,0,0,0,100,0,800,800,0,0,45,2,2,0,0,0,0,9,37746,0,200,0,0,0,0,"Quel'Delar - Script - Set Data 2 2 to Sunwell Caster Bunny"), -- 23:16:48.334 
(3774501,9,20,0,0,0,100,0,400,400,0,0,45,2,2,0,0,0,0,9,37746,0,200,0,0,0,0,"Quel'Delar - Script - Set Data 2 2 to Sunwell Caster Bunny"), -- 23:16:48.740 
(3774501,9,21,0,0,0,100,0,400,400,0,0,1,2,0,0,0,0,0,19,37781,0,0,0,0,0,0,"Quel'Delar - Script - Say Line 2"), -- 23:16:49.177 
(3774501,9,22,0,0,0,100,0,400,400,0,0,45,2,2,0,0,0,0,9,37746,0,200,0,0,0,0,"Quel'Delar - Script - Set Data 2 2 to Sunwell Caster Bunny"), -- 23:16:49.536 
(3774501,9,23,0,0,0,100,0,800,800,0,0,45,2,2,0,0,0,0,9,37746,0,200,0,0,0,0,"Quel'Delar - Script - Set Data 2 2 to Sunwell Caster Bunny"), -- 23:16:50.331 
(3774501,9,24,0,0,0,100,0,400,400,0,0,45,2,2,0,0,0,0,9,37746,0,200,0,0,0,0,"Quel'Delar - Script - Set Data 2 2 to Sunwell Caster Bunny"), -- 23:16:50.721 
(3774501,9,25,0,0,0,100,0,800,800,0,0,45,2,2,0,0,0,0,9,37746,0,200,0,0,0,0,"Quel'Delar - Script - Set Data 2 2 to Sunwell Caster Bunny"), -- 23:16:51.548 
(3774501,9,26,0,0,0,100,0,800,800,0,0,45,2,2,0,0,0,0,9,37746,0,200,0,0,0,0,"Quel'Delar - Script - Set Data 2 2 to Sunwell Caster Bunny"), -- 23:16:52.344 
(3774501,9,27,0,0,0,100,0,400,400,0,0,45,2,2,0,0,0,0,9,37746,0,200,0,0,0,0,"Quel'Delar - Script - Set Data 2 2 to Sunwell Caster Bunny"), -- 23:16:52.749 
(3774501,9,28,0,0,0,100,0,500,500,0,0,1,0,0,0,0,0,0,19,37764,0,0,0,0,0,0,"Quel'Delar - Script - Say Line 0"), -- 23:16:53.264 
(3774501,9,29,0,0,0,100,0,300,300,0,0,45,2,2,0,0,0,0,9,37746,0,200,0,0,0,0,"Quel'Delar - Script - Set Data 2 2 to Sunwell Caster Bunny"), -- 23:16:53.545 
(3774501,9,30,0,0,0,100,0,800,800,0,0,45,2,2,0,0,0,0,9,37746,0,200,0,0,0,0,"Quel'Delar - Script - Set Data 2 2 to Sunwell Caster Bunny"), -- 23:16:54.325 
(3774501,9,31,0,0,0,100,0,1200,1200,0,0,45,2,2,0,0,0,0,9,37746,0,200,0,0,0,0,"Quel'Delar - Script - Set Data 2 2 to Sunwell Caster Bunny"), -- 23:16:55.526 
(3774501,9,32,0,0,0,100,0,400,400,0,0,45,2,2,0,0,0,0,9,37746,0,200,0,0,0,0,"Quel'Delar - Script - Set Data 2 2 to Sunwell Caster Bunny"), -- 23:16:54.731 
(3774501,9,33,0,0,0,100,0,800,800,0,0,45,2,2,0,0,0,0,9,37746,0,200,0,0,0,0,"Quel'Delar - Script - Set Data 2 2 to Sunwell Caster Bunny"), -- 23:16:56.322 
(3774501,9,34,0,0,0,100,0,1200,1200,0,0,45,2,2,0,0,0,0,9,37746,0,200,0,0,0,0,"Quel'Delar - Script - Set Data 2 2 to Sunwell Caster Bunny"), -- 23:16:57.523 
(3774501,9,35,0,0,0,100,0,800,800,0,0,45,2,2,0,0,0,0,9,37746,0,200,0,0,0,0,"Quel'Delar - Script - Set Data 2 2 to Sunwell Caster Bunny"), -- 23:16:58.319 
(3774501,9,36,0,0,0,100,0,400,400,0,0,45,2,2,0,0,0,0,9,37746,0,200,0,0,0,0,"Quel'Delar - Script - Set Data 2 2 to Sunwell Caster Bunny"), -- 23:16:58.740 
(3774501,9,37,0,0,0,100,0,800,800,0,0,45,2,2,0,0,0,0,9,37746,0,200,0,0,0,0,"Quel'Delar - Script - Set Data 2 2 to Sunwell Caster Bunny"), -- 23:16:59.535 
(3774501,9,38,0,0,0,100,0,800,800,0,0,45,2,2,0,0,0,0,9,37746,0,200,0,0,0,0,"Quel'Delar - Script - Set Data 2 2 to Sunwell Caster Bunny"), -- 23:17:00.315 
(3774501,9,39,0,0,0,100,0,200,200,0,0,45,2,2,0,0,0,0,9,37746,0,200,0,0,0,0,"Quel'Delar - Script - Set Data 2 2 to Sunwell Caster Bunny"), -- 23:17:00.581  
(3774501,9,40,0,0,0,100,0,1000,1000,0,0,45,2,2,0,0,0,0,9,37746,0,200,0,0,0,0,"Quel'Delar - Script - Set Data 2 2 to Sunwell Caster Bunny"), -- 23:17:01.517  
(3774501,9,41,0,0,0,100,0,800,800,0,0,45,2,2,0,0,0,0,9,37746,0,200,0,0,0,0,"Quel'Delar - Script - Set Data 2 2 to Sunwell Caster Bunny"), -- 23:17:02.312  
(3774501,9,42,0,0,0,100,0,400,400,0,0,45,2,2,0,0,0,0,9,37746,0,200,0,0,0,0,"Quel'Delar - Script - Set Data 2 2 to Sunwell Caster Bunny"), -- 23:17:02.718  
(3774501,9,43,0,0,0,100,0,800,800,0,0,45,2,2,0,0,0,0,9,37746,0,200,0,0,0,0,"Quel'Delar - Script - Set Data 2 2 to Sunwell Caster Bunny"), -- 23:17:03.513  
(3774501,9,44,0,0,0,100,0,800,800,0,0,45,2,2,0,0,0,0,9,37746,0,200,0,0,0,0,"Quel'Delar - Script - Set Data 2 2 to Sunwell Caster Bunny"), -- 23:17:04.325   
(3774501,9,45,0,0,0,100,0,400,400,0,0,45,2,2,0,0,0,0,9,37746,0,200,0,0,0,0,"Quel'Delar - Script - Set Data 2 2 to Sunwell Caster Bunny"), -- 23:17:04.715  
(3774501,9,46,0,0,0,100,0,800,800,0,0,45,2,2,0,0,0,0,9,37746,0,200,0,0,0,0,"Quel'Delar - Script - Set Data 2 2 to Sunwell Caster Bunny"), -- 23:17:05.510  
(3774501,9,47,0,0,0,100,0,400,400,0,0,1,0,0,0,0,0,0,19,37763,0,0,0,0,0,0,"Quel'Delar - Script - Say Line 0"), -- 23:17:05.900 
(3774501,9,48,0,0,0,100,0,400,400,0,0,45,2,2,0,0,0,0,9,37746,0,200,0,0,0,0,"Quel'Delar - Script - Set Data 2 2 to Sunwell Caster Bunny"), -- 23:17:06.321  
(3774501,9,49,0,0,0,100,0,400,400,0,0,45,2,2,0,0,0,0,9,37746,0,200,0,0,0,0,"Quel'Delar - Script - Set Data 2 2 to Sunwell Caster Bunny"), -- 23:17:06.727   
(3774501,9,50,0,0,0,100,0,800,800,0,0,45,2,2,0,0,0,0,9,37746,0,200,0,0,0,0,"Quel'Delar - Script - Set Data 2 2 to Sunwell Caster Bunny"), -- 23:17:07.523   
(3774501,9,51,0,0,0,100,0,800,800,0,0,45,2,2,0,0,0,0,9,37746,0,200,0,0,0,0,"Quel'Delar - Script - Set Data 2 2 to Sunwell Caster Bunny"), -- 23:17:08.318   
(3774501,9,52,0,0,0,100,0,400,400,0,0,45,2,2,0,0,0,0,9,37746,0,200,0,0,0,0,"Quel'Delar - Script - Set Data 2 2 to Sunwell Caster Bunny"), -- 23:17:08.739  
(3774501,9,53,0,0,0,100,0,800,800,0,0,45,2,2,0,0,0,0,9,37746,0,200,0,0,0,0,"Quel'Delar - Script - Set Data 2 2 to Sunwell Caster Bunny"), -- 23:17:09.535  
(3774501,9,54,0,0,0,100,0,800,800,0,0,45,2,2,0,0,0,0,9,37746,0,200,0,0,0,0,"Quel'Delar - Script - Set Data 2 2 to Sunwell Caster Bunny"), -- 23:17:10.315  
(3774501,9,55,0,0,0,100,0,400,400,0,0,45,2,2,0,0,0,0,9,37746,0,200,0,0,0,0,"Quel'Delar - Script - Set Data 2 2 to Sunwell Caster Bunny"), -- 23:17:10.721  
(3774501,9,56,0,0,0,100,0,800,800,0,0,45,2,2,0,0,0,0,9,37746,0,200,0,0,0,0,"Quel'Delar - Script - Set Data 2 2 to Sunwell Caster Bunny"), -- 23:17:11.516  
(3774501,9,57,0,0,0,100,0,515,515,0,0,1,2,0,0,0,0,0,19,37764,0,0,0,0,0,0,"Quel'Delar - Script - Say Line 2"), -- 23:17:12.093 
(3774501,9,58,0,0,0,100,0,385,385,0,0,45,2,2,0,0,0,0,9,37746,0,200,0,0,0,0,"Quel'Delar - Script - Set Data 2 2 to Sunwell Caster Bunny"), -- 23:17:12.312  
(3774501,9,59,0,0,0,100,0,400,400,0,0,45,2,2,0,0,0,0,9,37746,0,200,0,0,0,0,"Quel'Delar - Script - Set Data 2 2 to Sunwell Caster Bunny"), -- 23:17:12.733  
(3774501,9,60,0,0,0,100,0,800,800,0,0,45,2,2,0,0,0,0,9,37746,0,200,0,0,0,0,"Quel'Delar - Script - Set Data 2 2 to Sunwell Caster Bunny"), -- 23:17:13.544  
(3774501,9,61,0,0,0,100,0,600,600,0,0,45,2,2,0,0,0,0,9,37746,0,200,0,0,0,0,"Quel'Delar - Script - Set Data 2 2 to Sunwell Caster Bunny"), -- 23:17:14.121  
(3774501,9,62,0,0,0,100,0,600,600,0,0,45,2,2,0,0,0,0,9,37746,0,200,0,0,0,0,"Quel'Delar - Script - Set Data 2 2 to Sunwell Caster Bunny"), -- 23:17:14.761
(3774501,9,63,0,0,0,100,0,800,800,0,0,45,2,2,0,0,0,0,9,37746,0,200,0,0,0,0,"Quel'Delar - Script - Set Data 2 2 to Sunwell Caster Bunny"), -- 23:17:15.338  
(3774501,9,64,0,0,0,100,0,800,800,0,0,45,8,1,0,0,0,0,19,37764,0,0,0,0,0,0,"Quel'Delar - Script - Say Line 1"), -- 23:17:16.103  
(3774501,9,65,0,0,0,100,0,0,0,0,0,45,2,2,0,0,0,0,9,37746,0,200,0,0,0,0,"Quel'Delar - Script - Set Data 2 2 to Sunwell Caster Bunny"), -- 23:17:16.118  
(3774501,9,66,0,0,0,100,0,400,400,0,0,45,2,2,0,0,0,0,9,37746,0,200,0,0,0,0,"Quel'Delar - Script - Set Data 2 2 to Sunwell Caster Bunny"), -- 23:17:16.539  
(3774501,9,67,0,0,0,100,0,800,800,0,0,45,2,2,0,0,0,0,9,37746,0,200,0,0,0,0,"Quel'Delar - Script - Set Data 2 2 to Sunwell Caster Bunny"), -- 23:17:17.335  
(3774501,9,68,0,0,0,100,0,800,800,0,0,45,2,2,0,0,0,0,9,37746,0,200,0,0,0,0,"Quel'Delar - Script - Set Data 2 2 to Sunwell Caster Bunny"), -- 23:17:18.146  
(3774501,9,69,0,0,0,100,0,400,400,0,0,45,8,2,0,0,0,0,19,37763,0,0,0,0,0,0,"Quel'Delar - Script - Say Line 0"), -- 23:17:18.536  
(3774501,9,70,0,0,0,100,0,0,0,0,0,45,2,2,0,0,0,0,9,37746,0,200,0,0,0,0,"Quel'Delar - Script - Set Data 2 2 to Sunwell Caster Bunny"), -- 23:17:18.536  
(3774501,9,71,0,0,0,100,0,1000,1000,0,0,45,2,2,0,0,0,0,9,37746,0,200,0,0,0,0,"Quel'Delar - Script - Set Data 2 2 to Sunwell Caster Bunny"), -- 23:17:19.535  
(3774501,9,72,0,0,0,100,0,600,600,0,0,45,2,2,0,0,0,0,9,37746,0,200,0,0,0,0,"Quel'Delar - Script - Set Data 2 2 to Sunwell Caster Bunny"), -- 23:17:20.127
(3774501,9,73,0,0,0,100,0,600,600,0,0,45,2,2,0,0,0,0,9,37746,0,200,0,0,0,0,"Quel'Delar - Script - Set Data 2 2 to Sunwell Caster Bunny"), -- 23:17:20.736
(3774501,9,74,0,0,0,100,0,600,600,0,0,45,2,2,0,0,0,0,9,37746,0,200,0,0,0,0,"Quel'Delar - Script - Set Data 2 2 to Sunwell Caster Bunny"), -- 23:17:21.344
(3774501,9,75,0,0,0,100,0,800,800,0,0,45,2,2,0,0,0,0,9,37746,0,200,0,0,0,0,"Quel'Delar - Script - Set Data 2 2 to Sunwell Caster Bunny"), -- 23:17:22.124  
(3774501,9,76,0,0,0,100,0,600,600,0,0,45,2,2,0,0,0,0,9,37746,0,200,0,0,0,0,"Quel'Delar - Script - Set Data 2 2 to Sunwell Caster Bunny"), -- 23:17:22.717
(3774501,9,77,0,0,0,100,0,600,600,0,0,45,2,2,0,0,0,0,9,37746,0,200,0,0,0,0,"Quel'Delar - Script - Set Data 2 2 to Sunwell Caster Bunny"), -- 23:17:23.341
(3774501,9,78,0,0,0,100,0,1000,1000,0,0,45,2,2,0,0,0,0,9,37746,0,200,0,0,0,0,"Quel'Delar - Script - Set Data 2 2 to Sunwell Caster Bunny"), -- 23:17:24.308  
(3774501,9,79,0,0,0,100,0,200,200,0,0,45,2,2,0,0,0,0,9,37746,0,200,0,0,0,0,"Quel'Delar - Script - Set Data 2 2 to Sunwell Caster Bunny"), -- 23:17:24.542  
(3774501,9,80,0,0,0,100,0,1000,1000,0,0,45,2,2,0,0,0,0,9,37746,0,200,0,0,0,0,"Quel'Delar - Script - Set Data 2 2 to Sunwell Caster Bunny"), -- 23:17:25.525  
(3774501,9,81,0,0,0,100,0,600,600,0,0,45,2,2,0,0,0,0,9,37746,0,200,0,0,0,0,"Quel'Delar - Script - Set Data 2 2 to Sunwell Caster Bunny"), -- 23:17:26.149
(3774501,9,82,0,0,0,100,0,600,600,0,0,45,2,2,0,0,0,0,9,37746,0,200,0,0,0,0,"Quel'Delar - Script - Set Data 2 2 to Sunwell Caster Bunny"), -- 23:17:26.742
(3774501,9,83,0,0,0,100,0,600,600,0,0,45,2,2,0,0,0,0,9,37746,0,200,0,0,0,0,"Quel'Delar - Script - Set Data 2 2 to Sunwell Caster Bunny"), -- 23:17:27.366
(3774501,9,84,0,0,0,100,0,800,800,0,0,45,2,2,0,0,0,0,9,37746,0,200,0,0,0,0,"Quel'Delar - Script - Set Data 2 2 to Sunwell Caster Bunny"), -- 23:17:28.162  
(3774501,9,85,0,0,0,100,0,400,400,0,0,45,2,2,0,0,0,0,9,37746,0,200,0,0,0,0,"Quel'Delar - Script - Set Data 2 2 to Sunwell Caster Bunny"), -- 23:17:28.567  
(3774501,9,86,0,0,0,100,0,1000,1000,0,0,45,2,2,0,0,0,0,9,37746,0,200,0,0,0,0,"Quel'Delar - Script - Set Data 2 2 to Sunwell Caster Bunny"), -- 23:17:29.503  
(3774501,9,87,0,0,0,100,0,0,0,0,0,1,6,0,0,0,0,0,19,37763,0,0,0,0,0,0,"Quel'Delar - Script - Say Line 6"), -- 23:17:24.542  
(3774501,9,88,0,0,0,100,0,800,800,0,0,45,2,2,0,0,0,0,9,37746,0,200,0,0,0,0,"Quel'Delar - Script - Set Data 2 2 to Sunwell Caster Bunny"), -- 23:17:30.330  
(3774501,9,89,0,0,0,100,0,200,200,0,0,45,2,2,0,0,0,0,9,37746,0,200,0,0,0,0,"Quel'Delar - Script - Set Data 2 2 to Sunwell Caster Bunny"), -- 23:17:30.580  
(3774501,9,90,0,0,0,100,0,800,800,0,0,45,2,2,0,0,0,0,9,37746,0,200,0,0,0,0,"Quel'Delar - Script - Set Data 2 2 to Sunwell Caster Bunny"), -- 23:17:31.391  
(3774501,9,91,0,0,0,100,0,800,800,0,0,45,2,2,0,0,0,0,9,37746,0,200,0,0,0,0,"Quel'Delar - Script - Set Data 2 2 to Sunwell Caster Bunny"), -- 23:17:32.124  
(3774501,9,92,0,0,0,100,0,600,600,0,0,45,2,2,0,0,0,0,9,37746,0,200,0,0,0,0,"Quel'Delar - Script - Set Data 2 2 to Sunwell Caster Bunny"), -- 23:17:32.732
(3774501,9,93,0,0,0,100,0,600,600,0,0,45,2,2,0,0,0,0,9,37746,0,200,0,0,0,0,"Quel'Delar - Script - Set Data 2 2 to Sunwell Caster Bunny"), -- 23:17:33.388
(3774501,9,94,0,0,0,100,0,800,800,0,0,45,2,2,0,0,0,0,9,37746,0,200,0,0,0,0,"Quel'Delar - Script - Set Data 2 2 to Sunwell Caster Bunny"), -- 23:17:34.183  
(3774501,9,95,0,0,0,100,0,400,400,0,0,45,2,2,0,0,0,0,9,37746,0,200,0,0,0,0,"Quel'Delar - Script - Set Data 2 2 to Sunwell Caster Bunny"), -- 23:17:34.589  
(3774501,9,96,0,0,0,100,0,500,500,0,0,1,7,0,0,0,0,0,19,37763,0,0,0,0,0,0,"Quel'Delar - Script - Say Line 3"), -- 23:17:35.041 
(3774501,9,97,0,0,0,100,0,400,400,0,0,45,2,2,0,0,0,0,9,37746,0,200,0,0,0,0,"Quel'Delar - Script - Set Data 2 2 to Sunwell Caster Bunny"), -- 23:17:35.416  
(3774501,9,98,0,0,0,100,0,900,900,0,0,45,2,2,0,0,0,0,9,37746,0,200,0,0,0,0,"Quel'Delar - Script - Set Data 2 2 to Sunwell Caster Bunny"), -- 23:17:36.336  
(3774501,9,99,0,0,0,100,0,300,300,0,0,45,2,2,0,0,0,0,9,37746,0,200,0,0,0,0,"Quel'Delar - Script - Set Data 2 2 to Sunwell Caster Bunny"), -- 23:17:36.648  
(3774501,9,100,0,0,0,100,0,900,900,0,0,45,2,2,0,0,0,0,9,37746,0,200,0,0,0,0,"Quel'Delar - Script - Set Data 2 2 to Sunwell Caster Bunny"), -- 23:17:37.537   
(3774501,9,101,0,0,0,100,0,700,700,0,0,45,2,2,0,0,0,0,9,37746,0,200,0,0,0,0,"Quel'Delar - Script - Set Data 2 2 to Sunwell Caster Bunny"), -- 23:17:38.255   
(3774501,9,102,0,0,0,100,0,400,400,0,0,45,2,2,0,0,0,0,9,37746,0,200,0,0,0,0,"Quel'Delar - Script - Set Data 2 2 to Sunwell Caster Bunny"), -- 23:17:38.629  
(3774501,9,103,0,0,0,100,0,800,800,0,0,45,2,2,0,0,0,0,9,37746,0,200,0,0,0,0,"Quel'Delar - Script - Set Data 2 2 to Sunwell Caster Bunny"), -- 23:17:39.440  
(3774501,9,104,0,0,0,100,0,0,0,0,0,1,3,0,0,0,0,0,19,37765,0,0,0,0,0,0,"Quel'Delar - Script - Say Line 3"), -- 23:17:39.440  
(3774501,9,105,0,0,0,100,0,800,800,0,0,45,2,2,0,0,0,0,9,37746,0,200,0,0,0,0,"Quel'Delar - Script - Set Data 2 2 to Sunwell Caster Bunny"), -- 23:17:40.236  
(3774501,9,106,0,0,0,100,0,400,400,0,0,45,2,2,0,0,0,0,9,37746,0,200,0,0,0,0,"Quel'Delar - Script - Set Data 2 2 to Sunwell Caster Bunny"), -- 23:17:40.626  
(3774501,9,107,0,0,0,100,0,800,800,0,0,45,2,2,0,0,0,0,9,37746,0,200,0,0,0,0,"Quel'Delar - Script - Set Data 2 2 to Sunwell Caster Bunny"), -- 23:17:41.437  
(3774501,9,108,0,0,0,100,0,800,800,0,0,45,2,2,0,0,0,0,9,37746,0,200,0,0,0,0,"Quel'Delar - Script - Set Data 2 2 to Sunwell Caster Bunny"), -- 23:17:42.248  
(3774501,9,109,0,0,0,100,0,500,500,0,0,45,2,2,0,0,0,0,9,37746,0,200,0,0,0,0,"Quel'Delar - Script - Set Data 2 2 to Sunwell Caster Bunny"), -- 23:17:42.732  
(3774501,9,110,0,0,0,100,0,900,900,0,0,45,2,2,0,0,0,0,9,37746,0,200,0,0,0,0,"Quel'Delar - Script - Set Data 2 2 to Sunwell Caster Bunny"), -- 23:17:43.403  
(3774501,9,111,0,0,0,100,0,800,800,0,0,45,2,2,0,0,0,0,9,37746,0,200,0,0,0,0,"Quel'Delar - Script - Set Data 2 2 to Sunwell Caster Bunny"), -- 23:17:44.245  
(3774501,9,112,0,0,0,100,0,500,500,0,0,45,2,2,0,0,0,0,9,37746,0,200,0,0,0,0,"Quel'Delar - Script - Set Data 2 2 to Sunwell Caster Bunny"), -- 23:17:44.729  
(3774501,9,113,0,0,0,100,0,900,900,0,0,45,2,2,0,0,0,0,9,37746,0,200,0,0,0,0,"Quel'Delar - Script - Set Data 2 2 to Sunwell Caster Bunny"), -- 23:17:45.462  
(3774501,9,114,0,0,0,100,0,400,400,0,0,1,4,0,0,0,0,0,19,37765,0,0,0,0,0,0,"Quel'Delar - Script - Say Line 4"), -- 23:17:45.883 
(3774501,9,115,0,0,0,100,0,400,400,0,0,45,2,2,0,0,0,0,9,37746,0,200,0,0,0,0,"Quel'Delar - Script - Set Data 2 2 to Sunwell Caster Bunny"), -- 23:17:46.258  
(3774501,9,116,0,0,0,100,0,400,400,0,0,45,2,2,0,0,0,0,9,37746,0,200,0,0,0,0,"Quel'Delar - Script - Set Data 2 2 to Sunwell Caster Bunny"), -- 23:17:46.663  
(3774501,9,117,0,0,0,100,0,800,800,0,0,45,2,2,0,0,0,0,9,37746,0,200,0,0,0,0,"Quel'Delar - Script - Set Data 2 2 to Sunwell Caster Bunny"), -- 23:17:47.459  
(3774501,9,118,0,0,0,100,0,800,800,0,0,45,2,2,0,0,0,0,9,37746,0,200,0,0,0,0,"Quel'Delar - Script - Set Data 2 2 to Sunwell Caster Bunny"), -- 23:17:48.270  
(3774501,9,119,0,0,0,100,0,400,400,0,0,45,2,2,0,0,0,0,9,37746,0,200,0,0,0,0,"Quel'Delar - Script - Set Data 2 2 to Sunwell Caster Bunny"), -- 23:17:48.676  
(3774501,9,120,0,0,0,100,0,800,800,0,0,45,2,2,0,0,0,0,9,37746,0,200,0,0,0,0,"Quel'Delar - Script - Set Data 2 2 to Sunwell Caster Bunny"), -- 23:17:49.487  
(3774501,9,121,0,0,0,100,0,800,800,0,0,45,2,2,0,0,0,0,9,37746,0,200,0,0,0,0,"Quel'Delar - Script - Set Data 2 2 to Sunwell Caster Bunny"), -- 23:17:50.282  
(3774501,9,122,0,0,0,100,0,500,500,0,0,45,2,2,0,0,0,0,9,37746,0,200,0,0,0,0,"Quel'Delar - Script - Set Data 2 2 to Sunwell Caster Bunny"), -- 23:17:50.735 
(3774501,9,123,0,0,0,100,0,0,0,0,0,45,8,3,0,0,0,0,19,37763,0,0,0,0,0,0,"Quel'Delar - Script - Set Data 2 2 to Sunwell Caster Bunny"), -- 23:17:45.462  
(3774501,9,124,0,0,0,100,0,900,900,0,0,50,201794,900,0,0,0,0,1,0,0,0,0,0,0,0.0,"Quel'Delar - Script - Spawn GO"), -- 23:17:51.484  
(3774501,9,125,0,0,0,100,0,0,0,0,0,45,2,2,0,0,0,0,9,37746,0,200,0,0,0,0,"Quel'Delar - Script - Set Data 2 2 to Sunwell Caster Bunny"), -- 23:17:51.484  
(3774501,9,126,0,0,0,100,0,400,400,0,0,45,8,4,0,0,0,0,19,37763,0,0,0,0,0,0,"Quel'Delar - Script - Set Data 8 8"),  
(3774501,9,127,0,0,0,100,0,0,0,0,0,45,8,4,0,0,0,0,19,37764,0,0,0,0,0,0,"Quel'Delar - Script - Set Data 8 8"),  
(3774501,9,128,0,0,0,100,0,0,0,0,0,45,8,4,0,0,0,0,19,37765,0,0,0,0,0,0,"Quel'Delar - Script - Set Data 8 8"),  
(3774501,9,129,0,0,0,100,0,800,800,0,0,44,8,0,0,0,0,0,1,0,0,0,0,0,0,0,"Quel'Delar - Script - Despawn"), -- 23:17:52.279  
(3776400,9,0,0,0,0,100,0,0,0,0,0,100,1,0,0,0,0,0,9,37781,0,200,0,0,0,0,"Lor'themar Theron - Script - Send Target"), -- 23:17:10.900
(3776400,9,1,0,0,0,100,0,5000,5000,0,0,45,2,2,0,0,0,0,10,122983,37781,0,0,0,0,0,"Lor'themar Theron - Script - Set Data"), -- 23:17:10.900
(3776400,9,2,0,0,0,100,0,0,0,0,0,45,3,3,0,0,0,0,10,122985,37781,0,0,0,0,0,"Lor'themar Theron - Script - Set Data"),
(3776400,9,3,0,0,0,100,0,0,0,0,0,45,3,3,0,0,0,0,10,122777,37781,0,0,0,0,0,"Lor'themar Theron - Script - Set Data"),
(3776400,9,4,0,0,0,100,0,0,0,0,0,45,3,3,0,0,0,0,10,122953,37781,0,0,0,0,0,"Lor'themar Theron - Script - Set Data"),
(3776400,9,5,0,0,0,100,0,0,5000,0,0,45,7,7,0,0,0,0,9,37781,0,200,0,0,0,0,"Lor'themar Theron - Script - Set Data"),
(3776400,9,6,0,0,0,100,0,0,5000,0,0,45,7,7,0,0,0,0,9,37781,0,200,0,0,0,0,"Lor'themar Theron - Script - Set Data"),
(3776400,9,7,0,0,0,100,0,20000,20000,0,0,45,4,4,0,0,0,0,10,122985,37781,0,0,0,0,0,"Lor'themar Theron - Script - Set Data"), -- 23:17:40.236
(3776400,9,8,0,0,0,100,0,0,0,0,0,45,4,4,0,0,0,0,10,122777,37781,0,0,0,0,0,"Lor'themar Theron - Script - Set Data"),
(3776400,9,9,0,0,0,100,0,0,0,0,0,45,4,4,0,0,0,0,10,122953,37781,0,0,0,0,0,"Lor'themar Theron - Script - Set Data"),
(3776400,9,10,0,0,0,100,0,1200,1200,0,0,45,5,5,0,0,0,0,10,122985,37781,0,0,0,0,0,"Lor'themar Theron - Script - Set Data"), -- 23:17:41.437
(3776400,9,11,0,0,0,100,0,0,0,0,0,45,5,5,0,0,0,0,10,122777,37781,0,0,0,0,0,"Lor'themar Theron - Script - Set Data"),
(3776400,9,12,0,0,0,100,0,0,0,0,0,45,5,5,0,0,0,0,10,122953,37781,0,0,0,0,0,"Lor'themar Theron - Script - Set Data"),
(3776400,9,13,0,0,0,100,0,2400,2400,0,0,45,6,6,0,0,0,0,10,122985,37781,0,0,0,0,0,"Lor'themar Theron - Script - Set Data"), -- 23:17:43.840
(3776400,9,14,0,0,0,100,0,0,0,0,0,45,6,6,0,0,0,0,10,122777,37781,0,0,0,0,0,"Lor'themar Theron - Script - Set Data"),
(3776400,9,15,0,0,0,100,0,0,0,0,0,45,6,6,0,0,0,0,10,122953,37781,0,0,0,0,0,"Lor'themar Theron - Script - Set Data"),
(3776500,9,0,0,0,0,100,0,3000,3000,0,0,66,0,0,0,0,0,0,8,0,0,0,0,0,0,5.026548,"Lor themar Theron - Script - Set Orientation"), -- 23:17:55.696  
(3776500,9,1,0,0,0,100,0,0,0,0,0,5,25,0,0,0,0,0,1,0,0,0,0,0,0,0,"Lor themar Theron - Script - Play Emote"), -- 23:17:55.696  
(3776500,9,2,0,0,0,100,0,200,200,0,0,1,2,0,0,0,0,0,12,1,0,0,0,0,0,0,"Lor themar Theron - Script - Say Line 2"), -- 23:17:55.899  
(3776500,9,3,0,0,0,100,0,3500,3500,0,0,53,0,3776500,0,0,0,0,1,0,0,0,0,0,0,0,"Lor themar Theron - Script - Start WP"), -- 23:17:59.533  
(3776500,9,4,0,0,0,100,0,3000,3000,0,0,45,9,9,0,0,0,0,19,37763,0,0,0,0,0,0,"Lor themar Theron - Script - Despawn"),   
(3776500,9,5,0,0,0,100,0,0,0,0,0,45,9,9,0,0,0,0,19,37764,0,0,0,0,0,0,"Lor themar Theron - Script - Despawn");   

DELETE FROM `waypoints` WHERE `entry`IN(37763,3776300,37764,3776400,37765,3776500);
INSERT INTO `waypoints` (`entry`, `pointid`, `position_x`, `position_y`, `position_z`, `orientation`, `point_comment`) VALUES 
(37763, 1, 1673.819, 625.1953, 28.09187, 0, 'Grand Magister Rommath'),
(37763, 2, 1673.958, 623.1528, 28.05021, 0, 'Grand Magister Rommath'),
(37763, 3, 1679.743, 619.6858, 28.2967, 0, 'Grand Magister Rommath'),
(3776300, 1, 1671.679, 631.2379, 28.05021, 3.996804, 'Grand Magister Rommath (Path 2)'),
(37764, 1, 1666.816, 627.8906, 28.09187, 0, 'Lor themar Theron'),
(37764, 2, 1668, 624.0313, 28.05021, 0, 'Lor themar Theron'),
(37764, 3, 1671.337, 618.75, 28.05021, 0, 'Lor themar Theron'),
(37764, 4, 1675.3, 616.118, 28.05021, 0, 'Lor themar Theron'),
(3776400, 1, 1665.13, 632.75, 28.1335, 5.02655, 'Lor themar Theron (Path 2)'),
(37765, 1, 1698.027, 604.7214, 28.15574, 0, 'Captain Auric Sunchaser'),
(37765, 2, 1695.984, 604.6389, 28.32832, 0, 'Captain Auric Sunchaser'),
(37765, 3, 1692.92, 604.7227, 28.02385, 0, 'Captain Auric Sunchaser'),
(37765, 4, 1690.852, 604.7344, 28.11132, 0, 'Captain Auric Sunchaser'),
(37765, 5, 1687.391, 608.5347, 28.52988, 1.553343, 'Captain Auric Sunchaser'),
(3776500, 1, 1700.569, 604.8038, 28.39968, 0, 'Captain Auric Sunchaser (Path 2)');

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`IN(14,15) AND `SourceGroup`=10963;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES 
(14, 10963, 15239, 0, 0, 9, 0, 24553, 0, 0, 1, 0, 0, '', 'Warden of the Sunwell display different gossip if player is not on quest'),
(14, 10963, 15239, 0, 0, 9, 0, 24564, 0, 0, 1, 0, 0, '', 'Warden of the Sunwell display different gossip if player is not on quest'),
(14, 10963, 15239, 0, 0, 9, 0, 24594, 0, 0, 1, 0, 0, '', 'Warden of the Sunwell display different gossip if player is not on quest'),
(14, 10963, 15239, 0, 0, 9, 0, 24595, 0, 0, 1, 0, 0, '', 'Warden of the Sunwell display different gossip if player is not on quest'),
(14, 10963, 15239, 0, 0, 9, 0, 24596, 0, 0, 1, 0, 0, '', 'Warden of the Sunwell display different gossip if player is not on quest'),
(14, 10963, 15239, 0, 0, 9, 0, 24598, 0, 0, 1, 0, 0, '', 'Warden of the Sunwell display different gossip if player is not on quest'),
(14, 10963, 15240, 0, 0, 9, 0, 24553, 0, 0, 0, 0, 0, '', 'Warden of the Sunwell display different gossip if player is on quest'),
(14, 10963, 15240, 0, 1, 9, 0, 24564, 0, 0, 0, 0, 0, '', 'Warden of the Sunwell display different gossip if player is on quest'),
(14, 10963, 15240, 0, 2, 9, 0, 24594, 0, 0, 0, 0, 0, '', 'Warden of the Sunwell display different gossip if player is on quest'),
(14, 10963, 15240, 0, 3, 9, 0, 24595, 0, 0, 0, 0, 0, '', 'Warden of the Sunwell display different gossip if player is on quest'),
(14, 10963, 15240, 0, 4, 9, 0, 24596, 0, 0, 0, 0, 0, '', 'Warden of the Sunwell display different gossip if player is on quest'),
(14, 10963, 15240, 0, 5, 9, 0, 24598, 0, 0, 0, 0, 0, '', 'Warden of the Sunwell display different gossip if player is on quest'),
(15, 10963, 0, 0, 0, 9, 0, 24553, 0, 0, 0, 0, 0, '', 'Warden of the Sunwell display different gossip if player is on quest'),
(15, 10963, 0, 0, 1, 9, 0, 24564, 0, 0, 0, 0, 0, '', 'Warden of the Sunwell display different gossip if player is on quest'),
(15, 10963, 0, 0, 2, 9, 0, 24594, 0, 0, 0, 0, 0, '', 'Warden of the Sunwell display different gossip if player is on quest'),
(15, 10963, 0, 0, 3, 9, 0, 24595, 0, 0, 0, 0, 0, '', 'Warden of the Sunwell display different gossip if player is on quest'),
(15, 10963, 0, 0, 4, 9, 0, 24596, 0, 0, 0, 0, 0, '', 'Warden of the Sunwell display different gossip if player is on quest'),
(15, 10963, 0, 0, 5, 9, 0, 24598, 0, 0, 0, 0, 0, '', 'Warden of the Sunwell display different gossip if player is on quest');

--
UPDATE `creature_template` SET `npcflag`=0 WHERE  `entry`=37523;
UPDATE `creature` SET `npcflag`=1 WHERE `guid` IN (121400, 121399);

-- Fix for "Elder Torntusk" when attacking him
-- Remove "StandState" flag "Dead" from template_addon
UPDATE `creature_template_addon` SET `StandState`=0 WHERE `entry`=14757;

-- Script
DELETE FROM `smart_scripts` WHERE `entryorguid`=14757 AND `source_type`=0 AND `id` IN (1,2);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(14757,0,1,0,25,0,100,0,0,0,0,0,90,7,0,0,0,0,0,1,0,0,0,0,0,0,0,"Elder Torntusk - On Reset - Set Flag Standstate 'Dead'"),
(14757,0,2,0,4,0,100,0,0,0,0,0,91,7,0,0,0,0,0,1,0,0,0,0,0,0,0,"Elder Torntusk - On Aggro - Remove Flag Standstate 'Dead'");
-- Hurley Blackbreath script fix
UPDATE `creature_text` SET `Emote`=5 WHERE `CreatureID`=9537;

UPDATE `waypoints` SET `position_x`=892.9590,`position_y`=-141.4704,`position_z`=-49.7570 WHERE `entry`=9537 AND `pointid`=2;
UPDATE `waypoints` SET `position_x`=888.984,`position_y`=-152.599,`position_z`=-49.76 WHERE `entry`=9541 AND `pointid`=1;
UPDATE `waypoints` SET `position_x`=889.8773,`position_y`=-141.2147,`position_z`=-49.7567 WHERE `entry`=9541 AND `pointid`=2;
UPDATE `waypoints` SET `position_x`=885.926,`position_y`=-145.908,`position_z`=-49.76 WHERE `entry`=9541000 AND `pointid`=1;
UPDATE `waypoints` SET `position_x`=892.9106,`position_y`=-140.2764,`position_z`=-49.7557 WHERE `entry`=9541000 AND `pointid`=2;
UPDATE `waypoints` SET `position_x`=897.1912,`position_y`=-136.4424,`position_z`=-49.7516 WHERE `entry`=9541001 AND `pointid`=2;

DELETE FROM `smart_scripts` WHERE `entryorguid` IN (9537,-71997,-71998,-71999);
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (953700,7199700,7199800,7199900) AND `source_type`=9;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`event_param5`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_param4`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(9537,0,0,0,2,0,100,0,0,30,30000,45000,0,11,14872,0,0,0,0,0,1,0,0,0,0,0,0,0,0,"Hurley Blackbreath - On Less than 30% HP - Cast 'Drunken Rage'"),
(9537,0,1,0,9,0,100,0,0,5,10000,15000,0,11,9573,0,0,0,0,0,7,0,0,0,0,0,0,0,0,"Hurley Blackbreath - On Range - Cast 'Flame Breath'"),
(9537,0,2,0,0,0,100,0,5000,6000,10000,14000,0,11,26211,0,0,0,0,0,2,0,0,0,0,0,0,0,0,"Hurley Blackbreath - IC - Cast 'Hamstring'"),
(9537,0,3,0,0,0,100,0,5000,8000,8000,13000,0,11,16856,0,0,0,0,0,2,0,0,0,0,0,0,0,0,"Hurley Blackbreath - IC - Cast 'Mortal Strike'"),
(9537,0,4,5,11,0,100,0,0,0,0,0,0,144,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,"Hurley Blackbreath - On Spawn - Set Immune to Players"),
(9537,0,5,6,61,0,100,0,0,0,0,0,0,145,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,"Hurley Blackbreath - On Link - Set Immune to NPC's"),
(9537,0,6,0,61,0,100,0,0,0,0,0,0,47,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,"Hurley Blackbreath - On Link - Set Invisible"),
(9537,0,7,8,38,0,100,1,1,1,0,0,0,47,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,"Hurley Blackbreath - On Data Set 1 1 - Set Visible"),
(9537,0,8,9,61,0,100,0,0,0,0,0,0,45,1,1,0,0,0,0,11,9541,50,0,0,0,0,0,0,"Hurley Blackbreath - On Link - Set Data 1 1 to 'Blackbreath Crony'"),
(9537,0,9,10,61,0,100,0,0,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,"Hurley Blackbreath - On Link - Say Line 0"),
(9537,0,10,0,61,0,100,0,0,0,0,0,0,53,1,9537,0,0,0,0,1,0,0,0,0,0,0,0,0,"Hurley Blackbreath - On Link - Start Waypoint"),
(9537,0,11,12,40,0,100,0,3,0,0,0,0,101,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,"Hurley Blackbreath - On Waypoint 3 Reached - Set Home Position"),
(9537,0,12,0,61,0,100,0,0,0,0,0,0,80,953700,0,0,0,0,0,1,0,0,0,0,0,0,0,0,"Hurley Blackbreath - On Link - Run Script"),
(9537,0,13,14,4,0,100,0,0,0,0,0,0,45,1,2,0,0,0,0,11,9541,50,0,0,0,0,0,0,"Hurley Blackbreath - On Agro - Set Data 1 2 to 'Blackbreath Crony'"),
(9537,0,14,0,61,0,100,0,0,0,0,0,0,49,0,0,0,0,0,0,7,0,0,0,0,0,0,0,0,"Hurley Blackbreath - On Link - Attack"),
(9537,0,15,0,38,0,100,0,1,2,0,0,0,49,0,0,0,0,0,0,21,50,0,0,0,0,0,0,0,"Hurley Blackbreath - On Data Set 1 2 - Attack"),

(953700,9,0,0,0,0,100,0,1000,1000,0,0,0,66,0,0,0,0,0,0,21,50,0,0,0,0,0,0,0,"Hurley Blackbreath - On Script - Set Orientation"),
(953700,9,1,0,0,0,100,0,0,0,0,0,0,1,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,"Hurley Blackbreath - On Script - Say Line 1"),
(953700,9,2,0,0,0,100,0,3000,3000,0,0,0,144,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,"Hurley Blackbreath - On Script - Remove Immune to Players"),
(953700,9,3,0,0,0,100,0,0,0,0,0,0,145,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,"Hurley Blackbreath - On Script - Remove Immune to NPC's"),
(953700,9,4,0,0,0,100,0,0,0,0,0,0,89,3,0,0,0,0,0,1,0,0,0,0,0,0,0,0,"Hurley Blackbreath - On Script - Set Random Movement"),

(-71997,0,0,0,0,0,100,0,1000,3000,4000,7000,0,11,15581,0,0,0,0,0,2,0,0,0,0,0,0,0,0,"Blackbreath Crony - IC - Cast 'Sinister Strike'"),
(-71997,0,1,0,0,0,100,0,2000,2000,11000,12000,0,11,15583,0,0,0,0,0,2,0,0,0,0,0,0,0,0,"Blackbreath Crony - IC - Cast 'Rupture'"),
(-71997,0,2,3,11,0,100,0,0,0,0,0,0,144,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,"Blackbreath Crony - On Spawn - Set Immune to Players"),
(-71997,0,3,4,61,0,100,0,0,0,0,0,0,145,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,"Blackbreath Crony - On Link - Set Immune to NPC's"),
(-71997,0,4,0,61,0,100,0,0,0,0,0,0,47,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,"Blackbreath Crony - On Link - Set Invisible"),
(-71997,0,5,6,38,0,100,0,1,1,0,0,0,47,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,"Blackbreath Crony - On Data Set 1 1 - Set Visible"),
(-71997,0,6,0,61,0,100,0,0,0,0,0,0,53,1,9541,0,0,0,0,1,0,0,0,0,0,0,0,0,"Blackbreath Crony - On Link - Start Waypoint"),
(-71997,0,7,8,40,0,100,0,3,0,0,0,0,101,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,"Blackbreath Crony - On Waypoint 3 Reached - Set Home Position"),
(-71997,0,8,0,61,0,100,0,0,0,0,0,0,80,7199700,0,0,0,0,0,1,0,0,0,0,0,0,0,0,"Blackbreath Crony - On Link - Run Script"), 
(-71997,0,9,10,4,0,100,0,0,0,0,0,0,45,1,2,0,0,0,0,11,9541,50,0,0,0,0,0,0,"Blackbreath Crony - On Agro - Set Data 1 2 to 'Blackbreath Crony'"),
(-71997,0,10,11,61,0,100,0,0,0,0,0,0,45,1,2,0,0,0,0,11,9537,50,0,0,0,0,0,0,"Blackbreath Crony - On Agro - Set Data 1 2 to 'Hurley Blackbreath'"),
(-71997,0,11,0,61,0,100,0,0,0,0,0,0,49,0,0,0,0,0,0,7,0,0,0,0,0,0,0,0,"Blackbreath Crony - On Link - Attack"),
(-71997,0,12,0,38,0,100,0,1,2,0,0,0,49,0,0,0,0,0,0,21,50,0,0,0,0,0,0,0,"Blackbreath Crony - On Data Set 1 2 - Attack"),

(7199700,9,0,0,0,0,100,0,3500,3500,0,0,0,89,3,0,0,0,0,0,1,0,0,0,0,0,0,0,0,"Blackbreath Crony - On Script - Set Random Movement"),
(7199700,9,1,0,0,0,100,0,0,0,0,0,0,144,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,"Blackbreath Crony - On Script - Remove Immune to Players"),
(7199700,9,2,0,0,0,100,0,0,0,0,0,0,145,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,"Blackbreath Crony - On Script - Remove Immune to NPC's"),

(-71998,0,0,0,0,0,100,0,1000,3000,4000,7000,0,11,15581,0,0,0,0,0,2,0,0,0,0,0,0,0,0,"Blackbreath Crony - IC - Cast 'Sinister Strike'"),
(-71998,0,1,0,0,0,100,0,2000,2000,11000,12000,0,11,15583,0,0,0,0,0,2,0,0,0,0,0,0,0,0,"Blackbreath Crony - IC - Cast 'Rupture'"),
(-71998,0,2,3,11,0,100,0,0,0,0,0,0,144,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,"Blackbreath Crony - On Spawn - Set Immune to Players"),
(-71998,0,3,4,61,0,100,0,0,0,0,0,0,145,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,"Blackbreath Crony - On Link - Set Immune to NPC's"),
(-71998,0,4,0,61,0,100,0,0,0,0,0,0,47,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,"Blackbreath Crony - On Link - Set Invisible"),
(-71998,0,5,6,38,0,100,0,1,1,0,0,0,47,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,"Blackbreath Crony - On Data Set 1 1 - Set Visible"),
(-71998,0,6,0,61,0,100,0,0,0,0,0,0,53,1,9541000,0,0,0,0,1,0,0,0,0,0,0,0,0,"Blackbreath Crony - On Link - Start Waypoint"),
(-71998,0,7,8,40,0,100,0,3,0,0,0,0,101,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,"Blackbreath Crony - On Waypoint 3 Reached - Set Home Position"),
(-71998,0,8,0,61,0,100,0,0,0,0,0,0,80,7199800,0,0,0,0,0,1,0,0,0,0,0,0,0,0,"Blackbreath Crony - On Link - Run Script"),
(-71998,0,9,10,4,0,100,0,0,0,0,0,0,45,1,2,0,0,0,0,11,9541,50,0,0,0,0,0,0,"Blackbreath Crony - On Agro - Set Data 1 2 to 'Blackbreath Crony'"),
(-71998,0,10,11,61,0,100,0,0,0,0,0,0,45,1,2,0,0,0,0,11,9537,50,0,0,0,0,0,0,"Blackbreath Crony - On Agro - Set Data 1 2 to 'Hurley Blackbreath'"),
(-71998,0,11,0,61,0,100,0,0,0,0,0,0,49,0,0,0,0,0,0,7,0,0,0,0,0,0,0,0,"Blackbreath Crony - On Link - Attack"),
(-71998,0,12,0,38,0,100,0,1,2,0,0,0,49,0,0,0,0,0,0,21,50,0,0,0,0,0,0,0,"Blackbreath Crony - On Data Set 1 2 - Attack"),

(7199800,9,0,0,0,0,100,0,4000,4000,0,0,0,89,3,0,0,0,0,0,1,0,0,0,0,0,0,0,0,"Blackbreath Crony - On Script - Set Random Movement"),
(7199800,9,1,0,0,0,100,0,0,0,0,0,0,144,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,"Blackbreath Crony - On Script - Remove Immune to Players"),
(7199800,9,2,0,0,0,100,0,0,0,0,0,0,145,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,"Blackbreath Crony - On Script - Remove Immune to NPC's"),

(-71999,0,0,0,0,0,100,0,2000,2000,11000,12000,0,11,15581,0,0,0,0,0,2,0,0,0,0,0,0,0,0,"Blackbreath Crony - IC - Cast 'Sinister Strike'"),
(-71999,0,1,0,0,0,100,0,3000,5000,15000,20000,0,11,15583,0,0,0,0,0,2,0,0,0,0,0,0,0,0,"Blackbreath Crony - IC - Cast 'Rupture'"),
(-71999,0,2,3,11,0,100,0,0,0,0,0,0,144,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,"Blackbreath Crony - On Spawn - Set Immune to Players"),
(-71999,0,3,4,61,0,100,0,0,0,0,0,0,145,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,"Blackbreath Crony - On Link - Set Immune to NPC's"),
(-71999,0,4,0,61,0,100,0,0,0,0,0,0,47,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,"Blackbreath Crony - On Link - Set Invisible"),
(-71999,0,5,6,38,0,100,0,1,1,0,0,0,47,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,"Blackbreath Crony - On Data Set 1 1 - Set Visible"),
(-71999,0,6,0,61,0,100,0,0,0,0,0,0,53,1,9541001,0,0,0,0,1,0,0,0,0,0,0,0,0,"Blackbreath Crony - On Link - Start Waypoint"),
(-71999,0,7,8,40,0,100,0,3,0,0,0,0,101,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,"Blackbreath Crony - On Waypoint 3 Reached - Set Home Position"),
(-71999,0,8,0,61,0,100,0,0,0,0,0,0,80,7199900,0,0,0,0,0,1,0,0,0,0,0,0,0,0,"Blackbreath Crony - On Link - Run Script"),
(-71999,0,9,10,4,0,100,0,0,0,0,0,0,45,1,2,0,0,0,0,11,9541,50,0,0,0,0,0,0,"Blackbreath Crony - On Agro - Set Data 1 2 to 'Blackbreath Crony'"),
(-71999,0,10,11,61,0,100,0,0,0,0,0,0,45,1,2,0,0,0,0,11,9537,50,0,0,0,0,0,0,"Blackbreath Crony - On Agro - Set Data 1 2 to 'Hurley Blackbreath'"),
(-71999,0,11,0,61,0,100,0,0,0,0,0,0,49,0,0,0,0,0,0,7,0,0,0,0,0,0,0,0,"Blackbreath Crony - On Link - Attack"),
(-71999,0,12,0,38,0,100,0,1,2,0,0,0,49,0,0,0,0,0,0,21,50,0,0,0,0,0,0,0,"Blackbreath Crony - On Data Set 1 2 - Attack"),

(7199900,9,0,0,0,0,100,0,3000,3000,0,0,0,89,3,0,0,0,0,0,1,0,0,0,0,0,0,0,0,"Blackbreath Crony - On Script - Set Random Movement"),
(7199900,9,1,0,0,0,100,0,0,0,0,0,0,144,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,"Blackbreath Crony - On Script - Remove Immune to Players"),
(7199900,9,2,0,0,0,100,0,0,0,0,0,0,145,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,"Blackbreath Crony - On Script - Remove Immune to NPC's");

DELETE FROM skill_fishing_base_level WHERE entry=4415;
INSERT INTO skill_fishing_base_level (entry, skill)
VALUES (4415, 550);

-- Cast aura 70193 on player if one of the following conditions are meet
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 17 AND `SourceGroup` = 0 AND `SourceEntry` = 70193;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(17, 0, 70193, 0, 1, 8, 0, 24480, 0, 0, 0, 0, 0, '', "Cast aura 70193 on player only if quest The Halls Of Reflection Alliance rewarded"),
(17, 0, 70193, 0, 2, 47, 0, 24522, 74, 0, 0, 0, 0, '', "Cast aura 70193 on player only if quest Journey To The Sunwell Alliance progress, completed or rewarded"),
(17, 0, 70193, 0, 3, 47, 0, 24535, 74, 0, 0, 0, 0, '', "Cast aura 70193 on player only if quest Thalorien Dawnseeker Alliance progress, completed or rewarded"),
(17, 0, 70193, 0, 4, 8, 0, 24561, 0, 0, 0, 0, 0, '', "Cast aura 70193 on player only if quest The Halls Of Reflection Horde rewarded"),
(17, 0, 70193, 0, 5, 47, 0, 24562, 74, 0, 0, 0, 0, '', "Cast aura 70193 on player only if quest Journey To The Sunwell Horde progress, completed or rewarded"),
(17, 0, 70193, 0, 6, 47, 0, 24563, 74, 0, 0, 0, 0, '', "Cast aura 70193 on player only if quest Thalorien Dawnseeker Horde progress, completed or rewarded");

--
DELETE FROM `spell_area` WHERE `spell`=70193 AND `quest_start` IN (24535,24563);
INSERT INTO `spell_area` (`spell`, `area`, `quest_start`, `quest_end`, `aura_spell`, `racemask`, `gender`, `autocast`, `quest_start_status`, `quest_end_status`) VALUES
(70193, 4092, 24535, 24535, 0, 0, 2, 1, 75, 75),
(70193, 4092, 24563, 24563, 0, 0, 2, 1, 75, 75);

--
UPDATE `spell_area` SET `quest_start_status`=75,`quest_end_status`=75 WHERE `spell`=70193 AND `area`=4094;

-- Update Kialon Nightblade
UPDATE `creature_template_addon` SET `PvPFlags`=1 WHERE `entry`=18098;
UPDATE `creature_template` SET `speed_walk`=1 WHERE `entry`=18098;

-- Waypoints
SET @PATH=64051 * 10;
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES
(@PATH, 0, 1955.909, 6887.554, 162.2125, NULL, 0, 0, 0, 100, 0),
(@PATH, 1, 1957.126, 6870.499, 161.0544, NULL, 0, 0, 0, 100, 0),
(@PATH, 2, 1963.431, 6862.901, 160.0951, NULL, 0, 0, 0, 100, 0),
(@PATH, 3, 1972.715, 6859.702, 162.0977, NULL, 60000, 0, 0, 100, 0),
(@PATH, 4, 1964.917, 6866.565, 160.7522, NULL, 0, 0, 0, 100, 0),
(@PATH, 5, 1956.629, 6881.325, 161.8812, NULL, 0, 0, 0, 100, 0),
(@PATH, 6, 1955.969, 6887.533, 162.1539, NULL, 0, 0, 0, 100, 0),
(@PATH, 7, 1957.679, 6894.385, 161.872, NULL, 300000, 0, 0, 100, 0);

-- SAI
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 18098;
DELETE FROM `smart_scripts` WHERE `source_type` = 0 AND `entryorguid` = 18098;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(18098, 0, 0, 0, 40, 0, 100, 0, 3, 640510, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, "Kialon Nightblade - On Waypoint 3 reached - Say Line 0"),
(18098, 0, 1, 0, 40, 0, 100, 0, 7, 640510, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 0, 4.45059,  "Kialon Nightblade - On Waypoint 7 reached - Set Orientation");

-- Update wrong translation for 'Scroll of enchant shield: defense'
UPDATE `item_template_locale` SET `Name`='Pergamino de Encantar escudo: defensa' WHERE `ID`=38954 AND `locale` IN ('esES','esMX');
-- Add missing locale for 'Scroll of enchant shield: greater intellect'
DELETE FROM `item_template_locale` WHERE `ID`=44455 AND `locale` IN ('esES','esMX');
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(44455, 'esES', 'Pergamino de Encantar escudo: intelecto superior', '', -12340),
(44455, 'esMX', 'Pergamino de Encantar escudo: intelecto superior', '', -12340);

--
DELETE FROM `trinity_string` WHERE `entry`=1517;
INSERT INTO `trinity_string` (`entry`, `content_default`, `content_loc1`, `content_loc2`, `content_loc3`, `content_loc4`, `content_loc5`, `content_loc6`, `content_loc7`, `content_loc8`) VALUES
(1517, 'Quest ID %u does not exist.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

-- Remove stun immunity from Captain Balinda Stonehearth and Captain Galvangar for all entries
UPDATE `creature_template` SET `mechanic_immune_mask`=`mechanic_immune_mask`&~2048 WHERE `entry` IN (22605,31820,37243,22606,31055,37244);

-- Horde
UPDATE `quest_poi_points` SET `X`=5893, `Y`=471, `VerifiedBuild`=53007 WHERE `QuestID`=24556 AND `Idx1`=1;
UPDATE `quest_poi_points` SET `X`=5798, `Y`=696, `VerifiedBuild`=53007 WHERE `QuestID`=24556 AND `Idx1`=2;
-- Alliance
UPDATE `quest_poi_points` SET `X`=5745, `Y`=721, `VerifiedBuild`=53007 WHERE `QuestID`=20438 AND `Idx1`=1;
UPDATE `quest_poi_points` SET `X`=5798, `Y`=696, `VerifiedBuild`=53007 WHERE `QuestID`=20438 AND `Idx1`=2;

-- 
UPDATE `quest_poi_points` SET `X`=5893, `Y`=471, `VerifiedBuild`=53007 WHERE `QuestID`=24451;

-- Alliance 
UPDATE quest_poi_points SET `X`=5745, `Y`=721, `VerifiedBuild`=19831 WHERE `QuestID`=14444; 
-- Horde 
UPDATE quest_poi_points SET `X`=5893, `Y`=471, `VerifiedBuild`=19831 WHERE `QuestID`=24555;

--
UPDATE `quest_poi_points` SET `X`=5745, `Y`=721, `VerifiedBuild`=19831 WHERE `QuestID`=14457 AND `Idx1`=1;
UPDATE `quest_poi_points` SET `X`=5917, `Y`=554, `VerifiedBuild`=19831 WHERE `QuestID`=14457 AND `Idx1`=2;

--
UPDATE `quest_poi_points` SET `X`=5745, `Y`=721, `VerifiedBuild`=53007 WHERE `QuestID`=20439;

--
UPDATE `quest_poi_points` SET `X`=5639, `Y`=764, `VerifiedBuild`=19831 WHERE `QuestID`=24557 AND `Idx1`=1;
UPDATE `quest_poi_points` SET `X`=5765, `Y`=718, `VerifiedBuild`=19831 WHERE `QuestID`=24557 AND `Idx1`=2;

--
DELETE FROM `disables` WHERE `sourceType`=0 AND `flags`=64 AND `entry` IN (48188,69922,53038,52227,46171,45949,38729,32979);

-- Remove from disables unnedeed LOS spells with TARGET_UNIT_NEARBY_ENTRY
DELETE FROM `disables` WHERE `sourceType`=0 AND `flags`=64 AND `entry` IN (
35113,-- Warp Measurement
36460,-- Ultra Deconsolodation Zapper
45323,-- Returning Vrykul Artifact
51964,-- Tormentor's Incense
58515,-- Burn Corpse
71024);-- Throw Bomb

-- "Artifacts of the Blacksilt" shouldn't have a prevquest requirement
UPDATE `quest_template_addon` SET `PrevQuestID`=0 WHERE `ID`=9549;

-- Breadcrumb quest Fix
DELETE FROM `quest_template_addon` WHERE `ID`=10063;
INSERT INTO `quest_template_addon` (`ID`, `BreadcrumbForQuestId`) VALUES
(10063,9549);

-- Defender Adrielle Gossip Menu Text
UPDATE `creature_template` SET `gossip_menu_id`=7539 WHERE `entry`=18020;

-- Missing Gossip Otions for "Galaen's Journal"
DELETE FROM `gossip_menu_option` WHERE `MenuID`IN (7493,7492,7491);
INSERT INTO `gossip_menu_option` (`MenuID`, `OptionID`, `OptionIcon`, `OptionText`, `OptionBroadcastTextID`, `OptionType`, `OptionNpcFlag`, `ActionMenuID`, `ActionPoiID`, `BoxCoded`, `BoxMoney`, `BoxText`, `BoxBroadcastTextID`, `VerifiedBuild`) VALUES
(7493,0,0,"<Turn to the next page.>",14429,1,1,7492,0,0,0,"",0,0),
(7492,0,0,"<Turn to the next page.>",14429,1,1,7491,0,0,0,"",0,0),
(7491,0,0,"<Turn to the next page.>",14429,1,1,7490,0,0,0,"",0,0);

-- Remove creature Galaen (he is spawned by script)
DELETE FROM `creature` WHERE `guid`=86514;

-- Quest "What Argus Means to Me" should not be availably when you have quest "Report to Exarch Admetius" in your log (Not Breadcrumb)
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`= 19 AND `SourceEntry`=9693;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`SourceId`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionTarget`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`NegativeCondition`,`ErrorType`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(19,0,9693,0,0,28,0,9668,0,0,1,0,0,'',"Don't show quest 'What Argus Means to Me' if quest 'Report To Exarch Admetius' is taken");

-- Vindicator Aesom gossip menu text changes after turning in quest "The Sun Gate"
-- Gossip menu
DELETE FROM `gossip_menu` WHERE `MenuID`=7517 AND `TextID`=9130;
INSERT INTO `gossip_menu` (`MenuID`, `TextID`, `VerifiedBuild`) VALUES
(7517,9130,0);

-- Condition
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=14 AND `SourceGroup`=7517;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(14,7517,9130,0,0,8,0,9740,0,0,0,0,0,"","Gossip text 9130 requires quest The Sun Gate (9740) rewarded");

-- High Chief Stillpine is missing gossip menu text
DELETE FROM `gossip_menu` WHERE `MenuID`=7434 AND `TextID`=9173;
INSERT INTO `gossip_menu` (`MenuID`, `TextID`, `VerifiedBuild`) VALUES
(7434,9173,0);

-- Conditions
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=14 AND `SourceGroup`=7434 AND `SourceEntry` IN (9173,9039);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(14,7434,9173,0,0,8,0,9544,0,0,1,0,0,"","Gossip text 9173 requires quest 'The Prophecy of Akida (9544)' not rewarded and"),
(14,7434,9173,0,0,47,0,9663,10,0,0,0,0,"","Gossip text 9173 requires players to have quest 'The Kessel Run' (9663) taken (active)"),
(14,7434,9039,0,1,8,0,9544,0,0,0,0,0,"","Gossip text 9039 requires quest 'The Prophecy of Akida (9544)' rewarded and"),
(14,7434,9039,0,1,47,0,9663,10,0,0,0,0,"","Gossip text 9039 requires players to have quest 'The Kessel Run' (9663) taken (active)");

-- Vindicator Boros gossip menu changes after turning in quest "I Shoot Magic Into the Darkness"
-- Gossip menu
DELETE FROM `gossip_menu` WHERE `MenuID`=7465 AND `TextID`=9076;
INSERT INTO `gossip_menu` (`MenuID`, `TextID`, `VerifiedBuild`) VALUES
(7465,9076,0);

-- Missing Gossip Otions for Vindicator Boros during quest "I Shoot Magic Inte the Darkness"
-- Gossip menu option text
DELETE FROM `gossip_menu_option` WHERE `MenuID`=7465;
INSERT INTO `gossip_menu_option` (`MenuID`, `OptionID`, `OptionIcon`, `OptionText`, `OptionBroadcastTextID`, `OptionType`, `OptionNpcFlag`, `ActionMenuID`, `ActionPoiID`, `BoxCoded`, `BoxMoney`, `BoxText`, `BoxBroadcastTextID`, `VerifiedBuild`) VALUES
(7465,0,0,"Where should I begin my search for the portal?",14503,1,1,7501,0,0,0,"",0,0);

-- Condition
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` IN (14,15) AND `SourceGroup`=7465;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`SourceId`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionTarget`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`NegativeCondition`,`ErrorType`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(14,7465,9076,0,0,8,0,9700,0,0,0,0,0,"","Gossip text 9076 requires quest 'I Shoot Magic Into the Darkness' rewarded"),
(15,7465,0,0,0,47,0,9700,10,0,0,0,0,'','Show gossip menu options only if Quest 9700 is taken (active)');

-- Missing Gossip Otions for Jessera of Mac'Aree during quest "Mac'Aree Mushroom Menagerie"
-- Gossip option text
DELETE FROM `gossip_menu_option` WHERE `MenuID`=7452 AND `OptionID` IN (0,1,2,3);
INSERT INTO `gossip_menu_option` (`MenuID`, `OptionID`, `OptionIcon`, `OptionText`, `OptionBroadcastTextID`, `OptionType`, `OptionNpcFlag`, `ActionMenuID`, `ActionPoiID`, `BoxCoded`, `BoxMoney`, `BoxText`, `BoxBroadcastTextID`, `VerifiedBuild`) VALUES
(7452,0,0,"Jessera, could you direct me towards the aquatic stinkhorn?",14284,1,1,7453,0,0,0,"",0,0),
(7452,1,0,"Jessera, could you direct me towards the ruinous polyspore?",14287,1,1,7454,0,0,0,"",0,0),
(7452,2,0,"Jessera, could you direct me towards the fel cone fungus?",14290,1,1,7456,0,0,0,"",0,0),
(7452,3,0,"Jessera, could you direct me towards the blood mushrooms?",14292,1,1,7457,0,0,0,"",0,0);

-- Conditions
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`= 15 AND `SourceGroup`=7452 AND `SourceEntry` IN (0,1,2,3);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`SourceId`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionTarget`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`NegativeCondition`,`ErrorType`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(15,7452,0,0,0,47,0,9648,10,0,0,0,0,'',"Show gossip menu options only if Quest 9648 is taken (active)"),
(15,7452,1,0,0,47,0,9648,10,0,0,0,0,'',"Show gossip menu options only if Quest 9648 is taken (active)"),
(15,7452,2,0,0,47,0,9648,10,0,0,0,0,'',"Show gossip menu options only if Quest 9648 is taken (active)"),
(15,7452,3,0,0,47,0,9648,10,0,0,0,0,'',"Show gossip menu options only if Quest 9648 is taken (active)");

-- Aqueous's gossip menu text changes after turning in quest "Call of Water" (9508)
DELETE FROM `gossip_menu` WHERE `MenuID`=7417 AND `TextID` IN (8958,9014,9016);
INSERT INTO `gossip_menu` (`MenuID`, `TextID`, `VerifiedBuild`) VALUES
(7417,8958,0),
(7417,9014,0),
(7417,9016,0);

-- Condition
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=14 AND `SourceGroup`=7417 AND `SourceEntry` IN (9014,9015,9016);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(14,7417,9014,0,0,15,0,64,0,0,0,0,0,"","Gossip text 9014 requires players to be a Shaman"),
(14,7417,9015,0,0,8,0,9501,0,0,0,0,0,"","Gossip text 9015 requires quest 'Call of Water' (9501) rewarded"),
(14,7417,9016,0,0,8,0,9508,0,0,0,0,0,"","Gossip text 9016 requires quest 'Call of Water' (9508) rewarded");

-- Vindicator Kuros gossip menu changes after turning in quest "The Cryo-Core"
-- Gossip menu
DELETE FROM `gossip_menu` WHERE `MenuID`=7489 AND `TextID`=9107;
INSERT INTO `gossip_menu` (`MenuID`, `TextID`, `VerifiedBuild`) VALUES
(7489,9107,0);

-- Condition
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=14 AND `SourceGroup`=7489;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(14,7489,9107,0,0,8,0,9703,0,0,0,0,0,"","Gossip text 9107 requires quest 'The Cryo-Core' rewarded");

-- Library Guardian (29724)
DELETE FROM `creature` WHERE `id`=29724 AND `guid` IN (83139,83140,83141,83142,83143);
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`) VALUES
(83139, 29724, 571, 0, 0, 1, 1, 26475, 1, 8058.83, -854.984, 971.823, 0.628318011760711669, 300, 0, 0, 12175, 3893, 0, 0, 0, 0, '', 0),
(83140, 29724, 571, 0, 0, 1, 1, 26475, 1, 8064.08, -831.682, 971.823, 5.427969932556152343, 300, 0, 0, 12175, 3893, 0, 0, 0, 0, '', 0),
(83141, 29724, 571, 0, 0, 1, 1, 26475, 1, 8110.12, -871.216, 957.133, 6.126110076904296875, 300, 0, 0, 12175, 3893, 0, 0, 0, 0, '', 0),
(83142, 29724, 571, 0, 0, 1, 1, 26475, 1, 8117.55, -838.988, 957.313, 6.230820178985595703, 300, 0, 0, 12175, 3893, 0, 0, 0, 0, '', 0),
(83143, 29724, 571, 0, 0, 1, 1, 26475, 1, 8129.377, -859.2718, 955.6569, 6.045253276824951171, 300, 0, 0, 12175, 3893, 2, 0, 0, 0, '', 0);

-- Waypoints
SET @PATH=83143 * 10;
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES
(@PATH, 0, 8087.6626, -849.15497, 970.93066, NULL, 0, 0, 0, 100, 0),
(@PATH, 1, 8088.6396, -849.36865, 970.93066, NULL, 0, 0, 0, 100, 0),
(@PATH, 2, 8091.55, -850.0977, 968.5479, NULL, 0, 0, 0, 100, 0),
(@PATH, 3, 8095.437, -851.04047, 966.1648, NULL, 0, 0, 0, 100, 0),
(@PATH, 4, 8099.324, -851.9832, 963.7824, NULL, 0, 0, 0, 100, 0),
(@PATH, 5, 8103.2114, -852.92596, 961.39984, NULL, 0, 0, 0, 100, 0),
(@PATH, 6, 8107.0986, -853.8687, 959.09894, NULL, 0, 0, 0, 100, 0),
(@PATH, 7, 8110.986, -854.81146, 956.6338, NULL, 0, 0, 0, 100, 0),
(@PATH, 8, 8114.873, -855.7542, 956.57263, NULL, 0, 0, 0, 100, 0),
(@PATH, 9, 8118.7603, -856.69696, 956.595, NULL, 0, 0, 0, 100, 0),
(@PATH, 10, 8122.6475, -857.6397, 956.32056, NULL, 0, 0, 0, 100, 0),
(@PATH, 11, 8126.5347, -858.58246, 955.9371, NULL, 0, 0, 0, 100, 0),
(@PATH, 12, 8130.422, -859.5252, 955.5539, NULL, 0, 0, 0, 100, 0),
(@PATH, 13, 8134.47, -860.507, 955.6393, NULL, 0, 0, 0, 100, 0);

DELETE FROM `creature_addon` WHERE `guid`=83143;
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `MountCreatureID`, `StandState`, `AnimTier`, `VisFlags`, `SheathState`, `PvPFlags`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(83143, @PATH, 9474, 0, 0, 0, 0, 0, 0, 0, 0, NULL);

-- Captured Sunhawk Agent missing dialogue after interrogation
-- Script
UPDATE `smart_scripts` SET `link`=2 WHERE `entryorguid`=17824 AND `id`=1;
DELETE FROM `smart_scripts` WHERE `entryorguid` = 17824 AND `id` IN (2,3);
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`event_param5`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_param4`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(17824,0,2,3,61,0,100,0,0,0,0,0,0,66,0,0,0,0,0,0,7,0,0,0,0,0,0,0,0,"Captured Sunhawk Agent - On Link - Set Orientation Invoker"),
(17824,0,3,0,61,0,100,0,9141,0,0,0,0,1,0,0,0,0,0,0,7,0,0,0,0,0,0,0,0,'Captured Sunhawk Agent - On Link - Say Text 0');

-- Creature text
DELETE FROM `creature_text` WHERE `CreatureID`=17824; 
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(17824,0,0,"Treacherous whelp! Sironas will destroy you and your people!",12,7,100,5,0,0,14637,0,"Captured Sunhawk Agent");

SET @CGUID := 213818;
SET @OGUID := 167035; -- First free guid in master branch
SET @EVENT := 61;

-- Creature templates
UPDATE `creature_template` SET `gossip_menu_id`=11375 WHERE `entry`=40352;
UPDATE `creature_template` SET `flags_extra`=`flags_extra`|0x200 WHERE `entry`=40416;

UPDATE `creature_template_addon` SET `PvpFlags`=1 WHERE `entry`=40204; -- 40204 (Handler Marnlek)
UPDATE `creature_template_addon` SET `PvpFlags`=1 WHERE `entry`=40253; -- 40253 (Champion Uru'zin)
UPDATE `creature_template_addon` SET `emote`=0 WHERE `entry`=40361; -- 40361 (Troll Dance Leader)

DELETE FROM `creature_template_addon` WHERE `entry` IN (40184, 40352);
INSERT INTO `creature_template_addon` (`entry`, `mount`, `StandState`, `AnimTier`, `VisFlags`, `SheathState`, `PvpFlags`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(40184, 0, 0, 0, 0, 0, 1, 0, 0, ''), -- 40184 (Vanira)
(40352, 0, 0, 0, 0, 0, 1, 0, 0, ''); -- 40352 (Witch Doctor Hez'tok)

DELETE FROM `creature_template_movement` WHERE `CreatureId` IN (40176, 40187, 40188, 40218, 40222, 40301, 40387);
INSERT INTO `creature_template_movement` (`CreatureId`, `Ground`, `Swim`, `Flight`, `Rooted`, `Chase`, `Random`, `InteractionPauseTimer`) VALUES
(40176, 1, 0, 0, 0, 0, 2, NULL),
(40187, 0, 0, 1, 1, 0, 0, NULL),
(40188, 1, 0, 0, 0, 0, 2, NULL),
(40218, 0, 0, 1, 0, 0, 0, NULL),
(40222, 2, 0, 0, 0, 0, 0, NULL),
(40301, 0, 0, 1, 0, 0, 0, NULL),
(40387, 0, 0, 1, 0, 0, 0, NULL);

-- Gossips
DELETE FROM `gossip_menu` WHERE (`MenuID`=21257 AND `TextID`=15846);
DELETE FROM `gossip_menu` WHERE (`MenuID`=11375 AND `TextID`=15846);
INSERT INTO `gossip_menu` (`MenuID`, `TextID`, `VerifiedBuild`) VALUES
(11375, 15846, 53788); -- 40352 (Witch Doctor Hez'tok)

-- Misc
DELETE FROM `npc_spellclick_spells` WHERE `npc_entry`=40176;
INSERT INTO `npc_spellclick_spells` (`npc_entry`, `spell_id`, `cast_flags`, `user_type`) VALUES
(40176, 74904, 1, 0);

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=13 AND `SourceEntry` IN (74903, 74977);
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=17 AND `SourceEntry`=74977;
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=15 AND `SourceGroup`=11345;
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=18 AND `SourceGroup`=40176;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(13, 1, 74903, 0, 0, 31, 0, 3, 40187, 0, 0, 0, 0, '', 'Spell "Attune" can only targets Vanira''s Sentry Totem'),
(13, 1, 74977, 0, 0, 31, 0, 3, 40218, 0, 0, 0, 0, '', 'Spell "Frogs Away!" can only targets Spy Frog Credit'),
(17, 0, 74977, 0, 0, 46, 0, 0, 0, 0, 0, 60, 0, '', 'Spell "Frogs Away!" can only be used on taxi'),
(15, 11345, 0, 0, 0, 47, 0, 25446, 10, 0, 0, 0, 0, '', 'Gossip menu option requires quest 25446 taken or completed'),
(15, 11345, 1, 0, 0, 47, 0, 25461, 10, 0, 0, 0, 0, '', 'Gossip menu option requires quest 25461 taken or completed'),
(15, 11345, 2, 0, 0, 47, 0, 25495, 2, 0, 0, 0, 0, '', 'Gossip menu option requires quest 25495 completed'),
(18, 40176, 74904, 0, 0, 2, 0, 53510, 5, 1, 1, 0, 0, '', 'Spellclick "Pickup Sen''jin Frog" requires less than 5 Captured Frog');

DELETE FROM `spell_area` WHERE `spell`=75434 AND `area` IN (367, 393);
UPDATE `spell_area` SET `quest_start_status`=10, `quest_end_status`=10 WHERE `spell`=75434;
UPDATE `spell_area` SET `area`=14, `quest_start_status`=10, `quest_end_status`=10 WHERE `spell`=74982 AND `area`=368;

-- Quests
DELETE FROM `quest_poi` WHERE `QuestID`=25461;
INSERT INTO `quest_poi` (`QuestID`, `id`, `ObjectiveIndex`, `MapID`, `WorldMapAreaId`, `Floor`, `Priority`, `Flags`, `VerifiedBuild`) VALUES
(25461, 0, -1, 1, 4, 0, 0, 1, 0),
(25461, 1, 0, 1, 4, 0, 1, 1, 0),
(25461, 2, 1, 1, 4, 0, 2, 1, 0);

DELETE FROM `quest_poi_points` WHERE `QuestID` IN (25444, 25446, 25461);
INSERT INTO `quest_poi_points` (`QuestID`, `Idx1`, `Idx2`, `X`, `Y`, `VerifiedBuild`) VALUES
(25444, 0, 0, -747, -5004, 53007),
(25444, 1, 0, -736, -5100, 53007),
(25444, 1, 1, -673, -5062, 53007),
(25444, 1, 2, -644, -4999, 53007),
(25444, 1, 3, -673, -4932, 53007),
(25444, 1, 4, -740, -4873, 53007),
(25444, 1, 5, -808, -4831, 53007),
(25444, 1, 6, -892, -4776, 53007),
(25444, 1, 7, -984, -4785, 53007),
(25444, 1, 8, -1014, -4911, 53007),
(25444, 1, 9, -959, -4995, 53007),
(25444, 1, 10, -887, -5062, 53007),
(25444, 1, 11, -808, -5100, 53007),
(25444, 2, 0, -749, -5024, 53007),
(25446, 0, 0, -1062, -5631, 53007),
(25446, 0, 1, -1041, -5585, 53007),
(25446, 0, 2, -1066, -5375, 53007),
(25446, 0, 3, -1189, -5343, 53007),
(25446, 0, 4, -1269, -5386, 53007),
(25446, 0, 5, -1320, -5477, 53007),
(25446, 0, 6, -1322, -5527, 53007),
(25446, 0, 7, -1289, -5571, 53007),
(25446, 0, 8, -1195, -5618, 53007),
(25446, 1, 0, -1532, -5341, 53007),
(25446, 1, 1, -1502, -5263, 53007),
(25446, 1, 2, -1611, -5276, 53007),
(25446, 1, 3, -1589, -5340, 53007),
(25446, 2, 0, -955, -5186, 53007),
(25446, 2, 1, -1020, -5153, 53007),
(25446, 2, 2, -1128, -5131, 53007),
(25446, 2, 3, -1089, -5174, 53007),
(25446, 3, 0, -806, -5674, 53007),
(25446, 3, 1, -730, -5656, 53007),
(25446, 3, 2, -654, -5627, 53007),
(25446, 3, 3, -688, -5518, 53007),
(25446, 3, 4, -732, -5499, 53007),
(25446, 3, 5, -795, -5544, 53007),
(25446, 3, 6, -835, -5606, 53007),
(25446, 4, 0, -747, -5004, 53007),
(25461, 2, 0, -773, -5016, 53788),
(25461, 1, 10, 266, -4830, 53788),
(25461, 1, 9, 246, -4715, 53788),
(25461, 1, 8, 247, -4675, 53788),
(25461, 1, 7, 248, -4673, 53788),
(25461, 1, 6, 284, -4628, 53788),
(25461, 1, 5, 302, -4612, 53788),
(25461, 1, 4, 380, -4661, 53788),
(25461, 1, 3, 411, -4704, 53788),
(25461, 1, 2, 376, -4778, 53788),
(25461, 1, 1, 345, -4831, 53788),
(25461, 1, 0, 343, -4831, 53788),
(25461, 0, 0, -765, -5018, 53788);

DELETE FROM `quest_details` WHERE `ID` IN (25446 /*Frogs Away!*/, 25444 /*Da Perfect Spies*/, 25461 /*Trollin' For Volunteers*/);
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES
(25446, 1, 1, 0, 0, 0, 0, 0, 0, 53788), -- Frogs Away!
(25444, 1, 1, 1, 0, 0, 0, 0, 0, 53788), -- Da Perfect Spies
(25461, 1, 1, 0, 0, 0, 0, 0, 0, 53788); -- Trollin' For Volunteers

DELETE FROM `quest_request_items` WHERE `ID` IN (25446 /*Frogs Away!*/, 25444 /*Da Perfect Spies*/, 25461 /*Trollin' For Volunteers*/);
INSERT INTO `quest_request_items` (`ID`, `EmoteOnComplete`, `EmoteOnIncomplete`, `CompletionText`, `VerifiedBuild`) VALUES
(25446, 0, 1, 'Did ya get those frogs onto de isles?', 53788), -- Frogs Away!
(25444, 0, 1, 'Ya helpin'' with da frogs or not?', 53788), -- Da Perfect Spies
(25461, 0, 1, 'We be needin'' as many volunteers as we can get.', 53788); -- Trollin' For Volunteers

UPDATE `quest_offer_reward` SET `Emote1`=1, `Emote2`=1, `VerifiedBuild`=53788 WHERE `ID`=25446; -- Frogs Away!
UPDATE `quest_offer_reward` SET `Emote1`=1, `Emote2`=1, `VerifiedBuild`=53788 WHERE `ID`=25444; -- Da Perfect Spies
UPDATE `quest_offer_reward` SET `Emote1`=1, `Emote2`=1, `VerifiedBuild`=53788 WHERE `ID`=25461; -- Trollin' For Volunteers

DELETE FROM `game_event_creature_quest` WHERE (`id`=40184 AND `quest` IN (25446,25444)) OR (`id`=40253 AND `quest`=25461);
DELETE FROM `creature_queststarter` WHERE (`id`=40184 AND `quest` IN (25446,25444));
DELETE FROM `creature_queststarter` WHERE (`id`=40253 AND `quest`=25461);
INSERT INTO `creature_queststarter` (`id`, `quest`) VALUES
(40184, 25446), -- Frogs Away! offered by Vanira
(40184, 25444), -- Da Perfect Spies offered by Vanira
(40253, 25461); -- Trollin' For Volunteers offered by Champion Uru'zin

-- SAI
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry` IN (40218, 40253, 40356, 40392);

DELETE FROM `smart_scripts` WHERE `entryorguid` IN (40176, 40188, 40204, 40218, 40253, 40356, 40392, 40416) AND `source_type`=0;
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (4021800, 4025300, 4039200, 4039201, 4039202, 4035600, 4035601, 4035602, 4041600, 4041601) AND `source_type`=9;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(40176,0,0,1,8,0,100,1,74904,0,5000,5000,0,127,0,5000,1,0,0,0,1,0,0,0,0,0,0,0,0,'Sen''jin Frog - On spellhit "Pickup Sen''jin Frog" - Pause movement'),
(40176,0,1,2,61,0,100,0,0,0,0,0,0,11,74905,0,0,0,0,0,7,0,0,0,0,0,0,0,0,'Sen''jin Frog - Event linked - Cast "Pickup Sen''jin Frog" on invoker'),
(40176,0,2,3,61,0,100,0,0,0,0,0,0,66,0,0,0,0,0,0,7,0,0,0,0,0,0,0,0,'Sen''jin Frog - Event linked - Face invoker'),
(40176,0,3,0,61,0,100,0,0,0,0,0,0,41,100,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Sen''jin Frog - Event linked - Despawn'),

(40188,0,0,1,11,0,100,0,0,0,0,0,0,11,31517,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Attuned Frog - On spawn - Cast "Bind Visual Spawn In DND"'),
(40188,0,1,0,61,0,100,0,0,0,0,0,0,89,10,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Attuned Frog - Event linked - Start random movement'),

(40204,0,0,3,62,0,100,0,11345,0,0,0,0,11,74978,2,0,0,0,0,7,0,0,0,0,0,0,0,0,'Handler Marnlek - On gossip option 0 selected - Cast "Echo Isles: Unlearned Spy Frog Taxi"'),
(40204,0,1,3,62,0,100,0,11345,1,0,0,0,11,75421,2,0,0,0,0,7,0,0,0,0,0,0,0,0,'Handler Marnlek - On gossip option 1 selected - Cast "Echo Isles: Unlearned Troll Recruit Taxi"'),
(40204,0,2,3,62,0,100,0,11345,2,0,0,0,11,75422,2,0,0,0,0,7,0,0,0,0,0,0,0,0,'Handler Marnlek - On gossip option 2 selected - Cast "Echo Isles: Unlearned Troll Battle Taxi"'),
(40204,0,3,0,61,0,100,0,0,0,0,0,0,72,0,0,0,0,0,0,7,0,0,0,0,0,0,0,0,'Handler Marnlek - Event linked - Close gossip'),

(40218,0,0,1,8,0,100,1,74977,0,10000,10000,0,33,40218,0,0,0,0,0,7,0,0,0,0,0,0,0,0,'Spy Frog Credit - On spellhit "Frogs Away!" - Kill credit'),
(40218,0,1,0,61,0,100,0,0,0,0,0,0,80,4021800,2,0,0,0,0,1,0,0,0,0,0,0,0,0,'Spy Frog Credit - Event linked - Call timed actionlist'),
(4021800,9,0,0,0,0,100,0,2000,2000,0,0,0,28,74971,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Actionlist - Spy Frog Credit - Remove aura "Red Flare State"'),
(4021800,9,1,0,0,0,100,0,0,0,0,0,0,41,500,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Actionlist - Spy Frog Credit - Despawn'),

(40253,0,0,0,1,0,100,0,0,0,300000,300000,0,80,4025300,2,0,0,0,0,1,0,0,0,0,0,0,0,0,'Champion Uru''zin - Out of combat (5 min) - Call timed actionlist'),
(4025300,9,0,0,0,0,100,0,0,0,0,0,0,40,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Actionlist - Champion Uru''zin - Set sheath state unarmed'),
(4025300,9,1,0,0,0,100,0,2500,2500,0,0,0,1,0,0,1,0,0,0,1,0,0,0,0,0,0,0,0,'Actionlist - Champion Uru''zin - Say line 1'),
(4025300,9,2,0,0,0,100,0,6500,6500,0,0,0,1,1,0,1,0,0,0,1,0,0,0,0,0,0,0,0,'Actionlist - Champion Uru''zin - Say line 2'),
(4025300,9,3,0,0,0,100,0,3250,3250,0,0,0,5,5,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Actionlist - Champion Uru''zin - Play emote'),
(4025300,9,4,0,0,0,100,0,1600,1600,0,0,0,45,1,1,0,0,0,0,11,40392,15,0,0,0,0,0,0,'Actionlist - Champion Uru''zin - Set data 1 1 on Darkspear Warrior'),
(4025300,9,5,0,0,0,100,0,1600,1600,0,0,0,1,2,0,1,0,0,0,1,0,0,0,0,0,0,0,0,'Actionlist - Champion Uru''zin - Say line 3'),
(4025300,9,6,0,0,0,100,0,6500,6500,0,0,0,1,3,0,1,0,0,0,1,0,0,0,0,0,0,0,0,'Actionlist - Champion Uru''zin - Say line 4'),
(4025300,9,7,0,0,0,100,0,6400,6400,0,0,0,1,4,0,1,0,0,0,1,0,0,0,0,0,0,0,0,'Actionlist - Champion Uru''zin - Say line 5'),
(4025300,9,8,0,0,0,100,0,3300,3300,0,0,0,5,273,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Actionlist - Champion Uru''zin - Play emote'),
(4025300,9,9,0,0,0,100,0,4800,4800,0,0,0,5,25,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Actionlist - Champion Uru''zin - Play emote'),
(4025300,9,10,0,0,0,100,0,3200,3200,0,0,0,40,2,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Actionlist - Champion Uru''zin - Set sheath state ranged'),

(40392,0,0,0,38,0,100,0,1,1,0,0,0,88,4039200,4039202,0,0,0,0,1,0,0,0,0,0,0,0,0,'Darkspear Warrior - On data set 1 1 - Call random range actionlist'),
(4039200,9,0,0,0,0,100,0,0,0,0,0,0,5,15,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Actionlist - Darkspear Warrior - Play emote'),
(4039200,9,1,0,0,0,100,0,13000,13000,0,0,0,5,71,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Actionlist - Darkspear Warrior - Play emote'),
(4039200,9,2,0,0,0,100,0,3300,3300,0,0,0,5,71,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Actionlist - Darkspear Warrior - Play emote'),
(4039200,9,3,0,0,0,100,0,4800,4800,0,0,0,5,15,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Actionlist - Darkspear Warrior - Play emote'),
(4039200,9,4,0,0,0,100,0,3200,3200,0,0,0,5,36,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Actionlist - Darkspear Warrior - Play emote'),
(4039201,9,0,0,0,0,100,0,800,800,0,0,0,5,15,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Actionlist - Darkspear Warrior - Play emote'),
(4039201,9,1,0,0,0,100,0,13000,13000,0,0,0,5,71,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Actionlist - Darkspear Warrior - Play emote'),
(4039201,9,2,0,0,0,100,0,3300,3300,0,0,0,5,71,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Actionlist - Darkspear Warrior - Play emote'),
(4039201,9,3,0,0,0,100,0,4800,4800,0,0,0,5,15,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Actionlist - Darkspear Warrior - Play emote'),
(4039201,9,4,0,0,0,100,0,3200,3200,0,0,0,5,36,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Actionlist - Darkspear Warrior - Play emote'),
(4039202,9,0,0,0,0,100,0,1600,1600,0,0,0,5,15,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Actionlist - Darkspear Warrior - Play emote'),
(4039202,9,1,0,0,0,100,0,13000,13000,0,0,0,5,71,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Actionlist - Darkspear Warrior - Play emote'),
(4039202,9,2,0,0,0,100,0,3300,3300,0,0,0,5,71,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Actionlist - Darkspear Warrior - Play emote'),
(4039202,9,3,0,0,0,100,0,4800,4800,0,0,0,5,15,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Actionlist - Darkspear Warrior - Play emote'),
(4039202,9,4,0,0,0,100,0,3200,3200,0,0,0,5,36,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Actionlist - Darkspear Warrior - Play emote'),

(40356,0,0,0,11,0,100,0,0,0,0,0,0,88,4035600,4035602,0,0,0,0,1,0,0,0,0,0,0,0,0,'Ritual Dancer - On spawn - Call random range actionlist'),
(4035600,9,0,0,0,0,100,0,0,0,0,0,0,11,75228,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Actionlist - Ritual Dancer - Cast "Tiki Mask Visual 01"'),
(4035601,9,0,0,0,0,100,0,0,0,0,0,0,11,75229,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Actionlist - Ritual Dancer - Cast "Tiki Mask Visual 02"'),
(4035602,9,0,0,0,0,100,0,0,0,0,0,0,11,75230,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Actionlist - Ritual Dancer - Cast "Tiki Mask Visual 03"'),

(40416,0,0,1,11,0,100,0,0,0,0,0,0,60,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Darkspear Scout - On spawn - Disable gravity'),
(40416,0,1,0,61,0,100,0,0,0,0,0,0,53,1,4041600,0,0,0,0,1,0,0,0,0,0,0,0,0,'Darkspear Scout - Event linked - Start waypoints 1'),
(40416,0,2,0,58,0,100,0,0,4041600,0,0,0,80,4041600,2,0,0,0,0,1,0,0,0,0,0,0,0,0,'Darkspear Scout - On waypoints 1 ended - Call timed actionlist 1'),
(40416,0,3,0,58,0,100,0,0,4041601,0,0,0,80,4041601,2,0,0,0,0,1,0,0,0,0,0,0,0,0,'Darkspear Scout - On waypoints 2 ended - Call timed actionlist 2'),
(40416,0,4,0,58,0,100,0,0,4041602,0,0,0,41,1000,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Darkspear Scout - On waypoints 3 ended - Despawn after 1s'),
(4041600,9,0,0,0,0,100,0,0,0,0,0,0,60,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Actionlist - Darkspear Scout - Enable gravity'),
(4041600,9,1,0,0,0,100,0,0,0,0,0,0,69,1,0,0,0,0,0,8,0,0,0,0,-838.1789,-4989.835,14.905015,0,'Actionlist - Darkspear Scout - Move to position'),
(4041600,9,2,0,0,0,100,0,1600,1600,0,0,0,43,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Actionlist - Darkspear Scout - Dismount'),
(4041600,9,3,0,0,0,100,0,2000,2000,0,0,0,53,1,4041601,0,0,0,0,1,0,0,0,0,0,0,0,0,'Actionlist - Darkspear Scout - Start waypoints 2'),
(4041601,9,0,0,0,0,100,0,200,200,0,0,0,66,0,0,0,0,0,0,8,0,0,0,0,0,0,0,0.820304751396179199,'Actionlist - Darkspear Scout - Set orientation'),
(4041601,9,1,0,0,0,100,0,0,0,0,0,0,40,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Actionlist - Darkspear Scout - Set sheath state unarmed'),
(4041601,9,2,0,0,0,100,0,1200,1200,0,0,0,5,2,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Actionlist - Darkspear Scout - Play emote'),
(4041601,9,3,0,0,0,100,0,3200,3200,0,0,0,1,0,0,1,0,0,0,1,0,0,0,0,0,0,0,0,'Actionlist - Darkspear Scout - Say line 1'),
(4041601,9,4,0,0,0,100,0,6500,6500,0,0,0,1,1,0,1,0,0,0,1,0,0,0,0,0,0,0,0,'Actionlist - Darkspear Scout - Say line 2'),
(4041601,9,5,0,0,0,100,0,10000,10000,0,0,0,1,0,0,0,0,0,0,19,40391,10,0,0,0,0,0,0,'Actionlist - Darkspear Scout - Vol''jin says line 1'),
(4041601,9,6,0,0,0,100,0,3000,3000,0,0,0,5,66,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Actionlist - Darkspear Scout - Play emote'),
(4041601,9,7,0,0,0,100,0,3200,3200,0,0,0,53,0,4041602,0,0,0,0,1,0,0,0,0,0,0,0,0,'Actionlist - Darkspear Scout - Start waypoints 3');

DELETE FROM `creature_text` WHERE `CreatureID` IN (40416, 40253, 40391);
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(40416, 0, 0, 'Zalazane got most of his hexed trolls hidden under de canopy on de big island.', 12, 0, 100, 5, 0, 0, 40411, 0, 'Darkspear Scout'),
(40416, 1, 0, 'He got a big army, an'' he be plannin'' somethin'' down dere.', 12, 0, 100, 1, 0, 0, 40412, 0, 'Darkspear Scout'),
(40391, 0, 0, 'Thank ya, scout. Keep up da patrols. But for now, a rest is in order. Dismissed.', 12, 0, 100, 5, 0, 0, 40413, 0, 'Vol''jin'),
(40253, 0, 0, 'Warriors of de Darkspear Tribe, our leader, de great Vol''jin prepares to reclaim de Echo Isles.', 12, 0, 100, 1, 0, 0, 40404, 0, 'Champion Uru''zin'),
(40253, 1, 0, 'De battle ahead will be de true test of de warrior''s skill, de true test of loyalty.', 12, 0, 100, 1, 0, 0, 40405, 0, 'Champion Uru''zin'),
(40253, 2, 0, 'De spirits of our ancestors will be watchin'' us and aidin'' us in dis battle.', 12, 0, 100, 1, 0, 0, 40408, 0, 'Champion Uru''zin'),
(40253, 3, 0, 'Do dem proud! Show dem your bravery and your ferocity! Bring honor to their spirits!', 12, 0, 100, 25, 0, 0, 40409, 0, 'Champion Uru''zin'),
(40253, 4, 0, 'An'' most of all, we be showin'' Zalazane dat his time be at an end! Dat he will give back what be rightfully ours!', 12, 0, 100, 5, 0, 0, 40410, 0, 'Champion Uru''zin');

DELETE FROM `waypoints` WHERE `entry`=40416;
DELETE FROM `waypoints` WHERE `entry` BETWEEN 4041600 AND 4041602;
INSERT INTO `waypoints` (`entry`, `pointid`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `point_comment`) VALUES
(4041600, 1, -847.34894, -5067.6147, 44.53932, NULL, 0, 'Darkspear Scout - Waypoints 1'),
(4041600, 2, -845.3715, -5046.6772, 36.678055, NULL, 0, 'Darkspear Scout - Waypoints 1'),
(4041600, 3, -842.8768, -5023.0103, 28.066988, NULL, 0, 'Darkspear Scout - Waypoints 1'),
(4041600, 4, -839.65625, -4999.0415, 18.678074, NULL, 0, 'Darkspear Scout - Waypoints 1'),
(4041600, 5, -838.17883, -4989.835, 16.316948, NULL, 0, 'Darkspear Scout - Waypoints 1'),
(4041601, 1, -830.34033, -4997.711, 15.596991, NULL, 0, 'Darkspear Scout - Waypoints 2'), -- Spline
(4041601, 2, -808.0018, -5010.587, 15.288965, NULL, 0, 'Darkspear Scout - Waypoints 2'),
(4041601, 3, -796.17365, -5009.604, 15.994558, NULL, 0, 'Darkspear Scout - Waypoints 2'),
(4041601, 4, -782.4566, -5002.5176, 17.227955, NULL, 0, 'Darkspear Scout - Waypoints 2'),
(4041601, 5, -758.71356, -5001.0884, 19.623611, NULL, 0, 'Darkspear Scout - Waypoints 2'),
(4041602, 1, -763.01044, -4995.0537, 20.094784, NULL, 0, 'Darkspear Scout - Waypoints 3'),
(4041602, 2, -753.53644, -4974.764, 21.784557, NULL, 0, 'Darkspear Scout - Waypoints 3'),
(4041602, 3, -742.8715, -4961.8784, 22.5831, NULL, 0, 'Darkspear Scout - Waypoints 3');

-- Old creature spawns
DELETE FROM `creature` WHERE `guid` BETWEEN 208901 AND 209018;
DELETE FROM `creature_addon` WHERE `guid` BETWEEN 208901 AND 209018;
DELETE FROM `game_event_creature` WHERE `guid` BETWEEN 208901 AND 209018;
DELETE FROM `spawn_group` WHERE `spawnType`=0 AND `spawnId` BETWEEN 208901 AND 209018;

-- Creature spawns
DELETE FROM `creature` WHERE `guid` BETWEEN @CGUID+0 AND @CGUID+154;
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `VerifiedBuild`) VALUES
-- Sen'jin Village
(@CGUID+0, 40184, 1, 14, 367, 1, 1, 0, 1, -747.17535400390625, -5003.97412109375, 19.50520896911621093, 3.769911050796508789, 120, 0, 0, 12600, 3994, 0, 53788), -- Vanira (Area: Sen'jin Village - Difficulty: 0) CreateObject1
(@CGUID+1, 40187, 1, 14, 367, 1, 1, 0, 0, -747.70489501953125, -5007.78125, 18.8993072509765625, 3.385938644409179687, 120, 0, 0, 53, 0, 0, 53788), -- Vanira's Sentry Totem (Area: Sen'jin Village - Difficulty: 0) CreateObject1
(@CGUID+2, 40204, 1, 14, 367, 1, 1, 0, 1, -840.05206298828125, -4982.1630859375, 14.42926979064941406, 4.86946868896484375, 120, 0, 0, 11770, 3809, 0, 53788), -- Handler Marnlek (Area: Sen'jin Village - Difficulty: 0) CreateObject1
(@CGUID+3, 40222, 1, 14, 367, 1, 1, 0, 0, -833.529541015625, -4980.720703125, 16.1929779052734375, 4.293509960174560546, 120, 0, 0, 12600, 0, 0, 53788), -- Scout Bat (Area: Sen'jin Village - Difficulty: 0) CreateObject1
(@CGUID+4, 40253, 1, 14, 367, 1, 1, 0, 1, -765.43231201171875, -5018.3974609375, 17.14230537414550781, 3.735004663467407226, 120, 0, 0, 12600, 3994, 0, 53788), -- Champion Uru'zin (Area: Sen'jin Village - Difficulty: 0) CreateObject1 (Auras: 75075 - [DND] Persuaded, 18950 - Invisibility and Stealth Detection)
(@CGUID+5, 40352, 1, 14, 367, 1, 1, 0, 1, -805.01043701171875, -4975.75, 17.731353759765625, 4.625122547149658203, 120, 0, 0, 12600, 3994, 0, 53788), -- Witch Doctor Hez'tok (Area: Sen'jin Village - Difficulty: 0) CreateObject1
(@CGUID+6, 40356, 1, 14, 367, 1, 1, 0, 0, -810.127685546875, -4981.27001953125, 17.4376068115234375, 5.148721218109130859, 120, 0, 0, 12600, 3994, 0, 53788), -- Ritual Dancer (Area: Sen'jin Village - Difficulty: 0) CreateObject1 (Auras: 75228 - Tiki Mask Visual 01)
(@CGUID+7, 40356, 1, 14, 367, 1, 1, 0, 0, -816.66607666015625, -4987.6337890625, 16.71418952941894531, 5.846852779388427734, 120, 0, 0, 11379, 3725, 0, 53788), -- Ritual Dancer (Area: Sen'jin Village - Difficulty: 0) CreateObject1 (Auras: 75229 - Tiki Mask Visual 02)
(@CGUID+8, 40356, 1, 14, 367, 1, 1, 0, 0, -794.63323974609375, -4987.93408203125, 17.71096420288085937, 3.490658521652221679, 120, 0, 0, 10282, 3466, 0, 53788), -- Ritual Dancer (Area: Sen'jin Village - Difficulty: 0) CreateObject1 (Auras: 75228 - Tiki Mask Visual 01)
(@CGUID+9, 40356, 1, 14, 367, 1, 1, 0, 0, -800.999755859375, -4981.392578125, 17.73172950744628906, 4.276056766510009765, 120, 0, 0, 12175, 3893, 0, 53788), -- Ritual Dancer (Area: Sen'jin Village - Difficulty: 0) CreateObject1 (Auras: 75228 - Tiki Mask Visual 01)
(@CGUID+10, 40356, 1, 14, 367, 1, 1, 0, 0, -801.29620361328125, -5003.42431640625, 16.53342056274414062, 2.216568231582641601, 120, 0, 0, 12600, 3994, 0, 53788), -- Ritual Dancer (Area: Sen'jin Village - Difficulty: 0) CreateObject1 (Auras: 75229 - Tiki Mask Visual 02)
(@CGUID+11, 40356, 1, 14, 367, 1, 1, 0, 0, -794.7557373046875, -4997.056640625, 17.17598724365234375, 3.211405754089355468, 120, 0, 0, 11379, 3725, 0, 53788), -- Ritual Dancer (Area: Sen'jin Village - Difficulty: 0) CreateObject1 (Auras: 75228 - Tiki Mask Visual 01)
(@CGUID+12, 40356, 1, 14, 367, 1, 1, 0, 0, -810.423095703125, -5003.30029296875, 16.23058891296386718, 0.994837641716003417, 120, 0, 0, 10282, 3466, 0, 53788), -- Ritual Dancer (Area: Sen'jin Village - Difficulty: 0) CreateObject1 (Auras: 75229 - Tiki Mask Visual 02)
(@CGUID+13, 40356, 1, 14, 367, 1, 1, 0, 0, -816.789794921875, -4996.76123046875, 16.61115455627441406, 0.349065840244293212, 120, 0, 0, 11379, 3725, 0, 53788), -- Ritual Dancer (Area: Sen'jin Village - Difficulty: 0) CreateObject1 (Auras: 75228 - Tiki Mask Visual 01)
(@CGUID+14, 40361, 1, 14, 367, 1, 1, 0, 0, -805.7860107421875, -4992.45068359375, 17.33248138427734375, 4.363323211669921875, 120, 0, 0, 42, 0, 0, 53788), -- Troll Dance Leader (Area: Sen'jin Village - Difficulty: 0) CreateObject1
(@CGUID+15, 40387, 1, 14, 367, 1, 1, 0, 0, -805.02081298828125, -4975.9375, 17.96628952026367187, 0, 120, 0, 0, 42, 0, 0, 53788), -- Omen Event Credit (Area: Sen'jin Village - Difficulty: 0) CreateObject1
(@CGUID+16, 40391, 1, 14, 367, 1, 1, 0, 1, -755.1475830078125, -4998.0400390625, 20.33691215515136718, 4.031710624694824218, 120, 0, 0, 5578000, 68128, 0, 53788), -- Vol'jin (Area: Sen'jin Village - Difficulty: 0) CreateObject1
(@CGUID+17, 40392, 1, 14, 367, 1, 1, 0, 1, -768.63543701171875, -5023.29541015625, 16.76416778564453125, 0.750491559505462646, 120, 0, 0, 12600, 0, 0, 53788), -- Darkspear Warrior (Area: Sen'jin Village - Difficulty: 0) CreateObject1
(@CGUID+18, 40392, 1, 14, 367, 1, 1, 0, 1, -771.30206298828125, -5021.15966796875, 16.70833396911621093, 0.750491559505462646, 120, 0, 0, 12600, 0, 0, 53788), -- Darkspear Warrior (Area: Sen'jin Village - Difficulty: 0) CreateObject1
(@CGUID+19, 40392, 1, 14, 367, 1, 1, 0, 1, -765.890625, -5025.62158203125, 16.8368072509765625, 0.715584993362426757, 120, 0, 0, 12600, 0, 0, 53788), -- Darkspear Warrior (Area: Sen'jin Village - Difficulty: 0) CreateObject1
(@CGUID+20, 40392, 1, 14, 367, 1, 1, 0, 1, -775.84552001953125, -5021.3505859375, 16.11614990234375, 0.558505356311798095, 120, 0, 0, 12600, 0, 0, 53788), -- Darkspear Warrior (Area: Sen'jin Village - Difficulty: 0) CreateObject1
(@CGUID+21, 40392, 1, 14, 367, 1, 1, 0, 1, -775.15802001953125, -5025.70849609375, 16.1457977294921875, 0.750491559505462646, 120, 0, 0, 12600, 0, 0, 53788), -- Darkspear Warrior (Area: Sen'jin Village - Difficulty: 0) CreateObject1
(@CGUID+22, 40392, 1, 14, 367, 1, 1, 0, 1, -749.078125, -5000.17041015625, 20.16327095031738281, 3.892084121704101562, 120, 0, 0, 12600, 0, 0, 53788), -- Darkspear Warrior (Area: Sen'jin Village - Difficulty: 0) CreateObject1
(@CGUID+23, 40392, 1, 14, 367, 1, 1, 0, 1, -773.82293701171875, -5019.0068359375, 16.52001953125, 0.610865235328674316, 120, 0, 0, 12600, 0, 0, 53788), -- Darkspear Warrior (Area: Sen'jin Village - Difficulty: 0) CreateObject1
(@CGUID+24, 40392, 1, 14, 367, 1, 1, 0, 1, -777.67706298828125, -5023.55908203125, 15.95835494995117187, 0.610865235328674316, 120, 0, 0, 12600, 0, 0, 53788), -- Darkspear Warrior (Area: Sen'jin Village - Difficulty: 0) CreateObject1
(@CGUID+25, 40392, 1, 14, 367, 1, 1, 0, 1, -767.90277099609375, -5027.93408203125, 16.31126785278320312, 0.767944872379302978, 120, 0, 0, 12600, 0, 0, 53788), -- Darkspear Warrior (Area: Sen'jin Village - Difficulty: 0) CreateObject1
(@CGUID+26, 40392, 1, 14, 367, 1, 1, 0, 1, -757.123291015625, -4992.1181640625, 21.01827430725097656, 3.96189737319946289, 120, 0, 0, 12600, 0, 0, 53788), -- Darkspear Warrior (Area: Sen'jin Village - Difficulty: 0) CreateObject1
(@CGUID+27, 40392, 1, 14, 367, 1, 1, 0, 1, -770.64581298828125, -5025.61474609375, 16.2830352783203125, 0.698131680488586425, 120, 0, 0, 12600, 0, 0, 53788), -- Darkspear Warrior (Area: Sen'jin Village - Difficulty: 0) CreateObject1
(@CGUID+28, 40392, 1, 14, 367, 1, 1, 0, 1, -773.326416015625, -5023.50341796875, 16.52063751220703125, 0.733038306236267089, 120, 0, 0, 12600, 0, 0, 53788), -- Darkspear Warrior (Area: Sen'jin Village - Difficulty: 0) CreateObject1
(@CGUID+29, 40392, 1, 14, 367, 1, 1, 0, 1, -763.30902099609375, -5027.79541015625, 16.87847328186035156, 0.733038306236267089, 120, 0, 0, 12600, 0, 0, 53788), -- Darkspear Warrior (Area: Sen'jin Village - Difficulty: 0) CreateObject1
(@CGUID+30, 40392, 1, 14, 367, 1, 1, 0, 1, -767.16839599609375, -5032.35791015625, 16.15991020202636718, 0.733038306236267089, 120, 0, 0, 12600, 0, 0, 53788), -- Darkspear Warrior (Area: Sen'jin Village - Difficulty: 0) CreateObject1
(@CGUID+31, 40392, 1, 14, 367, 1, 1, 0, 1, -765.3125, -5030.111328125, 16.3195953369140625, 0.715584993362426757, 120, 0, 0, 12600, 0, 0, 53788), -- Darkspear Warrior (Area: Sen'jin Village - Difficulty: 0) CreateObject1
(@CGUID+32, 40392, 1, 14, 367, 1, 1, 0, 1, -772.48785400390625, -5027.84375, 16.176177978515625, 0.593411922454833984, 120, 0, 0, 12600, 0, 0, 53788), -- Darkspear Warrior (Area: Sen'jin Village - Difficulty: 0) CreateObject1
(@CGUID+33, 40392, 1, 14, 367, 1, 1, 0, 1, -769.75, -5030.1630859375, 16.01453590393066406, 0.715584993362426757, 120, 0, 0, 12600, 0, 0, 53788), -- Darkspear Warrior (Area: Sen'jin Village - Difficulty: 0) CreateObject1
(@CGUID+34, 40392, 1, 14, 367, 1, 1, 0, 1, -738.1788330078125, -4955.24853515625, 22.87205696105957031, 4.276056766510009765, 120, 0, 0, 12600, 0, 0, 53788), -- Darkspear Warrior (Area: Sen'jin Village - Difficulty: 0) CreateObject1
(@CGUID+35, 40392, 1, 14, 367, 1, 1, 0, 1, -741.29168701171875, -4956.875, 22.8888702392578125, 5.8817596435546875, 120, 0, 0, 12600, 0, 0, 53788), -- Darkspear Warrior (Area: Sen'jin Village - Difficulty: 0) CreateObject1
(@CGUID+36, 40392, 1, 14, 367, 1, 1, 0, 1, -732.2413330078125, -5022.27587890625, 16.8452606201171875, 3.892084121704101562, 120, 0, 0, 12600, 0, 0, 53788), -- Darkspear Warrior (Area: Sen'jin Village - Difficulty: 0) CreateObject1
(@CGUID+37, 40392, 1, 14, 367, 1, 1, 0, 1, -735.36456298828125, -5027.3994140625, 16.46612167358398437, 2.007128715515136718, 120, 0, 0, 12600, 0, 0, 53788), -- Darkspear Warrior (Area: Sen'jin Village - Difficulty: 0) CreateObject1
(@CGUID+38, 40392, 1, 14, 367, 1, 1, 0, 1, -738.25, -4962.16650390625, 22.74147224426269531, 2.094395160675048828, 120, 0, 0, 12600, 0, 0, 53788), -- Darkspear Warrior (Area: Sen'jin Village - Difficulty: 0) CreateObject1
(@CGUID+39, 40416, 1, 14, 393, 1, 1, 0, 1, -861.3819580078125, -5117.953125, 47.46448516845703125, 1.298925042152404785, 120, 0, 0, 12600, 0, 0, 53788), -- Darkspear Scout (Area: Darkspear Strand - Difficulty: 0) CreateObject2
(@CGUID+40, 40176, 1, 14, 367, 1, 1, 0, 0, -761.4913330078125, -4979.48974609375, 21.27761077880859375, 0, 120, 10, 0, 42, 0, 1, 53788), -- Sen'jin Frog (Area: Sen'jin Village - Difficulty: 0) CreateObject2 (Auras: 75433 - Spawn Invisibility Aura (QZS 2)) (possible waypoints or random movement)
(@CGUID+41, 40176, 1, 14, 367, 1, 1, 0, 0, -721.45489501953125, -5041.0693359375, 15.96520614624023437, 0, 120, 10, 0, 42, 0, 1, 53788), -- Sen'jin Frog (Area: Sen'jin Village - Difficulty: 0) CreateObject2 (Auras: 75433 - Spawn Invisibility Aura (QZS 2))
(@CGUID+42, 40176, 1, 14, 367, 1, 1, 0, 0, -746.33856201171875, -4959.142578125, 22.60099029541015625, 0, 120, 10, 0, 42, 0, 1, 53788), -- Sen'jin Frog (Area: Sen'jin Village - Difficulty: 0) CreateObject2 (Auras: 75433 - Spawn Invisibility Aura (QZS 2)) (possible waypoints or random movement)
(@CGUID+43, 40176, 1, 14, 393, 1, 1, 0, 0, -721.44964599609375, -5060.798828125, 14.67235469818115234, 5.276498317718505859, 120, 10, 0, 42, 0, 1, 53788), -- Sen'jin Frog (Area: Darkspear Strand - Difficulty: 0) CreateObject2
(@CGUID+44, 40176, 1, 14, 367, 1, 1, 0, 0, -741.40802001953125, -5049.798828125, 14.89621448516845703, 0, 120, 10, 0, 42, 0, 1, 53788), -- Sen'jin Frog (Area: Sen'jin Village - Difficulty: 0) CreateObject2
(@CGUID+45, 40176, 1, 14, 0, 1, 1, 0, 0, -702.0242919921875, -4936.859375, 24.78557968139648437, 0, 120, 10, 0, 42, 0, 1, 53788), -- Sen'jin Frog (Area: 0 - Difficulty: 0) CreateObject2
(@CGUID+46, 40176, 1, 14, 0, 1, 1, 0, 0, -760.2413330078125, -4883.55224609375, 20.76257896423339843, 0, 120, 10, 0, 42, 0, 1, 53788), -- Sen'jin Frog (Area: 0 - Difficulty: 0) CreateObject2
(@CGUID+47, 40176, 1, 14, 367, 1, 1, 0, 0, -724.5625, -4818.8193359375, 26.28030014038085937, 0, 120, 10, 0, 42, 0, 1, 53788), -- Sen'jin Frog (Area: Sen'jin Village - Difficulty: 0) CreateObject2
(@CGUID+48, 40176, 1, 14, 0, 1, 1, 0, 0, -787.11456298828125, -4886.40087890625, 19.40635871887207031, 0, 120, 10, 0, 42, 0, 1, 53788), -- Sen'jin Frog (Area: 0 - Difficulty: 0) CreateObject2 (Auras: 75433 - Spawn Invisibility Aura (QZS 2)) (possible waypoints or random movement)
(@CGUID+49, 40176, 1, 14, 367, 1, 1, 0, 0, -729.86981201171875, -4891.54150390625, 20.80730819702148437, 0, 120, 10, 0, 42, 0, 1, 53788), -- Sen'jin Frog (Area: Sen'jin Village - Difficulty: 0) CreateObject2
(@CGUID+50, 40176, 1, 14, 367, 1, 1, 0, 0, -821.30206298828125, -4945.25341796875, 21.38181495666503906, 0, 120, 10, 0, 42, 0, 1, 53788), -- Sen'jin Frog (Area: Sen'jin Village - Difficulty: 0) CreateObject2 (Auras: 75433 - Spawn Invisibility Aura (QZS 2)) (possible waypoints or random movement)
(@CGUID+51, 40176, 1, 14, 367, 1, 1, 0, 0, -825.763916015625, -4881.84912109375, 19.6065673828125, 0, 120, 10, 0, 42, 0, 1, 53788), -- Sen'jin Frog (Area: Sen'jin Village - Difficulty: 0) CreateObject2 (Auras: 75433 - Spawn Invisibility Aura (QZS 2)) (possible waypoints or random movement)
(@CGUID+52, 40176, 1, 14, 367, 1, 1, 0, 0, -836.92706298828125, -4913.4462890625, 19.9190216064453125, 0, 120, 10, 0, 42, 0, 1, 53788), -- Sen'jin Frog (Area: Sen'jin Village - Difficulty: 0) CreateObject2
(@CGUID+53, 40176, 1, 14, 367, 1, 1, 0, 0, -748.83856201171875, -4906.57666015625, 21.7292327880859375, 0, 120, 10, 0, 42, 0, 1, 53788), -- Sen'jin Frog (Area: Sen'jin Village - Difficulty: 0) CreateObject2 (Auras: 75433 - Spawn Invisibility Aura (QZS 2)) (possible waypoints or random movement)
(@CGUID+54, 40176, 1, 14, 367, 1, 1, 0, 0, -819.82293701171875, -4899.18212890625, 19.33116531372070312, 0, 120, 10, 0, 42, 0, 1, 53788), -- Sen'jin Frog (Area: Sen'jin Village - Difficulty: 0) CreateObject2
(@CGUID+55, 40176, 1, 14, 367, 1, 1, 0, 0, -755.16839599609375, -4936.03662109375, 21.85312652587890625, 0, 120, 10, 0, 42, 0, 1, 53788), -- Sen'jin Frog (Area: Sen'jin Village - Difficulty: 0) CreateObject2
(@CGUID+56, 40176, 1, 14, 367, 1, 1, 0, 0, -816.50518798828125, -5012.21728515625, 14.52201271057128906, 0, 120, 10, 0, 42, 0, 1, 53788), -- Sen'jin Frog (Area: Sen'jin Village - Difficulty: 0) CreateObject2
(@CGUID+57, 40176, 1, 14, 367, 1, 1, 0, 0, -899.05035400390625, -4994.486328125, 11.61573982238769531, 0, 120, 10, 0, 42, 0, 1, 53788), -- Sen'jin Frog (Area: Sen'jin Village - Difficulty: 0) CreateObject2 (Auras: 75433 - Spawn Invisibility Aura (QZS 2)) (possible waypoints or random movement)
(@CGUID+58, 40176, 1, 14, 367, 1, 1, 0, 0, -802.01739501953125, -5037.51025390625, 10.57736015319824218, 0, 120, 10, 0, 42, 0, 1, 53788), -- Sen'jin Frog (Area: Sen'jin Village - Difficulty: 0) CreateObject2
(@CGUID+59, 40176, 1, 14, 367, 1, 1, 0, 0, -879.2586669921875, -4998.140625, 11.62432479858398437, 0, 120, 10, 0, 42, 0, 1, 53788), -- Sen'jin Frog (Area: Sen'jin Village - Difficulty: 0) CreateObject2 (Auras: 75433 - Spawn Invisibility Aura (QZS 2)) (possible waypoints or random movement)
(@CGUID+60, 40176, 1, 14, 367, 1, 1, 0, 0, -858.81597900390625, -5039.14404296875, 3.009856224060058593, 0, 120, 10, 0, 42, 0, 1, 53788), -- Sen'jin Frog (Area: Sen'jin Village - Difficulty: 0) CreateObject2 (Auras: 75433 - Spawn Invisibility Aura (QZS 2)) (possible waypoints or random movement)
(@CGUID+61, 40176, 1, 14, 367, 1, 1, 0, 0, -862.34027099609375, -4878.53466796875, 20.73167610168457031, 0, 120, 10, 0, 42, 0, 1, 53788), -- Sen'jin Frog (Area: Sen'jin Village - Difficulty: 0) CreateObject2 (Auras: 75433 - Spawn Invisibility Aura (QZS 2)) (possible waypoints or random movement)
(@CGUID+62, 40176, 1, 14, 367, 1, 1, 0, 0, -977.39410400390625, -4935.78466796875, 2.094997167587280273, 0, 120, 10, 0, 42, 0, 1, 53788), -- Sen'jin Frog (Area: Sen'jin Village - Difficulty: 0) CreateObject2
(@CGUID+63, 40176, 1, 14, 367, 1, 1, 0, 0, -886.93927001953125, -4879.79345703125, 11.099761962890625, 0, 120, 10, 0, 42, 0, 1, 53788), -- Sen'jin Frog (Area: Sen'jin Village - Difficulty: 0) CreateObject2
(@CGUID+64, 40176, 1, 14, 367, 1, 1, 0, 0, -902.4132080078125, -4921.45654296875, 15.91738510131835937, 0, 120, 10, 0, 42, 0, 1, 53788), -- Sen'jin Frog (Area: Sen'jin Village - Difficulty: 0) CreateObject2 (Auras: 75433 - Spawn Invisibility Aura (QZS 2)) (possible waypoints or random movement)
(@CGUID+65, 40176, 1, 14, 393, 1, 1, 0, 0, -1056.60595703125, -4785.24462890625, 16.12485313415527343, 0, 120, 10, 0, 42, 0, 1, 53788), -- Sen'jin Frog (Area: Darkspear Strand - Difficulty: 0) CreateObject2
(@CGUID+66, 40176, 1, 14, 393, 1, 1, 0, 0, -1095.2899169921875, -4817.8369140625, 4.299854278564453125, 0, 120, 10, 0, 42, 0, 1, 53788), -- Sen'jin Frog (Area: Darkspear Strand - Difficulty: 0) CreateObject2
(@CGUID+67, 40176, 1, 14, 393, 1, 1, 0, 0, -1043.8385009765625, -4853.01904296875, 10.14375591278076171, 0, 120, 10, 0, 42, 0, 1, 53788), -- Sen'jin Frog (Area: Darkspear Strand - Difficulty: 0) CreateObject2 (Auras: 75433 - Spawn Invisibility Aura (QZS 2)) (possible waypoints or random movement)
(@CGUID+68, 40176, 1, 14, 393, 1, 1, 0, 0, -1046.329833984375, -4874.751953125, 3.680143356323242187, 0, 120, 10, 0, 42, 0, 1, 53788), -- Sen'jin Frog (Area: Darkspear Strand - Difficulty: 0) CreateObject2
(@CGUID+69, 40176, 1, 14, 393, 1, 1, 0, 0, -1019.286376953125, -4867.87158203125, 7.741229534149169921, 0, 120, 10, 0, 42, 0, 1, 53788), -- Sen'jin Frog (Area: Darkspear Strand - Difficulty: 0) CreateObject2 (Auras: 75433 - Spawn Invisibility Aura (QZS 2)) (possible waypoints or random movement)
(@CGUID+70, 40176, 1, 14, 367, 1, 1, 0, 0, -943.03643798828125, -4990.80712890625, 5.739674568176269531, 0, 120, 10, 0, 42, 0, 1, 53788), -- Sen'jin Frog (Area: Sen'jin Village - Difficulty: 0) CreateObject2 (Auras: 75433 - Spawn Invisibility Aura (QZS 2)) (possible waypoints or random movement)
(@CGUID+71, 40176, 1, 14, 393, 1, 1, 0, 0, -944.935791015625, -4976.017578125, 7.39838266372680664, 0, 120, 10, 0, 42, 0, 1, 53788), -- Sen'jin Frog (Area: Darkspear Strand - Difficulty: 0) CreateObject2 (Auras: 75433 - Spawn Invisibility Aura (QZS 2)) (possible waypoints or random movement)
(@CGUID+72, 40176, 1, 14, 367, 1, 1, 0, 0, -980.50518798828125, -4858.24853515625, 12.1892242431640625, 0, 120, 10, 0, 42, 0, 1, 53788), -- Sen'jin Frog (Area: Sen'jin Village - Difficulty: 0) CreateObject2
(@CGUID+73, 40176, 1, 14, 393, 1, 1, 0, 0, -924.55035400390625, -4933.63916015625, 15.40508174896240234, 0, 120, 10, 0, 42, 0, 1, 53788), -- Sen'jin Frog (Area: Darkspear Strand - Difficulty: 0) CreateObject2
(@CGUID+74, 40176, 1, 14, 367, 1, 1, 0, 0, -975.32464599609375, -4958.41845703125, 2.663735151290893554, 0, 120, 10, 0, 42, 0, 1, 53788), -- Sen'jin Frog (Area: Sen'jin Village - Difficulty: 0) CreateObject2 (Auras: 75433 - Spawn Invisibility Aura (QZS 2))
(@CGUID+75, 40176, 1, 14, 393, 1, 1, 0, 0, -924.904541015625, -4912.98974609375, 14.60846614837646484, 0, 120, 10, 0, 42, 0, 1, 53788), -- Sen'jin Frog (Area: Darkspear Strand - Difficulty: 0) CreateObject2
(@CGUID+76, 40176, 1, 14, 367, 1, 1, 0, 0, -928.42364501953125, -4984.96875, 9.577900886535644531, 3.3780059814453125, 120, 10, 0, 42, 0, 1, 53788), -- Sen'jin Frog (Area: Sen'jin Village - Difficulty: 0) CreateObject2
(@CGUID+77, 40176, 1, 14, 393, 1, 1, 0, 0, -899.7882080078125, -5010.37158203125, 6.849414348602294921, 0, 120, 10, 0, 42, 0, 1, 53788), -- Sen'jin Frog (Area: Darkspear Strand - Difficulty: 0) CreateObject2 (Auras: 75433 - Spawn Invisibility Aura (QZS 2)) (possible waypoints or random movement)
(@CGUID+78, 40176, 1, 14, 367, 1, 1, 0, 0, -790.77081298828125, -5014.88916015625, 15.7722930908203125, 0, 120, 10, 0, 42, 0, 1, 53788), -- Sen'jin Frog (Area: Sen'jin Village - Difficulty: 0) CreateObject2
(@CGUID+79, 40176, 1, 14, 393, 1, 1, 0, 0, -689.66143798828125, -5107.501953125, 4.891781330108642578, 0, 120, 10, 0, 42, 0, 1, 53788), -- Sen'jin Frog (Area: Darkspear Strand - Difficulty: 0) CreateObject2
(@CGUID+80, 40176, 1, 14, 393, 1, 1, 0, 0, -706.873291015625, -5089.25341796875, 10.18779563903808593, 0, 120, 10, 0, 42, 0, 1, 53788), -- Sen'jin Frog (Area: Darkspear Strand - Difficulty: 0) CreateObject2
(@CGUID+81, 40176, 1, 14, 0, 1, 1, 0, 0, -707.09552001953125, -4877.09033203125, 24.10580253601074218, 2.177077293395996093, 120, 10, 0, 42, 0, 1, 53788), -- Sen'jin Frog (Area: 0 - Difficulty: 0) CreateObject2
(@CGUID+82, 40176, 1, 14, 393, 1, 1, 0, 0, -1101.3055419921875, -4749.20654296875, 9.48058319091796875, 0, 120, 10, 0, 42, 0, 1, 53788), -- Sen'jin Frog (Area: Darkspear Strand - Difficulty: 0) CreateObject2
(@CGUID+83, 40176, 1, 14, 393, 1, 1, 0, 0, -1088.6597900390625, -4744.001953125, 14.55965614318847656, 0, 120, 10, 0, 42, 0, 1, 53788), -- Sen'jin Frog (Area: Darkspear Strand - Difficulty: 0) CreateObject2
(@CGUID+84, 40176, 1, 14, 393, 1, 1, 0, 0, -1097.9583740234375, -4722.8662109375, 11.66373538970947265, 0, 120, 10, 0, 42, 0, 1, 53788), -- Sen'jin Frog (Area: Darkspear Strand - Difficulty: 0) CreateObject2
-- Echo Isles
(@CGUID+85, 40301, 1, 14, 368, 1, 1, 0, 0, -1122.29345703125, -5126.54345703125, 2.912185192108154296, 0.767944872379302978, 120, 0, 0, 42, 0, 0, 53788), -- Tiger Matriarch Credit (Area: Echo Isles - Difficulty: 0) CreateObject1
(@CGUID+86, 40218, 1, 14, 368, 1, 1, 0, 0, -954.8211669921875, -5186.23779296875, 1.090953350067138671, 0, 30, 0, 0, 42, 0, 0, 53788), -- Spy Frog Credit (Area: Echo Isles - Difficulty: 0) CreateObject1 (Auras: 74980 - Spy Frog Invisibility, 74971 - Red Flare State)
(@CGUID+87, 40218, 1, 14, 368, 1, 1, 0, 0, -853.24481201171875, -5335.12841796875, 2.751948356628417968, 0, 30, 0, 0, 42, 0, 0, 53788), -- Spy Frog Credit (Area: Echo Isles - Difficulty: 0) CreateObject1 (Auras: 74980 - Spy Frog Invisibility, 74971 - Red Flare State)
(@CGUID+88, 40218, 1, 14, 367, 1, 1, 0, 0, -794.69964599609375, -5350.50537109375, 2.743489265441894531, 0, 30, 0, 0, 42, 0, 0, 53788), -- Spy Frog Credit (Area: Sen'jin Village - Difficulty: 0) CreateObject1 (Auras: 74980 - Spy Frog Invisibility, 74971 - Red Flare State)
(@CGUID+89, 40218, 1, 14, 368, 1, 1, 0, 0, -688.09552001953125, -5517.6875, 6.003633499145507812, 0, 30, 0, 0, 42, 0, 0, 53788), -- Spy Frog Credit (Area: Echo Isles - Difficulty: 0) CreateObject1 (Auras: 74980 - Spy Frog Invisibility, 74971 - Red Flare State)
(@CGUID+90, 40218, 1, 14, 368, 1, 1, 0, 0, -732.17706298828125, -5498.767578125, 5.773289680480957031, 0, 30, 0, 0, 42, 0, 0, 53788), -- Spy Frog Credit (Area: Echo Isles - Difficulty: 0) CreateObject1 (Auras: 74980 - Spy Frog Invisibility, 74971 - Red Flare State)
(@CGUID+91, 40218, 1, 14, 368, 1, 1, 0, 0, -794.59552001953125, -5544.4619140625, 5.39234161376953125, 0, 30, 0, 0, 42, 0, 0, 53788), -- Spy Frog Credit (Area: Echo Isles - Difficulty: 0) CreateObject1 (Auras: 74980 - Spy Frog Invisibility, 74971 - Red Flare State)
(@CGUID+92, 40218, 1, 14, 368, 1, 1, 0, 0, -654.15625, -5626.69970703125, 7.23921060562133789, 0, 30, 0, 0, 42, 0, 0, 53788), -- Spy Frog Credit (Area: Echo Isles - Difficulty: 0) CreateObject1
(@CGUID+93, 40218, 1, 14, 368, 1, 1, 0, 0, -729.59722900390625, -5655.970703125, 20.00365638732910156, 0, 30, 0, 0, 42, 0, 0, 53788), -- Spy Frog Credit (Area: Echo Isles - Difficulty: 0) CreateObject1 (Auras: 74980 - Spy Frog Invisibility, 74971 - Red Flare State)
(@CGUID+94, 40218, 1, 14, 368, 1, 1, 0, 0, -805.80731201171875, -5674.3837890625, 6.655506610870361328, 0, 30, 0, 0, 42, 0, 0, 53788), -- Spy Frog Credit (Area: Echo Isles - Difficulty: 0) CreateObject1
(@CGUID+95, 40218, 1, 14, 368, 1, 1, 0, 0, -835.0711669921875, -5606.0380859375, 4.204616546630859375, 0, 30, 0, 0, 42, 0, 0, 53788), -- Spy Frog Credit (Area: Echo Isles - Difficulty: 0) CreateObject1 (Auras: 74980 - Spy Frog Invisibility, 74971 - Red Flare State)
(@CGUID+96, 40218, 1, 14, 368, 1, 1, 0, 0, -1061.529541015625, -5631.46337890625, 4.56439065933227539, 0, 30, 0, 0, 42, 0, 0, 53788), -- Spy Frog Credit (Area: Echo Isles - Difficulty: 0) CreateObject1
(@CGUID+97, 40218, 1, 14, 368, 1, 1, 0, 0, -1040.7882080078125, -5585.18603515625, 3.462282180786132812, 0, 30, 0, 0, 42, 0, 0, 53788), -- Spy Frog Credit (Area: Echo Isles - Difficulty: 0) CreateObject1 (Auras: 74980 - Spy Frog Invisibility, 74971 - Red Flare State)
(@CGUID+98, 40218, 1, 14, 368, 1, 1, 0, 0, -1123.2882080078125, -5619.78125, 5.644940376281738281, 0, 30, 0, 0, 42, 0, 0, 53788), -- Spy Frog Credit (Area: Echo Isles - Difficulty: 0) CreateObject1 (Auras: 74980 - Spy Frog Invisibility, 74971 - Red Flare State)
(@CGUID+99, 40218, 1, 14, 368, 1, 1, 0, 0, -1049.91845703125, -5542.5068359375, 7.805533409118652343, 0, 30, 0, 0, 42, 0, 0, 53788), -- Spy Frog Credit (Area: Echo Isles - Difficulty: 0) CreateObject1 (Auras: 74980 - Spy Frog Invisibility, 74971 - Red Flare State)
(@CGUID+100, 40218, 1, 14, 368, 1, 1, 0, 0, -1194.8160400390625, -5617.876953125, 6.845169544219970703, 0, 30, 0, 0, 42, 0, 0, 53788), -- Spy Frog Credit (Area: Echo Isles - Difficulty: 0) CreateObject1 (Auras: 74980 - Spy Frog Invisibility, 74971 - Red Flare State)
(@CGUID+101, 40218, 1, 14, 368, 1, 1, 0, 0, -1240.3785400390625, -5594.70849609375, 8.538580894470214843, 0, 30, 0, 0, 42, 0, 0, 53788), -- Spy Frog Credit (Area: Echo Isles - Difficulty: 0) CreateObject1 (Auras: 74980 - Spy Frog Invisibility, 74971 - Red Flare State)
(@CGUID+102, 40218, 1, 14, 368, 1, 1, 0, 0, -1129.8316650390625, -5481.1494140625, 7.601991653442382812, 0, 30, 0, 0, 42, 0, 0, 53788), -- Spy Frog Credit (Area: Echo Isles - Difficulty: 0) CreateObject1 (Auras: 74980 - Spy Frog Invisibility, 74971 - Red Flare State)
(@CGUID+103, 40218, 1, 14, 368, 1, 1, 0, 0, -1288.6024169921875, -5571.11474609375, 7.435792446136474609, 0, 30, 0, 0, 42, 0, 0, 53788), -- Spy Frog Credit (Area: Echo Isles - Difficulty: 0) CreateObject1
(@CGUID+104, 40218, 1, 14, 368, 1, 1, 0, 0, -1321.611083984375, -5527.359375, 4.558995723724365234, 0, 30, 0, 0, 42, 0, 0, 53788), -- Spy Frog Credit (Area: Echo Isles - Difficulty: 0) CreateObject1 (Auras: 74980 - Spy Frog Invisibility, 74971 - Red Flare State)
(@CGUID+105, 40218, 1, 14, 368, 1, 1, 0, 0, -1319.65625, -5477.3349609375, 5.189212322235107421, 0, 30, 0, 0, 42, 0, 0, 53788), -- Spy Frog Credit (Area: Echo Isles - Difficulty: 0) CreateObject1 (Auras: 74980 - Spy Frog Invisibility, 74971 - Red Flare State)
(@CGUID+106, 40218, 1, 14, 368, 1, 1, 0, 0, -1269.0521240234375, -5386.2412109375, 4.37299966812133789, 0, 30, 0, 0, 42, 0, 0, 53788), -- Spy Frog Credit (Area: Echo Isles - Difficulty: 0) CreateObject1 (Auras: 74980 - Spy Frog Invisibility, 74971 - Red Flare State)
(@CGUID+107, 40218, 1, 14, 368, 1, 1, 0, 0, -1532.3072509765625, -5340.73779296875, 7.001649379730224609, 0, 30, 0, 0, 42, 0, 0, 53788), -- Spy Frog Credit (Area: Echo Isles - Difficulty: 0) CreateObject1 (Auras: 74980 - Spy Frog Invisibility, 74971 - Red Flare State)
(@CGUID+108, 40218, 1, 14, 368, 1, 1, 0, 0, -1589.217041015625, -5340.08154296875, 7.069466590881347656, 0, 30, 0, 0, 42, 0, 0, 53788), -- Spy Frog Credit (Area: Echo Isles - Difficulty: 0) CreateObject1
(@CGUID+109, 40218, 1, 14, 368, 1, 1, 0, 0, -1502.296875, -5262.67724609375, 4.592952728271484375, 0, 30, 0, 0, 42, 0, 0, 53788), -- Spy Frog Credit (Area: Echo Isles - Difficulty: 0) CreateObject1 (Auras: 74980 - Spy Frog Invisibility, 74971 - Red Flare State)
(@CGUID+110, 40218, 1, 14, 368, 1, 1, 0, 0, -1611.142333984375, -5275.97900390625, 7.616913318634033203, 0, 30, 0, 0, 42, 0, 0, 53788), -- Spy Frog Credit (Area: Echo Isles - Difficulty: 0) CreateObject1
(@CGUID+111, 40218, 1, 14, 368, 1, 1, 0, 0, -1423.26220703125, -5171.40478515625, 3.539060354232788085, 0, 30, 0, 0, 42, 0, 0, 53788), -- Spy Frog Credit (Area: Echo Isles - Difficulty: 0) CreateObject1
(@CGUID+112, 40218, 1, 14, 368, 1, 1, 0, 0, -1304.359375, -5169.80029296875, 0.850009322166442871, 0, 30, 0, 0, 42, 0, 0, 53788), -- Spy Frog Credit (Area: Echo Isles - Difficulty: 0) CreateObject1 (Auras: 74980 - Spy Frog Invisibility, 74971 - Red Flare State)
(@CGUID+113, 40218, 1, 14, 368, 1, 1, 0, 0, -1290.5260009765625, -5122.4306640625, 1.761084318161010742, 0, 30, 0, 0, 42, 0, 0, 53788), -- Spy Frog Credit (Area: Echo Isles - Difficulty: 0) CreateObject1
(@CGUID+114, 40218, 1, 14, 368, 1, 1, 0, 0, -1127.7691650390625, -5131.19970703125, 2.938694238662719726, 0, 30, 0, 0, 42, 0, 0, 53788), -- Spy Frog Credit (Area: Echo Isles - Difficulty: 0) CreateObject1 (Auras: 74980 - Spy Frog Invisibility, 74971 - Red Flare State)
(@CGUID+115, 40218, 1, 14, 368, 1, 1, 0, 0, -1088.9635009765625, -5173.8837890625, 0.833697319030761718, 0, 30, 0, 0, 42, 0, 0, 53788), -- Spy Frog Credit (Area: Echo Isles - Difficulty: 0) CreateObject1
(@CGUID+116, 40218, 1, 14, 368, 1, 1, 0, 0, -1188.8177490234375, -5342.517578125, 4.285264492034912109, 0, 30, 0, 0, 42, 0, 0, 53788), -- Spy Frog Credit (Area: Echo Isles - Difficulty: 0) CreateObject1 (Auras: 74980 - Spy Frog Invisibility, 74971 - Red Flare State)
(@CGUID+117, 40218, 1, 14, 368, 1, 1, 0, 0, -1020.20831298828125, -5152.767578125, 0.750920295715332031, 0, 30, 0, 0, 42, 0, 0, 53788), -- Spy Frog Credit (Area: Echo Isles - Difficulty: 0) CreateObject1
(@CGUID+118, 40218, 1, 14, 368, 1, 1, 0, 0, -1066.361083984375, -5374.91650390625, 6.872701644897460937, 0, 30, 0, 0, 42, 0, 0, 53788), -- Spy Frog Credit (Area: Echo Isles - Difficulty: 0) CreateObject1 (Auras: 74980 - Spy Frog Invisibility, 74971 - Red Flare State)
(@CGUID+119, 40218, 1, 14, 368, 1, 1, 0, 0, -1201.6041259765625, -5379.16845703125, 8.589357376098632812, 0, 30, 0, 0, 42, 0, 0, 53788), -- Spy Frog Credit (Area: Echo Isles - Difficulty: 0) CreateObject1 (Auras: 74980 - Spy Frog Invisibility, 74971 - Red Flare State)
(@CGUID+120, 40218, 1, 14, 368, 1, 1, 0, 0, -1148.4254150390625, -5413.82275390625, 9.589723587036132812, 0, 30, 0, 0, 42, 0, 0, 53788), -- Spy Frog Credit (Area: Echo Isles - Difficulty: 0) CreateObject1 (Auras: 74980 - Spy Frog Invisibility, 74971 - Red Flare State)
(@CGUID+121, 40218, 1, 14, 368, 1, 1, 0, 0, -1102.048583984375, -5435.26416015625, 10.6309661865234375, 0, 30, 0, 0, 42, 0, 0, 53788), -- Spy Frog Credit (Area: Echo Isles - Difficulty: 0) CreateObject1 (Auras: 74980 - Spy Frog Invisibility, 74971 - Red Flare State)
(@CGUID+122, 40218, 1, 14, 368, 1, 1, 0, 0, -1060.920166015625, -5459.61962890625, 8.204561233520507812, 0, 30, 0, 0, 42, 0, 0, 53788), -- Spy Frog Credit (Area: Echo Isles - Difficulty: 0) CreateObject1 (Auras: 74980 - Spy Frog Invisibility, 74971 - Red Flare State)
-- Razor Hill
(@CGUID+123, 40256, 1, 14, 362, 1, 1, 0, 0, 271.295135498046875, -4739.45849609375, 9.899149894714355468, 5.79449319839477539, 120, 0, 0, 42, 0, 0, 53788), -- Troll Citizen (Area: 0 - Difficulty: 0) CreateObject1 (Auras: 73940 - Citizen Costume)
(@CGUID+124, 40256, 1, 14, 362, 1, 1, 0, 0, 248.001739501953125, -4672.84033203125, 16.01275634765625, 5.410520553588867187, 120, 0, 0, 42, 0, 0, 53788), -- Troll Citizen (Area: 0 - Difficulty: 0) CreateObject1 (Auras: 73940 - Citizen Costume)
(@CGUID+125, 40256, 1, 14, 362, 1, 1, 0, 0, 246.5208282470703125, -4717.0087890625, 15.29293155670166015, 1.535889744758605957, 120, 0, 0, 42, 0, 0, 53788), -- Troll Citizen (Area: 0 - Difficulty: 0) CreateObject1 (Auras: 73940 - Citizen Costume)
(@CGUID+126, 40256, 1, 14, 362, 1, 1, 0, 0, 254.9496612548828125, -4698.4130859375, 14.71032047271728515, 2.722713708877563476, 120, 0, 0, 42, 0, 0, 53788), -- Troll Citizen (Area: 0 - Difficulty: 0) CreateObject1 (Auras: 73940 - Citizen Costume)
(@CGUID+127, 40256, 1, 14, 362, 1, 1, 0, 0, 289.44964599609375, -4820.142578125, 10.60737133026123046, 0.959931075572967529, 120, 0, 0, 42, 0, 0, 53788), -- Troll Citizen (Area: Razor Hill - Difficulty: 0) CreateObject1 (Auras: 73940 - Citizen Costume)
(@CGUID+128, 40256, 1, 14, 362, 1, 1, 0, 0, 266.07464599609375, -4829.90283203125, 10.90517807006835937, 0.331612557172775268, 120, 0, 0, 42, 0, 0, 53788), -- Troll Citizen (Area: Razor Hill - Difficulty: 0) CreateObject1 (Auras: 73940 - Citizen Costume)
(@CGUID+129, 40256, 1, 14, 362, 1, 1, 0, 0, 310.90625, -4672.18603515625, 16.5634002685546875, 2.478367567062377929, 120, 0, 0, 42, 0, 0, 53788), -- Troll Citizen (Area: Razor Hill - Difficulty: 0) CreateObject1 (Auras: 73940 - Citizen Costume)
(@CGUID+130, 40256, 1, 14, 362, 1, 1, 0, 0, 347.310760498046875, -4723.87841796875, 10.32458209991455078, 4.939281940460205078, 120, 0, 0, 42, 0, 0, 53788), -- Troll Citizen (Area: Razor Hill - Difficulty: 0) CreateObject1 (Auras: 73940 - Citizen Costume)
(@CGUID+131, 40256, 1, 14, 362, 1, 1, 0, 0, 351.6788330078125, -4693.84033203125, 16.54110336303710937, 2.251474618911743164, 120, 0, 0, 42, 0, 0, 53788), -- Troll Citizen (Area: Razor Hill - Difficulty: 0) CreateObject1 (Auras: 73940 - Citizen Costume)
(@CGUID+132, 40256, 1, 14, 362, 1, 1, 0, 0, 343.736114501953125, -4791.71533203125, 11.36291027069091796, 0.959931075572967529, 120, 0, 0, 42, 0, 0, 53788), -- Troll Citizen (Area: Razor Hill - Difficulty: 0) CreateObject1 (Auras: 73940 - Citizen Costume)
(@CGUID+133, 40256, 1, 14, 362, 1, 1, 0, 0, 369.435760498046875, -4690.94970703125, 15.85660266876220703, 5.393067359924316406, 120, 0, 0, 42, 0, 0, 53788), -- Troll Citizen (Area: Razor Hill - Difficulty: 0) CreateObject1 (Auras: 73940 - Citizen Costume)
(@CGUID+134, 40256, 1, 14, 362, 1, 1, 0, 0, 375.814239501953125, -4775.57666015625, 12.50812625885009765, 5.759586334228515625, 120, 0, 0, 42, 0, 0, 53788), -- Troll Citizen (Area: Razor Hill - Difficulty: 0) CreateObject1 (Auras: 73940 - Citizen Costume)
(@CGUID+135, 40256, 1, 14, 362, 1, 1, 0, 0, 375.765625, -4777.9462890625, 12.52974224090576171, 0.767944872379302978, 120, 0, 0, 42, 0, 0, 53788), -- Troll Citizen (Area: Razor Hill - Difficulty: 0) CreateObject1 (Auras: 73940 - Citizen Costume)
(@CGUID+136, 40256, 1, 14, 362, 1, 1, 0, 0, 333.508697509765625, -4815.27099609375, 10.60719776153564453, 2.827433347702026367, 120, 0, 0, 42, 0, 0, 53788), -- Troll Citizen (Area: Razor Hill - Difficulty: 0) CreateObject1 (Auras: 73940 - Citizen Costume)
(@CGUID+137, 40256, 1, 14, 362, 1, 1, 0, 0, 343.204864501953125, -4831.05712890625, 10.19747829437255859, 0.244346097111701965, 120, 0, 0, 42, 0, 0, 53788), -- Troll Citizen (Area: Razor Hill - Difficulty: 0) CreateObject1 (Auras: 73940 - Citizen Costume)
(@CGUID+138, 40256, 1, 14, 362, 1, 1, 0, 0, 345.03125, -4831.41162109375, 10.30186080932617187, 2.600540637969970703, 120, 0, 0, 42, 0, 0, 53788), -- Troll Citizen (Area: Razor Hill - Difficulty: 0) CreateObject1
(@CGUID+139, 40257, 1, 14, 362, 1, 1, 0, 0, 273.432281494140625, -4738.96337890625, 9.832179069519042968, 3.735004663467407226, 120, 0, 0, 42, 0, 0, 53788), -- Troll Citizen (Area: Razor Hill - Difficulty: 0) CreateObject2
(@CGUID+140, 40257, 1, 14, 362, 1, 1, 0, 0, 321.611114501953125, -4640.15478515625, 16.68959426879882812, 3.490658521652221679, 120, 0, 0, 42, 0, 0, 53788), -- Troll Citizen (Area: Razor Hill - Difficulty: 0) CreateObject1 (Auras: 73939 - Citizen Costume)
(@CGUID+141, 40257, 1, 14, 362, 1, 1, 0, 0, 246.170135498046875, -4714.72900390625, 15.37176799774169921, 5.654866695404052734, 120, 0, 0, 42, 0, 0, 53788), -- Troll Citizen (Area: 0 - Difficulty: 0) CreateObject1 (Auras: 73939 - Citizen Costume)
(@CGUID+142, 40257, 1, 14, 362, 1, 1, 0, 0, 247.421875, -4675.2724609375, 16.19962692260742187, 0.296705961227416992, 120, 0, 0, 42, 0, 0, 53788), -- Troll Citizen (Area: 0 - Difficulty: 0) CreateObject1 (Auras: 73939 - Citizen Costume)
(@CGUID+143, 40257, 1, 14, 362, 1, 1, 0, 0, 349.482635498046875, -4724.8818359375, 10.32458209991455078, 3.124139308929443359, 120, 0, 0, 42, 0, 0, 53788), -- Troll Citizen (Area: Razor Hill - Difficulty: 0) CreateObject1 (Auras: 73939 - Citizen Costume)
(@CGUID+144, 40257, 1, 14, 362, 1, 1, 0, 0, 284.388885498046875, -4628.46728515625, 18.7369537353515625, 4.886921882629394531, 120, 0, 0, 42, 0, 0, 53788), -- Troll Citizen (Area: Razor Hill - Difficulty: 0) CreateObject1 (Auras: 73939 - Citizen Costume)
(@CGUID+145, 40257, 1, 14, 362, 1, 1, 0, 0, 338.173614501953125, -4669.6943359375, 16.54110336303710937, 4.712388992309570312, 120, 0, 0, 42, 0, 0, 53788), -- Troll Citizen (Area: Razor Hill - Difficulty: 0) CreateObject1 (Auras: 73939 - Citizen Costume)
(@CGUID+146, 40257, 1, 14, 362, 1, 1, 0, 0, 282.758697509765625, -4629.548828125, 18.29562568664550781, 0.226892799139022827, 120, 0, 0, 42, 0, 0, 53788), -- Troll Citizen (Area: Razor Hill - Difficulty: 0) CreateObject1 (Auras: 73939 - Citizen Costume)
(@CGUID+147, 40257, 1, 14, 362, 1, 1, 0, 0, 343.364593505859375, -4789.48779296875, 11.72961139678955078, 6.091198921203613281, 120, 0, 0, 42, 0, 0, 53788), -- Troll Citizen (Area: Razor Hill - Difficulty: 0) CreateObject1 (Auras: 73939 - Citizen Costume)
(@CGUID+148, 40257, 1, 14, 362, 1, 1, 0, 0, 301.664947509765625, -4612.20654296875, 28.02319908142089843, 0.959931075572967529, 120, 0, 0, 42, 0, 0, 53788), -- Troll Citizen (Area: Razor Hill - Difficulty: 0) CreateObject1 (Auras: 73939 - Citizen Costume)
(@CGUID+149, 40257, 1, 14, 362, 1, 1, 0, 0, 379.7257080078125, -4661.29345703125, 16.13381767272949218, 4.415682792663574218, 120, 0, 0, 42, 0, 0, 53788), -- Troll Citizen (Area: Razor Hill - Difficulty: 0) CreateObject1 (Auras: 73939 - Citizen Costume)
(@CGUID+150, 40257, 1, 14, 362, 1, 1, 0, 0, 411.10589599609375, -4704.45849609375, 9.560571670532226562, 3.822271108627319335, 120, 0, 0, 42, 0, 0, 53788), -- Troll Citizen (Area: Razor Hill - Difficulty: 0) CreateObject1 (Auras: 73939 - Citizen Costume)
(@CGUID+151, 40257, 1, 14, 362, 1, 1, 0, 0, 408.94964599609375, -4703.796875, 9.6985626220703125, 4.607669353485107421, 120, 0, 0, 42, 0, 0, 53788), -- Troll Citizen (Area: Razor Hill - Difficulty: 0) CreateObject1
(@CGUID+152, 40257, 1, 14, 362, 1, 1, 0, 0, 293.423614501953125, -4798.140625, 10.08959388732910156, 2.251474618911743164, 120, 0, 0, 42, 0, 0, 53788), -- Troll Citizen (Area: Razor Hill - Difficulty: 0) CreateObject2 (Auras: 73939 - Citizen Costume)
(@CGUID+153, 40257, 1, 14, 362, 1, 1, 0, 0, 273.35589599609375, -4774.60400390625, 12.17043685913085937, 0.959931075572967529, 120, 0, 0, 42, 0, 0, 53788), -- Troll Citizen (Area: Razor Hill - Difficulty: 0) CreateObject1 (Auras: 73939 - Citizen Costume)
(@CGUID+154, 40257, 1, 14, 362, 1, 1, 0, 0, 319.572906494140625, -4639.40087890625, 16.7221832275390625, 4.991641521453857421, 120, 0, 0, 42, 0, 0, 53788); -- Troll Citizen (Area: Razor Hill - Difficulty: 0) CreateObject1 (Auras: 73939 - Citizen Costume)

DELETE FROM `creature_addon` WHERE `guid` BETWEEN @CGUID+0 AND @CGUID+154;
INSERT INTO `creature_addon` (`guid`, `mount`, `StandState`, `AnimTier`, `VisFlags`, `SheathState`, `PvpFlags`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(@CGUID+34, 0, 0, 0, 0, 0, 0, 0, 0, ''), -- Darkspear Warrior
(@CGUID+35, 0, 0, 0, 0, 0, 0, 0, 0, ''), -- Darkspear Warrior
(@CGUID+36, 0, 1, 0, 0, 1, 0, 0, 0, ''), -- Darkspear Warrior
(@CGUID+37, 0, 0, 0, 0, 0, 0, 0, 0, ''), -- Darkspear Warrior
(@CGUID+38, 0, 1, 0, 0, 1, 0, 0, 0, ''), -- Darkspear Warrior
(@CGUID+126, 0, 1, 0, 0, 1, 0, 0, 0, '73940'), -- Troll Citizen
(@CGUID+127, 0, 1, 0, 0, 1, 0, 0, 0, '73940'), -- Troll Citizen
(@CGUID+128, 0, 1, 0, 0, 1, 0, 0, 0, '73940'), -- Troll Citizen
(@CGUID+129, 0, 1, 0, 0, 1, 0, 0, 0, '73940'), -- Troll Citizen
(@CGUID+131, 0, 1, 0, 0, 1, 0, 0, 0, '73940'), -- Troll Citizen
(@CGUID+133, 0, 1, 0, 0, 1, 0, 0, 0, '73940'), -- Troll Citizen
(@CGUID+136, 0, 1, 0, 0, 1, 0, 0, 0, '73940'), -- Troll Citizen
(@CGUID+145, 0, 1, 0, 0, 1, 0, 0, 0, '73939'), -- Troll Citizen
(@CGUID+148, 0, 1, 0, 0, 1, 0, 0, 0, '73939'), -- Troll Citizen
(@CGUID+149, 0, 1, 0, 0, 1, 0, 0, 0, '73939'), -- Troll Citizen
(@CGUID+152, 0, 1, 0, 0, 1, 0, 0, 0, '73939'), -- Troll Citizen
(@CGUID+153, 0, 1, 0, 0, 1, 0, 0, 0, '73939'); -- Troll Citizen

DELETE FROM `spawn_group` WHERE `spawnType` = 0 AND `spawnId` BETWEEN @CGUID+0 AND @CGUID+154;
INSERT INTO `spawn_group` (`groupId`, `spawnType`, `spawnId`) VALUES
(2, 0, @CGUID+40),
(2, 0, @CGUID+41),
(2, 0, @CGUID+42),
(2, 0, @CGUID+43),
(2, 0, @CGUID+44),
(2, 0, @CGUID+45),
(2, 0, @CGUID+46),
(2, 0, @CGUID+47),
(2, 0, @CGUID+48),
(2, 0, @CGUID+49),
(2, 0, @CGUID+50),
(2, 0, @CGUID+51),
(2, 0, @CGUID+52),
(2, 0, @CGUID+53),
(2, 0, @CGUID+54),
(2, 0, @CGUID+55),
(2, 0, @CGUID+56),
(2, 0, @CGUID+57),
(2, 0, @CGUID+58),
(2, 0, @CGUID+59),
(2, 0, @CGUID+60),
(2, 0, @CGUID+61),
(2, 0, @CGUID+62),
(2, 0, @CGUID+63),
(2, 0, @CGUID+64),
(2, 0, @CGUID+65),
(2, 0, @CGUID+66),
(2, 0, @CGUID+67),
(2, 0, @CGUID+68),
(2, 0, @CGUID+69),
(2, 0, @CGUID+70),
(2, 0, @CGUID+71),
(2, 0, @CGUID+72),
(2, 0, @CGUID+73),
(2, 0, @CGUID+74),
(2, 0, @CGUID+75),
(2, 0, @CGUID+76),
(2, 0, @CGUID+77),
(2, 0, @CGUID+78),
(2, 0, @CGUID+79),
(2, 0, @CGUID+80),
(2, 0, @CGUID+81),
(2, 0, @CGUID+82),
(2, 0, @CGUID+83),
(2, 0, @CGUID+84),
(2, 0, @CGUID+86),
(2, 0, @CGUID+87),
(2, 0, @CGUID+88),
(2, 0, @CGUID+89),
(2, 0, @CGUID+90),
(2, 0, @CGUID+91),
(2, 0, @CGUID+92),
(2, 0, @CGUID+93),
(2, 0, @CGUID+94),
(2, 0, @CGUID+95),
(2, 0, @CGUID+96),
(2, 0, @CGUID+97),
(2, 0, @CGUID+98),
(2, 0, @CGUID+99),
(2, 0, @CGUID+100),
(2, 0, @CGUID+101),
(2, 0, @CGUID+102),
(2, 0, @CGUID+103),
(2, 0, @CGUID+104),
(2, 0, @CGUID+105),
(2, 0, @CGUID+106),
(2, 0, @CGUID+107),
(2, 0, @CGUID+108),
(2, 0, @CGUID+109),
(2, 0, @CGUID+110),
(2, 0, @CGUID+111),
(2, 0, @CGUID+112),
(2, 0, @CGUID+113),
(2, 0, @CGUID+114),
(2, 0, @CGUID+115),
(2, 0, @CGUID+116),
(2, 0, @CGUID+117),
(2, 0, @CGUID+118),
(2, 0, @CGUID+119),
(2, 0, @CGUID+120),
(2, 0, @CGUID+121),
(2, 0, @CGUID+122),
(2, 0, @CGUID+123),
(2, 0, @CGUID+124),
(2, 0, @CGUID+125),
(2, 0, @CGUID+126),
(2, 0, @CGUID+127),
(2, 0, @CGUID+128),
(2, 0, @CGUID+129),
(2, 0, @CGUID+130),
(2, 0, @CGUID+131),
(2, 0, @CGUID+132),
(2, 0, @CGUID+133),
(2, 0, @CGUID+134),
(2, 0, @CGUID+135),
(2, 0, @CGUID+136),
(2, 0, @CGUID+137),
(2, 0, @CGUID+138),
(2, 0, @CGUID+139),
(2, 0, @CGUID+140),
(2, 0, @CGUID+141),
(2, 0, @CGUID+142),
(2, 0, @CGUID+143),
(2, 0, @CGUID+144),
(2, 0, @CGUID+145),
(2, 0, @CGUID+146),
(2, 0, @CGUID+147),
(2, 0, @CGUID+148),
(2, 0, @CGUID+149),
(2, 0, @CGUID+150),
(2, 0, @CGUID+151),
(2, 0, @CGUID+152),
(2, 0, @CGUID+153),
(2, 0, @CGUID+154);

-- Old gameobject spawns
DELETE FROM `gameobject` WHERE `guid` BETWEEN 151829 AND 151887;
DELETE FROM `gameobject_addon` WHERE `guid` BETWEEN 151829 AND 151887;
DELETE FROM `game_event_gameobject` WHERE `guid` BETWEEN 151829 AND 151887;

DELETE FROM `gameobject` WHERE `guid` BETWEEN @OGUID+0 AND @OGUID+59;
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `VerifiedBuild`) VALUES
-- Sen'jin Village
(@OGUID+0, 202833, 1, 14, 367, 1, 1, -839.14239501953125, -4978.3369140625, 14.5841064453125, 3.333590030670166015, 0, 0, -0.99539566040039062, 0.095851235091686248, 120, 255, 1, 53788), -- Sen'jin Bat Totem (Area: Sen'jin Village - Difficulty: 0) CreateObject1
(@OGUID+1, 202834, 1, 14, 367, 1, 1, -833.62847900390625, -4980.71337890625, 14.82357597351074218, 3.577930212020874023, 0, 0, -0.97629547119140625, 0.216442063450813293, 120, 255, 1, 53788), -- Sen'jin Bat Roost Straw (Area: Sen'jin Village - Difficulty: 0) CreateObject1
(@OGUID+2, 202835, 1, 14, 367, 1, 1, -827.06597900390625, -4983.640625, 15.51871395111083984, 3.211419343948364257, 0, 0, -0.9993906021118164, 0.034906134009361267, 120, 255, 1, 53788), -- Sen'jin Bat Roost Fence (Area: Sen'jin Village - Difficulty: 0) CreateObject1
(@OGUID+3, 202835, 1, 14, 367, 1, 1, -829.59552001953125, -4978.0087890625, 15.64376544952392578, 3.839725255966186523, 0, 0, -0.93969249725341796, 0.34202045202255249, 120, 255, 1, 53788), -- Sen'jin Bat Roost Fence (Area: Sen'jin Village - Difficulty: 0) CreateObject1
(@OGUID+4, 202839, 1, 14, 367, 1, 1, -831.79168701171875, -4975.609375, 15.85344982147216796, 3.874631166458129882, 0, 0, -0.93358039855957031, 0.358368009328842163, 120, 255, 1, 53788), -- Sen'jin Bat Roost Fence Post (Area: Sen'jin Village - Difficulty: 0) CreateObject1
(@OGUID+5, 202879, 1, 14, 367, 1, 1, -797.4774169921875, -4972.70166015625, 17.80503463745117187, 4.1538848876953125, 0, 0, -0.8746194839477539, 0.484810054302215576, 120, 255, 1, 53788), -- Ritual Drum (Area: Sen'jin Village - Difficulty: 0) CreateObject1
(@OGUID+6, 202880, 1, 14, 367, 1, 1, -789.609375, -4979.12841796875, 18.03583526611328125, 3.735006093978881835, 0, 0, -0.95630455017089843, 0.292372345924377441, 120, 255, 1, 53788), -- Ritual Gong (Area: Sen'jin Village - Difficulty: 0) CreateObject1
(@OGUID+7, 202882, 1, 14, 367, 1, 1, -811.529541015625, -4988.205078125, 17.11979103088378906, 5.201082706451416015, 0, 0, -0.51503753662109375, 0.857167601585388183, 120, 255, 1, 53788), -- Small Ritual Drum (Area: Sen'jin Village - Difficulty: 0) CreateObject1
(@OGUID+8, 202882, 1, 14, 367, 1, 1, -799.1007080078125, -4987.36474609375, 17.63783073425292968, 0.27925160527229309, 0, 0, 0.139172554016113281, 0.990268170833587646, 120, 255, 1, 53788), -- Small Ritual Drum (Area: Sen'jin Village - Difficulty: 0) CreateObject1
(@OGUID+9, 202883, 1, 14, 367, 1, 1, -810.48785400390625, -4987.16650390625, 17.10089874267578125, 5.201082706451416015, 0, 0, -0.51503753662109375, 0.857167601585388183, 120, 255, 1, 53788), -- Small Ritual Drum 2 (Area: Sen'jin Village - Difficulty: 0) CreateObject1
(@OGUID+10, 202883, 1, 14, 367, 1, 1, -799.7882080078125, -4986.07275390625, 17.48750495910644531, 0.27925160527229309, 0, 0, 0.139172554016113281, 0.990268170833587646, 120, 255, 1, 53788), -- Small Ritual Drum 2 (Area: Sen'jin Village - Difficulty: 0) CreateObject1
(@OGUID+11, 202885, 1, 14, 367, 1, 1, -747.27081298828125, -4998.53466796875, 20.1927032470703125, 3.90954136848449707, 0, 0, -0.92718315124511718, 0.37460830807685852, 120, 255, 1, 53788), -- Sen'jin Banner (Area: Sen'jin Village - Difficulty: 0) CreateObject1
(@OGUID+12, 202885, 1, 14, 367, 1, 1, -755.015625, -4990.8818359375, 20.33255958557128906, 3.961898565292358398, 0, 0, -0.91705989837646484, 0.398749500513076782, 120, 255, 1, 53788), -- Sen'jin Banner (Area: Sen'jin Village - Difficulty: 0) CreateObject1
(@OGUID+13, 202885, 1, 14, 367, 1, 1, -763.57989501953125, -4919.81787109375, 20.17787742614746093, 6.161012649536132812, 0, 0, -0.06104850769042968, 0.998134791851043701, 120, 255, 1, 53788), -- Sen'jin Banner (Area: Sen'jin Village - Difficulty: 0) CreateObject1
(@OGUID+14, 202885, 1, 14, 367, 1, 1, -764.842041015625, -4936.15966796875, 21.09831428527832031, 6.073746204376220703, 0, 0, -0.10452842712402343, 0.994521915912628173, 120, 255, 1, 53788), -- Sen'jin Banner (Area: Sen'jin Village - Difficulty: 0) CreateObject1
(@OGUID+15, 202885, 1, 14, 367, 1, 1, -789.14410400390625, -4880.5849609375, 19.14895057678222656, 0.750490784645080566, 0, 0, 0.3665008544921875, 0.93041771650314331, 120, 255, 1, 53788), -- Sen'jin Banner (Area: Sen'jin Village - Difficulty: 0) CreateObject1
(@OGUID+16, 202885, 1, 14, 367, 1, 1, -863.6007080078125, -4916.2587890625, 19.7371978759765625, 3.996806621551513671, 0, 0, -0.90996074676513671, 0.414694398641586303, 120, 255, 1, 53788), -- Sen'jin Banner (Area: Sen'jin Village - Difficulty: 0) CreateObject1
(@OGUID+17, 202885, 1, 14, 367, 1, 1, -857.83160400390625, -4945.3056640625, 20.622039794921875, 2.70525527000427246, 0, 0, 0.97629547119140625, 0.216442063450813293, 120, 255, 1, 53788), -- Sen'jin Banner (Area: Sen'jin Village - Difficulty: 0) CreateObject1
(@OGUID+18, 202885, 1, 14, 367, 1, 1, -775.44268798828125, -4895.79541015625, 19.87759590148925781, 0.733038187026977539, 0, 0, 0.358367919921875, 0.933580458164215087, 120, 255, 1, 53788), -- Sen'jin Banner (Area: Sen'jin Village - Difficulty: 0) CreateObject1
(@OGUID+19, 202885, 1, 14, 367, 1, 1, -834.109375, -4873.1474609375, 20.00675582885742187, 1.169368624687194824, 0, 0, 0.551936149597167968, 0.833886384963989257, 120, 255, 1, 53788), -- Sen'jin Banner (Area: Sen'jin Village - Difficulty: 0) CreateObject1
(@OGUID+20, 202886, 1, 14, 367, 1, 1, -736.05731201171875, -5025.12841796875, 16.79297828674316406, 2.757613182067871093, 0, 0, 0.981626510620117187, 0.190812408924102783, 120, 255, 1, 53788), -- Sen'jin Tent (Area: Sen'jin Village - Difficulty: 0) CreateObject1
(@OGUID+21, 202886, 1, 14, 367, 1, 1, -738.671875, -4956.7275390625, 22.82360649108886718, 2.757613182067871093, 0, 0, 0.981626510620117187, 0.190812408924102783, 120, 255, 1, 53788), -- Sen'jin Tent (Area: Sen'jin Village - Difficulty: 0) CreateObject1
(@OGUID+22, 202888, 1, 14, 367, 1, 1, -739.4375, -4957.40283203125, 22.81807136535644531, 0, 0, 0, 0, 1, 120, 255, 1, 53788), -- Sen'jin Table (Area: Sen'jin Village - Difficulty: 0) CreateObject1
(@OGUID+23, 202888, 1, 14, 367, 1, 1, -736.44268798828125, -5024.7587890625, 16.54466056823730468, 0, 0, 0, 0, 1, 120, 255, 1, 53788), -- Sen'jin Table (Area: Sen'jin Village - Difficulty: 0) CreateObject1
(@OGUID+24, 202889, 1, 14, 367, 1, 1, -737.08331298828125, -5024.984375, 17.58501243591308593, 3.176533222198486328, 0, 0, -0.999847412109375, 0.017469281330704689, 120, 255, 1, 53788), -- Troll Book 1 (Area: Sen'jin Village - Difficulty: 0) CreateObject1
(@OGUID+25, 202889, 1, 14, 367, 1, 1, -739.15277099609375, -4958.62158203125, 23.87224769592285156, 5.044002056121826171, 0, 0, -0.58070278167724609, 0.814115643501281738, 120, 255, 1, 53788), -- Troll Book 1 (Area: Sen'jin Village - Difficulty: 0) CreateObject1
(@OGUID+26, 202889, 1, 14, 367, 1, 1, -735.80731201171875, -5024.63720703125, 17.64069366455078125, 5.619962215423583984, 0, 0, -0.32556724548339843, 0.945518851280212402, 120, 255, 1, 53788), -- Troll Book 1 (Area: Sen'jin Village - Difficulty: 0) CreateObject1
(@OGUID+27, 202890, 1, 14, 367, 1, 1, -736.21356201171875, -5025.76220703125, 17.5919647216796875, 5.026549339294433593, 0, 0, -0.5877847671508789, 0.809017360210418701, 120, 255, 1, 53788), -- Troll Book 2 (Area: Sen'jin Village - Difficulty: 0) CreateObject1
(@OGUID+28, 202890, 1, 14, 367, 1, 1, -739.1944580078125, -4957.1630859375, 23.85643577575683593, 0.994837164878845214, 0, 0, 0.477158546447753906, 0.878817260265350341, 120, 255, 1, 53788), -- Troll Book 2 (Area: Sen'jin Village - Difficulty: 0) CreateObject1
(@OGUID+29, 202890, 1, 14, 367, 1, 1, -740.05902099609375, -4958.033203125, 23.83476829528808593, 3.43830275535583496, 0, 0, -0.98901557922363281, 0.147811368107795715, 120, 255, 1, 53788), -- Troll Book 2 (Area: Sen'jin Village - Difficulty: 0) CreateObject1
(@OGUID+30, 202891, 1, 14, 367, 1, 1, -742.06597900390625, -4997.02783203125, 20.31479644775390625, 6.230826377868652343, 0, 0, -0.02617645263671875, 0.999657332897186279, 120, 255, 1, 53788), -- Closed Weapon Crate (Area: Sen'jin Village - Difficulty: 0) CreateObject1
(@OGUID+31, 202891, 1, 14, 367, 1, 1, -742.09893798828125, -4997.0712890625, 20.856292724609375, 5.550147056579589843, 0, 0, -0.358367919921875, 0.933580458164215087, 120, 255, 1, 53788), -- Closed Weapon Crate (Area: Sen'jin Village - Difficulty: 0) CreateObject1
(@OGUID+32, 202891, 1, 14, 367, 1, 1, -740.84552001953125, -5023.08154296875, 17.34810829162597656, 1.797688722610473632, 0, 0, 0.7826080322265625, 0.622514784336090087, 120, 255, 1, 53788), -- Closed Weapon Crate (Area: Sen'jin Village - Difficulty: 0) CreateObject1
(@OGUID+33, 202891, 1, 14, 367, 1, 1, -743.295166015625, -4954.142578125, 22.78401565551757812, 1.32644820213317871, 0, 0, 0.615660667419433593, 0.788011372089385986, 120, 255, 1, 53788), -- Closed Weapon Crate (Area: Sen'jin Village - Difficulty: 0) CreateObject1
(@OGUID+34, 202891, 1, 14, 367, 1, 1, -743.3125, -4954.19091796875, 23.34920692443847656, 2.862335443496704101, 0, 0, 0.990267753601074218, 0.139175355434417724, 120, 255, 1, 53788), -- Closed Weapon Crate (Area: Sen'jin Village - Difficulty: 0) CreateObject1
(@OGUID+35, 202891, 1, 14, 367, 1, 1, -740.734375, -5022.94775390625, 16.8128814697265625, 1.32644820213317871, 0, 0, 0.615660667419433593, 0.788011372089385986, 120, 255, 1, 53788), -- Closed Weapon Crate (Area: Sen'jin Village - Difficulty: 0) CreateObject1
(@OGUID+36, 202891, 1, 14, 367, 1, 1, -819.2586669921875, -4934.97216796875, 21.0808868408203125, 5.235987663269042968, 0, 0, -0.5, 0.866025388240814208, 120, 255, 1, 53788), -- Closed Weapon Crate (Area: Sen'jin Village - Difficulty: 0) CreateObject1
(@OGUID+37, 202891, 1, 14, 367, 1, 1, -806.21527099609375, -4925.30224609375, 19.99849510192871093, 1.32644820213317871, 0, 0, 0.615660667419433593, 0.788011372089385986, 120, 255, 1, 53788), -- Closed Weapon Crate (Area: Sen'jin Village - Difficulty: 0) CreateObject1
(@OGUID+38, 202891, 1, 14, 367, 1, 1, -806.248291015625, -4925.19775390625, 19.40742683410644531, 4.049167633056640625, 0, 0, -0.89879322052001953, 0.438372820615768432, 120, 255, 1, 53788), -- Closed Weapon Crate (Area: Sen'jin Village - Difficulty: 0) CreateObject1
(@OGUID+39, 202891, 1, 14, 367, 1, 1, -819.33160400390625, -4935, 20.47183799743652343, 4.694936752319335937, 0, 0, -0.71325016021728515, 0.700909554958343505, 120, 255, 1, 53788), -- Closed Weapon Crate (Area: Sen'jin Village - Difficulty: 0) CreateObject1
(@OGUID+40, 202892, 1, 14, 367, 1, 1, -742.08331298828125, -4997.0087890625, 21.42633628845214843, 3.769911527633666992, 0, 0, -0.95105648040771484, 0.309017121791839599, 120, 255, 1, 53788), -- Open Weapon Crate (Area: Sen'jin Village - Difficulty: 0) CreateObject1
(@OGUID+41, 202892, 1, 14, 367, 1, 1, -743.263916015625, -4954.2880859375, 23.98391151428222656, 2.303830623626708984, 0, 0, 0.913544654846191406, 0.406738430261611938, 120, 255, 1, 53788), -- Open Weapon Crate (Area: Sen'jin Village - Difficulty: 0) CreateObject1
(@OGUID+42, 202892, 1, 14, 367, 1, 1, -819.3819580078125, -4934.984375, 21.64498519897460937, 5.916667938232421875, 0, 0, -0.18223476409912109, 0.98325502872467041, 120, 255, 1, 53788), -- Open Weapon Crate (Area: Sen'jin Village - Difficulty: 0) CreateObject1
(@OGUID+43, 202892, 1, 14, 367, 1, 1, -740.93231201171875, -5023.298828125, 17.89151954650878906, 3.769911527633666992, 0, 0, -0.95105648040771484, 0.309017121791839599, 120, 255, 1, 53788), -- Open Weapon Crate (Area: Sen'jin Village - Difficulty: 0) CreateObject1
(@OGUID+44, 202893, 1, 14, 367, 1, 1, -735.27777099609375, -5033.16162109375, 27.61154556274414062, 2.408554315567016601, 0, 0, 0.933580398559570312, 0.358368009328842163, 120, 255, 1, 53788), -- Sen'jin Pennant (Area: Sen'jin Village - Difficulty: 0) CreateObject1
(@OGUID+45, 202893, 1, 14, 367, 1, 1, -744.3194580078125, -5021.3837890625, 27.21346473693847656, 2.408554315567016601, 0, 0, 0.933580398559570312, 0.358368009328842163, 120, 255, 1, 53788), -- Sen'jin Pennant (Area: Sen'jin Village - Difficulty: 0) CreateObject1
(@OGUID+46, 202893, 1, 14, 367, 1, 1, -737.88543701171875, -4964.8037109375, 33.65756607055664062, 2.408554315567016601, 0, 0, 0.933580398559570312, 0.358368009328842163, 120, 255, 1, 53788), -- Sen'jin Pennant (Area: Sen'jin Village - Difficulty: 0) CreateObject1
(@OGUID+47, 202893, 1, 14, 367, 1, 1, -784.77081298828125, -4942.91845703125, 55.81523895263671875, 2.408554315567016601, 0, 0, 0.933580398559570312, 0.358368009328842163, 120, 255, 1, 53788), -- Sen'jin Pennant (Area: Sen'jin Village - Difficulty: 0) CreateObject1
(@OGUID+48, 202893, 1, 14, 367, 1, 1, -746.888916015625, -4953.02978515625, 33.657257080078125, 2.408554315567016601, 0, 0, 0.933580398559570312, 0.358368009328842163, 120, 255, 1, 53788), -- Sen'jin Pennant (Area: Sen'jin Village - Difficulty: 0) CreateObject1
(@OGUID+49, 202893, 1, 14, 367, 1, 1, -736.49481201171875, -5024.7412109375, 32.87637710571289062, 2.408554315567016601, 0, 0, 0.933580398559570312, 0.358368009328842163, 120, 255, 1, 53788), -- Sen'jin Pennant (Area: Sen'jin Village - Difficulty: 0) CreateObject1
(@OGUID+50, 202893, 1, 14, 367, 1, 1, -729.47393798828125, -5019.7431640625, 27.53687858581542968, 2.408554315567016601, 0, 0, 0.933580398559570312, 0.358368009328842163, 120, 255, 1, 53788), -- Sen'jin Pennant (Area: Sen'jin Village - Difficulty: 0) CreateObject1
(@OGUID+51, 202893, 1, 14, 367, 1, 1, -739.0625, -4956.28662109375, 39.07462310791015625, 2.408554315567016601, 0, 0, 0.933580398559570312, 0.358368009328842163, 120, 255, 1, 53788), -- Sen'jin Pennant (Area: Sen'jin Village - Difficulty: 0) CreateObject1
(@OGUID+52, 202893, 1, 14, 367, 1, 1, -732.10418701171875, -4951.34033203125, 33.59527969360351562, 2.408554315567016601, 0, 0, 0.933580398559570312, 0.358368009328842163, 120, 255, 1, 53788), -- Sen'jin Pennant (Area: Sen'jin Village - Difficulty: 0) CreateObject1
(@OGUID+53, 202893, 1, 14, 367, 1, 1, -775.2899169921875, -4910.6943359375, 32.34464645385742187, 2.408554315567016601, 0, 0, 0.933580398559570312, 0.358368009328842163, 120, 255, 1, 53788), -- Sen'jin Pennant (Area: Sen'jin Village - Difficulty: 0) CreateObject1
(@OGUID+54, 202893, 1, 14, 367, 1, 1, -842.765625, -4939.8994140625, 33.59177017211914062, 2.408554315567016601, 0, 0, 0.933580398559570312, 0.358368009328842163, 120, 255, 1, 53788), -- Sen'jin Pennant (Area: Sen'jin Village - Difficulty: 0) CreateObject1
(@OGUID+55, 202893, 1, 14, 367, 1, 1, -802.77081298828125, -4915.736328125, 29.89216423034667968, 2.408554315567016601, 0, 0, 0.933580398559570312, 0.358368009328842163, 120, 255, 1, 53788), -- Sen'jin Pennant (Area: Sen'jin Village - Difficulty: 0) CreateObject1
(@OGUID+56, 202893, 1, 14, 367, 1, 1, -835.0399169921875, -4898.42724609375, 30.94986343383789062, 2.408554315567016601, 0, 0, 0.933580398559570312, 0.358368009328842163, 120, 255, 1, 53788), -- Sen'jin Pennant (Area: Sen'jin Village - Difficulty: 0) CreateObject1
(@OGUID+57, 202893, 1, 14, 367, 1, 1, -802.79864501953125, -4896.53662109375, 30.40306663513183593, 2.408554315567016601, 0, 0, 0.933580398559570312, 0.358368009328842163, 120, 255, 1, 53788), -- Sen'jin Pennant (Area: Sen'jin Village - Difficulty: 0) CreateObject1
-- Echo Isles
(@OGUID+58, 180434, 1, 14, 368, 1, 1, -791.4913330078125, -5353.0537109375, 3.100693941116333007, 5.95157480239868164, 0, 0, -0.16504669189453125, 0.986285746097564697, 120, 255, 1, 53788), -- Bonfire (Area: Echo Isles - Difficulty: 0) CreateObject1
(@OGUID+59, 186865, 1, 14, 368, 1, 1, -797.97393798828125, -5349.142578125, 2.206597089767456054, 5.95157480239868164, 0, 0, -0.16504669189453125, 0.986285746097564697, 120, 255, 1, 53788); -- Amani Drum (Area: Echo Isles - Difficulty: 0) CreateObject1

-- Event spawns
DELETE FROM `game_event_creature` WHERE `eventEntry`=@EVENT AND `guid` BETWEEN @CGUID+0 AND @CGUID+154;
INSERT INTO `game_event_creature` (`eventEntry`, `guid`) VALUES
(@EVENT, @CGUID+0),
(@EVENT, @CGUID+1),
(@EVENT, @CGUID+2),
(@EVENT, @CGUID+3),
(@EVENT, @CGUID+4),
(@EVENT, @CGUID+5),
(@EVENT, @CGUID+6),
(@EVENT, @CGUID+7),
(@EVENT, @CGUID+8),
(@EVENT, @CGUID+9),
(@EVENT, @CGUID+10),
(@EVENT, @CGUID+11),
(@EVENT, @CGUID+12),
(@EVENT, @CGUID+13),
(@EVENT, @CGUID+14),
(@EVENT, @CGUID+15),
(@EVENT, @CGUID+16),
(@EVENT, @CGUID+17),
(@EVENT, @CGUID+18),
(@EVENT, @CGUID+19),
(@EVENT, @CGUID+20),
(@EVENT, @CGUID+21),
(@EVENT, @CGUID+22),
(@EVENT, @CGUID+23),
(@EVENT, @CGUID+24),
(@EVENT, @CGUID+25),
(@EVENT, @CGUID+26),
(@EVENT, @CGUID+27),
(@EVENT, @CGUID+28),
(@EVENT, @CGUID+29),
(@EVENT, @CGUID+30),
(@EVENT, @CGUID+31),
(@EVENT, @CGUID+32),
(@EVENT, @CGUID+33),
(@EVENT, @CGUID+34),
(@EVENT, @CGUID+35),
(@EVENT, @CGUID+36),
(@EVENT, @CGUID+37),
(@EVENT, @CGUID+38),
(@EVENT, @CGUID+39),
(@EVENT, @CGUID+40),
(@EVENT, @CGUID+41),
(@EVENT, @CGUID+42),
(@EVENT, @CGUID+43),
(@EVENT, @CGUID+44),
(@EVENT, @CGUID+45),
(@EVENT, @CGUID+46),
(@EVENT, @CGUID+47),
(@EVENT, @CGUID+48),
(@EVENT, @CGUID+49),
(@EVENT, @CGUID+50),
(@EVENT, @CGUID+51),
(@EVENT, @CGUID+52),
(@EVENT, @CGUID+53),
(@EVENT, @CGUID+54),
(@EVENT, @CGUID+55),
(@EVENT, @CGUID+56),
(@EVENT, @CGUID+57),
(@EVENT, @CGUID+58),
(@EVENT, @CGUID+59),
(@EVENT, @CGUID+60),
(@EVENT, @CGUID+61),
(@EVENT, @CGUID+62),
(@EVENT, @CGUID+63),
(@EVENT, @CGUID+64),
(@EVENT, @CGUID+65),
(@EVENT, @CGUID+66),
(@EVENT, @CGUID+67),
(@EVENT, @CGUID+68),
(@EVENT, @CGUID+69),
(@EVENT, @CGUID+70),
(@EVENT, @CGUID+71),
(@EVENT, @CGUID+72),
(@EVENT, @CGUID+73),
(@EVENT, @CGUID+74),
(@EVENT, @CGUID+75),
(@EVENT, @CGUID+76),
(@EVENT, @CGUID+77),
(@EVENT, @CGUID+78),
(@EVENT, @CGUID+79),
(@EVENT, @CGUID+80),
(@EVENT, @CGUID+81),
(@EVENT, @CGUID+82),
(@EVENT, @CGUID+83),
(@EVENT, @CGUID+84),
(@EVENT, @CGUID+85),
(@EVENT, @CGUID+86),
(@EVENT, @CGUID+87),
(@EVENT, @CGUID+88),
(@EVENT, @CGUID+89),
(@EVENT, @CGUID+90),
(@EVENT, @CGUID+91),
(@EVENT, @CGUID+92),
(@EVENT, @CGUID+93),
(@EVENT, @CGUID+94),
(@EVENT, @CGUID+95),
(@EVENT, @CGUID+96),
(@EVENT, @CGUID+97),
(@EVENT, @CGUID+98),
(@EVENT, @CGUID+99),
(@EVENT, @CGUID+100),
(@EVENT, @CGUID+101),
(@EVENT, @CGUID+102),
(@EVENT, @CGUID+103),
(@EVENT, @CGUID+104),
(@EVENT, @CGUID+105),
(@EVENT, @CGUID+106),
(@EVENT, @CGUID+107),
(@EVENT, @CGUID+108),
(@EVENT, @CGUID+109),
(@EVENT, @CGUID+110),
(@EVENT, @CGUID+111),
(@EVENT, @CGUID+112),
(@EVENT, @CGUID+113),
(@EVENT, @CGUID+114),
(@EVENT, @CGUID+115),
(@EVENT, @CGUID+116),
(@EVENT, @CGUID+117),
(@EVENT, @CGUID+118),
(@EVENT, @CGUID+119),
(@EVENT, @CGUID+120),
(@EVENT, @CGUID+121),
(@EVENT, @CGUID+122),
(@EVENT, @CGUID+123),
(@EVENT, @CGUID+124),
(@EVENT, @CGUID+125),
(@EVENT, @CGUID+126),
(@EVENT, @CGUID+127),
(@EVENT, @CGUID+128),
(@EVENT, @CGUID+129),
(@EVENT, @CGUID+130),
(@EVENT, @CGUID+131),
(@EVENT, @CGUID+132),
(@EVENT, @CGUID+133),
(@EVENT, @CGUID+134),
(@EVENT, @CGUID+135),
(@EVENT, @CGUID+136),
(@EVENT, @CGUID+137),
(@EVENT, @CGUID+138),
(@EVENT, @CGUID+139),
(@EVENT, @CGUID+140),
(@EVENT, @CGUID+141),
(@EVENT, @CGUID+142),
(@EVENT, @CGUID+143),
(@EVENT, @CGUID+144),
(@EVENT, @CGUID+145),
(@EVENT, @CGUID+146),
(@EVENT, @CGUID+147),
(@EVENT, @CGUID+148),
(@EVENT, @CGUID+149),
(@EVENT, @CGUID+150),
(@EVENT, @CGUID+151),
(@EVENT, @CGUID+152),
(@EVENT, @CGUID+153),
(@EVENT, @CGUID+154);

DELETE FROM `game_event_gameobject` WHERE `eventEntry`=@EVENT AND `guid` BETWEEN @OGUID+0 AND @OGUID+59;
INSERT INTO `game_event_gameobject` (`eventEntry`, `guid`) VALUES
(@EVENT, @OGUID+0),
(@EVENT, @OGUID+1),
(@EVENT, @OGUID+2),
(@EVENT, @OGUID+3),
(@EVENT, @OGUID+4),
(@EVENT, @OGUID+5),
(@EVENT, @OGUID+6),
(@EVENT, @OGUID+7),
(@EVENT, @OGUID+8),
(@EVENT, @OGUID+9),
(@EVENT, @OGUID+10),
(@EVENT, @OGUID+11),
(@EVENT, @OGUID+12),
(@EVENT, @OGUID+13),
(@EVENT, @OGUID+14),
(@EVENT, @OGUID+15),
(@EVENT, @OGUID+16),
(@EVENT, @OGUID+17),
(@EVENT, @OGUID+18),
(@EVENT, @OGUID+19),
(@EVENT, @OGUID+20),
(@EVENT, @OGUID+21),
(@EVENT, @OGUID+22),
(@EVENT, @OGUID+23),
(@EVENT, @OGUID+24),
(@EVENT, @OGUID+25),
(@EVENT, @OGUID+26),
(@EVENT, @OGUID+27),
(@EVENT, @OGUID+28),
(@EVENT, @OGUID+29),
(@EVENT, @OGUID+30),
(@EVENT, @OGUID+31),
(@EVENT, @OGUID+32),
(@EVENT, @OGUID+33),
(@EVENT, @OGUID+34),
(@EVENT, @OGUID+35),
(@EVENT, @OGUID+36),
(@EVENT, @OGUID+37),
(@EVENT, @OGUID+38),
(@EVENT, @OGUID+39),
(@EVENT, @OGUID+40),
(@EVENT, @OGUID+41),
(@EVENT, @OGUID+42),
(@EVENT, @OGUID+43),
(@EVENT, @OGUID+44),
(@EVENT, @OGUID+45),
(@EVENT, @OGUID+46),
(@EVENT, @OGUID+47),
(@EVENT, @OGUID+48),
(@EVENT, @OGUID+49),
(@EVENT, @OGUID+50),
(@EVENT, @OGUID+51),
(@EVENT, @OGUID+52),
(@EVENT, @OGUID+53),
(@EVENT, @OGUID+54),
(@EVENT, @OGUID+55),
(@EVENT, @OGUID+56),
(@EVENT, @OGUID+57),
(@EVENT, @OGUID+58),
(@EVENT, @OGUID+59);

-- Cleansing the Scar (9489)
DELETE FROM `quest_details` WHERE `ID`=9489;
INSERT INTO `quest_details` (`ID`,`Emote1`,`Emote2`,`Emote3`,`Emote4`,`EmoteDelay1`,`EmoteDelay2`,`EmoteDelay3`,`EmoteDelay4`,`VerifiedBuild`) VALUES
(9489,1,1,0,0,0,0,0,0,0);
UPDATE `quest_request_items` SET `EmoteOnIncomplete`=6 WHERE `ID`=9489;

-- Rogues of the Shattered Hand (10794)
DELETE FROM `quest_details` WHERE `ID`=10794;
INSERT INTO `quest_details` (`ID`,`Emote1`,`Emote2`,`Emote3`,`Emote4`,`EmoteDelay1`,`EmoteDelay2`,`EmoteDelay3`,`EmoteDelay4`,`VerifiedBuild`) VALUES
(10794,1,1,1,0,0,0,0,0,0);

-- A Discreet Inquiry (10372)
DELETE FROM `quest_details` WHERE `ID`=10372;
INSERT INTO `quest_details` (`ID`,`Emote1`,`Emote2`,`Emote3`,`Emote4`,`EmoteDelay1`,`EmoteDelay2`,`EmoteDelay3`,`EmoteDelay4`,`VerifiedBuild`) VALUES
(10372,1,1,1,0,0,0,0,0,0);
UPDATE `quest_offer_reward` SET `Emote1`=1 WHERE `ID`=10372; 

-- Find Keltus Darkleaf (9532)
DELETE FROM `quest_details` WHERE `ID`=9532;
INSERT INTO `quest_details` (`ID`,`Emote1`,`Emote2`,`Emote3`,`Emote4`,`EmoteDelay1`,`EmoteDelay2`,`EmoteDelay3`,`EmoteDelay4`,`VerifiedBuild`) VALUES
(9532,1,1,0,0,0,0,0,0,0);
UPDATE `quest_offer_reward` SET `Emote1`=5 WHERE `ID`=9532; 

-- Powering our Defenses (8490)
UPDATE `quest_offer_reward` SET `Emote1`=1 WHERE `ID`=8490; 

-- Old Whitebark's Pendant (8474)
UPDATE `quest_offer_reward` SET `Emote1`=18 WHERE `ID`=8474; 

-- Abandoned Investigations (8891)
UPDATE `quest_offer_reward` SET `Emote1`=1,`Emote2`=1,`Emote3`=1 WHERE `ID`=8891; 

-- Word from the Spire (8890)
DELETE FROM `quest_details` WHERE `ID`=8890;
INSERT INTO `quest_details` (`ID`,`Emote1`,`Emote2`,`Emote3`,`Emote4`,`EmoteDelay1`,`EmoteDelay2`,`EmoteDelay3`,`EmoteDelay4`,`VerifiedBuild`) VALUES
(8890,1,1,0,0,0,0,0,0,0);
UPDATE `quest_offer_reward` SET `Emote1`=5,`Emote2`=18 WHERE `ID`=8890;

-- Cleaning up the Grounds (8894)
DELETE FROM `quest_details` WHERE `ID`=8894;
INSERT INTO `quest_details` (`ID`,`Emote1`,`Emote2`,`Emote3`,`Emote4`,`EmoteDelay1`,`EmoteDelay2`,`EmoteDelay3`,`EmoteDelay4`,`VerifiedBuild`) VALUES
(8894,5,1,0,0,0,0,0,0,0);
UPDATE `quest_request_items` SET `EmoteOnIncomplete`=6 WHERE `ID`=8894;
UPDATE `quest_offer_reward` SET `Emote1`=1,`Emote2`=1 WHERE `ID`=8894;

-- Where's Wyllithen? (9394)
DELETE FROM `quest_details` WHERE `ID`=9394;
INSERT INTO `quest_details` (`ID`,`Emote1`,`Emote2`,`Emote3`,`Emote4`,`EmoteDelay1`,`EmoteDelay2`,`EmoteDelay3`,`EmoteDelay4`,`VerifiedBuild`) VALUES
(9394,1,6,0,0,0,0,0,0,0);
UPDATE `quest_offer_reward` SET `Emote1`=6,`Emote2`=5 WHERE `ID`=9394;

-- Deactivating the Spire (8889)
DELETE FROM `quest_details` WHERE `ID`=8889;
INSERT INTO `quest_details` (`ID`,`Emote1`,`Emote2`,`Emote3`,`Emote4`,`EmoteDelay1`,`EmoteDelay2`,`EmoteDelay3`,`EmoteDelay4`,`VerifiedBuild`) VALUES
(8889,1,1,6,0,0,0,0,0,0);
UPDATE `quest_request_items` SET `EmoteOnComplete`=6,`EmoteOnIncomplete`=6 WHERE `ID`=8889;
UPDATE `quest_offer_reward` SET `Emote1`=1,`Emote2`=1 WHERE `ID`=8889;

-- The Magister's Apprentice (8888)
DELETE FROM `quest_details` WHERE `ID`=8888;
INSERT INTO `quest_details` (`ID`,`Emote1`,`Emote2`,`Emote3`,`Emote4`,`EmoteDelay1`,`EmoteDelay2`,`EmoteDelay3`,`EmoteDelay4`,`VerifiedBuild`) VALUES
(8888,1,1,1,0,0,0,0,0,0);
UPDATE `quest_offer_reward` SET `Emote1`=6,`Emote2`=1 WHERE `ID`=8888;

-- The Spearcrafter's Hammer (8477)
DELETE FROM `quest_details` WHERE `ID`=8477;
INSERT INTO `quest_details` (`ID`,`Emote1`,`Emote2`,`Emote3`,`Emote4`,`EmoteDelay1`,`EmoteDelay2`,`EmoteDelay3`,`EmoteDelay4`,`VerifiedBuild`) VALUES
(8477,1,0,0,0,0,0,0,0,0);
UPDATE `quest_offer_reward` SET `Emote1`=1 WHERE `ID`=8477;

-- The Party Never Ends (9067)
DELETE FROM `quest_details` WHERE `ID`=9067;
INSERT INTO `quest_details` (`ID`,`Emote1`,`Emote2`,`Emote3`,`Emote4`,`EmoteDelay1`,`EmoteDelay2`,`EmoteDelay3`,`EmoteDelay4`,`VerifiedBuild`) VALUES
(9067,1,0,0,0,0,0,0,0,0);
UPDATE `quest_request_items` SET `EmoteOnComplete`=6,`EmoteOnIncomplete`=6 WHERE `ID`=9067;
UPDATE `quest_offer_reward` SET `Emote1`=1,`Emote2`=1 WHERE `ID`=9067;

-- Saltheril's Haven (9395)
DELETE FROM `quest_details` WHERE `ID`=9395;
INSERT INTO `quest_details` (`ID`,`Emote1`,`Emote2`,`Emote3`,`Emote4`,`EmoteDelay1`,`EmoteDelay2`,`EmoteDelay3`,`EmoteDelay4`,`VerifiedBuild`) VALUES
(9395,5,1,1,0,0,0,0,0,0);
UPDATE `quest_offer_reward` SET `Emote1`=1,`Emote2`=1,`Emote3`=6 WHERE `ID`=9395;

-- Unexpected Results (8488)
UPDATE `quest_offer_reward` SET `Emote1`=1 WHERE `ID`=8488;

-- Corrupted Soil (8487)
DELETE FROM `quest_details` WHERE `ID`=8487;
INSERT INTO `quest_details` (`ID`,`Emote1`,`Emote2`,`Emote3`,`Emote4`,`EmoteDelay1`,`EmoteDelay2`,`EmoteDelay3`,`EmoteDelay4`,`VerifiedBuild`) VALUES
(8487,1,5,0,0,0,0,0,0,0);
UPDATE `quest_offer_reward` SET `Emote1`=1 WHERE `ID`=8487;

-- Captain Kelisendra's Lost Rutters (8887)
UPDATE `quest_request_items` SET `EmoteOnComplete`=6 WHERE `ID`=8887;
UPDATE `quest_offer_reward` SET `Emote1`=1 WHERE `ID`=8887;

-- Lost Armaments (8480)
UPDATE `quest_offer_reward` SET `Emote1`=2 WHERE `ID`=8480;

-- Grimscale Pirates! (8886)
DELETE FROM `quest_details` WHERE `ID`=8886;
INSERT INTO `quest_details` (`ID`,`Emote1`,`Emote2`,`Emote3`,`Emote4`,`EmoteDelay1`,`EmoteDelay2`,`EmoteDelay3`,`EmoteDelay4`,`VerifiedBuild`) VALUES
(8886,5,1,6,0,0,0,0,0,0);
UPDATE `quest_request_items` SET `EmoteOnComplete`=6,`EmoteOnIncomplete`=6 WHERE `ID`=8886;
UPDATE `quest_offer_reward` SET `Emote1`=4,`Emote2`=1,`Emote3`=1 WHERE `ID`=8886;

-- The Dwarven Spy (8483)
UPDATE `quest_offer_reward` SET `Emote1`=5 WHERE `ID`=8483;

-- Incriminating Documents (8482)
UPDATE `quest_offer_reward` SET `Emote1`=5 WHERE `ID`=8482;

-- The Ring of Mmmrrrggglll (8885)
DELETE FROM `quest_details` WHERE `ID`=8885;
INSERT INTO `quest_details` (`ID`,`Emote1`,`Emote2`,`Emote3`,`Emote4`,`EmoteDelay1`,`EmoteDelay2`,`EmoteDelay3`,`EmoteDelay4`,`VerifiedBuild`) VALUES
(8885,1,1,1,0,0,0,0,0,0);
UPDATE `quest_request_items` SET `EmoteOnComplete`=6,`EmoteOnIncomplete`=6 WHERE `ID`=8885;

-- Fish Heads, Fish Heads... (8884)
DELETE FROM `quest_details` WHERE `ID`=8884;
INSERT INTO `quest_details` (`ID`,`Emote1`,`Emote2`,`Emote3`,`Emote4`,`EmoteDelay1`,`EmoteDelay2`,`EmoteDelay3`,`EmoteDelay4`,`VerifiedBuild`) VALUES
(8884,1,1,5,0,0,0,0,0,0);
UPDATE `quest_request_items` SET `EmoteOnComplete`=6,`EmoteOnIncomplete`=6 WHERE `ID`=8884;
UPDATE `quest_offer_reward` SET `Emote1`=1,`Emote2`=1 WHERE `ID`=8884;

-- Arcane Instability (8486)
UPDATE `quest_offer_reward` SET `Emote1`=1 WHERE `ID`=8486;

-- Completing the Delivery (8350)
DELETE FROM `quest_details` WHERE `ID`=8350;
INSERT INTO `quest_details` (`ID`,`Emote1`,`Emote2`,`Emote3`,`Emote4`,`EmoteDelay1`,`EmoteDelay2`,`EmoteDelay3`,`EmoteDelay4`,`VerifiedBuild`) VALUES
(8350,1,1,0,0,0,0,0,0,0);

-- Aiding the Outrunners (8347)
UPDATE `quest_offer_reward` SET `Emote1`=1,`Emote2`=1 WHERE `ID`=8347;

-- Tainted Arcane Sliver (8338)
UPDATE `quest_request_items` SET `EmoteOnComplete`=6 WHERE `ID`=8338;
UPDATE `quest_offer_reward` SET `Emote1`=1,`Emote2`=1 WHERE `ID`=8338;

-- Aiding the Outrunners (8347)
DELETE FROM `quest_details` WHERE `ID`=8347;
INSERT INTO `quest_details` (`ID`,`Emote1`,`Emote2`,`Emote3`,`Emote4`,`EmoteDelay1`,`EmoteDelay2`,`EmoteDelay3`,`EmoteDelay4`,`VerifiedBuild`) VALUES
(8347,2,1,0,0,0,0,0,0,0);

-- Felendren the Banished (8335)
DELETE FROM `quest_details` WHERE `ID`=8335;
INSERT INTO `quest_details` (`ID`,`Emote1`,`Emote2`,`Emote3`,`Emote4`,`EmoteDelay1`,`EmoteDelay2`,`EmoteDelay3`,`EmoteDelay4`,`VerifiedBuild`) VALUES
(8335,1,5,0,0,0,0,0,0,0);

-- Aggression (8334)
UPDATE `quest_details` SET `Emote3`=1 WHERE `ID`=8334;
UPDATE `quest_offer_reward` SET `Emote2`=1 WHERE `ID`=8334;

-- Report to Lanthan Perilon (8327)
DELETE FROM `quest_details` WHERE `ID`=8327;
INSERT INTO `quest_details` (`ID`,`Emote1`,`Emote2`,`Emote3`,`Emote4`,`EmoteDelay1`,`EmoteDelay2`,`EmoteDelay3`,`EmoteDelay4`,`VerifiedBuild`) VALUES
(8327,1,2,0,0,0,0,0,0,0);

-- A Fistful of Slivers (8336)
UPDATE `quest_offer_reward` SET `Emote1`=1,`Emote2`=1 WHERE `ID`=8336;

-- Solanian's Belongings (8330)
UPDATE `quest_request_items` SET `EmoteOnComplete`=6 WHERE `ID`=8330;
UPDATE `quest_offer_reward` SET `Emote2`=1,`Emote2`=1 WHERE `ID`=8330;

-- Thirst Unending (8346)
DELETE FROM `quest_details` WHERE `ID`=8346;
INSERT INTO `quest_details` (`ID`,`Emote1`,`Emote2`,`Emote3`,`Emote4`,`EmoteDelay1`,`EmoteDelay2`,`EmoteDelay3`,`EmoteDelay4`,`VerifiedBuild`) VALUES
(8346,1,1,1,0,0,0,0,0,0);
UPDATE `quest_offer_reward` SET `Emote1`=1,`Emote2`=1 WHERE `ID`=8346;

-- The Shrine of Dath'Remar (8345)
UPDATE `quest_request_items` SET `EmoteOnIncomplete`=6 WHERE `ID`=8345;
UPDATE `quest_offer_reward` SET `Emote3`=1 WHERE `ID`=8345;

-- Solanian's Belongings (8330)
DELETE FROM `quest_details` WHERE `ID`=8330;
INSERT INTO `quest_details` (`ID`,`Emote1`,`Emote2`,`Emote3`,`Emote4`,`EmoteDelay1`,`EmoteDelay2`,`EmoteDelay3`,`EmoteDelay4`,`VerifiedBuild`) VALUES
(8330,1,1,1,0,0,0,0,0,0);

-- Well Watcher Solanian (10071)
DELETE FROM `quest_details` WHERE `ID`=10071;
INSERT INTO `quest_details` (`ID`,`Emote1`,`Emote2`,`Emote3`,`Emote4`,`EmoteDelay1`,`EmoteDelay2`,`EmoteDelay3`,`EmoteDelay4`,`VerifiedBuild`) VALUES
(10071,1,1,0,0,0,0,0,0,0);
UPDATE `quest_offer_reward` SET `Emote1`=1 WHERE `ID`=10071;

-- Unfortunate Measures (8326)
DELETE FROM `quest_details` WHERE `ID`=8326;
INSERT INTO `quest_details` (`ID`,`Emote1`,`Emote2`,`Emote3`,`Emote4`,`EmoteDelay1`,`EmoteDelay2`,`EmoteDelay3`,`EmoteDelay4`,`VerifiedBuild`) VALUES
(8326,1,1,0,0,0,0,0,0,0);

-- Rogue Training (9392)
DELETE FROM `quest_details` WHERE `ID`=9392;
INSERT INTO `quest_details` (`ID`,`Emote1`,`Emote2`,`Emote3`,`Emote4`,`EmoteDelay1`,`EmoteDelay2`,`EmoteDelay3`,`EmoteDelay4`,`VerifiedBuild`) VALUES
(9392,1,1,0,0,0,0,0,0,0);
UPDATE `quest_offer_reward` SET `Emote1`=1,`Emote2`=1 WHERE `ID`=9392;

-- Breadcrumb quest Fix
DELETE FROM `quest_template_addon` WHERE `ID`=9035;
INSERT INTO `quest_template_addon` (`ID`, `BreadcrumbForQuestId`) VALUES
(9035,9062);

-- Cleaning up the Grounds (8894)
UPDATE `quest_offer_reward` SET `RewardText`="Well, I suppose that will have to do, now won't it? Thanks for the help, $c. I can only hope to get this mess completely cleaned up before the Magister returns to Duskwither Spire.$B$BTake this pocket change; it's not much but it's all that I have at the moment. Feel free to dispatch a few more of the beasties on your way out, if you'd be so kind." WHERE `ID`=8894;

-- Wretched Ringleader (9076)
UPDATE `quest_offer_reward` SET `RewardText`="You defeated him after all!  Undoubtedly my men softened him up for you.$B$BI jest, $c.  You've done well.  You'll make a name for yourself if you keep your nose clean." WHERE `ID`=9076;

-- Captain Kelisendra's Lost Rutters (8887)
UPDATE `quest_request_items` SET `CompletionText`="Hello, $c, you're a sight for sore eyes. I know, it's crazy for me to be here, what with the anchorage overrun by the Wretched. Velendris and his rangers have sworn to protect me on the condition that I get out of here as soon as I've recovered my cargo.$B$BWhat's that you have there... it looks vaguely familiar?" WHERE `ID`=8887;
UPDATE `quest_offer_reward` SET `RewardText`="Oh you sweet, sweet $c! I had no idea that those disgusting Grimscale murlocs had also pirated away with my navigation rudders! Without them, I would have no chance of navigating the seas again once we retake the anchorage and repair the ship.$B$BThank you very much! Here, take this coin as a sign of my appreciation." WHERE `ID`=8887;

-- Quest "Runewarden Deryan" should not be available until "Defending Fairbreeze Village" is rewarded
UPDATE `quest_template_addon` SET `PrevQuestID`=9252 WHERE `ID`=9253;

-- Magister Duskwither gossip menu text changes after turning in quest "The Magister's Apprentice"
-- Gossip menu
DELETE FROM `gossip_menu` WHERE `MenuID`=6942 AND `TextID`=8233;
INSERT INTO `gossip_menu` (`MenuID`, `TextID`, `VerifiedBuild`) VALUES
(6942,8233,0);

-- Condition
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=14 AND `SourceGroup`=6942;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(14,6942,8233,0,0,8,0,8888,0,0,0,0,0,"","Gossip text 8233 requires quest The Magister's Apprentice rewarded");

SET @CGUID := 213973;
SET @OGUID := 167095;
SET @EVENT := 61;

-- Creature templates
UPDATE `creature_template` SET `gossip_menu_id`=11394 WHERE `entry`=40492;
UPDATE `creature_template` SET `gossip_menu_id`=11398 WHERE `entry`=39654;
UPDATE `creature_template` SET `unit_flags`=33555200 WHERE `entry`=41839; -- [DND] Controller
UPDATE `creature_template` SET `npcflag`=1, `unit_flags`=768 WHERE `entry`=40492; -- Zild'jian
UPDATE `creature_template` SET `unit_flags`=768 WHERE `entry`=40425; -- Voodoo Troll
UPDATE `creature_template` SET `unit_flags`=768 WHERE `entry`=40231; -- Hexed Troll
UPDATE `creature_template` SET `unit_flags`=33554432 WHERE `entry`=40199; -- Tiki Warrior

DELETE FROM `creature_template_addon` WHERE `entry` IN (41839 /*41839 ([DND] Controller)*/, 40492 /*40492 (Zild'jian)*/, 40425 /*40425 (Voodoo Troll)*/, 40241 /*40241 (Darkspear Warrior)*/, 40231 /*40231 (Hexed Troll)*/, 40199 /*40199 (Tiki Warrior) - Enchanted Tiki Warrior: Enchanted Tiki Warrior Visual 03, Freeze Anim*/);
INSERT INTO `creature_template_addon` (`entry`, `mount`, `StandState`, `AnimTier`, `VisFlags`, `SheathState`, `PvpFlags`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(41839, 0, 0, 0, 0, 1, 0, 0, 0, ''), -- 41839 ([DND] Controller)
(40492, 0, 0, 0, 0, 1, 0, 173, 0, ''), -- 40492 (Zild'jian)
(40425, 0, 0, 0, 0, 1, 0, 0, 0, ''), -- 40425 (Voodoo Troll)
(40241, 0, 0, 0, 0, 1, 0, 0, 0, ''), -- 40241 (Darkspear Warrior)
(40231, 0, 0, 0, 0, 1, 0, 0, 0, ''), -- 40231 (Hexed Troll)
(40199, 0, 0, 0, 0, 1, 0, 0, 0, '75038'); -- 40199 (Tiki Warrior) - Freeze Anim

UPDATE `creature_template_addon` SET `SheathState`=1 WHERE `entry`=40192; -- 40192 (Vanira)
UPDATE `creature_template_addon` SET `SheathState`=1 WHERE `entry`=39654; -- 39654 (Vol'jin)

DELETE FROM `creature_template_movement` WHERE `CreatureId` IN (41839);
INSERT INTO `creature_template_movement` (`CreatureId`, `Ground`, `Swim`, `Flight`, `Rooted`, `Chase`, `Random`, `InteractionPauseTimer`) VALUES
(41839, 0, 0, 1, 1, 0, 0, NULL);

-- Gossips
DELETE FROM `gossip_menu` WHERE (`MenuID`=11394 AND `TextID`=15871);
INSERT INTO `gossip_menu` (`MenuID`, `TextID`, `VerifiedBuild`) VALUES
(11394, 15871, 53788); -- 40492 (Zild'jian)

UPDATE `gossip_menu_option` SET `ActionMenuID`=11397 WHERE (`MenuID`=11398 AND `OptionID`=0);

DELETE FROM `npc_text` WHERE `ID`=15871;
INSERT INTO `npc_text` (`ID`, `text0_0`, `Probability0`, `Probability1`, `Probability2`, `Probability3`, `Probability4`, `Probability5`, `Probability6`, `Probability7`, `BroadcastTextId0`, `BroadcastTextId1`, `BroadcastTextId2`, `BroadcastTextId3`, `BroadcastTextId4`, `BroadcastTextId5`, `BroadcastTextId6`, `BroadcastTextId7`, `VerifiedBuild`) VALUES
(15871, 'Vol''jin be waitin for ya.  You should talk wit him now, my arms are gettin'' tired.$B$BDis echo isle attack betta be startin'' soon. ', 1, 0, 0, 0, 0, 0, 0, 0, 40472, 0, 0, 0, 0, 0, 0, 0, 53788); -- 15871

-- Misc
UPDATE `spell_area` SET `quest_start`=25480, `quest_start_status`=64 WHERE `spell`=74092;

-- Quests
DELETE FROM `quest_details` WHERE `ID`=25495;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES
(25495, 1, 1, 0, 0, 0, 0, 0, 0, 53788); -- Preparin' For Battle

UPDATE `quest_offer_reward` SET `Emote1`=1, `Emote2`=1, `VerifiedBuild`=53788 WHERE `ID`=25495; -- Preparin' For Battle

DELETE FROM `game_event_creature_quest` WHERE (`id`=40253 AND `quest`=25495);
DELETE FROM `creature_queststarter` WHERE (`id`=40253 AND `quest`=25495);
INSERT INTO `creature_queststarter` (`id`, `quest`) VALUES
(40253, 25495); -- Preparin' For Battle offered by Champion Uru'zin

-- SAI
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry` IN (40199);

DELETE FROM `smart_scripts` WHERE `entryorguid` IN (40199) AND `source_type`=0;
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (4019900, 4019901, 4019902) AND `source_type`=9;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(40199,0,0,0,11,0,100,0,0,0,0,0,0,88,4019900,4019902,0,0,0,0,1,0,0,0,0,0,0,0,0,'Tiki Warrior - On spawn - Call random range actionlist'),
(4019900,9,0,0,0,0,100,0,0,0,0,0,0,11,52614,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Actionlist - Tiki Warrior - Cast "Enchanted Tiki Warrior: Enchanted Tiki Warrior Visual 01"'),
(4019901,9,0,0,0,0,100,0,0,0,0,0,0,11,52617,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Actionlist - Tiki Warrior - Cast "Enchanted Tiki Warrior: Enchanted Tiki Warrior Visual 02"'),
(4019902,9,0,0,0,0,100,0,0,0,0,0,0,11,52618,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Actionlist - Tiki Warrior - Cast "Enchanted Tiki Warrior: Enchanted Tiki Warrior Visual 03"');

-- Creature spawns
DELETE FROM `creature` WHERE `guid` BETWEEN @CGUID+0 AND @CGUID+30;
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `VerifiedBuild`) VALUES
(@CGUID+0, 39654, 1, 14, 368, 1, 256, 0, 1, -803.7569580078125, -5372.67529296875, 1.706597328186035156, 4.607669353485107421, 120, 0, 0, 5578000, 68128, 0, 53788), -- Vol'jin (Area: Echo Isles - Difficulty: 0) CreateObject1
(@CGUID+1, 40192, 1, 14, 368, 1, 256, 0, 1, -806.6007080078125, -5372.3662109375, 1.740533351898193359, 4.607669353485107421, 120, 0, 0, 630000, 99850, 0, 53788), -- Vanira (Area: Echo Isles - Difficulty: 0) CreateObject1
(@CGUID+2, 40199, 1, 14, 368, 1, 256, 0, 0, -1089.203125, -5534.72412109375, 8.209239959716796875, 3.176499128341674804, 120, 0, 0, 25200, 0, 0, 53788), -- Tiki Warrior (Area: Echo Isles - Difficulty: 0) CreateObject1 (Auras: 52618 - Enchanted Tiki Warrior: Enchanted Tiki Warrior Visual 03, 75038 - Freeze Anim)
(@CGUID+3, 40199, 1, 14, 368, 1, 256, 0, 0, -1103.0660400390625, -5601.11474609375, 8.610991477966308593, 2.216568231582641601, 120, 0, 0, 25200, 0, 0, 53788), -- Tiki Warrior (Area: Echo Isles - Difficulty: 0) CreateObject1
(@CGUID+4, 40199, 1, 14, 368, 1, 256, 0, 0, -1116.671875, -5546.1787109375, 8.427076339721679687, 1.326450228691101074, 120, 0, 0, 25200, 0, 0, 53788), -- Tiki Warrior (Area: Echo Isles - Difficulty: 0) CreateObject1
(@CGUID+5, 40199, 1, 14, 368, 1, 256, 0, 0, -1130.310791015625, -5561.09033203125, 10.66214179992675781, 3.665191411972045898, 120, 0, 0, 25200, 0, 0, 53788), -- Tiki Warrior (Area: Echo Isles - Difficulty: 0) CreateObject1
(@CGUID+6, 40199, 1, 14, 368, 1, 256, 0, 0, -1125.625, -5578.8212890625, 9.991229057312011718, 2.809980154037475585, 120, 0, 0, 25200, 0, 0, 53788), -- Tiki Warrior (Area: Echo Isles - Difficulty: 0) CreateObject1
(@CGUID+7, 40199, 1, 14, 368, 1, 256, 0, 0, -1141.717041015625, -5561.7880859375, 9.991229057312011718, 5.375614166259765625, 120, 0, 0, 25200, 0, 0, 53788), -- Tiki Warrior (Area: Echo Isles - Difficulty: 0) CreateObject1
(@CGUID+8, 40199, 1, 14, 368, 1, 256, 0, 0, -1127.5625, -5604.67041015625, 8.571069717407226562, 1.326450228691101074, 120, 0, 0, 25200, 0, 0, 53788), -- Tiki Warrior (Area: Echo Isles - Difficulty: 0) CreateObject1
(@CGUID+9, 40199, 1, 14, 368, 1, 256, 0, 0, -1144.564208984375, -5577.41650390625, 9.991169929504394531, 0.191986218094825744, 120, 0, 0, 25200, 0, 0, 53788), -- Tiki Warrior (Area: Echo Isles - Difficulty: 0) CreateObject1
(@CGUID+10, 40199, 1, 14, 368, 1, 256, 0, 0, -1148.5555419921875, -5529.25, 6.521678447723388671, 0.05235987901687622, 120, 0, 0, 25200, 0, 0, 53788), -- Tiki Warrior (Area: Echo Isles - Difficulty: 0) CreateObject1 (Auras: 52618 - Enchanted Tiki Warrior: Enchanted Tiki Warrior Visual 03, 75038 - Freeze Anim)
(@CGUID+11, 40199, 1, 14, 368, 1, 256, 0, 0, -1137.2291259765625, -5507.49853515625, 7.451714515686035156, 4.642575740814208984, 120, 0, 0, 25200, 0, 0, 53788), -- Tiki Warrior (Area: Echo Isles - Difficulty: 0) CreateObject1 (Auras: 52614 - Enchanted Tiki Warrior: Enchanted Tiki Warrior Visual 01, 75038 - Freeze Anim)
(@CGUID+12, 40222, 1, 14, 368, 1, 256, 0, 0, -854.15625, -5344.60595703125, 3.308190345764160156, 1.186823844909667968, 120, 0, 0, 12600, 0, 0, 53788), -- Scout Bat (Area: Echo Isles - Difficulty: 0) CreateObject1
(@CGUID+13, 40231, 1, 14, 368, 1, 256, 0, 0, -1250.9305419921875, -5507.1162109375, 5.849954605102539062, 3.525565147399902343, 120, 0, 0, 151200, 139790, 0, 53788), -- Hexed Troll (Area: Echo Isles - Difficulty: 0) CreateObject1
(@CGUID+14, 40231, 1, 14, 368, 1, 256, 0, 0, -1242.1492919921875, -5513.3505859375, 9.614050865173339843, 3.281219005584716796, 120, 0, 0, 151200, 139790, 0, 53788), -- Hexed Troll (Area: Echo Isles - Difficulty: 0) CreateObject1
(@CGUID+15, 40231, 1, 14, 368, 1, 256, 0, 0, -1262.9635009765625, -5497.2587890625, 4.929576396942138671, 5.078907966613769531, 120, 0, 0, 151200, 139790, 0, 53788), -- Hexed Troll (Area: Echo Isles - Difficulty: 0) CreateObject1
(@CGUID+16, 40231, 1, 14, 368, 1, 256, 0, 0, -1271.390625, -5517.07275390625, 5.070352554321289062, 0, 120, 0, 0, 151200, 139790, 0, 53788), -- Hexed Troll (Area: Echo Isles - Difficulty: 0) CreateObject1
(@CGUID+17, 40231, 1, 14, 368, 1, 256, 0, 0, -1281.654541015625, -5508.578125, 8.472925186157226562, 0, 120, 0, 0, 151200, 139790, 0, 53788), -- Hexed Troll (Area: Echo Isles - Difficulty: 0) CreateObject1
(@CGUID+18, 40231, 1, 14, 368, 1, 256, 0, 0, -1278.5972900390625, -5501.01904296875, 5.113239288330078125, 0, 120, 0, 0, 151200, 139790, 0, 53788), -- Hexed Troll (Area: Echo Isles - Difficulty: 0) CreateObject1
(@CGUID+19, 40241, 1, 14, 368, 1, 256, 0, 1, -814.0694580078125, -5360.75, 2.521949291229248046, 4.747295379638671875, 120, 0, 0, 1008000, 0, 0, 53788), -- Darkspear Warrior (Area: Echo Isles - Difficulty: 0) CreateObject1
(@CGUID+20, 40241, 1, 14, 368, 1, 256, 0, 1, -795.6961669921875, -5360.73095703125, 2.28309035301208496, 4.520402908325195312, 120, 0, 0, 1008000, 0, 0, 53788), -- Darkspear Warrior (Area: Echo Isles - Difficulty: 0) CreateObject1
(@CGUID+21, 40241, 1, 14, 368, 1, 256, 0, 1, -807.34722900390625, -5360.52587890625, 2.302173137664794921, 4.747295379638671875, 120, 0, 0, 1008000, 0, 0, 53788), -- Darkspear Warrior (Area: Echo Isles - Difficulty: 0) CreateObject1
(@CGUID+22, 40241, 1, 14, 368, 1, 256, 0, 1, -788.65802001953125, -5361.0869140625, 3.251736164093017578, 4.520402908325195312, 120, 0, 0, 1008000, 0, 0, 53788), -- Darkspear Warrior (Area: Echo Isles - Difficulty: 0) CreateObject1
(@CGUID+23, 40241, 1, 14, 368, 1, 256, 0, 1, -810.217041015625, -5361.923828125, 2.541666269302368164, 4.747295379638671875, 120, 0, 0, 1008000, 0, 0, 53788), -- Darkspear Warrior (Area: Echo Isles - Difficulty: 0) CreateObject1
(@CGUID+24, 40241, 1, 14, 368, 1, 256, 0, 1, -792.0850830078125, -5362.5224609375, 2.518892288208007812, 4.520402908325195312, 120, 0, 0, 1008000, 0, 0, 53788), -- Darkspear Warrior (Area: Echo Isles - Difficulty: 0) CreateObject1
(@CGUID+25, 40425, 1, 14, 368, 1, 256, 0, 0, -1232.8021240234375, -5516.01025390625, 6.147329330444335937, 0, 120, 0, 0, 151200, 59910, 0, 53788), -- Voodoo Troll (Area: Echo Isles - Difficulty: 0) CreateObject1 (Auras: )
(@CGUID+26, 40425, 1, 14, 368, 1, 256, 0, 0, -1259.90283203125, -5544.4619140625, 10.13318634033203125, 1.378810048103332519, 120, 0, 0, 151200, 59910, 0, 53788), -- Voodoo Troll (Area: Echo Isles - Difficulty: 0) CreateObject1
(@CGUID+27, 40425, 1, 14, 368, 1, 256, 0, 0, -1261.3958740234375, -5505.87353515625, 5.455820560455322265, 0, 120, 0, 0, 151200, 59910, 0, 53788), -- Voodoo Troll (Area: Echo Isles - Difficulty: 0) CreateObject1 (Auras: )
(@CGUID+28, 40492, 1, 14, 368, 1, 256, 0, 1, -802.140625, -5347.78466796875, 2.247483253479003906, 5.951572895050048828, 120, 0, 0, 12600, 0, 0, 53788), -- Zild'jian (Area: Echo Isles - Difficulty: 0) CreateObject1
(@CGUID+29, 41839, 1, 14, 368, 1, 256, 0, 0, -1168.8004150390625, -5505.4150390625, 5.630413532257080078, 0, 120, 0, 0, 42, 0, 0, 53788), -- [DND] Controller (Area: Echo Isles - Difficulty: 0) CreateObject1
(@CGUID+30, 41839, 1, 14, 368, 1, 256, 0, 0, -1168.9375, -5505.126953125, 5.627105712890625, 0, 120, 0, 0, 42, 0, 0, 53788); -- [DND] Controller (Area: Echo Isles - Difficulty: 0) CreateObject1

DELETE FROM `creature_addon` WHERE `guid` BETWEEN @CGUID+0 AND @CGUID+30;
INSERT INTO `creature_addon` (`guid`, `mount`, `StandState`, `AnimTier`, `VisFlags`, `SheathState`, `PvpFlags`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(@CGUID+4, 0, 0, 0, 0, 1, 0, 333, 0, ''); -- Tiki Warrior

-- Gameobject spawns
DELETE FROM `gameobject` WHERE `guid` IN (12373,12398,12399,12400,12401,12402,12403);
DELETE FROM `gameobject_addon` WHERE `guid` IN (12373,12398,12399,12400,12401,12402,12403);
DELETE FROM `gameobject` WHERE `guid` BETWEEN @OGUID+0 AND @OGUID+16;
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `VerifiedBuild`) VALUES
(12373, 3237, 1, 14, 368, 1, 257, -1286.0894775390625, -5528.13037109375, 15.20782184600830078, 1.972219824790954589, 0, 0, 0.83388519287109375, 0.55193793773651123, 120, 255, 1, 53788), -- Imprisoned Darkspear (Area: Echo Isles - Difficulty: 0) CreateObject1
(12398, 3237, 1, 14, 368, 1, 257, -1287.270751953125, -5528.1318359375, 15.20782184600830078, 3.019413232803344726, 0, 0, 0.998134613037109375, 0.061051756143569946, 120, 255, 1, 53788), -- Imprisoned Darkspear (Area: Echo Isles - Difficulty: 0) CreateObject1
(12399, 3237, 1, 14, 368, 1, 257, -1287.2486572265625, -5530.0029296875, 15.20782184600830078, 2.495818138122558593, 0, 0, 0.948323249816894531, 0.317305892705917358, 120, 255, 1, 53788), -- Imprisoned Darkspear (Area: Echo Isles - Difficulty: 0) CreateObject1
(12400, 3237, 1, 14, 368, 1, 257, -1287.583984375, -5528.7802734375, 15.20782184600830078, 5.759587764739990234, 0, 0, -0.25881862640380859, 0.965925931930541992, 120, 255, 1, 53788), -- Imprisoned Darkspear (Area: Echo Isles - Difficulty: 0) CreateObject1
(12401, 3237, 1, 14, 368, 1, 257, -1287.740234375, -5527.71142578125, 15.20781993865966796, 0.663223206996917724, 0, 0, 0.325567245483398437, 0.945518851280212402, 120, 255, 1, 53788), -- Imprisoned Darkspear (Area: Echo Isles - Difficulty: 0) CreateObject1
(12402, 3237, 1, 14, 368, 1, 257, -1286.97314453125, -5529.0693359375, 15.20782184600830078, 0.052358884364366531, 0, 0, 0.02617645263671875, 0.999657332897186279, 120, 255, 1, 53788), -- Imprisoned Darkspear (Area: Echo Isles - Difficulty: 0) CreateObject1
(12403, 3237, 1, 14, 368, 1, 257, -1288.1153564453125, -5529.064453125, 15.20782279968261718, 1.623155713081359863, 0, 0, 0.725374221801757812, 0.688354730606079101, 120, 255, 1, 53788), -- Imprisoned Darkspear (Area: Echo Isles - Difficulty: 0) CreateObject1
(@OGUID+0, 188470, 1, 14, 368, 1, 256, -1282.2274169921875, -5532.27978515625, 15.03157901763916015, 3.385940074920654296, 0, 0, -0.99254608154296875, 0.121869951486587524, 120, 255, 1, 53788), -- Event Fog (Area: Echo Isles - Difficulty: 0) CreateObject1
(@OGUID+1, 190214, 1, 14, 368, 1, 256, -789.91839599609375, -5355.3369140625, 3.387152910232543945, 5.95157480239868164, 0, 0, -0.16504669189453125, 0.986285746097564697, 120, 255, 1, 53788), -- Voodoo Pile Skulls (Area: Echo Isles - Difficulty: 0) CreateObject1
(@OGUID+2, 190214, 1, 14, 368, 1, 256, -794.296875, -5354.46875, 3.019097089767456054, 5.95157480239868164, 0, 0, -0.16504669189453125, 0.986285746097564697, 120, 255, 1, 53788), -- Voodoo Pile Skulls (Area: Echo Isles - Difficulty: 0) CreateObject1
(@OGUID+3, 190214, 1, 14, 368, 1, 256, -791.00518798828125, -5351.1650390625, 2.854166984558105468, 5.95157480239868164, 0, 0, -0.16504669189453125, 0.986285746097564697, 120, 255, 1, 53788), -- Voodoo Pile Skulls (Area: Echo Isles - Difficulty: 0) CreateObject1
(@OGUID+4, 194501, 1, 14, 368, 1, 256, -811.0225830078125, -5343.18603515625, 0.917156994342803955, 4.363324165344238281, 0, 0, -0.81915187835693359, 0.573576688766479492, 120, 255, 1, 53788), -- Sen'jin Banner (Area: Echo Isles - Difficulty: 0) CreateObject1
(@OGUID+5, 194501, 1, 14, 368, 1, 256, -835.3507080078125, -5314.251953125, 1.883900046348571777, 1.797688722610473632, 0, 0, 0.7826080322265625, 0.622514784336090087, 120, 255, 1, 53788), -- Sen'jin Banner (Area: Echo Isles - Difficulty: 0) CreateObject1
(@OGUID+6, 194501, 1, 14, 368, 1, 256, -792.4600830078125, -5378.80029296875, 3.098958015441894531, 4.293513298034667968, 0, 0, -0.8386697769165039, 0.544640243053436279, 120, 255, 1, 53788), -- Sen'jin Banner (Area: Echo Isles - Difficulty: 0) CreateObject1
(@OGUID+7, 194501, 1, 14, 368, 1, 256, -784.0538330078125, -5352.375, 2.78125, 4.345870018005371093, 0, 0, -0.82412624359130859, 0.566406130790710449, 120, 255, 1, 53788), -- Sen'jin Banner (Area: Echo Isles - Difficulty: 0) CreateObject1
(@OGUID+8, 194501, 1, 14, 368, 1, 256, -819.33856201171875, -5369.609375, 2.072698116302490234, 4.310965538024902343, 0, 0, -0.83388519287109375, 0.55193793773651123, 120, 255, 1, 53788), -- Sen'jin Banner (Area: Echo Isles - Difficulty: 0) CreateObject1
(@OGUID+9, 194501, 1, 14, 368, 1, 256, -872.62152099609375, -5329.5244140625, 1.313696026802062988, 1.797688722610473632, 0, 0, 0.7826080322265625, 0.622514784336090087, 120, 255, 1, 53788), -- Sen'jin Banner (Area: Echo Isles - Difficulty: 0) CreateObject1
(@OGUID+10, 194501, 1, 14, 368, 1, 256, -868.357666015625, -5371.22216796875, 0.976329982280731201, 4.59021615982055664, 0, 0, -0.74895572662353515, 0.662620067596435546, 120, 255, 1, 53788), -- Sen'jin Banner (Area: Echo Isles - Difficulty: 0) CreateObject1
(@OGUID+11, 202833, 1, 14, 368, 1, 256, -848.420166015625, -5348.6650390625, 3.214971065521240234, 3.333590030670166015, 0, 0, -0.99539566040039062, 0.095851235091686248, 120, 255, 1, 53788), -- Sen'jin Bat Totem (Area: Echo Isles - Difficulty: 0) CreateObject1
(@OGUID+12, 202834, 1, 14, 368, 1, 256, -853.86456298828125, -5344.2587890625, 3.884398937225341796, 4.380776405334472656, 0, 0, -0.81411552429199218, 0.580702960491180419, 120, 255, 1, 53788), -- Sen'jin Bat Roost Straw (Area: Echo Isles - Difficulty: 0) CreateObject1
(@OGUID+13, 202835, 1, 14, 368, 1, 256, -855.28643798828125, -5348.17041015625, 4.395833015441894531, 1.378809213638305664, 0, 0, 0.636077880859375, 0.771624863147735595, 120, 255, 1, 53788), -- Sen'jin Bat Roost Fence (Area: Echo Isles - Difficulty: 0) CreateObject1
(@OGUID+14, 202835, 1, 14, 368, 1, 256, -861.04339599609375, -5345.95166015625, 3.407985925674438476, 0.750490784645080566, 0, 0, 0.3665008544921875, 0.93041771650314331, 120, 255, 1, 53788), -- Sen'jin Bat Roost Fence (Area: Echo Isles - Difficulty: 0) CreateObject1
(@OGUID+15, 202839, 1, 14, 368, 1, 256, -852.03643798828125, -5348.32666015625, 4.36799478530883789, 1.413715124130249023, 0, 0, 0.649447441101074218, 0.760406434535980224, 120, 255, 1, 53788), -- Sen'jin Bat Roost Fence Post (Area: Echo Isles - Difficulty: 0) CreateObject1
(@OGUID+16, 202845, 1, 14, 368, 1, 256, -698.029541015625, -5593.4462890625, 23.58217811584472656, 3.298687219619750976, 0, 0, -0.99691677093505859, 0.078466430306434631, 120, 255, 1, 53788); -- Voodoo Pile Skulls (Area: Echo Isles - Difficulty: 0) CreateObject1

UPDATE `gameobject` SET `phasemask`=257 WHERE `guid` IN (167093, 167094);
UPDATE `gameobject` SET `phasemask`=257 WHERE `id` IN (178444, 102986, 18084, 3240, 3089);

DELETE FROM `spawn_group` WHERE `spawnType`=1 AND `spawnId` IN (12373,12398,12399,12400,12401,12402,12403);
INSERT INTO `spawn_group` (`groupId`, `spawnType`, `spawnId`) VALUES
(2, 1, 12373),
(2, 1, 12398),
(2, 1, 12399),
(2, 1, 12400),
(2, 1, 12401),
(2, 1, 12402),
(2, 1, 12403);

-- Event spawns
DELETE FROM `game_event_creature` WHERE `eventEntry`=@EVENT AND `guid` BETWEEN @CGUID+0 AND @CGUID+30;
INSERT INTO `game_event_creature` (`eventEntry`, `guid`) VALUES
(@EVENT, @CGUID+0),
(@EVENT, @CGUID+1),
(@EVENT, @CGUID+2),
(@EVENT, @CGUID+3),
(@EVENT, @CGUID+4),
(@EVENT, @CGUID+5),
(@EVENT, @CGUID+6),
(@EVENT, @CGUID+7),
(@EVENT, @CGUID+8),
(@EVENT, @CGUID+9),
(@EVENT, @CGUID+10),
(@EVENT, @CGUID+11),
(@EVENT, @CGUID+12),
(@EVENT, @CGUID+13),
(@EVENT, @CGUID+14),
(@EVENT, @CGUID+15),
(@EVENT, @CGUID+16),
(@EVENT, @CGUID+17),
(@EVENT, @CGUID+18),
(@EVENT, @CGUID+19),
(@EVENT, @CGUID+20),
(@EVENT, @CGUID+21),
(@EVENT, @CGUID+22),
(@EVENT, @CGUID+23),
(@EVENT, @CGUID+24),
(@EVENT, @CGUID+25),
(@EVENT, @CGUID+26),
(@EVENT, @CGUID+27),
(@EVENT, @CGUID+28),
(@EVENT, @CGUID+29),
(@EVENT, @CGUID+30);

DELETE FROM `game_event_gameobject` WHERE `eventEntry`=@EVENT AND `guid` BETWEEN @OGUID+0 AND @OGUID+16;
INSERT INTO `game_event_gameobject` (`eventEntry`, `guid`) VALUES
(@EVENT, @OGUID+0),
(@EVENT, @OGUID+1),
(@EVENT, @OGUID+2),
(@EVENT, @OGUID+3),
(@EVENT, @OGUID+4),
(@EVENT, @OGUID+5),
(@EVENT, @OGUID+6),
(@EVENT, @OGUID+7),
(@EVENT, @OGUID+8),
(@EVENT, @OGUID+9),
(@EVENT, @OGUID+10),
(@EVENT, @OGUID+11),
(@EVENT, @OGUID+12),
(@EVENT, @OGUID+13),
(@EVENT, @OGUID+14),
(@EVENT, @OGUID+15),
(@EVENT, @OGUID+16);

-- Breadcrumb quest Fix
UPDATE `quest_template_addon` SET `PrevQuestID`=0 WHERE `ID`=9491;
DELETE FROM `quest_template_addon` WHERE `ID`=10372;
INSERT INTO `quest_template_addon` (`ID`, `BreadcrumbForQuestId`) VALUES
(10372,9491);

-- Breadcrumb quest Fix
UPDATE `quest_template_addon` SET `PrevQuestID`=0 WHERE `ID`=9143;
DELETE FROM `quest_template_addon` WHERE `ID`=9145;
INSERT INTO `quest_template_addon` (`ID`, `BreadcrumbForQuestId`) VALUES
(9145,9143);

-- These quests should not be available until either "The Forsaken" (9327) or "The Forsaken" (9329) is rewarded
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`= 19 AND `SourceEntry` IN (9145,9149,9150,9152,9155,9160,9171,9192);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`SourceId`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionTarget`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`NegativeCondition`,`ErrorType`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(19,0,9145,0,0,8,0,9327,0,0,0,0,0,'',"Don't show quest 'Help Ranger Valanna!' (9145) if quest 'The Forsaken (9327)' is not rewarded or"),
(19,0,9145,0,1,8,0,9329,0,0,0,0,0,'',"Don't show quest 'Help Ranger Valanna!' (9145) if quest 'The Forsaken (9329)' is not rewarded"),
(19,0,9149,0,0,8,0,9327,0,0,0,0,0,'',"Don't show quest 'The Plagued Coast' (9149) if quest 'The Forsaken (9327)' is not rewarded or"),
(19,0,9149,0,1,8,0,9329,0,0,0,0,0,'',"Don't show quest 'The Plagued Coast' (9149) if quest 'The Forsaken (9329)' is not rewarded"),
(19,0,9150,0,0,8,0,9327,0,0,0,0,0,'',"Don't show quest 'Salvaging the Past' (9150) if quest 'The Forsaken (9327)' is not rewarded or"),
(19,0,9150,0,1,8,0,9329,0,0,0,0,0,'',"Don't show quest 'Salvaging the Past' (9150) if quest 'The Forsaken (9329)' is not rewarded"),
(19,0,9152,0,0,8,0,9327,0,0,0,0,0,'',"Don't show quest 'Tomber's Supplies' (9152) if quest 'The Forsaken (9327)' is not rewarded or"),
(19,0,9152,0,1,8,0,9329,0,0,0,0,0,'',"Don't show quest 'Tomber's Supplies' (9152) if quest 'The Forsaken (9329)' is not rewarded"),
(19,0,9155,0,0,8,0,9327,0,0,0,0,0,'',"Don't show quest 'Down the Dead Scar' (9155) if quest 'The Forsaken (9327)' is not rewarded or"),
(19,0,9155,0,1,8,0,9329,0,0,0,0,0,'',"Don't show quest 'Down the Dead Scar' (9155) if quest 'The Forsaken (9329)' is not rewarded"),
(19,0,9160,0,0,8,0,9327,0,0,0,0,0,'',"Don't show quest 'Investigate An'daroth' (9160) if quest 'The Forsaken (9327)' is not rewarded or"),
(19,0,9160,0,1,8,0,9329,0,0,0,0,0,'',"Don't show quest 'Investigate An'daroth' (9160) if quest 'The Forsaken (9329)' is not rewarded"),
(19,0,9171,0,0,8,0,9327,0,0,0,0,0,'',"Don't show quest 'Culinary Crunch' (9171) if quest 'The Forsaken (9327)' is not rewarded or"),
(19,0,9171,0,1,8,0,9329,0,0,0,0,0,'',"Don't show quest 'Culinary Crunch' (9171) if quest 'The Forsaken (9329)' is not rewarded"),
(19,0,9192,0,0,8,0,9327,0,0,0,0,0,'',"Don't show quest 'Trouble at the Underlight Mines' (9192) if quest 'The Forsaken (9327)' is not rewarded or"),
(19,0,9192,0,1,8,0,9329,0,0,0,0,0,'',"Don't show quest 'Trouble at the Underlight Mines' (9192) if quest 'The Forsaken (9329)' is not rewarded");

-- These quests requires friendly reputation with Tranquillien (922) to be available
DELETE FROM `quest_template_addon` WHERE `ID` IN (9145,9150,9155,9160,9171,9192,9207);
INSERT INTO `quest_template_addon` (`ID`,`RequiredMinRepFaction`,`RequiredMinRepValue`,`SpecialFlags`) VALUES
(9145,922,3000,0),
(9150,922,3000,0),
(9155,922,3000,0),
(9160,922,3000,2),
(9171,922,3000,0),
(9207,922,3000,0),
(9192,922,3000,0);

-- Quest "Retaking Windrunner Spire" requires honored reputation with Tranquillien to be available
DELETE FROM `quest_template_addon` WHERE `ID`=9173;
INSERT INTO `quest_template_addon` (`ID`,`RequiredMinRepFaction`,`RequiredMinRepValue`) VALUES
(9173,922,9000);

-- Journey to Undercity (9180)
DELETE FROM `quest_details` WHERE `ID`=9180;
INSERT INTO `quest_details` (`ID`,`Emote1`,`Emote2`,`Emote3`,`Emote4`,`EmoteDelay1`,`EmoteDelay2`,`EmoteDelay3`,`EmoteDelay4`,`VerifiedBuild`) VALUES
(9180,1,0,0,0,0,0,0,0,0);
UPDATE `quest_request_items` SET `EmoteOnComplete`=6 WHERE `ID`=9180;
UPDATE `quest_offer_reward` SET `Emote1`=396 WHERE `ID`=9180;

-- The Lady's Necklace (9175)
UPDATE `quest_request_items` SET `EmoteOnComplete`=6 WHERE `ID`=9175;
UPDATE `quest_offer_reward` SET `Emote1`=6 WHERE `ID`=9175;

-- Deactivate An'owyn (9169)
DELETE FROM `quest_details` WHERE `ID`=9169;
INSERT INTO `quest_details` (`ID`,`Emote1`,`Emote2`,`Emote3`,`Emote4`,`EmoteDelay1`,`EmoteDelay2`,`EmoteDelay3`,`EmoteDelay4`,`VerifiedBuild`) VALUES
(9169,1,0,0,0,0,0,0,0,0);
UPDATE `quest_request_items` SET `EmoteOnIncomplete`=6 WHERE `ID`=9169;
UPDATE `quest_offer_reward` SET `Emote1`=1,`Emote2`=2 WHERE `ID`=9169;

-- Deliver the Plans to An'telas (9166)
DELETE FROM `quest_details` WHERE `ID`=9166;
INSERT INTO `quest_details` (`ID`,`Emote1`,`Emote2`,`Emote3`,`Emote4`,`EmoteDelay1`,`EmoteDelay2`,`EmoteDelay3`,`EmoteDelay4`,`VerifiedBuild`) VALUES
(9166,1,0,0,0,0,0,0,0,0);
UPDATE `quest_offer_reward` SET `Emote1`=5,`Emote2`=5 WHERE `ID`=9166;

-- Windrunner Village (9140)
DELETE FROM `quest_details` WHERE `ID`=9140;
INSERT INTO `quest_details` (`ID`,`Emote1`,`Emote2`,`Emote3`,`Emote4`,`EmoteDelay1`,`EmoteDelay2`,`EmoteDelay3`,`EmoteDelay4`,`VerifiedBuild`) VALUES
(9140,1,0,0,0,0,0,0,0,0);
UPDATE `quest_request_items` SET `EmoteOnComplete`=6,`EmoteOnIncomplete`=6 WHERE `ID`=9140;
UPDATE `quest_offer_reward` SET `Emote1`=5 WHERE `ID`=9140;

-- Into Occupied Territory (9163)
DELETE FROM `quest_details` WHERE `ID`=9163;
INSERT INTO `quest_details` (`ID`,`Emote1`,`Emote2`,`Emote3`,`Emote4`,`EmoteDelay1`,`EmoteDelay2`,`EmoteDelay3`,`EmoteDelay4`,`VerifiedBuild`) VALUES
(9163,1,0,0,0,0,0,0,0,0);
UPDATE `quest_request_items` SET `EmoteOnComplete`=6,`EmoteOnIncomplete`=6 WHERE `ID`=9163;
UPDATE `quest_offer_reward` SET `Emote1`=1 WHERE `ID`=9163;

-- Underlight Ore Samples (9207)
DELETE FROM `quest_details` WHERE `ID`=9207;
INSERT INTO `quest_details` (`ID`,`Emote1`,`Emote2`,`Emote3`,`Emote4`,`EmoteDelay1`,`EmoteDelay2`,`EmoteDelay3`,`EmoteDelay4`,`VerifiedBuild`) VALUES
(9207,1,0,0,0,0,0,0,0,0);
UPDATE `quest_request_items` SET `EmoteOnComplete`=6 WHERE `ID`=9207;
UPDATE `quest_offer_reward` SET `Emote1`=1 WHERE `ID`=9207;

-- Assault on Zeb'Nowa (9277)
DELETE FROM `quest_details` WHERE `ID`=9277;
INSERT INTO `quest_details` (`ID`,`Emote1`,`Emote2`,`Emote3`,`Emote4`,`EmoteDelay1`,`EmoteDelay2`,`EmoteDelay3`,`EmoteDelay4`,`VerifiedBuild`) VALUES
(9277,1,0,0,0,0,0,0,0,0);
UPDATE `quest_request_items` SET `EmoteOnIncomplete`=6 WHERE `ID`=9277;
UPDATE `quest_offer_reward` SET `Emote1`=4,`Emote2`=1 WHERE `ID`=9277;

-- Bring Me Kel'gash's Head! (9215)
UPDATE `quest_request_items` SET `EmoteOnComplete`=6,`EmoteOnIncomplete`=6 WHERE `ID`=9215;
UPDATE `quest_offer_reward` SET `Emote1`=1 WHERE `ID`=9215;

-- Attack on Zeb'Tela (9276)
DELETE FROM `quest_details` WHERE `ID`=9276;
INSERT INTO `quest_details` (`ID`,`Emote1`,`Emote2`,`Emote3`,`Emote4`,`EmoteDelay1`,`EmoteDelay2`,`EmoteDelay3`,`EmoteDelay4`,`VerifiedBuild`) VALUES
(9276,1,0,0,0,0,0,0,0,0);
UPDATE `quest_request_items` SET `EmoteOnIncomplete`=6 WHERE `ID`=9276;
UPDATE `quest_offer_reward` SET `Emote1`=1 WHERE `ID`=9276;

-- A Little Dash of Seasoning (9275)
DELETE FROM `quest_details` WHERE `ID`=9275;
INSERT INTO `quest_details` (`ID`,`Emote1`,`Emote2`,`Emote3`,`Emote4`,`EmoteDelay1`,`EmoteDelay2`,`EmoteDelay3`,`EmoteDelay4`,`VerifiedBuild`) VALUES
(9275,2,1,0,0,0,0,0,0,0);
UPDATE `quest_request_items` SET `EmoteOnIncomplete`=6 WHERE `ID`=9275;
UPDATE `quest_offer_reward` SET `Emote1`=4,`Emote2`=1 WHERE `ID`=9275;

-- Shadowpine Weaponry (9214)
DELETE FROM `quest_details` WHERE `ID`=9214;
INSERT INTO `quest_details` (`ID`,`Emote1`,`Emote2`,`Emote3`,`Emote4`,`EmoteDelay1`,`EmoteDelay2`,`EmoteDelay3`,`EmoteDelay4`,`VerifiedBuild`) VALUES
(9214,1,0,0,0,0,0,0,0,0);
UPDATE `quest_request_items` SET `EmoteOnComplete`=6,`EmoteOnIncomplete`=6 WHERE `ID`=9214;
UPDATE `quest_offer_reward` SET `Emote1`=1 WHERE `ID`=9214;

-- Report to Captain Helios (9146)
DELETE FROM `quest_details` WHERE `ID`=9146;
INSERT INTO `quest_details` (`ID`,`Emote1`,`Emote2`,`Emote3`,`Emote4`,`EmoteDelay1`,`EmoteDelay2`,`EmoteDelay3`,`EmoteDelay4`,`VerifiedBuild`) VALUES
(9146,6,0,0,0,0,0,0,0,0);
UPDATE `quest_offer_reward` SET `Emote1`=1 WHERE `ID`=9146;

-- Dealing with Zeb'Sora (9143)
UPDATE `quest_request_items` SET `EmoteOnIncomplete`=6 WHERE `ID`=9143;
UPDATE `quest_request_items` SET `EmoteOnComplete`=6 WHERE `ID`=9143;
UPDATE `quest_offer_reward` SET `Emote1`=1 WHERE `ID`=9143;

-- Goldenmist Village (9139)
DELETE FROM `quest_details` WHERE `ID`=9139;
INSERT INTO `quest_details` (`ID`,`Emote1`,`Emote2`,`Emote3`,`Emote4`,`EmoteDelay1`,`EmoteDelay2`,`EmoteDelay3`,`EmoteDelay4`,`VerifiedBuild`) VALUES
(9139,1,0,0,0,0,0,0,0,0);
UPDATE `quest_offer_reward` SET `Emote1`=1 WHERE `ID`=9139;

-- Culinary Crunch (9171)
DELETE FROM `quest_details` WHERE `ID`=9171;
INSERT INTO `quest_details` (`ID`,`Emote1`,`Emote2`,`Emote3`,`Emote4`,`EmoteDelay1`,`EmoteDelay2`,`EmoteDelay3`,`EmoteDelay4`,`VerifiedBuild`) VALUES
(9171,5,1,0,0,0,0,0,0,0);
UPDATE `quest_offer_reward` SET `Emote1`=1,`Emote2`=1,`Emote3`=1 WHERE `ID`=9171;

-- Retaking Windrunner Spire (9173)
DELETE FROM `quest_details` WHERE `ID`=9173;
INSERT INTO `quest_details` (`ID`,`Emote1`,`Emote2`,`Emote3`,`Emote4`,`EmoteDelay1`,`EmoteDelay2`,`EmoteDelay3`,`EmoteDelay4`,`VerifiedBuild`) VALUES
(9173,1,0,0,0,0,0,0,0,0);
UPDATE `quest_request_items` SET `EmoteOnIncomplete`=6 WHERE `ID`=9173;
UPDATE `quest_offer_reward` SET `Emote1`=1 WHERE `ID`=9173;

-- Trouble at the Underlight Mines (9192)
DELETE FROM `quest_details` WHERE `ID`=9192;
INSERT INTO `quest_details` (`ID`,`Emote1`,`Emote2`,`Emote3`,`Emote4`,`EmoteDelay1`,`EmoteDelay2`,`EmoteDelay3`,`EmoteDelay4`,`VerifiedBuild`) VALUES
(9192,1,5,0,0,0,0,0,0,0);
UPDATE `quest_request_items` SET `EmoteOnIncomplete`=6 WHERE `ID`=9192;
UPDATE `quest_offer_reward` SET `Emote1`=1 WHERE `ID`=9192;

-- Investigate An'daroth (9160)
DELETE FROM `quest_details` WHERE `ID`=9160;
INSERT INTO `quest_details` (`ID`,`Emote1`,`Emote2`,`Emote3`,`Emote4`,`EmoteDelay1`,`EmoteDelay2`,`EmoteDelay3`,`EmoteDelay4`,`VerifiedBuild`) VALUES
(9160,1,0,0,0,0,0,0,0,0);
UPDATE `quest_request_items` SET `EmoteOnIncomplete`=6 WHERE `ID`=9160;
UPDATE `quest_offer_reward` SET `Emote1`=1 WHERE `ID`=9160;

-- Help Ranger Valanna! (9145)
DELETE FROM `quest_details` WHERE `ID`=9145;
INSERT INTO `quest_details` (`ID`,`Emote1`,`Emote2`,`Emote3`,`Emote4`,`EmoteDelay1`,`EmoteDelay2`,`EmoteDelay3`,`EmoteDelay4`,`VerifiedBuild`) VALUES
(9145,5,1,0,0,0,0,0,0,0);
UPDATE `quest_offer_reward` SET `Emote1`=1 WHERE `ID`=9145;

-- The Sad Truth (10548)
DELETE FROM `quest_details` WHERE `ID`=10548;
INSERT INTO `quest_details` (`ID`,`Emote1`,`Emote2`,`Emote3`,`Emote4`,`EmoteDelay1`,`EmoteDelay2`,`EmoteDelay3`,`EmoteDelay4`,`VerifiedBuild`) VALUES
(10548,1,5,1,0,0,0,0,0,0);
UPDATE `quest_offer_reward` SET `Emote1`=1,`Emote2`=5 WHERE `ID`=10548;

-- Tomber's Supplies (9152)
UPDATE `quest_offer_reward` SET `Emote1`=1 WHERE `ID`=9152;

-- Return the Reports (9618)
UPDATE `quest_request_items` SET `EmoteOnComplete`=6 WHERE `ID`=9618;
UPDATE `quest_offer_reward` SET `Emote1`=1,`Emote2`=5,`Emote3`=1 WHERE `ID`=9618;

-- Combining Forces (9460)
DELETE FROM `quest_details` WHERE `ID`=9460;
INSERT INTO `quest_details` (`ID`,`Emote1`,`Emote2`,`Emote3`,`Emote4`,`EmoteDelay1`,`EmoteDelay2`,`EmoteDelay3`,`EmoteDelay4`,`VerifiedBuild`) VALUES
(9460,66,6,1,0,0,0,0,0,0);
UPDATE `quest_request_items` SET `EmoteOnIncomplete`=6,`EmoteOnComplete`=6 WHERE `ID`=9460;
UPDATE `quest_offer_reward` SET `Emote1`=5,`Emote2`=25 WHERE `ID`=9460;

-- Anok'suten (9315)
UPDATE `quest_request_items` SET `EmoteOnIncomplete`=5 WHERE `ID`=9315;
UPDATE `quest_offer_reward` SET `Emote1`=1 WHERE `ID`=9315;

-- Escape from the Catacombs (9212)
DELETE FROM `quest_details` WHERE `ID`=9212;
INSERT INTO `quest_details` (`ID`,`Emote1`,`Emote2`,`Emote3`,`Emote4`,`EmoteDelay1`,`EmoteDelay2`,`EmoteDelay3`,`EmoteDelay4`,`VerifiedBuild`) VALUES
(9212,1,0,0,0,0,0,0,0,0);
UPDATE `quest_request_items` SET `EmoteOnIncomplete`=6 WHERE `ID`=9212;
UPDATE `quest_offer_reward` SET `Emote1`=1 WHERE `ID`=9212;

-- Return to Quartermaster Lymel (9135)
DELETE FROM `quest_details` WHERE `ID`=9135;
INSERT INTO `quest_details` (`ID`,`Emote1`,`Emote2`,`Emote3`,`Emote4`,`EmoteDelay1`,`EmoteDelay2`,`EmoteDelay3`,`EmoteDelay4`,`VerifiedBuild`) VALUES
(9135,1,0,0,0,0,0,0,0,0);
UPDATE `quest_request_items` SET `EmoteOnComplete`=6 WHERE `ID`=9135;
UPDATE `quest_offer_reward` SET `Emote1`=1 WHERE `ID`=9135;

-- Skymistress Gloaming (9134)
DELETE FROM `quest_details` WHERE `ID`=9134;
INSERT INTO `quest_details` (`ID`,`Emote1`,`Emote2`,`Emote3`,`Emote4`,`EmoteDelay1`,`EmoteDelay2`,`EmoteDelay3`,`EmoteDelay4`,`VerifiedBuild`) VALUES
(9134,1,0,0,0,0,0,0,0,0);
UPDATE `quest_request_items` SET `EmoteOnComplete`=6 WHERE `ID`=9134;
UPDATE `quest_offer_reward` SET `Emote1`=6,`Emote2`=1 WHERE `ID`=9134; 

-- Suncrown Village (9138)
DELETE FROM `quest_details` WHERE `ID`=9138;
INSERT INTO `quest_details` (`ID`,`Emote1`,`Emote2`,`Emote3`,`Emote4`,`EmoteDelay1`,`EmoteDelay2`,`EmoteDelay3`,`EmoteDelay4`,`VerifiedBuild`) VALUES
(9138,1,5,0,0,0,0,0,0,0);
UPDATE `quest_offer_reward` SET `Emote1`=1 WHERE `ID`=9138; 

-- Return to Arcanist Vandril (9758)
DELETE FROM `quest_details` WHERE `ID`=9758;
INSERT INTO `quest_details` (`ID`,`Emote1`,`Emote2`,`Emote3`,`Emote4`,`EmoteDelay1`,`EmoteDelay2`,`EmoteDelay3`,`EmoteDelay4`,`VerifiedBuild`) VALUES
(9758,1,1,0,0,0,0,0,0,0);
UPDATE `quest_offer_reward` SET `Emote1`=1 WHERE `ID`=9758; 

-- Fly to Silvermoon City (9133)
DELETE FROM `quest_details` WHERE `ID`=9133;
INSERT INTO `quest_details` (`ID`,`Emote1`,`Emote2`,`Emote3`,`Emote4`,`EmoteDelay1`,`EmoteDelay2`,`EmoteDelay3`,`EmoteDelay4`,`VerifiedBuild`) VALUES
(9133,1,0,0,0,0,0,0,0,0);
UPDATE `quest_offer_reward` SET `Emote1`=5,`Emote2`=6 WHERE `ID`=9133; 

-- Goods from Silvermoon City (9130)
DELETE FROM `quest_details` WHERE `ID`=9130;
INSERT INTO `quest_details` (`ID`,`Emote1`,`Emote2`,`Emote3`,`Emote4`,`EmoteDelay1`,`EmoteDelay2`,`EmoteDelay3`,`EmoteDelay4`,`VerifiedBuild`) VALUES
(9130,1,0,0,0,0,0,0,0,0);
UPDATE `quest_request_items` SET `EmoteOnComplete`=6 WHERE `ID`=9130;
UPDATE `quest_offer_reward` SET `Emote1`=1 WHERE `ID`=9130; 

-- Troll Juju (9199)
DELETE FROM `quest_details` WHERE `ID`=9199;
INSERT INTO `quest_details` (`ID`,`Emote1`,`Emote2`,`Emote3`,`Emote4`,`EmoteDelay1`,`EmoteDelay2`,`EmoteDelay3`,`EmoteDelay4`,`VerifiedBuild`) VALUES
(9199,1,0,0,0,0,0,0,0,0);
UPDATE `quest_offer_reward` SET `Emote1`=1 WHERE `ID`=9199; 

-- Investigate the Amani Catacombs (9193)
DELETE FROM `quest_details` WHERE `ID`=9193;
INSERT INTO `quest_details` (`ID`,`Emote1`,`Emote2`,`Emote3`,`Emote4`,`EmoteDelay1`,`EmoteDelay2`,`EmoteDelay3`,`EmoteDelay4`,`VerifiedBuild`) VALUES
(9193,1,0,0,0,0,0,0,0,0);
UPDATE `quest_offer_reward` SET `Emote1`=1 WHERE `ID`=9193; 

-- Greed (9491)
DELETE FROM `quest_details` WHERE `ID`=9491;
INSERT INTO `quest_details` (`ID`,`Emote1`,`Emote2`,`Emote3`,`Emote4`,`EmoteDelay1`,`EmoteDelay2`,`EmoteDelay3`,`EmoteDelay4`,`VerifiedBuild`) VALUES
(9491,1,1,5,0,0,0,0,0,0);
UPDATE `quest_offer_reward` SET `Emote1`=1,`Emote2`=5 WHERE `ID`=9491; 

-- The Forsaken (9327)
DELETE FROM `quest_details` WHERE `ID`=9327;
INSERT INTO `quest_details` (`ID`,`Emote1`,`Emote2`,`Emote3`,`Emote4`,`EmoteDelay1`,`EmoteDelay2`,`EmoteDelay3`,`EmoteDelay4`,`VerifiedBuild`) VALUES
(9327,1,0,0,0,0,0,0,0,0);
UPDATE `quest_offer_reward` SET `Emote1`=1,`Emote2`=1 WHERE `ID`=9327;

-- Ranger Lethvalin's gossip menu text changes when quest "Dealing with Zeb'Sora" (9143) is rewarded.
DELETE FROM `gossip_menu` WHERE `MenuID`=7158 AND `TextID`=8428;
INSERT INTO `gossip_menu` (`MenuID`, `TextID`, `VerifiedBuild`) VALUES
(7158,8428,0);

-- Condition
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=14 AND `SourceGroup`=7158;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(14,7158,8428,0,0,8,0,9143,0,0,0,0,0,"","Show gossip dialog text 8428 if Quest 'Dealing with Zeb'Sora' (9143) is rewarded");

-- Ranger Valanna's gossip menu text changes depending on different quest statuses.
-- NPC Text
DELETE FROM `npc_text` WHERE `ID`=8508;
INSERT INTO `npc_text` (`ID`,`text0_0`,`text0_1`,`Probability0`,`BroadcastTextId0`,`VerifiedBuild`) VALUES
(8508,"","I'm sure that help from Farstrider Enclave will be here soon to help me and this useless lieutenant get to safety. You might not want to stick around; I've heard all sorts of strange sounds coming from the lake and that village over yonder.",1,12101,0);

-- Gossip Menu
DELETE FROM `gossip_menu` WHERE `MenuID`=7159 AND `TextID`IN (8505,8508);
INSERT INTO `gossip_menu` (`MenuID`, `TextID`, `VerifiedBuild`) VALUES
(7159,8505,0),
(7159,8508,0);

-- Conditions
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=14 AND `SourceGroup`=7159;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(14,7159,8505,0,0,47,0,9145,10,0,1,0,0,"","Show gossip dialog text 8505 if Quest 'Help Ranger Valanna!' (9145) is not taken (active)"),
(14,7159,8508,0,0,47,0,9146,74,0,0,0,0,"","Show gossip dialog text 8508 if Quest 'Report to Captain Helios' (9146) is taken, completed or rewarded");

-- Farstrider Solanna's gossip menu text changes when the quest "Attack on Zeb'Tela" is active and changes again after it has been turned in. It allso changes when the quest "Assault on Zeb'Nowa" is rewarded
-- Gossip Menu
DELETE FROM `gossip_menu` WHERE `MenuID`=7253 AND `TextID` IN (8570,8571,8572);
INSERT INTO `gossip_menu` (`MenuID`, `TextID`, `VerifiedBuild`) VALUES
(7253,8570,0),
(7253,8571,0),
(7253,8572,0);

-- Conditions
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=14 AND `SourceGroup`=7253;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(14,7253,8569,0,0,47,0,9276,10,0,1,0,0,"","Show gossip dialog text 8569  if quest 'Attack on Zeb'Tela' (9276) is NOT taken"),
(14,7253,8570,0,0,47,0,9276,10,0,0,0,0,"","Show gossip dialog text 8570 if quest 'Attack on Zeb'Tela' (9276) is taken (active)"),
(14,7253,8571,0,0,8,0,9276,0,0,0,0,0,"","Gossip text 8571 requires quest 'Attack on Zeb'Tela' (9276) rewarded"),
(14,7253,8572,0,0,8,0,9277,0,0,0,0,0,"","Gossip text 8572 requires quest 'Attack on Zeb'Nowa' (9277) rewarded");

-- TODO: Fix core scripts (40301, 40312)
-- TODO: Fix invisibility detection issue (core)

-- Creature templates
UPDATE `creature_template_addon` SET `auras`='75165 75180 22650' WHERE `entry`=40305; -- 40305 (Spirit of the Tiger)

-- Gossips
DELETE FROM `gossip_menu` WHERE (`MenuID`=11394);
INSERT INTO `gossip_menu` (`MenuID`, `TextID`, `VerifiedBuild`) VALUES
(11394, 15873, 53788), -- 40492 (Zild'jian)
(11394, 15872, 53788), -- 40492 (Zild'jian)
(11394, 15871, 53788); -- 40492 (Zild'jian)

DELETE FROM `gossip_menu_option` WHERE (`MenuID`=21257);
DELETE FROM `gossip_menu_option` WHERE (`MenuID`=11341 AND `OptionID`=0);
INSERT INTO `gossip_menu_option` (`MenuID`, `OptionID`, `OptionIcon`, `OptionText`, `OptionBroadcastTextID`, `OptionType`, `OptionNpcFlag`, `ActionMenuID`, `ActionPoiID`, `BoxCoded`, `BoxMoney`, `BoxText`, `BoxBroadcastTextID`, `VerifiedBuild`) VALUES
(11341, 0, 0, 'Would you call down the Spirit of the Tiger again, Vanira?', 40445, 1, 1, 0, 0, 0, 0, NULL, 0, 53788);

DELETE FROM `npc_text` WHERE `ID`=15872;
INSERT INTO `npc_text` (`ID`, `text0_0`, `Probability0`, `Probability1`, `Probability2`, `Probability3`, `Probability4`, `Probability5`, `Probability6`, `Probability7`, `BroadcastTextId0`, `BroadcastTextId1`, `BroadcastTextId2`, `BroadcastTextId3`, `BroadcastTextId4`, `BroadcastTextId5`, `BroadcastTextId6`, `BroadcastTextId7`, `VerifiedBuild`) VALUES
(15872, 'De Echo Isles attack be startin'' soon!$B$BSit back and relax, dis song will be over in anotha $5071W minutes and then we''d be going.', 1, 0, 0, 0, 0, 0, 0, 0, 40475, 0, 0, 0, 0, 0, 0, 0, 53788); -- 15872

UPDATE `npc_text` SET `VerifiedBuild`=53788 WHERE `ID` IN (15865, 15873, 15877, 15876);
UPDATE `npc_text` SET `VerifiedBuild`=53788 WHERE `ID` IN (15806, 15846, 15796);

-- Misc
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=13 AND `SourceEntry` IN (74903, 74977);
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=17 AND `SourceEntry` IN (75159, 75160, 75161);
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=15 AND `SourceGroup`=11341;
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=15 AND `SourceGroup`=21257;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(13, 1, 74903, 0, 0, 31, 0, 3, 40187, 0, 0, 0, 0, '', 'Spell "Attune" can only target Vanira''s Sentry Totem'),
(13, 1, 74977, 0, 0, 31, 0, 3, 40218, 0, 0, 0, 0, '', 'Spell "Frogs Away!" can only target Spy Frog Credit'),
(17, 0, 75159, 0, 0, 31, 1, 3, 40312, 0, 0, 12, 0, '', 'Spell "Claw" can only target Tiger Matriarch'),
(17, 0, 75160, 0, 0, 31, 1, 3, 40312, 0, 0, 12, 0, '', 'Spell "Bloody Rip" can only target Tiger Matriarch'),
(17, 0, 75161, 0, 0, 31, 1, 3, 40312, 0, 0, 12, 0, '', 'Spell "Spinning Rake" can only target Tiger Matriarch'),
(15, 11341, 0, 0, 0, 47, 0, 25470, 10, 0, 0, 0, 0, '', 'Gossip menu option requires quest 25470 taken or completed'),
(15, 11341, 0, 0, 0, 1, 0, 75166, 0, 0, 1, 0, 0, '', 'Gossip menu option requires aura 25470 not applied');

UPDATE `creature_addon` SET `auras`='75038' WHERE `guid`=213977;

-- Quests
DELETE FROM `quest_details` WHERE `ID`=25470;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES
(25470, 1, 1, 1, 0, 0, 0, 0, 0, 53788); -- Lady Of Da Tigers

DELETE FROM `quest_request_items` WHERE `ID`=25470;
INSERT INTO `quest_request_items` (`ID`, `EmoteOnComplete`, `EmoteOnIncomplete`, `CompletionText`, `VerifiedBuild`) VALUES
(25470, 0, 1, 'Did you find out anythin'' about that tiger?', 53788); -- Lady Of Da Tigers

UPDATE `quest_offer_reward` SET `Emote1`=1, `Emote2`=1, `Emote3`=1, `VerifiedBuild`=53788 WHERE `ID`=25470; -- Lady Of Da Tigers

DELETE FROM `game_event_creature_quest` WHERE (`id`=40184 AND `quest` IN (25470));
DELETE FROM `creature_queststarter` WHERE (`id`=40184 AND `quest`=25470);
INSERT INTO `creature_queststarter` (`id`, `quest`) VALUES
(40184, 25470); -- Lady Of Da Tigers offered by Vanira

-- SAI
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry` IN (40305);

DELETE FROM `smart_scripts` WHERE `entryorguid` IN (40184, 40305) AND `source_type`=0;
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (4018400) AND `source_type`=9;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(40184,0,0,0,19,0,100,0,25470,0,0,0,0,80,4018400,2,0,0,0,0,1,0,0,0,0,0,0,0,0,'Vanira - On quest 25470 taken - Call timed actionlist'),
(40184,0,1,2,62,0,100,0,11341,0,0,0,0,11,75186,0,0,0,0,0,7,0,0,0,0,0,0,0,0,'Vanira - On gossip option 0 selected - Cast "Force Cast Spirit of the Tiger" on invoker'),
(40184,0,2,0,61,0,100,0,0,0,0,0,0,72,0,0,0,0,0,0,7,0,0,0,0,0,0,0,0,'Vanira - Event linked - Close gossip'),
(4018400,9,0,0,0,0,100,0,0,0,0,0,0,11,75186,0,0,0,0,0,7,0,0,0,0,0,0,0,0,'Actionlist - Vanira - Cast "Force Cast Spirit of the Tiger" on invoker'),
(4018400,9,1,0,0,0,100,0,0,0,0,0,0,1,0,0,1,0,0,0,7,0,0,0,0,0,0,0,0,'Actionlist - Vanira - Say line 1'),
(4018400,9,2,0,0,0,100,0,0,0,0,0,0,11,60957,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Actionlist - Vanira - Cast "Cosmetic Nature Cast"'),
(4018400,9,3,0,0,0,100,0,0,0,0,0,0,66,0,0,0,0,0,0,7,0,0,0,0,0,0,0,0,'Actionlist - Vanira - Face invoker'),
(4018400,9,4,0,0,0,100,0,2000,2000,0,0,0,66,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Actionlist - Vanira - Set original orientation'),

(40305,0,0,0,27,0,100,512,0,0,0,0,0,11,75166,2,0,0,0,0,1,0,0,0,0,0,0,0,0,'Spirit of the Tiger - On passenger boarded - Cast "Spirit of the Tiger Aura (Rider)"'),
(40305,0,1,0,28,0,100,512,0,0,0,0,0,11,75167,2,0,0,0,0,1,0,0,0,0,0,0,0,0,'Spirit of the Tiger - On passenger removed - Cast "Cancel Spirit of the Tiger"'),
(40305,0,2,0,6,0,100,512,0,0,0,0,0,11,50630,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Spirit of the Tiger - On death - Cast "Eject All Passengers"'),
(40305,0,3,4,60,0,100,512,500,500,3000,3000,0,1,0,0,1,0,0,0,23,0,0,0,0,0,0,0,0,'Spirit of the Tiger - On update (every 10s) - Say line 1'),
(40305,0,4,0,61,0,100,512,0,0,0,0,0,41,2500,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Spirit of the Tiger - Event linked - Despawn');

DELETE FROM `creature_text` WHERE `CreatureID` IN (40305);
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(40305, 0, 0, 'You must remain in the Echo Isles, Darkspear Strand, or Sen''jin Village.', 42, 0, 100, 0, 0, 0, 40345, 0, 'Spirit of the Tiger');

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=16 AND `SourceEntry`=40305;
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=22 AND `SourceGroup`=4 AND `SourceEntry`=40305 AND `SourceId`=0;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(22, 4, 40305, 0, 0, 23, 1, 367, 0, 0, 1, 0, 0, '', 'Smart event requires area not allowed'),
(22, 4, 40305, 0, 0, 23, 1, 368, 0, 0, 1, 0, 0, '', 'Smart event requires area not allowed'),
(22, 4, 40305, 0, 0, 23, 1, 393, 0, 0, 1, 0, 0, '', 'Smart event requires area not allowed');

-- re-add ignore LOS, still needed on certain coordinates
DELETE FROM `disables` WHERE `sourceType`=0 AND `entry`=69922;
INSERT INTO `disables` (`sourceType`, `entry`, `flags`, `params_0`, `params_1`, `comment`) VALUES
(0,69922,64,'','','Ignore LOS on Temper Quel Delar');

-- Captaion Helios gossip menu text
-- NPC Text
DELETE FROM `npc_text` WHERE `ID` IN (8493,8494,8496);
INSERT INTO `npc_text` (`ID`,`text0_0`,`text0_1`,`Probability0`,`Emote0_0`,`EmoteDelay0_1`,`Emote0_1`,`BroadcastTextId0`,`VerifiedBuild`) VALUES
(8493,"You've dealt the decisive blow against the Shadowpine trolls, $n. I only hope that we can muster our forces quickly enough to finish them off before they receive reinforcements from Zul'Aman.$B$BIt would be nice if Tranquillien were to reinforce us.","",1,1,0,0,12219,0),
(8494,"You're a one-$g man : woman; rescue machine. That's three of my Farstriders that you've saved now!","",1,1,0,0,12217,0),
(8496,"What can I say, $c? You're a true $g hero : heroine;! Not only have you personally saved many of my rangers, but you've dealt a decisive blow against the Shadowpine trolls. Are you sure that you don't want to stay here and be one of my Farstriders?$B$BFare well, $n.","",1,1,1000,2,12216,0);

-- Gossip Menu
DELETE FROM `gossip_menu` WHERE `MenuID`=7160 AND `TextID` IN (8493,8494,8495,8496);
INSERT INTO `gossip_menu` (`MenuID`, `TextID`, `VerifiedBuild`) VALUES
(7160,8493,0),
(7160,8494,0),
(7160,8495,0),
(7160,8496,0);

-- Conditions
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=14 AND `SourceGroup`=7160;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(14,7160,8496,0,4,8,0,9146,0,0,0,0,0,"","Gossip text 8496 requires quest 'Report to Captain Helios' (9146) rewarded and"),
(14,7160,8496,0,4,8,0,9212,0,0,0,0,0,"","Gossip text 8496 requires quest 'Escape from the Catacombs' (9212) rewarded and"),
(14,7160,8496,0,4,8,0,9214,0,0,0,0,0,"","Gossip text 8496 requires quest 'Shadowpine Weaponry' (9214) rewarded and"),
(14,7160,8496,0,4,8,0,9215,0,0,0,0,0,"","Gossip text 8496 requires quest 'Bring Me Kel'gash's Head!' (9215) rewarded"),
(14,7160,8494,0,0,8,0,9146,0,0,0,0,0,"","Gossip text 8494 requires quest 'Report to Captain Helios' (9146) rewarded and"),
(14,7160,8494,0,0,8,0,9212,0,0,0,0,0,"","Gossip text 8494 requires quest 'Escape from the Catacombs' (9212) rewarded and"),
(14,7160,8494,0,0,8,0,9214,0,0,1,0,0,"","Gossip text 8494 requires quest 'Shadowpine Weaponry' (9214) not rewarded and"),
(14,7160,8494,0,0,8,0,9215,0,0,1,0,0,"","Gossip text 8494 requires quest 'Bring Me Kel'gash's Head!' (9215) not rewarded"),
(14,7160,8495,0,1,47,0,9214,10,0,0,0,0,"","Show gossip dialog text 8495 if Quest 'Shadowpine Weaponry' (9214) is taken (active) and completed or"),
(14,7160,8495,0,2,47,0,9215,10,0,0,0,0,"","Show gossip dialog text 8495 if Quest 'Bring Me Kel'gash's Head!' (9215) is taken (active) and completed"),
(14,7160,8493,0,3,8,0,9214,0,0,0,0,0,"","Gossip text 8493 requires quest 'Shadowpine Weaponry rewarded' (9214) and"),
(14,7160,8493,0,3,8,0,9215,0,0,0,0,0,"","Gossip text 8493 requires quest 'Bring Me Kel'gash's Head!' (9215) rewarded and");

-- Dame Auriferous gossip menu text changes when quest "Investigate An'daroth" is active and rewarded. Her gossip menu also changes when quest "Deactivate An'owyn" is rewarded
-- Gossip Menu
DELETE FROM `gossip_menu` WHERE `MenuID`=7163 AND `TextID` IN (8439,8440);
INSERT INTO `gossip_menu` (`MenuID`, `TextID`, `VerifiedBuild`) VALUES
(7163,8439,0),
(7163,8440,0);

-- Conditions
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=14 AND `SourceGroup`=7163;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(14,7163,8433,0,0,47,0,9160,74,0,1,0,0,"","Show gossip dialog text 8433  if Quest 'Investigate An'daroth' is NOT taken"),
(14,7163,8439,0,0,47,0,9160,74,0,0,0,0,"","Show gossip dialog text 8439 if Quest 'Investigate An'daroth' is taken (active)"),
(14,7163,8440,0,0,8,0,9169,0,0,0,0,0,"","Gossip text 8440 requires quest 'Deactivate An'owyn' rewarded");

-- Deathstalker Maltendis gossip menu change after turning in quest "Troll Juju" and again after turning in "Trouble at the Underlight Mines"
-- NPC Text
DELETE FROM `npc_text` WHERE `ID` IN (8490,8491);
INSERT INTO `npc_text` (`ID`,`text0_0`,`text0_1`,`Probability0`,`Emote0_0`,`EmoteDelay0_1`,`Emote0_1`,`BroadcastTextId0`,`VerifiedBuild`) VALUES
(8490,"Good to see you again, $g man! : gorgeous!; We work well together; $g see you around. : I hope we get to continue to do so.;","",1,2,0,0,12214,0),
(8491,"You've done us exemplary service, $n. Between dealing with the gnolls at the Underlight Mines, and the mummified trolls in the Amani Catacombs, you've dealt a mighty blow to our enemies!$B$B$G Good job! : We should get together for drinks sometime, what do you say?;","",1,1,1000,2,12213,0);

-- Gossip Menu
DELETE FROM `gossip_menu` WHERE `MenuID`=7207 AND `TextID` IN (8490,8491);
INSERT INTO `gossip_menu` (`MenuID`, `TextID`, `VerifiedBuild`) VALUES
(7207,8490,0),
(7207,8491,0);

-- Conditions
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=14 AND `SourceGroup`=7207;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(14,7207,8490,0,0,8,0,9199,0,0,0,0,0,"","Gossip text 8490 requires quest 'Troll Juju' rewarded or"),
(14,7207,8490,0,1,8,0,9192,0,0,0,0,0,"","Gossip text 8490 requires quest 'Trouble at the Underlight Mines' rewarded"),
(14,7207,8491,0,2,8,0,9199,0,0,0,0,0,"","Gossip text 8491 requires quest 'Troll Juju' rewarded and"),
(14,7207,8491,0,2,8,0,9192,0,0,0,0,0,"","Gossip text 8491 requires quest 'Trouble at the Underlight Mines' rewarded");

-- Advisor Valwyn gossip menu changes when quest "Investigate the Amani Catacombs" is active and changes again after it has been turned in
-- Gossip Menu
DELETE FROM `gossip_menu` WHERE `MenuID`=7188 AND `TextID` IN (8467,8468);
INSERT INTO `gossip_menu` (`MenuID`, `TextID`, `VerifiedBuild`) VALUES
(7188,8467,0),
(7188,8468,0);

-- Conditions
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=14 AND `SourceGroup`=7188;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(14,7188,8468,0,0,8,0,9193,0,0,0,0,0,"","Gossip text 8491 requires quest 'Investigate the Amani Catacombs' rewarded"),
(14,7188,8467,0,0,47,0,9193,10,0,0,0,0,"","Show gossip dialog text 8467 if Quest 'Investigate the Amani Catacombs' is taken (active)");

-- Arcanist Vandril gossip menu changes when quest "Delivery to Tranquillien" is active, when "Suncrown Village" is active, when Goldenmist Village is active and when "Windrunner Village" is active and after it is completed.
-- Gossip Menu
DELETE FROM `gossip_menu` WHERE `MenuID`=7153 AND `TextID` IN (8561,8425,8426);
INSERT INTO `gossip_menu` (`MenuID`, `TextID`, `VerifiedBuild`) VALUES
(7153,8425,0),
(7153,8426,0),
(7153,8561,0);

-- Conditions
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=14 AND `SourceGroup`=7153;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(14,7153,8561,0,0,47,0,9148,10,0,0,0,0,"","Show gossip dialog text 8561 if Quest 'Delivery to Tranquillien' is taken (active)"),
(14,7153,8426,0,0,8,0,9140,0,0,0,0,0,"","Gossip text 8226 requires quest 'Windrunner Village' rewarded"),
(14,7153,8425,0,0,47,0,9138,10,0,0,0,0,"","Show gossip dialog text 8425 if Quest 'Suncrown Village' is taken (active)"),
(14,7153,8425,0,1,47,0,9139,10,0,0,0,0,"","Show gossip dialog text 8425 if Quest 'Goldenmist Village' is taken (active)"),
(14,7153,8425,0,2,47,0,9140,10,0,0,0,0,"","Show gossip dialog text 8425 if Quest 'Windrunner Village' is taken (active)");

-- The quest "Escape from the Catacombs" is missing Completion Text
UPDATE `quest_request_items` SET `CompletionText`="You're the one that rescued my ranger?" WHERE `ID`=9212;

-- Magister Sylastor is missing an Gossip Menu
-- Add creature Flag and Gossip Menu
UPDATE `creature_template` SET `npcflag`=`npcflag`|1,`gossip_menu_id`=57031 WHERE `entry` = 16237;

-- Gossip Menu
DELETE FROM `gossip_menu` WHERE `MenuID`=57031 AND `TextID` IN (8441,8442,8650);
INSERT INTO `gossip_menu` (`MenuID`, `TextID`, `VerifiedBuild`) VALUES
(57031,8441,0),
(57031,8442,0),
(57031,8650,0);

-- Conditions
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=14 AND `SourceGroup`=57031;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(14,57031,8650,0,0,8,0,9166,0,0,0,0,0,"","Gossip text 8650 requires quest 'Deliver the Plans to An'telas' rewarded and"),
(14,57031,8650,0,0,8,0,9169,0,0,1,0,0,"","Gossip text 8650 requires quest 'Deactivate An'owyn' not rewarded"),
(14,57031,8442,0,0,8,0,9169,0,0,0,0,0,"","Gossip text 8467 requires quest 'Deactivate An'owyn' rewarded");

-- Returning the Lost Satchel
UPDATE `quest_offer_reward` SET `Emote1`=2,`Emote2`=1 WHERE `ID`=5724;

-- Searching for the Lost Satchel
UPDATE `quest_details` SET `Emote2`=1 WHERE `ID`=5722;

-- The Barrens Oases
UPDATE `quest_offer_reward` SET `Emote1`=2 WHERE `ID`=886;

-- Rites of the Earthmother
UPDATE `quest_offer_reward` SET `Emote2`=21 WHERE `ID`=776;

-- A Sacred Burial
UPDATE `quest_request_items` SET `EmoteOnComplete`=5 WHERE `ID`=833;

-- The Ravaged Caravan
UPDATE `quest_details` SET `Emote1`=1 WHERE `ID`=749;

-- Kyle's Gone Missing!
UPDATE `quest_details` SET `Emote1`=5,`Emote2`=1,`Emote3`=1,`Emote4`=1 WHERE `ID`=11129;
UPDATE `quest_request_items` SET `EmoteOnComplete`=6,`EmoteOnIncomplete`=6 WHERE `ID`=11129;
UPDATE `quest_offer_reward` SET `Emote1`=4,`Emote2`=1,`Emote3`=1 WHERE `ID`=11129;

-- Dangers of the Windfury
UPDATE `quest_details` SET `Emote1`=2,`Emote3`=1 WHERE `ID`=743;

-- The Hunt Begins (Wrong use of "$c")
UPDATE `quest_request_items` SET `CompletionText`="Providing meat and feathers for the tribe is the first step in proving yourself as a hunter before the Chief." WHERE `ID`=747;

-- Break Sharptusk! (Upper case "$c") 
UPDATE `quest_offer_reward` SET `RewardText`="Justice has been served on this day by your swift actions, $N.  Let this deed serve as a warning to all who would threaten our home.$b$bYou have earned this reward to help you on your sojourn, young $c." WHERE `ID`=3376;

-- The Hunt Begins (Wrong use of "$r")
UPDATE `quest_offer_reward` SET `RewardText`="The tauren of Narache thank you, $N. You show much promise." WHERE `ID`=747;

-- The Hunt Continues (Wrong use of "$r")
UPDATE `quest_offer_reward` SET `RewardText`="The tauren of Narache thank you for these provisions, $N. With your skill in the ways of the hunt you will surely be revered in Thunder Bluff someday." WHERE `ID`=750;

-- Rites of the Earthmother (Upper case "$c")
UPDATE `quest_request_items` SET `CompletionText`="What brings you to my village, $c?" WHERE `ID`=763;

-- Swoop Hunting (Upper case "$c")
UPDATE `quest_offer_reward` SET `RewardText`="I know that gathering these quills was not an easy task, $N.  In doing this, you prove that you are a $c of merit.  It is good to have you at Bloodhoof Village." WHERE `ID`=761;

-- The Demon Scarred Cloak (Wrong use of "$c" and upper case "$c")
UPDATE `quest_offer_reward` SET `RewardText`="I can barely believe my old eyes!  You defeated the great wolf Ghost Howl?  I look upon you with new respect, young $c.  You are a hunter of extreme skills!$b$bLet me offer you something.  My days of hunting are over, but I would be honored if you used one of my weapons in your hunts.$b$bMay it strike true, and bring you renown.$b$bAnd let us hope that Ghost Howl's spirit has finally found peace." WHERE `ID`=770;

-- The Hunter's Way (Wrong use of "$c")
UPDATE `quest_offer_reward` SET `RewardText`="Skorn Whitecloud is a wise tauren.  He has hunted for years and years, and although his body is old, his spirit burns fiercely.  We are honored to have him with us.$b$bIf Skorn sent you to me, then you too must have the hunter's spirit.  And to have gathered these claws shows your burgeoning skills.$b$bPerhaps you are ready to walk the path." WHERE `ID`=861;

-- Journey into Thunder Bluff (Upper case "$c")
UPDATE `quest_offer_reward` SET `RewardText`="Hail, young $c. I see you found your way to my doorstep." WHERE `ID`=775;

-- The Barrens Oases (Upper case "$c")
UPDATE `quest_offer_reward` SET `RewardText`="My brethren in Thunder Bluff were wise to send you, young $c.  For the mystery of the Barrens is one that I alone cannot unravel.$B$BWith your aid, let us hope we can find answers to our questions." WHERE `ID`=886;

-- Quest is missing Reward next quest
UPDATE `quest_template` SET `RewardNextQuest`=763 WHERE `Id`=757;

-- Allegiance to the Horde
UPDATE `quest_offer_reward` SET `Emote1`=2 WHERE `ID`=9627;

-- Meeting the Warchief
UPDATE `quest_offer_reward` SET `Emote1`=6 WHERE `ID`=9626;

-- Hidden Enemies (5730)
DELETE FROM `quest_details` WHERE `ID`=5730;
INSERT INTO `quest_details` (`ID`,`Emote1`,`Emote2`,`Emote3`,`Emote4`,`EmoteDelay1`,`EmoteDelay2`,`EmoteDelay3`,`EmoteDelay4`,`VerifiedBuild`) VALUES
(5730,6,1,1,0,0,0,0,0,0);
UPDATE `quest_offer_reward` SET `Emote1`=1,`Emote2`=1,`Emote3`=4 WHERE `ID`=5730;

-- Hidden Enemies (5729)
DELETE FROM `quest_details` WHERE `ID`=5729;
INSERT INTO `quest_details` (`ID`,`Emote1`,`Emote2`,`Emote3`,`Emote4`,`EmoteDelay1`,`EmoteDelay2`,`EmoteDelay3`,`EmoteDelay4`,`VerifiedBuild`) VALUES
(5729,1,1,0,0,0,0,0,0,0);
UPDATE `quest_offer_reward` SET `Emote1`=5,`Emote2`=2 WHERE `ID`=5729;

-- Hidden Enemies (5728)
UPDATE `quest_request_items` SET `EmoteOnIncomplete`=6 WHERE `ID`=5728;
UPDATE `quest_offer_reward` SET `Emote1`=4,`Emote2`=1 WHERE `ID`=5728;

-- Hidden Enemies (5727)
UPDATE `quest_details` SET `Emote2`=1 WHERE `ID`=5727;
UPDATE `quest_request_items` SET `EmoteOnComplete`=6 WHERE `ID`=5727;
UPDATE `quest_offer_reward` SET `Emote2`=1 WHERE `ID`=5727;

-- Hidden Enemies (5726)
UPDATE `quest_details` SET `Emote2`=1 WHERE `ID`=5726;
UPDATE `quest_offer_reward` SET `Emote2`=1,`Emote3`=1 WHERE `ID`=5726;

-- Slaying the Beast
DELETE FROM `quest_details` WHERE `ID`=5761;
INSERT INTO `quest_details` (`ID`,`Emote1`,`Emote2`,`Emote3`,`Emote4`,`EmoteDelay1`,`EmoteDelay2`,`EmoteDelay3`,`EmoteDelay4`,`VerifiedBuild`) VALUES
(5761,1,1,0,0,0,0,0,0,0);
UPDATE `quest_request_items` SET `EmoteOnComplete`=6,`EmoteOnIncomplete`=6 WHERE `ID`=5761;
UPDATE `quest_offer_reward` SET `Emote1`=4,`Emote2`=1 WHERE `ID`=5761;

-- Hinott's Assistance
DELETE FROM `quest_details` WHERE `ID`=2479;
INSERT INTO `quest_details` (`ID`,`Emote1`,`Emote2`,`Emote3`,`Emote4`,`EmoteDelay1`,`EmoteDelay2`,`EmoteDelay3`,`EmoteDelay4`,`VerifiedBuild`) VALUES
(2479,1,1,0,0,0,0,0,0,0);

-- Deep Cover
UPDATE `quest_offer_reward` SET `Emote1`=1,`Emote2`=1 WHERE `ID`=2458;

-- The Shattered Salute
DELETE FROM `quest_details` WHERE `ID`=2460;
INSERT INTO `quest_details` (`ID`,`Emote1`,`Emote2`,`Emote3`,`Emote4`,`EmoteDelay1`,`EmoteDelay2`,`EmoteDelay3`,`EmoteDelay4`,`VerifiedBuild`) VALUES
(2460,1,1,0,0,0,0,0,0,0);
UPDATE `quest_request_items` SET `EmoteOnComplete`=5,`EmoteOnIncomplete`=5 WHERE `ID`=2460;

-- Rogues of the Shattered Hand
UPDATE `quest_offer_reward` SET `Emote1`=6,`Emote2`=1 WHERE `ID`=10794;

-- Find the Shattered Hand
UPDATE `quest_offer_reward` SET `Emote1`=6 WHERE `ID`=2378;

-- The Admiral's Orders
UPDATE `quest_request_items` SET `EmoteOnComplete`=6,`EmoteOnIncomplete`=6 WHERE `ID`=831;
UPDATE `quest_offer_reward` SET `Emote2`=1 WHERE `ID`=831;

-- Burning Shadows
UPDATE `quest_request_items` SET `EmoteOnComplete`=2,`EmoteOnComplete`=2 WHERE `ID`=832;
UPDATE `quest_offer_reward` SET `Emote2`=2,`EmoteDelay1`=0 WHERE `ID`=832;

-- Finding the Antidote
UPDATE `quest_details` SET `Emote2`=1 WHERE `ID`=813;

-- Need for a Cure
UPDATE `quest_details` SET `Emote2`=1,`Emote3`=1 WHERE `ID`=812;

-- Margoz
UPDATE `quest_offer_reward` SET `Emote2`=1 WHERE `ID`=828;

-- Dark Storms
UPDATE `quest_offer_reward` SET `Emote2`=1 WHERE `ID`=806;

-- Securing the Lines
UPDATE `quest_details` SET `Emote3`=6 WHERE `ID`=835;

-- Lost But Not Forgotten
UPDATE `quest_details` SET `Emote2`=1,`Emote3`=20 WHERE `ID`=816;
UPDATE `quest_offer_reward` SET `Emote2`=1 WHERE `ID`=816;

-- Break a Few Eggs
UPDATE `quest_request_items` SET `EmoteOnComplete`=1,`EmoteOnIncomplete`=1 WHERE `ID`=815;

-- The Admiral's Orders
DELETE FROM `quest_details` WHERE `ID`=831;
INSERT INTO `quest_details` (`ID`,`Emote1`,`Emote2`,`Emote3`,`Emote4`,`EmoteDelay1`,`EmoteDelay2`,`EmoteDelay3`,`EmoteDelay4`,`VerifiedBuild`) VALUES
(831,1,5,0,0,0,0,0,0,0);

-- From The Wreckage....
UPDATE `quest_details` SET `Emote2`=1 WHERE `ID`=825;

-- Vanquish the Betrayers
UPDATE `quest_details` SET `Emote2`=1,`Emote3`=1 WHERE `ID`=784;
UPDATE `quest_request_items` SET `EmoteOnIncomplete`=25 WHERE `ID`=784;

-- A Solvent Spirit
UPDATE `quest_offer_reward` SET `Emote2`=1,`Emote3`=4 WHERE `ID`=818;

-- Practical Prey
UPDATE `quest_details` SET `Emote2`=1,`Emote3`=1 WHERE `ID`=817;
UPDATE `quest_offer_reward` SET `Emote2`=1,`Emote4`=4 WHERE `ID`=817;

-- Thwarting Kolkar Aggression
UPDATE `quest_request_items` SET `EmoteOnComplete`=5 WHERE `ID`=786;

-- Your Place In The World
UPDATE `quest_offer_reward` SET `Emote3`=1,`Emote4`=4 WHERE `ID`=4641;

SET @CGUID := 208509;
SET @OGUID := 152118;
SET @EVENT := 82;

-- Creature templates
DELETE FROM `creature_template_addon` WHERE `entry` IN (39711 /*39711 (Mechano-Tank Attack Target)*/, 39678 /*39678 (Toby Zeigear)*/, 39624 /*39624 (Motivated Citizen)*/, 39466 /*39466 (Motivated Citizen)*/, 39396 /*39396 ('Thunderflash')*/, 39386 /*39386 (Pilot Muzzlesprock)*/, 39368 /*39368 (Drill Sergeant Steamcrank)*/, 39349 /*39349 (Gnomeregan Trainee)*/, 39275 /*Gnomeregan Medic*/);
INSERT INTO `creature_template_addon` (`entry`, `mount`, `StandState`, `AnimTier`, `VisFlags`, `SheathState`, `PvpFlags`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(39711, 0, 0, 0, 0, 1, 0, 0, 0, ''), -- 39711 (Mechano-Tank Attack Target)
(39678, 0, 0, 0, 0, 1, 0, 0, 0, ''), -- 39678 (Toby Zeigear)
(39624, 0, 0, 0, 0, 1, 0, 0, 0, ''), -- 39624 (Motivated Citizen)
(39466, 0, 0, 0, 0, 1, 0, 0, 0, ''), -- 39466 (Motivated Citizen)
(39396, 0, 1, 3, 0, 1, 0, 0, 0, ''), -- 39396 ('Thunderflash')
(39386, 0, 0, 0, 0, 1, 0, 0, 0, ''), -- 39386 (Pilot Muzzlesprock)
(39368, 0, 0, 0, 0, 1, 0, 0, 0, ''), -- 39368 (Drill Sergeant Steamcrank)
(39349, 0, 0, 0, 0, 1, 0, 0, 0, ''), -- 39349 (Gnomeregan Trainee)
(39275, 0, 0, 0, 0, 1, 0, 0, 0, ''); -- 39275 (Gnomeregan Medic)

DELETE FROM `creature_template_movement` WHERE `CreatureId` IN (39396, 39420, 39711);
INSERT INTO `creature_template_movement` (`CreatureId`, `Ground`, `Swim`, `Flight`, `Rooted`, `Chase`, `Random`, `InteractionPauseTimer`) VALUES
(39396, 0, 0, 1, 0, 0, 0, NULL),
(39420, 0, 0, 1, 1, 0, 0, NULL),
(39711, 0, 0, 1, 1, 0, 0, NULL);

-- Old creature spawns
DELETE FROM `creature` WHERE `guid` IN (130847, 130848, 130849, 130853, 130855, 130906, 130907, 130908, 130971);
DELETE FROM `creature` WHERE `guid` BETWEEN 207174 AND 207209;
DELETE FROM `creature_addon` WHERE `guid` IN (130847, 130848, 130849, 130853, 130855, 130906, 130907, 130908, 130971);
DELETE FROM `creature_addon` WHERE `guid` BETWEEN 207174 AND 207209;
DELETE FROM `game_event_creature` WHERE `guid` BETWEEN 207174 AND 207209;
DELETE FROM `game_event_creature` WHERE `guid` IN (130847, 130848, 130849, 130853, 130855, 130906, 130907, 130908, 130971);

-- Creature spawns
DELETE FROM `creature` WHERE `guid` BETWEEN @CGUID+0 AND @CGUID+54;
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `VerifiedBuild`) VALUES
-- Steelgrill's Depot
(@CGUID+0, 39263, 0, 1, 189, 1, 1, 0, 0, -5456.2587890625, -671.8507080078125, 393.0345458984375, 0.645771801471710205, 120, 0, 0, 42, 100, 0, 53788), -- Disassembled Mechano-Tank (Area: Steelgrill's Depot - Difficulty: 0) CreateObject1 (Auras: 29266 - Permanent Feign Death)
(@CGUID+1, 39263, 0, 1, 189, 1, 1, 0, 0, -5462.94091796875, -675.2725830078125, 392.849609375, 2.565634012222290039, 120, 0, 0, 42, 100, 0, 53788), -- Disassembled Mechano-Tank (Area: Steelgrill's Depot - Difficulty: 0) CreateObject1 (Auras: 29266 - Permanent Feign Death)
(@CGUID+2, 39263, 0, 1, 189, 1, 1, 0, 0, -5469.34912109375, -674.9461669921875, 392.5477294921875, 3.769911050796508789, 120, 0, 0, 42, 100, 0, 53788), -- Disassembled Mechano-Tank (Area: Steelgrill's Depot - Difficulty: 0) CreateObject1 (Auras: 29266 - Permanent Feign Death)
(@CGUID+3, 39349, 0, 1, 189, 1, 1, 0, 1, -5422.046875, -632.66668701171875, 394.719482421875, 4.729842185974121093, 120, 0, 0, 176, 0, 0, 53788), -- Gnomeregan Trainee (Area: Steelgrill's Depot - Difficulty: 0) CreateObject1 (Auras: )
(@CGUID+4, 39349, 0, 1, 189, 1, 1, 0, 1, -5424.9306640625, -629.92535400390625, 394.91375732421875, 4.729842185974121093, 120, 0, 0, 176, 0, 0, 53788), -- Gnomeregan Trainee (Area: Steelgrill's Depot - Difficulty: 0) CreateObject1 (Auras: )
(@CGUID+5, 39349, 0, 1, 189, 1, 1, 0, 1, -5427.7880859375, -630.07464599609375, 394.7366943359375, 4.729842185974121093, 120, 0, 0, 176, 0, 0, 53788), -- Gnomeregan Trainee (Area: Steelgrill's Depot - Difficulty: 0) CreateObject1
(@CGUID+6, 39349, 0, 1, 189, 1, 1, 0, 1, -5427.9931640625, -632.55731201171875, 394.62030029296875, 4.729842185974121093, 120, 0, 0, 156, 0, 0, 53788), -- Gnomeregan Trainee (Area: Steelgrill's Depot - Difficulty: 0) CreateObject1 (Auras: )
(@CGUID+7, 39349, 0, 1, 189, 1, 1, 0, 1, -5428.20166015625, -628.0225830078125, 394.84637451171875, 4.729842185974121093, 120, 0, 0, 156, 0, 0, 53788), -- Gnomeregan Trainee (Area: Steelgrill's Depot - Difficulty: 0) CreateObject1 (Auras: )
(@CGUID+8, 39349, 0, 1, 189, 1, 1, 0, 1, -5419.32275390625, -630.03125, 394.83953857421875, 4.729842185974121093, 120, 0, 0, 156, 0, 0, 53788), -- Gnomeregan Trainee (Area: Steelgrill's Depot - Difficulty: 0) CreateObject1 (Auras: )
(@CGUID+9, 39349, 0, 1, 189, 1, 1, 0, 1, -5428.2900390625, -635.16668701171875, 394.535614013671875, 4.729842185974121093, 120, 0, 0, 176, 0, 0, 53788), -- Gnomeregan Trainee (Area: Steelgrill's Depot - Difficulty: 0) CreateObject1 (Auras: )
(@CGUID+10, 39349, 0, 1, 189, 1, 1, 0, 1, -5422.27783203125, -628.24481201171875, 395.105010986328125, 4.729842185974121093, 120, 0, 0, 198, 0, 0, 53788), -- Gnomeregan Trainee (Area: Steelgrill's Depot - Difficulty: 0) CreateObject1 (Auras: )
(@CGUID+11, 39349, 0, 1, 189, 1, 1, 0, 1, -5425.080078125, -635.295166015625, 394.43603515625, 4.729842185974121093, 120, 0, 0, 176, 0, 0, 53788), -- Gnomeregan Trainee (Area: Steelgrill's Depot - Difficulty: 0) CreateObject1 (Auras: )
(@CGUID+12, 39349, 0, 1, 189, 1, 1, 0, 1, -5425.36279296875, -627.8125, 395.06195068359375, 4.729842185974121093, 120, 0, 0, 176, 0, 0, 53788), -- Gnomeregan Trainee (Area: Steelgrill's Depot - Difficulty: 0) CreateObject1
(@CGUID+13, 39349, 0, 1, 189, 1, 1, 0, 1, -5419.375, -627.920166015625, 395.061614990234375, 4.729842185974121093, 120, 0, 0, 156, 0, 0, 53788), -- Gnomeregan Trainee (Area: Steelgrill's Depot - Difficulty: 0) CreateObject1 (Auras: )
(@CGUID+14, 39349, 0, 1, 189, 1, 1, 0, 1, -5418.8525390625, -635.701416015625, 394.34320068359375, 4.729842185974121093, 120, 0, 0, 176, 0, 0, 53788), -- Gnomeregan Trainee (Area: Steelgrill's Depot - Difficulty: 0) CreateObject1 (Auras: )
(@CGUID+15, 39368, 0, 1, 189, 1, 1, 0, 1, -5424.02783203125, -638.08160400390625, 393.9921875, 1.588249532384327854, 120, 0, 0, 10635, 0, 0, 53788), -- Drill Sergeant Steamcrank (Area: Steelgrill's Depot - Difficulty: 0) CreateObject1 (Auras: )
(@CGUID+16, 39386, 0, 1, 189, 1, 1, 0, 0, -5444.3212890625, -665.154541015625, 393.80096435546875, 2.164208173751831054, 120, 0, 0, 12600, 0, 0, 53788), -- Pilot Muzzlesprock (Area: Steelgrill's Depot - Difficulty: 0) CreateObject1
(@CGUID+17, 39396, 0, 1, 189, 1, 1, 0, 0, -5447.55224609375, -667.30902099609375, 395.18896484375, 2.268928050994873046, 120, 0, 0, 1753, 0, 0, 53788), -- 'Thunderflash' (Area: Steelgrill's Depot - Difficulty: 0) CreateObject1
(@CGUID+18, 39675, 0, 1, 189, 1, 1, 0, 1, -5464.71728515625, -668.71527099609375, 393.602447509765625, 1.850049018859863281, 120, 0, 0, 10635, 0, 0, 53788), -- Captain Tread Sparknozzle (Area: Steelgrill's Depot - Difficulty: 0) CreateObject1 (Auras: 73954 - [DND] Persuaded)
(@CGUID+19, 39678, 0, 1, 189, 1, 1, 0, 0, -5461.8349609375, -626.95831298828125, 393.68707275390625, 5.183627605438232421, 120, 0, 0, 198, 0, 0, 53788), -- Toby Zeigear (Area: Steelgrill's Depot - Difficulty: 0) CreateObject1
(@CGUID+20, 39711, 0, 1, 189, 1, 1, 0, 0, -5453.7099609375, -701.3038330078125, 397.677825927734375, 0.418879032135009765, 120, 0, 0, 42, 0, 0, 53788), -- Mechano-Tank Attack Target (Area: Steelgrill's Depot - Difficulty: 0) CreateObject1
(@CGUID+21, 39711, 0, 1, 189, 1, 1, 0, 0, -5458.6962890625, -691.717041015625, 396.82049560546875, 0.418879032135009765, 120, 0, 0, 42, 0, 0, 53788), -- Mechano-Tank Attack Target (Area: Steelgrill's Depot - Difficulty: 0) CreateObject1
(@CGUID+22, 39715, 0, 1, 189, 1, 1, 0, 0, -5474.34375, -670.2725830078125, 392.29296875, 1.65806281566619873, 120, 0, 0, 42, 100, 0, 53788), -- Ejector Mechano-Tank (Area: Steelgrill's Depot - Difficulty: 0) CreateObject1
(@CGUID+23, 39716, 0, 1, 189, 1, 1, 0, 0, -5459.3349609375, -666.44964599609375, 392.48077392578125, 1.93731546401977539, 120, 0, 0, 42, 100, 0, 53788), -- Scuttling Mechano-Tank (Area: Steelgrill's Depot - Difficulty: 0) CreateObject1 (Auras: 16245 - Freeze Anim)
(@CGUID+24, 39717, 0, 1, 189, 1, 1, 0, 0, -5440.40625, -681.72918701171875, 395.342132568359375, 3.857177734375, 120, 0, 0, 42, 100, 0, 53788), -- Shooting Mechano-Tank (Area: Steelgrill's Depot - Difficulty: 0) CreateObject1 (Auras: 16245 - Freeze Anim)
-- Tinkertown
(@CGUID+25, 39420, 0, 1, 133, 1, 1, 0, 0, -5272.158203125, 471.59375, 386.891082763671875, 4.171336650848388671, 120, 0, 0, 42, 0, 0, 53788), -- [DND] Probe Target Bunny (Area: Iceflow Lake - Difficulty: 0) CreateObject1
(@CGUID+26, 39420, 0, 1, 133, 1, 1, 0, 0, -5299.33154296875, 466.90625, 386.6923828125, 4.171336650848388671, 120, 0, 0, 42, 0, 0, 53788), -- [DND] Probe Target Bunny (Area: Iceflow Lake - Difficulty: 0) CreateObject1
(@CGUID+27, 39420, 0, 1, 133, 1, 1, 0, 0, -5299.2880859375, 554.82293701171875, 386.44189453125, 4.171336650848388671, 120, 0, 0, 42, 0, 0, 53788), -- [DND] Probe Target Bunny (Area: Tinkertown - Difficulty: 0) CreateObject1
(@CGUID+28, 39420, 0, 1, 133, 1, 1, 0, 0, -5018.890625, 544.22918701171875, 474.3267822265625, 4.171336650848388671, 120, 0, 0, 42, 0, 0, 53788), -- [DND] Probe Target Bunny (Area: Iceflow Lake - Difficulty: 0) CreateObject1 (Auras: 75779 - [DND] Marker)
(@CGUID+29, 39420, 0, 1, 133, 1, 1, 0, 0, -5125.2744140625, 593.85589599609375, 461.769866943359375, 3.351032257080078125, 120, 0, 0, 42, 0, 0, 53788), -- [DND] Probe Target Bunny (Area: Tinkertown - Difficulty: 0) CreateObject1 (Auras: 75779 - [DND] Marker)
(@CGUID+30, 39420, 0, 1, 133, 1, 1, 0, 0, -5159.70654296875, 629.78125, 466.691650390625, 4.660028934478759765, 120, 0, 0, 42, 0, 0, 53788), -- [DND] Probe Target Bunny (Area: Tinkertown - Difficulty: 0) CreateObject1 (Auras: 75779 - [DND] Marker)
(@CGUID+31, 39420, 0, 1, 133, 1, 1, 0, 0, -5223.38037109375, 625.94793701171875, 456.428009033203125, 4.380776405334472656, 120, 0, 0, 42, 0, 0, 53788), -- [DND] Probe Target Bunny (Area: 0 - Difficulty: 0) CreateObject1 (Auras: 75779 - [DND] Marker)
(@CGUID+32, 39420, 0, 1, 133, 1, 1, 0, 0, -5304.75341796875, 665.59893798828125, 447.205474853515625, 4.694935798645019531, 120, 0, 0, 42, 0, 0, 53788), -- [DND] Probe Target Bunny (Area: Tinkertown - Difficulty: 0) CreateObject1 (Auras: 75779 - [DND] Marker)
(@CGUID+33, 39420, 0, 1, 133, 1, 1, 0, 0, -5349.8056640625, 648.625, 443.591217041015625, 4.97418832778930664, 120, 0, 0, 42, 0, 0, 53788), -- [DND] Probe Target Bunny (Area: Tinkertown - Difficulty: 0) CreateObject1 (Auras: 75779 - [DND] Marker)
-- Ironforge
(@CGUID+34, 39253, 0, 1537, 1537, 1, 1, 0, 0, -4981.658203125, -1256.7291259765625, 501.77008056640625, 1.431169986724853515, 120, 0, 0, 42, 0, 0, 53788), -- Gnome Citizen (Area: Ironforge - Difficulty: 0) CreateObject1 (Auras: 73930 - Citizen Costume)
(@CGUID+35, 39253, 0, 1537, 1537, 1, 1, 0, 0, -4981.4462890625, -1255.4635009765625, 501.76953125, 4.642575740814208984, 120, 0, 0, 42, 0, 0, 53788), -- Gnome Citizen (Area: Ironforge - Difficulty: 0) CreateObject1 (Auras: 73930 - Citizen Costume)
(@CGUID+36, 39253, 0, 1537, 1537, 1, 1, 0, 0, -4969.00341796875, -1276.376708984375, 502.0528564453125, 0.506145477294921875, 120, 0, 0, 42, 0, 0, 53788), -- Gnome Citizen (Area: Ironforge - Difficulty: 0) CreateObject1 (Auras: 73930 - Citizen Costume)
(@CGUID+37, 39253, 0, 1537, 1537, 1, 1, 0, 0, -4968.92724609375, -1274.329833984375, 510.36865234375, 2.914699792861938476, 120, 0, 0, 42, 0, 0, 53788), -- Gnome Citizen (Area: Ironforge - Difficulty: 0) CreateObject1 (Auras: 73930 - Citizen Costume)
(@CGUID+38, 39253, 0, 1537, 1537, 1, 1, 0, 0, -4970.5087890625, -1273.7117919921875, 510.36865234375, 6.2657318115234375, 120, 0, 0, 42, 0, 0, 53788), -- Gnome Citizen (Area: Ironforge - Difficulty: 0) CreateObject1 (Auras: 73930 - Citizen Costume)
(@CGUID+39, 39253, 0, 1537, 1537, 1, 1, 0, 0, -4842.38525390625, -1245.9149169921875, 501.853759765625, 5.393067359924316406, 120, 0, 0, 42, 0, 0, 53788), -- Gnome Citizen (Area: Ironforge - Difficulty: 0) CreateObject1 (Auras: 73930 - Citizen Costume)
(@CGUID+40, 39253, 0, 1537, 1537, 1, 1, 0, 0, -4840.55224609375, -1246.7396240234375, 501.873443603515625, 3.333578824996948242, 120, 0, 0, 42, 0, 0, 53788), -- Gnome Citizen (Area: Ironforge - Difficulty: 0) CreateObject1 (Auras: 73930 - Citizen Costume)
(@CGUID+41, 39253, 0, 1537, 1537, 1, 1, 0, 0, -4834.71337890625, -1245.8160400390625, 501.89208984375, 4.572762489318847656, 120, 0, 0, 42, 0, 0, 53788), -- Gnome Citizen (Area: Ironforge - Difficulty: 0) CreateObject1 (Auras: 73930 - Citizen Costume)
(@CGUID+42, 39253, 0, 1537, 1537, 1, 1, 0, 0, -4814.96533203125, -1287.9930419921875, 501.8604736328125, 1.431169986724853515, 120, 0, 0, 42, 0, 0, 53788), -- Gnome Citizen (Area: Ironforge - Difficulty: 0) CreateObject1 (Auras: 73930 - Citizen Costume)
(@CGUID+43, 39253, 0, 1537, 1537, 1, 1, 0, 0, -4815.46728515625, -1303.9444580078125, 501.9512939453125, 3.543018341064453125, 120, 0, 0, 42, 0, 0, 53788), -- Gnome Citizen (Area: Ironforge - Difficulty: 0) CreateObject1 (Auras: 73930 - Citizen Costume)
(@CGUID+44, 39253, 0, 1537, 1537, 1, 1, 0, 0, -4816.845703125, -1304.5052490234375, 501.9512939453125, 0.506145477294921875, 120, 0, 0, 42, 0, 0, 53788), -- Gnome Citizen (Area: Ironforge - Difficulty: 0) CreateObject1 (Auras: 73930 - Citizen Costume)
(@CGUID+45, 39623, 0, 1537, 1537, 1, 1, 0, 0, -4864.23291015625, -1148.6146240234375, 502.248046875, 1.274090290069580078, 120, 0, 0, 42, 0, 0, 53788), -- Gnome Citizen (Area: Ironforge - Difficulty: 0) CreateObject1 (Auras: 73930 - Citizen Costume)
(@CGUID+46, 39623, 0, 1537, 1537, 1, 1, 0, 0, -4916.4462890625, -1217.7066650390625, 501.645782470703125, 5.078907966613769531, 120, 0, 0, 42, 0, 0, 53788), -- Gnome Citizen (Area: Ironforge - Difficulty: 0) CreateObject1 (Auras: 73929 - Citizen Costume)
(@CGUID+47, 39623, 0, 1537, 1537, 1, 1, 0, 0, -4967.8349609375, -1275.9271240234375, 502.0528564453125, 3.577924966812133789, 120, 0, 0, 42, 0, 0, 53788), -- Gnome Citizen (Area: Ironforge - Difficulty: 0) CreateObject1 (Auras: 73929 - Citizen Costume)
(@CGUID+48, 39623, 0, 1537, 1537, 1, 1, 0, 0, -4842.0224609375, -1248.0069580078125, 501.87469482421875, 1.186823844909667968, 120, 0, 0, 42, 0, 0, 53788), -- Gnome Citizen (Area: Ironforge - Difficulty: 0) CreateObject1 (Auras: 73929 - Citizen Costume)
(@CGUID+49, 39623, 0, 1537, 1537, 1, 1, 0, 0, -4854.5537109375, -1283.921875, 501.9512939453125, 0.593411922454833984, 120, 0, 0, 42, 0, 0, 53788), -- Gnome Citizen (Area: Ironforge - Difficulty: 0) CreateObject1 (Auras: 73929 - Citizen Costume)
(@CGUID+50, 39623, 0, 1537, 1537, 1, 1, 0, 0, -4814.625, -1286.12158203125, 501.9512939453125, 4.572762489318847656, 120, 0, 0, 42, 0, 0, 53788), -- Gnome Citizen (Area: Ironforge - Difficulty: 0) CreateObject1 (Auras: 73929 - Citizen Costume)
(@CGUID+51, 39623, 0, 1537, 1537, 1, 1, 0, 0, -4818.11962890625, -1252.0242919921875, 501.956817626953125, 0.261799395084381103, 120, 0, 0, 42, 0, 0, 53788), -- Gnome Citizen (Area: Ironforge - Difficulty: 0) CreateObject1 (Auras: 73929 - Citizen Costume)
(@CGUID+52, 39623, 0, 1537, 1537, 1, 1, 0, 0, -4863.75341796875, -1146.90283203125, 502.250946044921875, 4.485496044158935546, 120, 0, 0, 42, 0, 0, 53788), -- Gnome Citizen (Area: Ironforge - Difficulty: 0) CreateObject1 (Auras: 73929 - Citizen Costume)
(@CGUID+53, 39623, 0, 1537, 1537, 1, 1, 0, 0, -4763.94091796875, -1173.501708984375, 502.157012939453125, 0.436332315206527709, 120, 0, 0, 42, 0, 0, 53788), -- Gnome Citizen (Area: Ironforge - Difficulty: 0) CreateObject1 (Auras: 73929 - Citizen Costume)
(@CGUID+54, 39623, 0, 1537, 1537, 1, 1, 0, 0, -4814.4912109375, -1296.0972900390625, 501.9512939453125, 2.181661605834960937, 120, 0, 0, 42, 0, 0, 53788); -- Gnome Citizen (Area: Ironforge - Difficulty: 0) CreateObject1 (Auras: 73929 - Citizen Costume)

DELETE FROM `creature_addon` WHERE `guid` BETWEEN @CGUID+0 AND @CGUID+54;
INSERT INTO `creature_addon` (`guid`, `mount`, `StandState`, `AnimTier`, `VisFlags`, `SheathState`, `PvpFlags`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(@CGUID+25, 0, 0, 0, 0, 1, 0, 0, 4, ''), -- [DND] Probe Target Bunny
(@CGUID+26, 0, 0, 0, 0, 1, 0, 0, 4, ''), -- [DND] Probe Target Bunny
(@CGUID+27, 0, 0, 0, 0, 1, 0, 0, 4, ''), -- [DND] Probe Target Bunny
(@CGUID+46, 0, 3, 0, 0, 1, 0, 0, 0, '73929'), -- Gnome Citizen - 73929 - Citizen Costume
(@CGUID+53, 0, 3, 0, 0, 1, 0, 0, 0, '73929'), -- Gnome Citizen - 73929 - Citizen Costume
(@CGUID+54, 0, 3, 0, 0, 1, 0, 0, 0, '73929'); -- Gnome Citizen - 73929 - Citizen Costume

-- Old gameobject spawns
DELETE FROM `gameobject` WHERE `guid`=151888;
DELETE FROM `gameobject` WHERE `guid` BETWEEN 151244 AND 151277;
DELETE FROM `gameobject_addon` WHERE `guid`=151888;
DELETE FROM `gameobject_addon` WHERE `guid` BETWEEN 151244 AND 151277;
DELETE FROM `game_event_gameobject` WHERE `guid` BETWEEN 151244 AND 151277;

-- Gameobject spawns
DELETE FROM `gameobject` WHERE `guid` BETWEEN @OGUID+0 AND @OGUID+35;
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `VerifiedBuild`) VALUES
-- Steelgrill's Depot
(@OGUID+0, 179968, 0, 1, 189, 1, 1, -5457.0244140625, -695.94793701171875, 398.040985107421875, 0.436331570148468017, 0, 0, 0.216439247131347656, 0.976296067237854003, 120, 255, 1, 53788), -- Haystack 01 (Area: Steelgrill's Depot - Difficulty: 0) CreateObject1
(@OGUID+1, 179968, 0, 1, 189, 1, 1, -5457.79150390625, -694.56597900390625, 397.83416748046875, 0.436331570148468017, 0, 0, 0.216439247131347656, 0.976296067237854003, 120, 255, 1, 53788), -- Haystack 01 (Area: Steelgrill's Depot - Difficulty: 0) CreateObject1
(@OGUID+2, 179968, 0, 1, 189, 1, 1, -5455.611328125, -696.06597900390625, 397.884002685546875, 0.436331570148468017, 0, 0, 0.216439247131347656, 0.976296067237854003, 120, 255, 1, 53788), -- Haystack 01 (Area: Steelgrill's Depot - Difficulty: 0) CreateObject1
(@OGUID+3, 179968, 0, 1, 189, 1, 1, -5454.9375, -697.3975830078125, 397.884063720703125, 0.436331570148468017, 0, 0, 0.216439247131347656, 0.976296067237854003, 120, 255, 1, 53788), -- Haystack 01 (Area: Steelgrill's Depot - Difficulty: 0) CreateObject1
(@OGUID+4, 179968, 0, 1, 189, 1, 1, -5457.1474609375, -693.5555419921875, 397.535858154296875, 0.436331570148468017, 0, 0, 0.216439247131347656, 0.976296067237854003, 120, 255, 1, 53788), -- Haystack 01 (Area: Steelgrill's Depot - Difficulty: 0) CreateObject1
(@OGUID+5, 179968, 0, 1, 189, 1, 1, -5454.35595703125, -698.7899169921875, 397.880218505859375, 0.436331570148468017, 0, 0, 0.216439247131347656, 0.976296067237854003, 120, 255, 1, 53788), -- Haystack 01 (Area: Steelgrill's Depot - Difficulty: 0) CreateObject1
(@OGUID+6, 179968, 0, 1, 189, 1, 1, -5455.69091796875, -698.6336669921875, 398.054229736328125, 0.436331570148468017, 0, 0, 0.216439247131347656, 0.976296067237854003, 120, 255, 1, 53788), -- Haystack 01 (Area: Steelgrill's Depot - Difficulty: 0) CreateObject1
(@OGUID+7, 179968, 0, 1, 189, 1, 1, -5456.32275390625, -697.28643798828125, 398.05120849609375, 0.436331570148468017, 0, 0, 0.216439247131347656, 0.976296067237854003, 120, 255, 1, 53788), -- Haystack 01 (Area: Steelgrill's Depot - Difficulty: 0) CreateObject1
(@OGUID+8, 179968, 0, 1, 189, 1, 1, -5456.3505859375, -694.81597900390625, 397.74237060546875, 0.436331570148468017, 0, 0, 0.216439247131347656, 0.976296067237854003, 120, 255, 1, 53788), -- Haystack 01 (Area: Steelgrill's Depot - Difficulty: 0) CreateObject1
(@OGUID+9, 180038, 0, 1, 189, 1, 1, -5457.8818359375, -698.607666015625, 398.394927978515625, 0.069811686873435974, 0, 0, 0.034898757934570312, 0.999390840530395507, 120, 255, 1, 53788), -- Haybail 02 (Area: Steelgrill's Depot - Difficulty: 0) CreateObject1
(@OGUID+10, 180038, 0, 1, 189, 1, 1, -5456.3369140625, -701.29864501953125, 398.25640869140625, 1.867502212524414062, 0, 0, 0.803856849670410156, 0.594822824001312255, 120, 255, 1, 53788), -- Haybail 02 (Area: Steelgrill's Depot - Difficulty: 0) CreateObject1
(@OGUID+11, 180038, 0, 1, 189, 1, 1, -5459.6162109375, -693.85418701171875, 398.018218994140625, 2.949595451354980468, 0, 0, 0.995395660400390625, 0.095851235091686248, 120, 255, 1, 53788), -- Haybail 02 (Area: Steelgrill's Depot - Difficulty: 0) CreateObject1
(@OGUID+12, 180038, 0, 1, 189, 1, 1, -5459.80712890625, -696.357666015625, 398.621246337890625, 1.186823248863220214, 0, 0, 0.559192657470703125, 0.829037725925445556, 120, 255, 1, 53788), -- Haybail 02 (Area: Steelgrill's Depot - Difficulty: 0) CreateObject1
(@OGUID+13, 187254, 0, 1, 189, 1, 1, -5463.8681640625, -626.44097900390625, 394.500885009765625, 0, 0, 0, 0, 1, 120, 255, 1, 53788), -- Rolled Scroll (Area: Steelgrill's Depot - Difficulty: 0) CreateObject1
(@OGUID+14, 187254, 0, 1, 189, 1, 1, -5464.3818359375, -626.8211669921875, 394.505340576171875, 0.261798173189163208, 0, 0, 0.130525588989257812, 0.991444945335388183, 120, 255, 1, 53788), -- Rolled Scroll (Area: Steelgrill's Depot - Difficulty: 0) CreateObject1
(@OGUID+15, 194498, 0, 1, 189, 1, 1, -5399.82666015625, -627.45831298828125, 392.36993408203125, 5.84685373306274414, 0, 0, -0.21643924713134765, 0.976296067237854003, 120, 255, 1, 53788), -- Gnomeregan Banner (Area: Steelgrill's Depot - Difficulty: 0) CreateObject1
(@OGUID+16, 194498, 0, 1, 189, 1, 1, -5462.3349609375, -692.32464599609375, 398.11553955078125, 0.506144583225250244, 0, 0, 0.250379562377929687, 0.968147754669189453, 120, 255, 1, 53788), -- Gnomeregan Banner (Area: Steelgrill's Depot - Difficulty: 0) CreateObject1
(@OGUID+17, 194498, 0, 1, 189, 1, 1, -5435.580078125, -706.25, 393.914031982421875, 5.759587764739990234, 0, 0, -0.25881862640380859, 0.965925931930541992, 120, 255, 1, 53788), -- Gnomeregan Banner (Area: Steelgrill's Depot - Difficulty: 0) CreateObject1
(@OGUID+18, 194498, 0, 1, 189, 1, 1, -5456.85791015625, -702.98785400390625, 398.340423583984375, 0.506144583225250244, 0, 0, 0.250379562377929687, 0.968147754669189453, 120, 255, 1, 53788), -- Gnomeregan Banner (Area: Steelgrill's Depot - Difficulty: 0) CreateObject1
(@OGUID+19, 194498, 0, 1, 189, 1, 1, -5388.81103515625, -603.154541015625, 392.115478515625, 5.84685373306274414, 0, 0, -0.21643924713134765, 0.976296067237854003, 120, 255, 1, 53788), -- Gnomeregan Banner (Area: Steelgrill's Depot - Difficulty: 0) CreateObject1
(@OGUID+20, 194498, 0, 1, 189, 1, 1, -5467.99658203125, -679.295166015625, 392.318267822265625, 1.291541695594787597, 0, 0, 0.60181427001953125, 0.798636078834533691, 120, 255, 1, 53788), -- Gnomeregan Banner (Area: Steelgrill's Depot - Difficulty: 0) CreateObject1
(@OGUID+21, 194498, 0, 1, 189, 1, 1, -5409.43408203125, -654.05206298828125, 392.521240234375, 5.969027042388916015, 0, 0, -0.1564340591430664, 0.987688362598419189, 120, 255, 1, 53788), -- Gnomeregan Banner (Area: Steelgrill's Depot - Difficulty: 0) CreateObject1
(@OGUID+22, 202564, 0, 1, 189, 1, 1, -5463.98974609375, -626.967041015625, 393.528717041015625, 0, 0, 0, 0, 1, 120, 255, 1, 53788), -- Gnome Table (Area: Steelgrill's Depot - Difficulty: 0) CreateObject1
(@OGUID+23, 202713, 0, 1, 189, 1, 1, -5417.48779296875, -667.49481201171875, 394.615875244140625, 1.291541695594787597, 0, 0, 0.60181427001953125, 0.798636078834533691, 120, 255, 1, 53788), -- Hazard Light Red 02 (Area: Steelgrill's Depot - Difficulty: 0) CreateObject1
(@OGUID+24, 202713, 0, 1, 189, 1, 1, -5432.19287109375, -700.07464599609375, 395.03656005859375, 1.291541695594787597, 0, 0, 0.60181427001953125, 0.798636078834533691, 120, 255, 1, 53788), -- Hazard Light Red 02 (Area: Steelgrill's Depot - Difficulty: 0) CreateObject1
(@OGUID+25, 202713, 0, 1, 189, 1, 1, -5412.611328125, -659.8211669921875, 393.9151611328125, 1.291541695594787597, 0, 0, 0.60181427001953125, 0.798636078834533691, 120, 255, 1, 53788), -- Hazard Light Red 02 (Area: Steelgrill's Depot - Difficulty: 0) CreateObject1
(@OGUID+26, 202713, 0, 1, 189, 1, 1, -5414.6943359375, -662.7117919921875, 394.140045166015625, 1.291541695594787597, 0, 0, 0.60181427001953125, 0.798636078834533691, 120, 255, 1, 53788), -- Hazard Light Red 02 (Area: Steelgrill's Depot - Difficulty: 0) CreateObject1
(@OGUID+27, 202713, 0, 1, 189, 1, 1, -5410.23974609375, -654.8975830078125, 393.749176025390625, 1.291541695594787597, 0, 0, 0.60181427001953125, 0.798636078834533691, 120, 255, 1, 53788), -- Hazard Light Red 02 (Area: Steelgrill's Depot - Difficulty: 0) CreateObject1
(@OGUID+28, 202713, 0, 1, 189, 1, 1, -5391.9443359375, -609.545166015625, 393.589263916015625, 1.291541695594787597, 0, 0, 0.60181427001953125, 0.798636078834533691, 120, 255, 1, 53788), -- Hazard Light Red 02 (Area: Steelgrill's Depot - Difficulty: 0) CreateObject1
(@OGUID+29, 202713, 0, 1, 189, 1, 1, -5434.78466796875, -704.91143798828125, 395.076080322265625, 1.291541695594787597, 0, 0, 0.60181427001953125, 0.798636078834533691, 120, 255, 1, 53788), -- Hazard Light Red 02 (Area: Steelgrill's Depot - Difficulty: 0) CreateObject1
(@OGUID+30, 202713, 0, 1, 189, 1, 1, -5389.4599609375, -604.69793701171875, 393.34521484375, 1.291541695594787597, 0, 0, 0.60181427001953125, 0.798636078834533691, 120, 255, 1, 53788), -- Hazard Light Red 02 (Area: Steelgrill's Depot - Difficulty: 0) CreateObject1
(@OGUID+31, 202713, 0, 1, 189, 1, 1, -5393.62353515625, -612.3680419921875, 393.79925537109375, 1.291541695594787597, 0, 0, 0.60181427001953125, 0.798636078834533691, 120, 255, 1, 53788), -- Hazard Light Red 02 (Area: Steelgrill's Depot - Difficulty: 0) CreateObject1
(@OGUID+32, 202713, 0, 1, 189, 1, 1, -5430.65087890625, -697.17364501953125, 394.862701416015625, 1.291541695594787597, 0, 0, 0.60181427001953125, 0.798636078834533691, 120, 255, 1, 53788), -- Hazard Light Red 02 (Area: Steelgrill's Depot - Difficulty: 0) CreateObject1
(@OGUID+33, 202713, 0, 1, 189, 1, 1, -5396.00537109375, -617.33331298828125, 393.740631103515625, 1.291541695594787597, 0, 0, 0.60181427001953125, 0.798636078834533691, 120, 255, 1, 53788), -- Hazard Light Red 02 (Area: Steelgrill's Depot - Difficulty: 0) CreateObject1
(@OGUID+34, 202713, 0, 1, 189, 1, 1, -5428.03125, -692.39581298828125, 394.647613525390625, 1.291541695594787597, 0, 0, 0.60181427001953125, 0.798636078834533691, 120, 255, 1, 53788), -- Hazard Light Red 02 (Area: Steelgrill's Depot - Difficulty: 0) CreateObject1
(@OGUID+35, 202898, 0, 1, 189, 1, 1, -5463.5244140625, -627.1961669921875, 394.483184814453125, 1.169368624687194824, 0, 0, 0.551936149597167968, 0.833886384963989257, 120, 255, 1, 53788); -- Scroll (Area: Steelgrill's Depot - Difficulty: 0) CreateObject1

-- Event spawns
DELETE FROM `game_event_creature` WHERE `eventEntry`=@EVENT AND `guid` BETWEEN @CGUID+0 AND @CGUID+54;
INSERT INTO `game_event_creature` (`eventEntry`, `guid`) VALUES
(@EVENT, @CGUID+0),
(@EVENT, @CGUID+1),
(@EVENT, @CGUID+2),
(@EVENT, @CGUID+3),
(@EVENT, @CGUID+4),
(@EVENT, @CGUID+5),
(@EVENT, @CGUID+6),
(@EVENT, @CGUID+7),
(@EVENT, @CGUID+8),
(@EVENT, @CGUID+9),
(@EVENT, @CGUID+10),
(@EVENT, @CGUID+11),
(@EVENT, @CGUID+12),
(@EVENT, @CGUID+13),
(@EVENT, @CGUID+14),
(@EVENT, @CGUID+15),
(@EVENT, @CGUID+16),
(@EVENT, @CGUID+17),
(@EVENT, @CGUID+18),
(@EVENT, @CGUID+19),
(@EVENT, @CGUID+20),
(@EVENT, @CGUID+21),
(@EVENT, @CGUID+22),
(@EVENT, @CGUID+23),
(@EVENT, @CGUID+24),
(@EVENT, @CGUID+25),
(@EVENT, @CGUID+26),
(@EVENT, @CGUID+27),
(@EVENT, @CGUID+28),
(@EVENT, @CGUID+29),
(@EVENT, @CGUID+30),
(@EVENT, @CGUID+31),
(@EVENT, @CGUID+32),
(@EVENT, @CGUID+33),
(@EVENT, @CGUID+34),
(@EVENT, @CGUID+35),
(@EVENT, @CGUID+36),
(@EVENT, @CGUID+37),
(@EVENT, @CGUID+38),
(@EVENT, @CGUID+39),
(@EVENT, @CGUID+40),
(@EVENT, @CGUID+41),
(@EVENT, @CGUID+42),
(@EVENT, @CGUID+43),
(@EVENT, @CGUID+44),
(@EVENT, @CGUID+45),
(@EVENT, @CGUID+46),
(@EVENT, @CGUID+47),
(@EVENT, @CGUID+48),
(@EVENT, @CGUID+49),
(@EVENT, @CGUID+50),
(@EVENT, @CGUID+51),
(@EVENT, @CGUID+52),
(@EVENT, @CGUID+53),
(@EVENT, @CGUID+54);

DELETE FROM `game_event_gameobject` WHERE `eventEntry`=@EVENT AND `guid` BETWEEN @OGUID+0 AND @OGUID+35;
INSERT INTO `game_event_gameobject` (`eventEntry`, `guid`) VALUES
(@EVENT, @OGUID+0),
(@EVENT, @OGUID+1),
(@EVENT, @OGUID+2),
(@EVENT, @OGUID+3),
(@EVENT, @OGUID+4),
(@EVENT, @OGUID+5),
(@EVENT, @OGUID+6),
(@EVENT, @OGUID+7),
(@EVENT, @OGUID+8),
(@EVENT, @OGUID+9),
(@EVENT, @OGUID+10),
(@EVENT, @OGUID+11),
(@EVENT, @OGUID+12),
(@EVENT, @OGUID+13),
(@EVENT, @OGUID+14),
(@EVENT, @OGUID+15),
(@EVENT, @OGUID+16),
(@EVENT, @OGUID+17),
(@EVENT, @OGUID+18),
(@EVENT, @OGUID+19),
(@EVENT, @OGUID+20),
(@EVENT, @OGUID+21),
(@EVENT, @OGUID+22),
(@EVENT, @OGUID+23),
(@EVENT, @OGUID+24),
(@EVENT, @OGUID+25),
(@EVENT, @OGUID+26),
(@EVENT, @OGUID+27),
(@EVENT, @OGUID+28),
(@EVENT, @OGUID+29),
(@EVENT, @OGUID+30),
(@EVENT, @OGUID+31),
(@EVENT, @OGUID+32),
(@EVENT, @OGUID+33),
(@EVENT, @OGUID+34),
(@EVENT, @OGUID+35);

-- Ambassador Dawnsinger's gossip text should be different if player is blood elf.
-- Gossip Menu
DELETE FROM `gossip_menu` WHERE `MenuID`=7359 AND `TextID`=8791;
INSERT INTO `gossip_menu` (`MenuID`, `TextID`, `VerifiedBuild`) VALUES
(7359,8791,0);

-- Condition
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=14 AND `SourceGroup`=7359;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(14,7359,8791,0,0,16,0,512,0,0,0,0,0,"","Show gossip text 8791 if player is a blood elf");

-- Breadcrumb quest Fix
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId`=2460 WHERE `ID`=10794;

-- Sting of the Scorpid (Wrong use of "$c")
UPDATE `quest_request_items` SET `CompletionText`="The carapace of a scorpid isn't so thick that the strength of a determined warrior will be deterred. Strike strongly and without doubt, and the scorpids should prove easy prey." WHERE `ID`=789;

-- A Peon's Burden (Upper case "$c") 
UPDATE `quest_offer_reward` SET `RewardText`="Ah, this is the food Ukor brought to the Valley of Trials.  Did they not need it? Well, I guess they like to starve you heroes in training.  Builds spirit, they say!$b$bThank you for returning the food.  I'll stick it back on the shelves... but here, let me offer you some refreshment first!$b$bAnd don't forget to rest here in the inn. You may be a brave $c ready to take on the world, but if your energy is sapped you won't be doing yourself, or the Horde, much good." WHERE `ID`=2161;

-- Vanquish the Betrayers (Upper case "$c") 
UPDATE `quest_offer_reward` SET `RewardText`="Word of your bravery travels fast, $c. Tales of your victory at Tiragarde Keep will be heralded in Orgrimmar." WHERE `ID`=784;

-- The Admiral's Orders (Upper case "$c") 
UPDATE `quest_request_items` SET `CompletionText`="There is a look of concern on your face, $c. What have you there?" WHERE `ID`=830;

-- Carry Your Weight (Upper case "$c") 
UPDATE `quest_offer_reward` SET `RewardText`="Most excellent, $N. Any good $c will surely find a use for this bag on the battlefield.$b$bI salute your vigor and willingness to die in the name of the Horde!" WHERE `ID`=791;

-- From The Wreckage.... (Upper case "$c") 
UPDATE `quest_offer_reward` SET `RewardText`="Your recovery mission was a success, $c. I will see to it that these tools get to Orgrimmar with the next caravan.$b$bNicely done." WHERE `ID`=825;

-- Margoz (Upper case "$c") 
UPDATE `quest_offer_reward` SET `RewardText`="Welcome, $N.  Word reached me of your coming, and of your exploits in Durotar.$b$bYou are a $c of growing skill and renown.$b$bStay on the pure path, and your future will be great indeed." WHERE `ID`=828;

-- Hidden Enemies (Upper case "$c") 
UPDATE `quest_offer_reward` SET `RewardText`="What is it?! Oh, you, $c... my apologies. My anger rivals that of a rabid kodo bull... but perhaps it is my own fault. In sending travelers into Ragefire Chasm, I should have seen the possibility that some harm would come from it. It seems both Bazzalan and Jergosh were taken unaware and slain by some of Thrall's do-gooders. A most inopportune time, but there is nothing that can be done about it now." WHERE `ID`=5729;

-- Neeru Fireblade (Upper case "$c" and upper case "$r") 
UPDATE `quest_request_items` SET `CompletionText`="My most humble greetings, $c.  How might I help my $r $gbrother:sister; today?" WHERE `ID`=829;

-- The Admiral's Orders (Upper case "$c") 
UPDATE `quest_offer_reward` SET `RewardText`="Countless times I urged the Warchief not to trust the humans, but personal pride is not what is at stake here.$b$bYou have served the Horde honorably, young $c.$b$bNow excuse me, I must counsel Thrall on these matters at once...." WHERE `ID`=831;

-- Missing request text
UPDATE `quest_request_items` SET `CompletionText`="Practice!" WHERE `ID`=2460;

-- Gest, correct gossip text when "Elegant Letter" is available
-- Gossip Menu
DELETE FROM `gossip_menu` WHERE `MenuID`=4513 AND `TextID` IN (5993,5996);
INSERT INTO `gossip_menu` (`MenuID`,`TextID`) VALUES (4513,5993);
-- Condition
UPDATE `conditions` SET `SourceEntry`=5993 WHERE `SourceGroup`=4513 AND `SourceEntry`=5996;

-- Quest is missing reward next quest
UPDATE `quest_template` SET `RewardNextQuest`=6394 WHERE `Id`=5441;

SET @CGUID := 208509;

DELETE FROM `spawn_group` WHERE `spawnType`=0 AND `spawnId` BETWEEN 207174 AND 207209;
DELETE FROM `spawn_group` WHERE `spawnType`=0 AND `spawnId` IN (130847, 130848, 130849, 130853, 130855, 130906, 130907, 130908, 130971);
DELETE FROM `spawn_group` WHERE `spawnType`=0 AND `spawnId` BETWEEN @CGUID+0 AND @CGUID+54;
INSERT INTO `spawn_group` (`groupId`, `spawnType`, `spawnId`) VALUES
(2, 0, @CGUID+34),
(2, 0, @CGUID+35),
(2, 0, @CGUID+36),
(2, 0, @CGUID+37),
(2, 0, @CGUID+38),
(2, 0, @CGUID+39),
(2, 0, @CGUID+40),
(2, 0, @CGUID+41),
(2, 0, @CGUID+42),
(2, 0, @CGUID+43),
(2, 0, @CGUID+44),
(2, 0, @CGUID+45),
(2, 0, @CGUID+46),
(2, 0, @CGUID+47),
(2, 0, @CGUID+48),
(2, 0, @CGUID+49),
(2, 0, @CGUID+50),
(2, 0, @CGUID+51),
(2, 0, @CGUID+52),
(2, 0, @CGUID+53),
(2, 0, @CGUID+54);

-- Update Ellia Moondancer (33644) spawn coordinates
UPDATE `creature` SET `position_x`=8579.241, `position_y`=755.2691, `position_z`=547.376, `orientation`=0 WHERE `guid`=200793 AND `id`=33644;

-- Update Jenna Thunderbrew (33645) spawn coordinates
UPDATE `creature` SET `position_x`=8579.87, `position_y`=749.8559, `position_z`=547.376, `orientation`=0 WHERE `guid`=75091 AND `id`=33645;

-- Add properly required fishing skill for Zul'Gurub area
DELETE FROM `skill_fishing_base_level` WHERE `entry`=1977;
INSERT INTO `skill_fishing_base_level` (`entry`, `skill`) VALUES
(1977, 330);

-- TODO: Check actionlist (missing emotes, summons and waypoints)

-- Gossips
DELETE FROM `gossip_menu_option` WHERE (`MenuID`=11375 AND `OptionID`=0);
INSERT INTO `gossip_menu_option` (`MenuID`, `OptionID`, `OptionIcon`, `OptionText`, `OptionBroadcastTextID`, `OptionType`, `OptionNpcFlag`, `ActionMenuID`, `ActionPoiID`, `BoxCoded`, `BoxMoney`, `BoxText`, `BoxBroadcastTextID`, `VerifiedBuild`) VALUES
(11375, 0, 0, 'Let us consult the omens.', 40385, 1, 1, 0, 0, 0, 0, NULL, 0, 53788);

-- Misc
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=15 AND `SourceGroup`=11375;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(15, 11375, 0, 0, 0, 47, 0, 25480, 10, 0, 0, 0, 0, '', 'Gossip menu option requires quest 25480 taken or completed');

-- Quests
DELETE FROM `quest_details` WHERE `ID`=25480;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES
(25480, 1, 1, 0, 0, 0, 0, 0, 0, 53788); -- Dance Of De Spirits

DELETE FROM `quest_request_items` WHERE `ID`=25480;
INSERT INTO `quest_request_items` (`ID`, `EmoteOnComplete`, `EmoteOnIncomplete`, `CompletionText`, `VerifiedBuild`) VALUES
(25480, 0, 1, 'Well, what do de omens tell us?', 53788); -- Dance Of De Spirits

UPDATE `quest_offer_reward` SET `Emote1`=1, `Emote2`=1, `VerifiedBuild`=53788 WHERE `ID`=25480; -- Dance Of De Spirits

DELETE FROM `game_event_creature_quest` WHERE (`id`=40391 AND `quest`=25480);
DELETE FROM `creature_queststarter` WHERE (`id`=40391 AND `quest`=25480);
INSERT INTO `creature_queststarter` (`id`, `quest`) VALUES
(40391, 25480); -- Dance Of De Spirits offered by Vol'jin

-- SAI
DELETE FROM `smart_scripts` WHERE `entryorguid`=40352 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(40352,0,0,1,62,0,100,0,11375,0,0,0,0,80,4035200,2,0,0,0,0,1,0,0,0,0,0,0,0,0,'Witch Doctor Hez''tok - On gossip option 0 selected - Call timed actionlist'),
(40352,0,1,0,61,0,100,0,0,0,0,0,0,72,0,0,0,0,0,0,7,0,0,0,0,0,0,0,0,'Witch Doctor Hez''tok - Event linked - Close gossip');

SET @CGUID := 208564;
SET @OGUID := 152154;
SET @EVENT := 82;

-- TODO: Creature spawn @CGUID+5 after waypoint_data.point 6 plays emote 66 and recieve the same emote from formation (script)

-- Creature templates
UPDATE `creature_template` SET `unit_flags`=64 WHERE `entry`=39271; -- High Tinker Mekkatorque
UPDATE `creature_template` SET `faction`=35 WHERE `entry`=39273; -- "Doc" Cogspin
UPDATE `creature_template` SET `npcflag`=0 WHERE `entry`=39275; -- Gnomeregan Medic
UPDATE `creature_template` SET `unit_flags2`=65536 WHERE `entry`=39860; -- Gnomeregan Mechano-Tank
UPDATE `creature_template` SET `faction`=1770, `unit_flags`=0, `unit_flags2`=2048 WHERE `entry`=39264; -- Gnomeregan Mechano-Tank Pilot
UPDATE `creature_template` SET `faction`=35 WHERE `entry`=39910; -- Hinkles Fastblast
UPDATE `creature_template` SET `unit_flags`=768 WHERE `entry`=40478; -- Elgin Clickspring
UPDATE `creature_template` SET `unit_flags2`=65536 WHERE `entry`=39759; -- Tankbuster Cannon
UPDATE `creature_template` SET `unit_flags`=256, `unit_flags2`=0 WHERE `entry`=39820; -- Rocket Launcher
UPDATE `creature_template` SET `unit_flags`=33554432 WHERE `entry`=39902; -- Gnomeregan Battle Suit
UPDATE `creature_template` SET `unit_flags2`=65536 WHERE `entry`=39819; -- Irradiated Mechano-Tank
UPDATE `creature_template` SET `unit_flags`=768 WHERE `entry`=39841; -- [DND] Boom Bunny
UPDATE `creature_template` SET `unit_flags`=33554432 WHERE `entry`=40617; -- [DND] Bunny

DELETE FROM `creature_template_addon` WHERE `entry` IN (40617 /*40617 ([DND] Bunny) - Radiation Cloud*/, 39902 /*39902 (Gnomeregan Battle Suit) - Permanent Feign Death*/, 39860 /*39860 (Gnomeregan Mechano-Tank)*/, 39819 /*39819 (Irradiated Mechano-Tank)*/, 39755 /*39755 (Irradiated Infantry) - Ride Vehicle Hardcoded*/, 39275 /*39275 (Gnomeregan Medic)*/, 39264 /*39264 (Gnomeregan Mechano-Tank Pilot) - Ride Vehicle Hardcoded*/, 39252 /*39252 (Gnomeregan Infantry)*/, 39230 /*39230 (Gnomeregan Mechano-Tank Pilot)*/);
INSERT INTO `creature_template_addon` (`entry`, `mount`, `StandState`, `AnimTier`, `VisFlags`, `SheathState`, `PvpFlags`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(39902, 0, 0, 0, 0, 2, 0, 0, 0, '74490'), -- 39902 (Gnomeregan Battle Suit) - Permanent Feign Death
(39860, 0, 0, 0, 0, 1, 0, 0, 0, ''), -- 39860 (Gnomeregan Mechano-Tank)
(39819, 0, 0, 0, 0, 1, 0, 0, 0, ''), -- 39819 (Irradiated Mechano-Tank)
(39755, 0, 0, 0, 0, 1, 0, 0, 0, ''), -- 39755 (Irradiated Infantry)
(39275, 0, 0, 0, 0, 1, 0, 0, 0, ''), -- 39275 (Gnomeregan Medic)
(39264, 0, 0, 0, 0, 1, 0, 0, 0, ''), -- 39264 (Gnomeregan Mechano-Tank Pilot)
(39252, 0, 0, 0, 0, 1, 0, 0, 0, ''), -- 39252 (Gnomeregan Infantry)
(39230, 0, 0, 0, 0, 1, 0, 0, 0, ''), -- 39230 (Gnomeregan Mechano-Tank Pilot)
(40617, 0, 0, 0, 0, 1, 0, 0, 0, '74532'); -- 40617 ([DND] Bunny) - Radiation Cloud

UPDATE `creature_template_addon` SET `SheathState`=1 WHERE `entry`=40478; -- 40478 (Elgin Clickspring)
UPDATE `creature_template_addon` SET `SheathState`=1 WHERE `entry`=39910; -- 39910 (Hinkles Fastblast)
UPDATE `creature_template_addon` SET `auras`='74463' WHERE `entry`=39841; -- 39841 ([DND] Boom Bunny) - [DND] Boom
UPDATE `creature_template_addon` SET `auras`='74311' WHERE `entry`=39820; -- 39820 (Rocket Launcher) - Fire Rocket
UPDATE `creature_template_addon` SET `auras`='74458' WHERE `entry`=39759; -- 39759 (Tankbuster Cannon) - Power Shield XL-1
UPDATE `creature_template_addon` SET `SheathState`=1 WHERE `entry`=39273; -- 39273 ("Doc" Cogspin)
UPDATE `creature_template_addon` SET `SheathState`=1 WHERE `entry`=39271; -- 39271 (High Tinker Mekkatorque)
UPDATE `creature_template_addon` SET `AnimTier`=3, `SheathState`=1 WHERE `entry`=39259; -- 39259 (Gnomeregan Flying Machine)

DELETE FROM `creature_template_movement` WHERE `CreatureId` IN (40617, 39841, 39759, 39820, 39259);
INSERT INTO `creature_template_movement` (`CreatureId`, `Ground`, `Swim`, `Flight`, `Rooted`, `Chase`, `Random`, `InteractionPauseTimer`) VALUES
(39841, 0, 0, 1, 0, 0, 0, NULL),
(39259, 0, 0, 1, 0, 0, 0, NULL),
(39759, 0, 0, 1, 1, 0, 0, NULL),
(39820, 0, 0, 1, 1, 0, 0, NULL),
(40617, 0, 0, 1, 1, 0, 0, NULL);

DELETE FROM `creature_equip_template` WHERE (`CreatureID`=39755 AND `ID`=2);
INSERT INTO `creature_equip_template` (`CreatureID`, `ID`, `ItemID1`, `ItemID2`, `ItemID3`, `VerifiedBuild`) VALUES
(39755, 2, 53055, 0, 30128, 54261); -- Irradiated Infantry

UPDATE `creature_equip_template` SET `VerifiedBuild`=54261 WHERE (`ID`=1 AND `CreatureID` IN (40478,39910,39755,39273,39271,39264,39252,39230));

UPDATE `creature_template` SET `gossip_menu_id`=11194 WHERE `entry`=39271; -- High Tinker Mekkatorque
DELETE FROM `gossip_menu_option` WHERE (`MenuID` IN (11191,11194) AND `OptionID`=0);
INSERT INTO `gossip_menu_option` (`MenuID`, `OptionID`, `OptionIcon`, `OptionText`, `OptionBroadcastTextID`, `OptionType`, `OptionNpcFlag`, `ActionMenuID`, `ActionPoiID`, `BoxCoded`, `BoxMoney`, `BoxText`, `BoxBroadcastTextID`, `VerifiedBuild`) VALUES
(11194, 0, 0, 'What is going on here?', 39332, 1, 1, 11191, 0, 0, 0, NULL, 0, 54261),
(11191, 0, 0, 'What is your plan?', 39323, 1, 1, 11192, 0, 0, 0, NULL, 0, 54261);

DELETE FROM `vehicle_template_accessory` WHERE `entry` IN (39819,39759,39860);
INSERT INTO `vehicle_template_accessory` (`entry`, `accessory_entry`, `seat_id`, `minion`, `description`, `summontype`, `summontimer`) VALUES
(39819, 39755, 0, 1, 'Irradiated Mechano-Tank - Irradiated Infantry', 7, 0), -- Irradiated Mechano-Tank - Irradiated Infantry
(39759, 39755, 0, 1, 'Tankbuster Cannon - Irradiated Infantry', 7, 0), -- Tankbuster Cannon - Irradiated Infantry
(39860, 39264, 0, 1, 'Gnomeregan Mechano-Tank - Gnomeregan Mechano-Tank Pilot', 7, 0); -- Gnomeregan Mechano-Tank - Gnomeregan Mechano-Tank Pilot

DELETE FROM `npc_spellclick_spells` WHERE `npc_entry` IN (39819, 39759, 39860);
INSERT INTO `npc_spellclick_spells` (`npc_entry`, `spell_id`, `cast_flags`, `user_type`) VALUES
(39819, 46598, 1, 0),
(39759, 43671, 1, 0),
(39860, 46598, 1, 0);

-- Gameobject templates
UPDATE `gameobject_template_addon` SET `faction`=114, `flags`=32 WHERE `entry`=202922; -- Irradiator 3000

-- Misc
DELETE FROM `spell_area` WHERE `spell`=74310;
INSERT INTO `spell_area` (`spell`, `area`, `quest_start`, `quest_end`, `aura_spell`, `racemask`, `gender`, `autocast`, `quest_start_status`, `quest_end_status`) VALUES
(74310, 133, 25287, 25393, 0, 0, 2, 1, 74, 11),
(74310, 135, 25287, 25393, 0, 0, 2, 1, 74, 11),
(74310, 137, 25287, 25393, 0, 0, 2, 1, 74, 11),
(74310, 211, 25287, 25393, 0, 0, 2, 1, 74, 11);

-- SAI
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry` IN (39230);

DELETE FROM `smart_scripts` WHERE `entryorguid` IN (39230) AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(39230,0,0,0,1,0,100,0,0,5000,8000,13000,0,10,6,273,274,396,0,0,1,0,0,0,0,0,0,0,0,'Gnomeregan Mechano-Tank Pilot - Out of combat (8-13s) - Play random emote');

-- Creature spawns
DELETE FROM `creature` WHERE `guid` BETWEEN @CGUID+0 AND @CGUID+130;
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `VerifiedBuild`) VALUES
-- Frostmane Hold
(@CGUID+0, 39230, 0, 1, 135, 1, 256, 0, 1, -5429.52978515625, 533.54864501953125, 386.946197509765625, 1.797689080238342285, 120, 0, 0, 12600, 0, 0, 54261), -- Gnomeregan Mechano-Tank Pilot (Area: Frostmane Hold - Difficulty: 0) CreateObject1
(@CGUID+1, 39230, 0, 1, 135, 1, 256, 0, 1, -5431.6025390625, 534.31597900390625, 386.98785400390625, 0.645771801471710205, 120, 0, 0, 12600, 0, 0, 54261), -- Gnomeregan Mechano-Tank Pilot (Area: Frostmane Hold - Difficulty: 0) CreateObject1
(@CGUID+2, 39230, 0, 1, 135, 1, 256, 0, 1, -5429.626953125, 540.41668701171875, 386.821319580078125, 2.617993831634521484, 120, 0, 0, 12600, 0, 0, 54261), -- Gnomeregan Mechano-Tank Pilot (Area: Frostmane Hold - Difficulty: 0) CreateObject1
(@CGUID+3, 39230, 0, 1, 135, 1, 256, 0, 1, -5431.0712890625, 541.15277099609375, 386.8350830078125, 5.951572895050048828, 120, 0, 0, 12600, 0, 0, 54261), -- Gnomeregan Mechano-Tank Pilot (Area: Frostmane Hold - Difficulty: 0) CreateObject1
(@CGUID+4, 39230, 0, 1, 135, 1, 256, 0, 1, -5431.4912109375, 536.857666015625, 386.91973876953125, 5.567600250244140625, 120, 0, 0, 12600, 0, 0, 54261), -- Gnomeregan Mechano-Tank Pilot (Area: Frostmane Hold - Difficulty: 0) CreateObject1
(@CGUID+5, 39252, 0, 1, 135, 1, 256, 0, 1, -5401.2603, 488.00522, 385.00113, 2.328075647354125976, 120, 0, 0, 315000, 0, 2, 54261), -- Gnomeregan Infantry (Area: Frostmane Hold - Difficulty: 0) CreateObject1 (possible waypoints or random movement)
(@CGUID+6, 39252, 0, 1, 135, 1, 256, 0, 1, -5404.40478515625, 485.171875, 384.94677734375, 0.837758064270019531, 120, 0, 0, 315000, 0, 0, 54261), -- Gnomeregan Infantry (Area: Frostmane Hold - Difficulty: 0) CreateObject1
(@CGUID+7, 39252, 0, 1, 135, 1, 256, 0, 1, -5404.57666015625, 488.588531494140625, 385.421875, 0.837758064270019531, 120, 0, 0, 315000, 0, 0, 54261), -- Gnomeregan Infantry (Area: Frostmane Hold - Difficulty: 0) CreateObject1
(@CGUID+8, 39252, 0, 1, 135, 1, 256, 0, 1, -5410.35791015625, 490.57464599609375, 386.207000732421875, 0.837758064270019531, 120, 0, 0, 315000, 0, 0, 54261), -- Gnomeregan Infantry (Area: Frostmane Hold - Difficulty: 0) CreateObject1
(@CGUID+9, 39252, 0, 1, 135, 1, 256, 0, 1, -5406.28466796875, 486.82464599609375, 385.328125, 0.837758064270019531, 120, 0, 0, 315000, 0, 0, 54261), -- Gnomeregan Infantry (Area: Frostmane Hold - Difficulty: 0) CreateObject1
(@CGUID+10, 39252, 0, 1, 135, 1, 256, 0, 1, -5406.48974609375, 490.505218505859375, 385.911956787109375, 0.837758064270019531, 120, 0, 0, 315000, 0, 0, 54261), -- Gnomeregan Infantry (Area: Frostmane Hold - Difficulty: 0) CreateObject1
(@CGUID+11, 39252, 0, 1, 135, 1, 256, 0, 1, -5402.60400390625, 486.734375, 384.986480712890625, 0.837758064270019531, 120, 0, 0, 315000, 0, 0, 54261), -- Gnomeregan Infantry (Area: Frostmane Hold - Difficulty: 0) CreateObject1
(@CGUID+12, 39252, 0, 1, 135, 1, 256, 0, 1, -5410.63720703125, 494.505218505859375, 386.5621337890625, 0.837758064270019531, 120, 0, 0, 315000, 0, 0, 54261), -- Gnomeregan Infantry (Area: Frostmane Hold - Difficulty: 0) CreateObject1
(@CGUID+13, 39252, 0, 1, 135, 1, 256, 0, 1, -5408.22216796875, 488.78125, 385.824005126953125, 0.837758064270019531, 120, 0, 0, 315000, 0, 0, 54261), -- Gnomeregan Infantry (Area: Frostmane Hold - Difficulty: 0) CreateObject1
(@CGUID+14, 39252, 0, 1, 135, 1, 256, 0, 1, -5408.53125, 492.369781494140625, 386.335357666015625, 0.837758064270019531, 120, 0, 0, 315000, 0, 0, 54261), -- Gnomeregan Infantry (Area: Frostmane Hold - Difficulty: 0) CreateObject1
(@CGUID+15, 39252, 0, 1, 135, 1, 256, 0, 1, -5410.34912109375, 486.720489501953125, 385.601318359375, 0.837758064270019531, 120, 0, 0, 315000, 0, 0, 54261), -- Gnomeregan Infantry (Area: Frostmane Hold - Difficulty: 0) CreateObject1
(@CGUID+16, 39252, 0, 1, 135, 1, 256, 0, 1, -5414.53662109375, 490.789947509765625, 386.328216552734375, 0.837758064270019531, 120, 0, 0, 315000, 0, 0, 54261), -- Gnomeregan Infantry (Area: Frostmane Hold - Difficulty: 0) CreateObject1
(@CGUID+17, 39252, 0, 1, 135, 1, 256, 0, 1, -5408.47216796875, 484.822906494140625, 385.164947509765625, 0.837758064270019531, 120, 0, 0, 315000, 0, 0, 54261), -- Gnomeregan Infantry (Area: Frostmane Hold - Difficulty: 0) CreateObject1
(@CGUID+18, 39252, 0, 1, 135, 1, 256, 0, 1, -5410.26025390625, 482.86285400390625, 384.8768310546875, 0.837758064270019531, 120, 0, 0, 315000, 0, 0, 54261), -- Gnomeregan Infantry (Area: Frostmane Hold - Difficulty: 0) CreateObject1
(@CGUID+19, 39252, 0, 1, 135, 1, 256, 0, 1, -5416.080078125, 488.798614501953125, 386.078857421875, 0.837758064270019531, 120, 0, 0, 315000, 0, 0, 54261), -- Gnomeregan Infantry (Area: Frostmane Hold - Difficulty: 0) CreateObject1
(@CGUID+20, 39252, 0, 1, 135, 1, 256, 0, 1, -5412.39599609375, 492.736114501953125, 386.483734130859375, 0.837758064270019531, 120, 0, 0, 315000, 0, 0, 54261), -- Gnomeregan Infantry (Area: Frostmane Hold - Difficulty: 0) CreateObject1
(@CGUID+21, 39252, 0, 1, 135, 1, 256, 0, 1, -5406.57275390625, 483.036468505859375, 384.77777099609375, 0.837758064270019531, 120, 0, 0, 315000, 0, 0, 54261), -- Gnomeregan Infantry (Area: Frostmane Hold - Difficulty: 0) CreateObject1
(@CGUID+22, 39252, 0, 1, 135, 1, 256, 0, 1, -5412.40966796875, 488.711822509765625, 386.022216796875, 0.837758064270019531, 120, 0, 0, 315000, 0, 0, 54261), -- Gnomeregan Infantry (Area: Frostmane Hold - Difficulty: 0) CreateObject1
(@CGUID+23, 39252, 0, 1, 135, 1, 256, 0, 1, -5414.14404296875, 486.932281494140625, 385.7724609375, 0.837758064270019531, 120, 0, 0, 315000, 0, 0, 54261), -- Gnomeregan Infantry (Area: Frostmane Hold - Difficulty: 0) CreateObject1
(@CGUID+24, 39252, 0, 1, 135, 1, 256, 0, 1, -5412.16162109375, 484.888885498046875, 385.323486328125, 0.837758064270019531, 120, 0, 0, 315000, 0, 0, 54261), -- Gnomeregan Infantry (Area: Frostmane Hold - Difficulty: 0) CreateObject1
(@CGUID+25, 39252, 0, 1, 135, 1, 256, 0, 1, -5408.45654296875, 481.28125, 384.630615234375, 0.837758064270019531, 120, 0, 0, 315000, 0, 0, 54261), -- Gnomeregan Infantry (Area: Frostmane Hold - Difficulty: 0) CreateObject1
(@CGUID+26, 39252, 0, 1, 135, 1, 256, 0, 1, -5393.02099609375, 518.60589599609375, 386.25390625, 0.575958669185638427, 120, 0, 0, 315000, 0, 0, 54261), -- Gnomeregan Infantry (Area: Frostmane Hold - Difficulty: 0) CreateObject1
(@CGUID+27, 39252, 0, 1, 135, 1, 256, 0, 1, -5396.3037109375, 523.63714599609375, 387.024322509765625, 0.401425719261169433, 120, 0, 0, 315000, 0, 0, 54261), -- Gnomeregan Infantry (Area: Frostmane Hold - Difficulty: 0) CreateObject1
(@CGUID+28, 39252, 0, 1, 135, 1, 256, 0, 1, -5398.64599609375, 533.1961669921875, 387.230560302734375, 0.453785598278045654, 120, 0, 0, 315000, 0, 0, 54261), -- Gnomeregan Infantry (Area: Frostmane Hold - Difficulty: 0) CreateObject1
(@CGUID+29, 39252, 0, 1, 135, 1, 256, 0, 1, -5401.89599609375, 547.248291015625, 387.5538330078125, 0.244346097111701965, 120, 0, 0, 315000, 0, 0, 54261), -- Gnomeregan Infantry (Area: Frostmane Hold - Difficulty: 0) CreateObject1
(@CGUID+30, 39252, 0, 1, 135, 1, 256, 0, 1, -5402.88525390625, 550.53643798828125, 387.97918701171875, 0.122173048555850982, 120, 0, 0, 315000, 0, 0, 54261), -- Gnomeregan Infantry (Area: Frostmane Hold - Difficulty: 0) CreateObject1
(@CGUID+31, 39252, 0, 1, 135, 1, 256, 0, 1, -5448.28662109375, 497.37152099609375, 385.70635986328125, 3.577924966812133789, 120, 0, 0, 315000, 0, 0, 54261), -- Gnomeregan Infantry (Area: Frostmane Hold - Difficulty: 0) CreateObject1
(@CGUID+32, 39252, 0, 1, 135, 1, 256, 0, 1, -5420.8505859375, 460.447906494140625, 385.935302734375, 3.59537816047668457, 120, 0, 0, 315000, 0, 0, 54261), -- Gnomeregan Infantry (Area: Frostmane Hold - Difficulty: 0) CreateObject1
(@CGUID+33, 39252, 0, 1, 135, 1, 256, 0, 1, -5453.84912109375, 514.36114501953125, 387.285919189453125, 3.839724302291870117, 120, 0, 0, 315000, 0, 0, 54261), -- Gnomeregan Infantry (Area: Frostmane Hold - Difficulty: 0) CreateObject1
(@CGUID+34, 39252, 0, 1, 135, 1, 256, 0, 1, -5441.25341796875, 481.0538330078125, 384.850341796875, 3.59537816047668457, 120, 0, 0, 315000, 0, 0, 54261), -- Gnomeregan Infantry (Area: Frostmane Hold - Difficulty: 0) CreateObject1
(@CGUID+35, 39252, 0, 1, 135, 1, 256, 0, 1, -5418.44091796875, 458.017364501953125, 386.95867919921875, 3.804817676544189453, 120, 0, 0, 315000, 0, 0, 54261), -- Gnomeregan Infantry (Area: Frostmane Hold - Difficulty: 0) CreateObject1
(@CGUID+36, 39259, 0, 1, 135, 1, 256, 0, 0, -5399.173828125, 534.484375, 394.620513916015625, 0.401425719261169433, 120, 0, 0, 315000, 0, 0, 54261), -- Gnomeregan Flying Machine (Area: Frostmane Hold - Difficulty: 0) CreateObject1
(@CGUID+37, 39259, 0, 1, 135, 1, 256, 0, 0, -5396.1181640625, 519.88714599609375, 394.06854248046875, 0.523598790168762207, 120, 0, 0, 315000, 0, 0, 54261), -- Gnomeregan Flying Machine (Area: Frostmane Hold - Difficulty: 0) CreateObject1
(@CGUID+38, 39259, 0, 1, 135, 1, 256, 0, 0, -5401.6025390625, 549.52606201171875, 395.183990478515625, 0.209439516067504882, 120, 0, 0, 315000, 0, 0, 54261), -- Gnomeregan Flying Machine (Area: Frostmane Hold - Difficulty: 0) CreateObject1
(@CGUID+39, 39259, 0, 1, 135, 1, 256, 0, 0, -5402.9375, 497.423614501953125, 392.82000732421875, 0.959931075572967529, 120, 0, 0, 315000, 0, 0, 54261), -- Gnomeregan Flying Machine (Area: Frostmane Hold - Difficulty: 0) CreateObject1
(@CGUID+40, 39259, 0, 1, 135, 1, 256, 0, 0, -5398.7099609375, 467.0382080078125, 391.05047607421875, 5.654866695404052734, 120, 0, 0, 315000, 0, 0, 54261), -- Gnomeregan Flying Machine (Area: Frostmane Hold - Difficulty: 0) CreateObject1
(@CGUID+41, 39259, 0, 1, 135, 1, 256, 0, 0, -5445.0537109375, 525.6875, 393.753662109375, 2.827433347702026367, 120, 0, 0, 315000, 0, 0, 54261), -- Gnomeregan Flying Machine (Area: Frostmane Hold - Difficulty: 0) CreateObject1
(@CGUID+42, 39271, 0, 1, 135, 1, 256, 0, 1, -5424.76904296875, 528.06427001953125, 387.052642822265625, 5.288347721099853515, 120, 0, 0, 5578000, 0, 0, 54261), -- High Tinker Mekkatorque (Area: Frostmane Hold - Difficulty: 0) CreateObject1
(@CGUID+43, 39273, 0, 1, 135, 1, 256, 0, 1, -5425.88916015625, 532.36285400390625, 387.012176513671875, 5.25344085693359375, 120, 0, 0, 630000, 0, 0, 54261), -- "Doc" Cogspin (Area: Frostmane Hold - Difficulty: 0) CreateObject1
(@CGUID+44, 39275, 0, 1, 135, 1, 256, 0, 0, -5413.79541015625, 496.3507080078125, 386.696533203125, 5.183627605438232421, 120, 0, 0, 10635, 0, 0, 54261), -- Gnomeregan Medic (Area: Frostmane Hold - Difficulty: 0) CreateObject1
(@CGUID+45, 39860, 0, 1, 135, 1, 256, 0, 0, -5402.34912109375, 519.94964599609375, 386.850830078125, 0.366519153118133544, 120, 0, 0, 1008000, 0, 0, 54261), -- Gnomeregan Mechano-Tank (Area: Frostmane Hold - Difficulty: 0) CreateObject1 (Auras: )
(@CGUID+46, 39860, 0, 1, 135, 1, 256, 0, 0, -5404.876953125, 534.078125, 387.093994140625, 0.296705961227416992, 120, 0, 0, 1008000, 0, 0, 54261), -- Gnomeregan Mechano-Tank (Area: Frostmane Hold - Difficulty: 0) CreateObject1 (Auras: )
(@CGUID+47, 39860, 0, 1, 135, 1, 256, 0, 0, -5407.6806640625, 546.092041015625, 387.715301513671875, 0.436332315206527709, 120, 0, 0, 1008000, 0, 0, 54261), -- Gnomeregan Mechano-Tank (Area: Frostmane Hold - Difficulty: 0) CreateObject1 (Auras: )
(@CGUID+48, 39860, 0, 1, 135, 1, 256, 0, 0, -5389.7412109375, 466.774322509765625, 384.623931884765625, 5.811946392059326171, 120, 0, 0, 1008000, 0, 0, 54261), -- Gnomeregan Mechano-Tank (Area: Frostmane Hold - Difficulty: 0) CreateObject1 (Auras: )
(@CGUID+49, 39860, 0, 1, 135, 1, 256, 0, 0, -5434.38720703125, 496.670135498046875, 385.328125, 4.084070205688476562, 120, 0, 0, 1008000, 0, 0, 54261), -- Gnomeregan Mechano-Tank (Area: Frostmane Hold - Difficulty: 0) CreateObject1 (Auras: )
(@CGUID+50, 39910, 0, 1, 135, 1, 256, 0, 1, -5429.142578125, 529.6475830078125, 387.16668701171875, 5.340707302093505859, 120, 0, 0, 630000, 0, 0, 54261), -- Hinkles Fastblast (Area: Frostmane Hold - Difficulty: 0) CreateObject1
(@CGUID+51, 40478, 0, 1, 135, 1, 256, 0, 1, -5423.81103515625, 537.6475830078125, 386.641998291015625, 4.258603572845458984, 120, 0, 0, 12600, 0, 0, 54261), -- Elgin Clickspring (Area: Frostmane Hold - Difficulty: 0) CreateObject1
-- New Tinkertown
(@CGUID+52, 23837, 0, 1, 133, 1, 256, 0, 0, -5359.27978515625, 540.08160400390625, 386.854766845703125, 0, 120, 0, 0, 42, 0, 0, 54261), -- ELM General Purpose Bunny (Area: New Tinkertown - Difficulty: 0) CreateObject1 (Auras: 52855 - Cosmetic - Low Poly Fire (with Sound))
(@CGUID+53, 23837, 0, 1, 133, 1, 256, 0, 0, -5363.17041015625, 544.0069580078125, 387.032196044921875, 0, 120, 0, 0, 42, 0, 0, 54261), -- ELM General Purpose Bunny (Area: New Tinkertown - Difficulty: 0) CreateObject1 (Auras: 52855 - Cosmetic - Low Poly Fire (with Sound))
(@CGUID+54, 39755, 0, 1, 133, 1, 256, 0, 1, -5348.0537109375, 540.51910400390625, 385.17822265625, 3.787364482879638671, 120, 0, 0, 189000, 0, 0, 54261), -- Irradiated Infantry (Area: New Tinkertown - Difficulty: 0) CreateObject1
(@CGUID+55, 39755, 0, 1, 133, 1, 256, 0, 1, -5358.97900390625, 561.123291015625, 386.962799072265625, 3.735004663467407226, 120, 0, 0, 189000, 0, 0, 54261), -- Irradiated Infantry (Area: New Tinkertown - Difficulty: 0) CreateObject1
(@CGUID+56, 39755, 0, 1, 133, 1, 256, 0, 1, -5356.1962890625, 556.7430419921875, 386.569091796875, 3.735004663467407226, 120, 0, 0, 189000, 0, 0, 54261), -- Irradiated Infantry (Area: New Tinkertown - Difficulty: 0) CreateObject1
(@CGUID+57, 39755, 0, 1, 133, 1, 256, 0, 1, -5343.94287109375, 534.57989501953125, 384.838775634765625, 3.59537816047668457, 120, 0, 0, 189000, 0, 0, 54261), -- Irradiated Infantry (Area: New Tinkertown - Difficulty: 0) CreateObject1
(@CGUID+58, 39755, 0, 1, 133, 1, 256, 0, 1, -5289.72216796875, 553.51739501953125, 383.84368896484375, 3.03687286376953125, 120, 0, 0, 189000, 0, 0, 54261), -- Irradiated Infantry (Area: New Tinkertown - Difficulty: 0) CreateObject1
(@CGUID+59, 39755, 0, 1, 133, 1, 256, 0, 1, -5348.5380859375, 574.953125, 387.094207763671875, 0.087266460061073303, 120, 0, 0, 189000, 0, 0, 54261), -- Irradiated Infantry (Area: New Tinkertown - Difficulty: 0) CreateObject1
(@CGUID+60, 39755, 0, 1, 133, 1, 256, 0, 1, -5300.033203125, 534.72052001953125, 385.281585693359375, 5.550147056579589843, 120, 0, 0, 189000, 0, 0, 54261), -- Irradiated Infantry (Area: New Tinkertown - Difficulty: 0) CreateObject1
(@CGUID+61, 39755, 0, 1, 133, 1, 256, 0, 1, -5323.12353515625, 586.9930419921875, 389.009521484375, 5.288347721099853515, 120, 0, 0, 189000, 0, 0, 54261), -- Irradiated Infantry (Area: New Tinkertown - Difficulty: 0) CreateObject1
(@CGUID+62, 39755, 0, 1, 133, 1, 256, 0, 1, -5352.486328125, 575.451416015625, 387.155853271484375, 3.50811171531677246, 120, 0, 0, 189000, 0, 0, 54261), -- Irradiated Infantry (Area: New Tinkertown - Difficulty: 0) CreateObject1
(@CGUID+63, 39755, 0, 1, 133, 1, 256, 0, 1, -5344.283203125, 555.65802001953125, 384.487762451171875, 3.438298702239990234, 120, 0, 0, 189000, 0, 0, 54261), -- Irradiated Infantry (Area: New Tinkertown - Difficulty: 0) CreateObject1
(@CGUID+64, 39755, 0, 1, 133, 1, 256, 0, 1, -5333.4130859375, 545.32293701171875, 385.25537109375, 3.159045934677124023, 120, 0, 0, 189000, 0, 0, 54261), -- Irradiated Infantry (Area: New Tinkertown - Difficulty: 0) CreateObject1
(@CGUID+65, 39755, 0, 1, 133, 1, 256, 0, 1, -5287.76220703125, 541.69793701171875, 384.072845458984375, 5.567600250244140625, 120, 0, 0, 189000, 0, 0, 54261), -- Irradiated Infantry (Area: New Tinkertown - Difficulty: 0) CreateObject1
(@CGUID+66, 39755, 0, 1, 133, 1, 256, 0, 1, -5306.359375, 523.84552001953125, 385.169189453125, 5.427973747253417968, 120, 0, 0, 189000, 0, 0, 54261), -- Irradiated Infantry (Area: New Tinkertown - Difficulty: 0) CreateObject1
(@CGUID+67, 39755, 0, 1, 133, 1, 256, 0, 1, -5337.45166015625, 560.05902099609375, 395.717315673828125, 3.420845270156860351, 120, 0, 0, 189000, 0, 0, 54261), -- Irradiated Infantry (Area: New Tinkertown - Difficulty: 0) CreateObject1
(@CGUID+68, 39755, 0, 1, 133, 1, 256, 0, 1, -5324.98779296875, 590.28472900390625, 389.05645751953125, 2.0245819091796875, 120, 0, 0, 189000, 0, 0, 54261), -- Irradiated Infantry (Area: New Tinkertown - Difficulty: 0) CreateObject1
(@CGUID+69, 39755, 0, 1, 133, 1, 256, 0, 1, -5329.98974609375, 546.0711669921875, 385.19366455078125, 0.733038306236267089, 120, 0, 0, 189000, 0, 0, 54261), -- Irradiated Infantry (Area: New Tinkertown - Difficulty: 0) CreateObject1
(@CGUID+70, 39755, 0, 1, 133, 1, 256, 0, 1, -5339.18408203125, 563.73614501953125, 395.96392822265625, 3.717551231384277343, 120, 0, 0, 189000, 0, 0, 54261), -- Irradiated Infantry (Area: New Tinkertown - Difficulty: 0) CreateObject1
(@CGUID+71, 39755, 0, 1, 133, 1, 256, 0, 1, -5296.43212890625, 570.9913330078125, 386.973114013671875, 3.769911050796508789, 120, 0, 0, 189000, 0, 0, 54261), -- Irradiated Infantry (Area: New Tinkertown - Difficulty: 0) CreateObject1
(@CGUID+72, 39755, 0, 1, 133, 1, 256, 0, 1, -5310.0224609375, 585.22052001953125, 389.62396240234375, 3.368485450744628906, 120, 0, 0, 189000, 0, 0, 54261), -- Irradiated Infantry (Area: New Tinkertown - Difficulty: 0) CreateObject1
(@CGUID+73, 39755, 0, 1, 133, 1, 256, 0, 1, -5270.91650390625, 566.701416015625, 386.6964111328125, 3.141592741012573242, 120, 0, 0, 189000, 0, 0, 54261), -- Irradiated Infantry (Area: New Tinkertown - Difficulty: 0) CreateObject1
(@CGUID+74, 39755, 0, 1, 133, 1, 256, 0, 1, -5274.78662109375, 550.732666015625, 386.570831298828125, 5.864306449890136718, 120, 0, 0, 189000, 0, 0, 54261), -- Irradiated Infantry (Area: New Tinkertown - Difficulty: 0) CreateObject1
(@CGUID+75, 39755, 0, 1, 133, 1, 256, 0, 1, -5293.1025390625, 573.03302001953125, 386.90826416015625, 0.680678427219390869, 120, 0, 0, 189000, 0, 0, 54261), -- Irradiated Infantry (Area: New Tinkertown - Difficulty: 0) CreateObject1
(@CGUID+76, 39755, 0, 1, 133, 1, 256, 0, 1, -5295.720703125, 600.4757080078125, 389.19757080078125, 2.530727386474609375, 120, 0, 0, 189000, 0, 0, 54261), -- Irradiated Infantry (Area: New Tinkertown - Difficulty: 0) CreateObject1
(@CGUID+77, 39755, 0, 1, 133, 1, 256, 0, 1, -5185.734375, 575.54339599609375, 401.383087158203125, 4.747295379638671875, 120, 0, 0, 189000, 0, 0, 54261), -- Irradiated Infantry (Area: New Tinkertown - Difficulty: 0) CreateObject1
(@CGUID+78, 39755, 0, 1, 133, 1, 256, 0, 1, -5192.05029296875, 572.5867919921875, 400.321258544921875, 4.747295379638671875, 120, 0, 0, 189000, 0, 0, 54261), -- Irradiated Infantry (Area: New Tinkertown - Difficulty: 0) CreateObject1
(@CGUID+79, 39755, 0, 1, 133, 1, 256, 0, 1, -5193.22216796875, 586.21875, 405.40301513671875, 4.747295379638671875, 120, 0, 0, 189000, 0, 0, 54261), -- Irradiated Infantry (Area: New Tinkertown - Difficulty: 0) CreateObject1
(@CGUID+80, 39755, 0, 1, 133, 1, 256, 0, 1, -5191.48974609375, 598.1336669921875, 408.924407958984375, 4.747295379638671875, 120, 0, 0, 189000, 0, 0, 54261), -- Irradiated Infantry (Area: New Tinkertown - Difficulty: 0) CreateObject1
(@CGUID+81, 39755, 0, 1, 133, 1, 256, 0, 1, -5177.43603515625, 587.62677001953125, 405.4580078125, 4.747295379638671875, 120, 0, 0, 189000, 0, 0, 54261), -- Irradiated Infantry (Area: New Tinkertown - Difficulty: 0) CreateObject1
(@CGUID+82, 39755, 0, 1, 133, 1, 256, 0, 1, -5178.9375, 572.71875, 399.95343017578125, 4.747295379638671875, 120, 0, 0, 189000, 0, 0, 54261), -- Irradiated Infantry (Area: New Tinkertown - Difficulty: 0) CreateObject1
(@CGUID+83, 39755, 0, 1, 133, 1, 256, 0, 1, -5161.2880859375, 585.5625, 408.72576904296875, 3.420845270156860351, 120, 0, 0, 189000, 0, 0, 54261), -- Irradiated Infantry (Area: New Tinkertown - Difficulty: 0) CreateObject1
(@CGUID+84, 39755, 0, 1, 133, 1, 256, 0, 1, -5176.828125, 598.717041015625, 408.84521484375, 4.747295379638671875, 120, 0, 0, 189000, 0, 0, 54261), -- Irradiated Infantry (Area: New Tinkertown - Difficulty: 0) CreateObject1
(@CGUID+85, 39755, 0, 1, 133, 1, 256, 0, 1, -5119.81103515625, 468.4288330078125, 397.38916015625, 3.089232683181762695, 120, 0, 0, 189000, 0, 0, 54261), -- Irradiated Infantry (Area: New Tinkertown - Difficulty: 0) CreateObject1
(@CGUID+86, 39755, 0, 1, 133, 1, 256, 0, 1, -5153.72412109375, 458.984375, 392.002197265625, 1.989675283432006835, 120, 0, 0, 189000, 0, 0, 54261), -- Irradiated Infantry (Area: New Tinkertown - Difficulty: 0) CreateObject1
(@CGUID+87, 39755, 0, 1, 133, 1, 256, 0, 1, -5136.19091796875, 462.029510498046875, 393.539306640625, 3.141592741012573242, 120, 0, 0, 189000, 0, 0, 54261), -- Irradiated Infantry (Area: New Tinkertown - Difficulty: 0) CreateObject1
(@CGUID+88, 39755, 0, 1, 133, 1, 256, 0, 1, -5091.3037109375, 465.352447509765625, 404.57794189453125, 3.141592741012573242, 120, 0, 0, 189000, 0, 0, 54261), -- Irradiated Infantry (Area: New Tinkertown - Difficulty: 0) CreateObject1
(@CGUID+89, 39755, 0, 1, 133, 1, 256, 0, 1, -5087.20849609375, 480.064239501953125, 401.89154052734375, 4.049163818359375, 120, 0, 0, 189000, 0, 0, 54261), -- Irradiated Infantry (Area: New Tinkertown - Difficulty: 0) CreateObject1
(@CGUID+90, 39755, 0, 1, 133, 1, 256, 0, 1, -5121.90625, 445.927093505859375, 396.843292236328125, 3.141592741012573242, 120, 0, 0, 189000, 0, 0, 54261), -- Irradiated Infantry (Area: New Tinkertown - Difficulty: 0) CreateObject1
(@CGUID+91, 39755, 0, 1, 133, 1, 256, 0, 1, -5105.0068359375, 452.888885498046875, 401.898193359375, 3.141592741012573242, 120, 0, 0, 189000, 0, 0, 54261), -- Irradiated Infantry (Area: New Tinkertown - Difficulty: 0) CreateObject1
(@CGUID+92, 39755, 0, 1, 133, 1, 256, 0, 1, -5081.77587890625, 475.982635498046875, 402.063934326171875, 3.909537553787231445, 120, 0, 0, 189000, 0, 0, 54261), -- Irradiated Infantry (Area: New Tinkertown - Difficulty: 0) CreateObject1
(@CGUID+93, 39755, 0, 1, 133, 1, 256, 0, 1, -5130.9306640625, 432.317718505859375, 396.533203125, 1.675516128540039062, 120, 0, 0, 189000, 0, 0, 54261), -- Irradiated Infantry (Area: New Tinkertown - Difficulty: 0) CreateObject1
(@CGUID+94, 39755, 0, 1, 133, 1, 256, 0, 1, -5090.65966796875, 488.920135498046875, 404.43701171875, 3.926990747451782226, 120, 0, 0, 189000, 0, 0, 54261), -- Irradiated Infantry (Area: New Tinkertown - Difficulty: 0) CreateObject1
(@CGUID+95, 39755, 0, 1, 133, 1, 256, 0, 1, -5121.595703125, 456.645843505859375, 397.4964599609375, 3.490658521652221679, 120, 0, 0, 189000, 0, 0, 54261), -- Irradiated Infantry (Area: New Tinkertown - Difficulty: 0) CreateObject1
(@CGUID+96, 39755, 0, 1, 133, 1, 256, 0, 1, -5103.5849609375, 422.873260498046875, 403.033447265625, 3.089232683181762695, 120, 0, 0, 189000, 0, 0, 54261), -- Irradiated Infantry (Area: New Tinkertown - Difficulty: 0) CreateObject1
(@CGUID+97, 39755, 0, 1, 133, 1, 256, 0, 1, -5086.126953125, 447.140625, 409.984375, 2.059488534927368164, 120, 0, 0, 189000, 0, 0, 54261), -- Irradiated Infantry (Area: New Tinkertown - Difficulty: 0) CreateObject1
(@CGUID+98, 39755, 0, 1, 133, 1, 256, 0, 1, -5078.2568359375, 463.953125, 406.89276123046875, 3.141592741012573242, 120, 0, 0, 189000, 0, 0, 54261), -- Irradiated Infantry (Area: New Tinkertown - Difficulty: 0) CreateObject1
(@CGUID+99, 39755, 0, 1, 133, 1, 256, 0, 1, -5082.2431640625, 452.94097900390625, 409.813751220703125, 2.792526721954345703, 120, 0, 0, 189000, 0, 0, 54261), -- Irradiated Infantry (Area: New Tinkertown - Difficulty: 0) CreateObject1
(@CGUID+100, 39759, 0, 1, 133, 1, 256, 0, 0, -5147.05908203125, 436.289947509765625, 395.835784912109375, 1.972222089767456054, 120, 0, 0, 756000, 0, 0, 54261), -- Tankbuster Cannon (Area: New Tinkertown - Difficulty: 0) CreateObject1
(@CGUID+101, 39759, 0, 1, 133, 1, 256, 0, 0, -5112.57666015625, 426.373260498046875, 398.37225341796875, 2.408554315567016601, 120, 0, 0, 756000, 0, 0, 54261), -- Tankbuster Cannon (Area: New Tinkertown - Difficulty: 0) CreateObject1 (Auras: 74458 - Power Shield XL-1)
(@CGUID+102, 39759, 0, 1, 133, 1, 256, 0, 0, -5108.5556640625, 478.145843505859375, 398.51495361328125, 3.996803998947143554, 120, 0, 0, 756000, 0, 0, 54261), -- Tankbuster Cannon (Area: New Tinkertown - Difficulty: 0) CreateObject1
(@CGUID+103, 39759, 0, 1, 133, 1, 256, 0, 0, -5097.0712890625, 454.213531494140625, 404.49664306640625, 3.089232683181762695, 120, 0, 0, 756000, 0, 0, 54261), -- Tankbuster Cannon (Area: New Tinkertown - Difficulty: 0) CreateObject1
(@CGUID+104, 39759, 0, 1, 133, 1, 256, 0, 0, -5087.56103515625, 432.217010498046875, 412.7264404296875, 2.775073528289794921, 120, 0, 0, 756000, 0, 0, 54261), -- Tankbuster Cannon (Area: New Tinkertown - Difficulty: 0) CreateObject1 (Auras: 74458 - Power Shield XL-1)
(@CGUID+105, 39759, 0, 1, 133, 1, 256, 0, 0, -5074.6943359375, 460.59375, 409.74652099609375, 3.019419670104980468, 120, 0, 0, 756000, 0, 0, 54261), -- Tankbuster Cannon (Area: New Tinkertown - Difficulty: 0) CreateObject1 (Auras: 74458 - Power Shield XL-1)
(@CGUID+106, 39819, 0, 1, 133, 1, 256, 0, 0, -5340.0747, 544.31946, 385.06015, 2.130715847015380859, 120, 0, 0, 1008000, 0, 2, 54261), -- Irradiated Mechano-Tank (Area: New Tinkertown - Difficulty: 0) CreateObject1 (Auras: )
(@CGUID+107, 39819, 0, 1, 133, 1, 256, 0, 0, -5332.44970703125, 537.62152099609375, 385.172760009765625, 3.752457857131958007, 120, 0, 0, 1008000, 0, 0, 54261), -- Irradiated Mechano-Tank (Area: New Tinkertown - Difficulty: 0) CreateObject1 (Auras: )
(@CGUID+108, 39819, 0, 1, 133, 1, 256, 0, 0, -5317.33837890625, 575.279541015625, 387.68310546875, 3.59537816047668457, 120, 0, 0, 1008000, 0, 0, 54261), -- Irradiated Mechano-Tank (Area: New Tinkertown - Difficulty: 0) CreateObject1 (Auras: )
(@CGUID+109, 39819, 0, 1, 133, 1, 256, 0, 0, -5290.21728515625, 581.435791015625, 387.529052734375, 3.839724302291870117, 120, 0, 0, 1008000, 0, 0, 54261), -- Irradiated Mechano-Tank (Area: New Tinkertown - Difficulty: 0) CreateObject1
(@CGUID+110, 39819, 0, 1, 133, 1, 256, 0, 0, -5261.078125, 556.92706298828125, 387.381805419921875, 2.722713708877563476, 120, 0, 0, 1008000, 0, 0, 54261), -- Irradiated Mechano-Tank (Area: New Tinkertown - Difficulty: 0) CreateObject1 (Auras: )
(@CGUID+111, 39819, 0, 1, 133, 1, 256, 0, 0, -5121.222, 417.56424, 396.6584, 4.833743095397949218, 120, 0, 0, 1008000, 0, 2, 54261), -- Irradiated Mechano-Tank (Area: New Tinkertown - Difficulty: 0) CreateObject1 (Auras: )
(@CGUID+112, 39819, 0, 1, 133, 1, 256, 0, 0, -5116.6787, 453.06946, 398.87387, 0, 120, 0, 0, 1008000, 0, 2, 54261), -- Irradiated Mechano-Tank (Area: New Tinkertown - Difficulty: 0) CreateObject1
(@CGUID+113, 39819, 0, 1, 133, 1, 256, 0, 0, -5069.2255859375, 471.3125, 403.606353759765625, 0.231994718313217163, 120, 0, 0, 1008000, 0, 2, 54261), -- Irradiated Mechano-Tank (Area: New Tinkertown - Difficulty: 0) CreateObject1 (Auras: )
(@CGUID+114, 39820, 0, 1, 133, 1, 256, 0, 0, -5294.63037109375, 571.828125, 386.8916015625, 5.323254108428955078, 120, 0, 0, 756000, 0, 0, 54261), -- Rocket Launcher (Area: New Tinkertown - Difficulty: 0) CreateObject1 (Auras: 74311 - Fire Rocket)
(@CGUID+115, 39820, 0, 1, 133, 1, 256, 0, 0, -5350.45654296875, 575.029541015625, 387.189697265625, 4.694935798645019531, 120, 0, 0, 756000, 0, 0, 54261), -- Rocket Launcher (Area: New Tinkertown - Difficulty: 0) CreateObject1 (Auras: 74311 - Fire Rocket)
(@CGUID+116, 39820, 0, 1, 133, 1, 256, 0, 0, -5324.21875, 588.55206298828125, 388.98089599609375, 3.682644605636596679, 120, 0, 0, 756000, 0, 0, 54261), -- Rocket Launcher (Area: New Tinkertown - Difficulty: 0) CreateObject1 (Auras: 74311 - Fire Rocket)
(@CGUID+117, 39820, 0, 1, 133, 1, 256, 0, 0, -5331.4619140625, 544.87677001953125, 385.160614013671875, 4.991641521453857421, 120, 0, 0, 756000, 0, 0, 54261), -- Rocket Launcher (Area: New Tinkertown - Difficulty: 0) CreateObject1 (Auras: 74311 - Fire Rocket)
(@CGUID+118, 39841, 0, 1, 133, 1, 256, 0, 0, -5335.8145, 545.21875, 403.1348, 0, 120, 0, 0, 26946, 0, 2, 54261), -- [DND] Boom Bunny (Area: New Tinkertown - Difficulty: 0) CreateObject1 (Auras: 74463 - [DND] Boom) (possible waypoints or random movement)
(@CGUID+119, 39841, 0, 1, 133, 1, 256, 0, 0, -5295.0903, 574.07117, 404.9674, 0, 120, 0, 0, 26946, 0, 2, 54261), -- [DND] Boom Bunny (Area: New Tinkertown - Difficulty: 0) CreateObject1 (Auras: 74463 - [DND] Boom) (possible waypoints or random movement)
(@CGUID+120, 39902, 0, 1, 133, 1, 256, 0, 0, -5074.22216796875, 481.795135498046875, 401.56805419921875, 4.502949237823486328, 120, 0, 0, 567000, 0, 0, 54261), -- Gnomeregan Battle Suit (Area: New Tinkertown - Difficulty: 0) CreateObject1 (Auras: 74490 - Permanent Feign Death)
(@CGUID+121, 39902, 0, 1, 133, 1, 256, 0, 0, -5065.5068359375, 484.805572509765625, 401.56805419921875, 5.759586334228515625, 120, 0, 0, 567000, 0, 0, 54261), -- Gnomeregan Battle Suit (Area: New Tinkertown - Difficulty: 0) CreateObject1 (Auras: 74490 - Permanent Feign Death)
(@CGUID+122, 39902, 0, 1, 133, 1, 256, 0, 0, -5069.8525390625, 481.984375, 401.67535400390625, 4.904375076293945312, 120, 0, 0, 567000, 0, 0, 54261), -- Gnomeregan Battle Suit (Area: New Tinkertown - Difficulty: 0) CreateObject1 (Auras: 74490 - Permanent Feign Death)
(@CGUID+123, 40617, 0, 1, 133, 1, 256, 0, 0, -5182.75, 610.76043701171875, 409.047119140625, 4.607669353485107421, 120, 0, 0, 42, 0, 0, 54261), -- [DND] Bunny (Area: New Tinkertown - Difficulty: 0) CreateObject1 (Auras: 74532 - Radiation Cloud)
(@CGUID+124, 40617, 0, 1, 133, 1, 256, 0, 0, -5181.376953125, 631.123291015625, 398.629638671875, 4.607669353485107421, 120, 0, 0, 42, 0, 0, 54261), -- [DND] Bunny (Area: New Tinkertown - Difficulty: 0) CreateObject1 (Auras: 74532 - Radiation Cloud)
(@CGUID+125, 40617, 0, 1, 133, 1, 256, 0, 0, -5179.76416015625, 652.93231201171875, 389.968414306640625, 4.607669353485107421, 120, 0, 0, 42, 0, 0, 54261), -- [DND] Bunny (Area: New Tinkertown - Difficulty: 0) CreateObject1 (Auras: 74532 - Radiation Cloud)
(@CGUID+126, 40617, 0, 1, 133, 1, 256, 0, 0, -5178.625, 668.34027099609375, 384.878265380859375, 4.607669353485107421, 120, 0, 0, 42, 0, 0, 54261), -- [DND] Bunny (Area: New Tinkertown - Difficulty: 0) CreateObject1 (Auras: 74532 - Radiation Cloud)
(@CGUID+127, 40617, 0, 1, 133, 1, 256, 0, 0, -5162.89404296875, 670.34722900390625, 351.3189697265625, 4.607669353485107421, 120, 0, 0, 42, 0, 0, 54261), -- [DND] Bunny (Area: New Tinkertown - Difficulty: 0) CreateObject1 (Auras: 74532 - Radiation Cloud)
(@CGUID+128, 40617, 0, 1, 133, 1, 256, 0, 0, -5177.3349609375, 690.43231201171875, 376.7799072265625, 4.607669353485107421, 120, 0, 0, 42, 0, 0, 54261), -- [DND] Bunny (Area: New Tinkertown - Difficulty: 0) CreateObject1 (Auras: 74532 - Radiation Cloud)
(@CGUID+129, 40617, 0, 1, 133, 1, 256, 0, 0, -5159.84228515625, 700.420166015625, 367.409454345703125, 4.607669353485107421, 120, 0, 0, 42, 0, 0, 54261), -- [DND] Bunny (Area: New Tinkertown - Difficulty: 0) CreateObject1 (Auras: 74532 - Radiation Cloud)
(@CGUID+130, 40617, 0, 1, 133, 1, 256, 0, 0, -5166.65966796875, 715.31427001953125, 369.1473388671875, 4.607669353485107421, 120, 0, 0, 42, 0, 0, 54261); -- [DND] Bunny (Area: New Tinkertown - Difficulty: 0) CreateObject1 (Auras: 74532 - Radiation Cloud)

DELETE FROM `creature_addon` WHERE `guid` BETWEEN @CGUID+0 AND @CGUID+130;
INSERT INTO `creature_addon` (`guid`, `mount`, `StandState`, `AnimTier`, `VisFlags`, `SheathState`, `PvpFlags`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(@CGUID+5, 0, 0, 0, 0, 0, 0, 0, 0, ''), -- Gnomeregan Infantry
(@CGUID+6, 0, 0, 0, 0, 1, 0, 214, 0, ''), -- Gnomeregan Infantry
(@CGUID+7, 0, 0, 0, 0, 1, 0, 214, 0, ''), -- Gnomeregan Infantry
(@CGUID+8, 0, 0, 0, 0, 1, 0, 214, 0, ''), -- Gnomeregan Infantry
(@CGUID+9, 0, 0, 0, 0, 1, 0, 214, 0, ''), -- Gnomeregan Infantry
(@CGUID+10, 0, 0, 0, 0, 1, 0, 214, 0, ''), -- Gnomeregan Infantry
(@CGUID+11, 0, 0, 0, 0, 1, 0, 214, 0, ''), -- Gnomeregan Infantry
(@CGUID+12, 0, 0, 0, 0, 1, 0, 214, 0, ''), -- Gnomeregan Infantry
(@CGUID+13, 0, 0, 0, 0, 1, 0, 214, 0, ''), -- Gnomeregan Infantry
(@CGUID+14, 0, 0, 0, 0, 1, 0, 214, 0, ''), -- Gnomeregan Infantry
(@CGUID+15, 0, 0, 0, 0, 1, 0, 214, 0, ''), -- Gnomeregan Infantry
(@CGUID+16, 0, 0, 0, 0, 1, 0, 214, 0, ''), -- Gnomeregan Infantry
(@CGUID+17, 0, 0, 0, 0, 1, 0, 214, 0, ''), -- Gnomeregan Infantry
(@CGUID+18, 0, 0, 0, 0, 1, 0, 214, 0, ''), -- Gnomeregan Infantry
(@CGUID+19, 0, 0, 0, 0, 1, 0, 214, 0, ''), -- Gnomeregan Infantry
(@CGUID+20, 0, 0, 0, 0, 1, 0, 214, 0, ''), -- Gnomeregan Infantry
(@CGUID+21, 0, 0, 0, 0, 1, 0, 214, 0, ''), -- Gnomeregan Infantry
(@CGUID+22, 0, 0, 0, 0, 1, 0, 214, 0, ''), -- Gnomeregan Infantry
(@CGUID+23, 0, 0, 0, 0, 1, 0, 214, 0, ''), -- Gnomeregan Infantry
(@CGUID+24, 0, 0, 0, 0, 1, 0, 214, 0, ''), -- Gnomeregan Infantry
(@CGUID+25, 0, 0, 0, 0, 1, 0, 214, 0, ''), -- Gnomeregan Infantry
(@CGUID+26, 0, 0, 0, 0, 2, 0, 214, 0, ''), -- Gnomeregan Infantry
(@CGUID+27, 0, 0, 0, 0, 2, 0, 214, 0, ''), -- Gnomeregan Infantry
(@CGUID+28, 0, 0, 0, 0, 2, 0, 214, 0, ''), -- Gnomeregan Infantry
(@CGUID+29, 0, 0, 0, 0, 2, 0, 214, 0, ''), -- Gnomeregan Infantry
(@CGUID+30, 0, 0, 0, 0, 2, 0, 214, 0, ''), -- Gnomeregan Infantry
(@CGUID+31, 0, 0, 0, 0, 2, 0, 214, 0, ''), -- Gnomeregan Infantry
(@CGUID+32, 0, 0, 0, 0, 2, 0, 214, 0, ''), -- Gnomeregan Infantry
(@CGUID+33, 0, 0, 0, 0, 2, 0, 214, 0, ''), -- Gnomeregan Infantry
(@CGUID+34, 0, 0, 0, 0, 2, 0, 214, 0, ''), -- Gnomeregan Infantry
(@CGUID+35, 0, 0, 0, 0, 2, 0, 214, 0, ''), -- Gnomeregan Infantry
(@CGUID+52, 0, 0, 0, 0, 1, 0, 0, 0, '52855'), -- ELM General Purpose Bunny - 52855 - Cosmetic - Low Poly Fire (with Sound)
(@CGUID+53, 0, 0, 0, 0, 1, 0, 0, 0, '52855'), -- ELM General Purpose Bunny - 52855 - Cosmetic - Low Poly Fire (with Sound)
(@CGUID+54, 0, 0, 0, 0, 1, 0, 333, 0, ''), -- Irradiated Infantry
(@CGUID+55, 0, 0, 0, 0, 1, 0, 333, 0, ''), -- Irradiated Infantry
(@CGUID+56, 0, 0, 0, 0, 1, 0, 333, 0, ''), -- Irradiated Infantry
(@CGUID+57, 0, 0, 0, 0, 1, 0, 333, 0, ''), -- Irradiated Infantry
(@CGUID+58, 0, 0, 0, 0, 1, 0, 333, 0, ''), -- Irradiated Infantry
(@CGUID+59, 0, 0, 0, 0, 1, 0, 333, 0, ''), -- Irradiated Infantry
(@CGUID+60, 0, 0, 0, 0, 1, 0, 333, 0, ''), -- Irradiated Infantry
(@CGUID+61, 0, 0, 0, 0, 1, 0, 333, 0, ''), -- Irradiated Infantry
(@CGUID+62, 0, 0, 0, 0, 1, 0, 333, 0, ''), -- Irradiated Infantry
(@CGUID+63, 0, 0, 0, 0, 1, 0, 333, 0, ''), -- Irradiated Infantry
(@CGUID+64, 0, 0, 0, 0, 1, 0, 333, 0, ''), -- Irradiated Infantry
(@CGUID+65, 0, 0, 0, 0, 1, 0, 333, 0, ''), -- Irradiated Infantry
(@CGUID+66, 0, 0, 0, 0, 1, 0, 333, 0, ''), -- Irradiated Infantry
(@CGUID+67, 0, 0, 0, 0, 1, 0, 333, 0, ''), -- Irradiated Infantry
(@CGUID+68, 0, 0, 0, 0, 1, 0, 333, 0, ''), -- Irradiated Infantry
(@CGUID+69, 0, 0, 0, 0, 1, 0, 333, 0, ''), -- Irradiated Infantry
(@CGUID+70, 0, 0, 0, 0, 1, 0, 333, 0, ''), -- Irradiated Infantry
(@CGUID+71, 0, 0, 0, 0, 1, 0, 333, 0, ''), -- Irradiated Infantry
(@CGUID+72, 0, 0, 0, 0, 1, 0, 333, 0, ''), -- Irradiated Infantry
(@CGUID+73, 0, 0, 0, 0, 1, 0, 333, 0, ''), -- Irradiated Infantry
(@CGUID+74, 0, 0, 0, 0, 1, 0, 333, 0, ''), -- Irradiated Infantry
(@CGUID+75, 0, 0, 0, 0, 1, 0, 333, 0, ''), -- Irradiated Infantry
(@CGUID+76, 0, 0, 0, 0, 1, 0, 333, 0, ''), -- Irradiated Infantry
(@CGUID+77, 0, 0, 0, 0, 1, 0, 333, 0, ''), -- Irradiated Infantry
(@CGUID+78, 0, 0, 0, 0, 1, 0, 333, 0, ''), -- Irradiated Infantry
(@CGUID+79, 0, 0, 0, 0, 1, 0, 333, 0, ''), -- Irradiated Infantry
(@CGUID+80, 0, 0, 0, 0, 1, 0, 333, 0, ''), -- Irradiated Infantry
(@CGUID+81, 0, 0, 0, 0, 1, 0, 333, 0, ''), -- Irradiated Infantry
(@CGUID+82, 0, 0, 0, 0, 1, 0, 333, 0, ''), -- Irradiated Infantry
(@CGUID+83, 0, 0, 0, 0, 1, 0, 333, 0, ''), -- Irradiated Infantry
(@CGUID+84, 0, 0, 0, 0, 1, 0, 333, 0, ''), -- Irradiated Infantry
(@CGUID+85, 0, 0, 0, 0, 1, 0, 333, 0, ''), -- Irradiated Infantry
(@CGUID+86, 0, 0, 0, 0, 1, 0, 333, 0, ''), -- Irradiated Infantry
(@CGUID+87, 0, 0, 0, 0, 1, 0, 333, 0, ''), -- Irradiated Infantry
(@CGUID+88, 0, 0, 0, 0, 1, 0, 333, 0, ''), -- Irradiated Infantry
(@CGUID+89, 0, 0, 0, 0, 1, 0, 333, 0, ''), -- Irradiated Infantry
(@CGUID+90, 0, 0, 0, 0, 1, 0, 333, 0, ''), -- Irradiated Infantry
(@CGUID+91, 0, 0, 0, 0, 1, 0, 333, 0, ''), -- Irradiated Infantry
(@CGUID+92, 0, 0, 0, 0, 1, 0, 333, 0, ''), -- Irradiated Infantry
(@CGUID+93, 0, 0, 0, 0, 1, 0, 333, 0, ''), -- Irradiated Infantry
(@CGUID+94, 0, 0, 0, 0, 1, 0, 333, 0, ''), -- Irradiated Infantry
(@CGUID+95, 0, 0, 0, 0, 1, 0, 333, 0, ''), -- Irradiated Infantry
(@CGUID+96, 0, 0, 0, 0, 1, 0, 333, 0, ''), -- Irradiated Infantry
(@CGUID+97, 0, 0, 0, 0, 1, 0, 333, 0, ''), -- Irradiated Infantry
(@CGUID+98, 0, 0, 0, 0, 1, 0, 333, 0, ''), -- Irradiated Infantry
(@CGUID+99, 0, 0, 0, 0, 1, 0, 333, 0, ''), -- Irradiated Infantry
(@CGUID+106, 0, 0, 0, 0, 1, 0, 0, 0, ''), -- Irradiated Mechano-Tank
(@CGUID+111, 0, 0, 0, 0, 1, 0, 0, 0, ''), -- Irradiated Mechano-Tank
(@CGUID+112, 0, 0, 0, 0, 1, 0, 0, 0, ''), -- Irradiated Mechano-Tank
(@CGUID+113, 0, 0, 0, 0, 1, 0, 0, 0, ''), -- Irradiated Mechano-Tank
(@CGUID+118, 0, 0, 0, 0, 0, 0, 0, 3, '74463'), -- [DND] Boom Bunny
(@CGUID+119, 0, 0, 0, 0, 0, 0, 0, 3, '74463'); -- [DND] Boom Bunny

DELETE FROM `creature_movement_override` WHERE `SpawnId` BETWEEN @CGUID+0 AND @CGUID+130;
INSERT INTO `creature_movement_override` (`SpawnId`, `Ground`, `Swim`, `Flight`, `Rooted`, `Chase`, `Random`, `InteractionPauseTimer`) VALUES
(@CGUID+6, 0, 0, 1, 1, 0, 0, NULL),
(@CGUID+7, 0, 0, 1, 1, 0, 0, NULL),
(@CGUID+8, 0, 0, 1, 1, 0, 0, NULL),
(@CGUID+9, 0, 0, 1, 1, 0, 0, NULL),
(@CGUID+10, 0, 0, 1, 1, 0, 0, NULL),
(@CGUID+11, 0, 0, 1, 1, 0, 0, NULL),
(@CGUID+12, 0, 0, 1, 1, 0, 0, NULL),
(@CGUID+13, 0, 0, 1, 1, 0, 0, NULL),
(@CGUID+14, 0, 0, 1, 1, 0, 0, NULL),
(@CGUID+15, 0, 0, 1, 1, 0, 0, NULL),
(@CGUID+16, 0, 0, 1, 1, 0, 0, NULL),
(@CGUID+17, 0, 0, 1, 1, 0, 0, NULL),
(@CGUID+18, 0, 0, 1, 1, 0, 0, NULL),
(@CGUID+19, 0, 0, 1, 1, 0, 0, NULL),
(@CGUID+20, 0, 0, 1, 1, 0, 0, NULL),
(@CGUID+21, 0, 0, 1, 1, 0, 0, NULL),
(@CGUID+22, 0, 0, 1, 1, 0, 0, NULL),
(@CGUID+23, 0, 0, 1, 1, 0, 0, NULL),
(@CGUID+24, 0, 0, 1, 1, 0, 0, NULL),
(@CGUID+25, 0, 0, 1, 1, 0, 0, NULL),
(@CGUID+26, 0, 0, 1, 1, 0, 0, NULL),
(@CGUID+27, 0, 0, 1, 1, 0, 0, NULL),
(@CGUID+28, 0, 0, 1, 1, 0, 0, NULL),
(@CGUID+29, 0, 0, 1, 1, 0, 0, NULL),
(@CGUID+30, 0, 0, 1, 1, 0, 0, NULL),
(@CGUID+31, 0, 0, 1, 1, 0, 0, NULL),
(@CGUID+32, 0, 0, 1, 1, 0, 0, NULL),
(@CGUID+33, 0, 0, 1, 1, 0, 0, NULL),
(@CGUID+34, 0, 0, 1, 1, 0, 0, NULL),
(@CGUID+35, 0, 0, 1, 1, 0, 0, NULL),
(@CGUID+36, 0, 0, 1, 1, 0, 0, NULL),
(@CGUID+37, 0, 0, 1, 1, 0, 0, NULL),
(@CGUID+38, 0, 0, 1, 1, 0, 0, NULL),
(@CGUID+45, 0, 0, 1, 1, 0, 0, NULL),
(@CGUID+46, 0, 0, 1, 1, 0, 0, NULL),
(@CGUID+47, 0, 0, 1, 1, 0, 0, NULL),
(@CGUID+57, 0, 0, 1, 1, 0, 0, NULL),
(@CGUID+59, 0, 0, 1, 1, 0, 0, NULL),
(@CGUID+61, 0, 0, 1, 1, 0, 0, NULL),
(@CGUID+62, 0, 0, 1, 1, 0, 0, NULL),
(@CGUID+63, 0, 0, 1, 1, 0, 0, NULL),
(@CGUID+64, 0, 0, 1, 1, 0, 0, NULL),
(@CGUID+68, 0, 0, 1, 1, 0, 0, NULL),
(@CGUID+69, 0, 0, 1, 1, 0, 0, NULL),
(@CGUID+71, 0, 0, 1, 1, 0, 0, NULL),
(@CGUID+72, 0, 0, 1, 1, 0, 0, NULL),
(@CGUID+73, 0, 0, 1, 1, 0, 0, NULL),
(@CGUID+75, 0, 0, 1, 1, 0, 0, NULL),
(@CGUID+77, 0, 0, 1, 1, 0, 0, NULL),
(@CGUID+78, 0, 0, 1, 1, 0, 0, NULL),
(@CGUID+82, 0, 0, 1, 1, 0, 0, NULL),
(@CGUID+90, 0, 0, 1, 1, 0, 0, NULL),
(@CGUID+92, 0, 0, 1, 1, 0, 0, NULL),
(@CGUID+94, 0, 0, 1, 1, 0, 0, NULL),
(@CGUID+95, 0, 0, 1, 1, 0, 0, NULL),
(@CGUID+97, 0, 0, 1, 1, 0, 0, NULL),
(@CGUID+99, 0, 0, 1, 1, 0, 0, NULL);

SET @ENTRY := 39252;
SET @PATHOFFSET := 0;
SET @PATH := @ENTRY * 100 + @PATHOFFSET;
UPDATE `creature_addon` SET `path_id`=@PATH WHERE `guid`=@CGUID+5;
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES
(@PATH, 1, -5409.3057, 495.4896, 386.48718, NULL, 3500, 0, 0, 100, 0),
(@PATH, 2, -5401.408, 487.97397, 384.9283, NULL, 3500, 0, 0, 100, 0),
(@PATH, 3, -5409.6875, 495.4861, 386.49844, NULL, 3500, 0, 0, 100, 0),
(@PATH, 4, -5405.3315, 491.64758, 385.8566, NULL, 1000, 0, 0, 100, 0),
(@PATH, 5, -5405.3315, 491.64758, 385.8566, 4.014257431030273437, 6500, 0, 0, 100, 0),
(@PATH, 6, -5401.222, 488.08508, 384.92426, NULL, 6000, 0, 0, 100, 0);

SET @ENTRY := 39819;
SET @PATHOFFSET := 0;
SET @PATH := @ENTRY * 100 + @PATHOFFSET;
UPDATE `creature_addon` SET `path_id`=@PATH WHERE `guid`=@CGUID+106;
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES
(@PATH, 1, -5355.243, 571.51215, 386.53516, NULL, 1500, 0, 0, 100, 0),
(@PATH, 2, -5343.557, 549.875, 384.94324, NULL, 1500, 0, 0, 100, 0);

SET @ENTRY := 39819;
SET @PATHOFFSET := 1;
SET @PATH := @ENTRY * 100 + @PATHOFFSET;
UPDATE `creature_addon` SET `path_id`=@PATH WHERE `guid`=@CGUID+111;
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES
(@PATH, 1, -5122.5903, 428.783, 396.64246, NULL, 0, 0, 0, 100, 0),
(@PATH, 2, -5124.2173, 436.50696, 396.5359, NULL, 0, 0, 0, 100, 0),
(@PATH, 3, -5126.3267, 442.71008, 396.0109, NULL, 1000, 0, 0, 100, 0),
(@PATH, 4, -5124.2173, 436.50696, 396.5359, NULL, 0, 0, 0, 100, 0),
(@PATH, 5, -5122.5903, 428.783, 396.64246, NULL, 0, 0, 0, 100, 0),
(@PATH, 6, -5121.222, 417.56424, 396.6584, NULL, 1000, 0, 0, 100, 0);

SET @ENTRY := 39819;
SET @PATHOFFSET := 2;
SET @PATH := @ENTRY * 100 + @PATHOFFSET;
UPDATE `creature_addon` SET `path_id`=@PATH WHERE `guid`=@CGUID+112;
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES
(@PATH, 1, -5116.6787, 453.06946, 398.87387, NULL, 0, 0, 0, 100, 0),
(@PATH, 2, -5107.7446, 457.31076, 401.8087, NULL, 0, 0, 0, 100, 0),
(@PATH, 3, -5097.547, 464.60764, 403.94888, NULL, 0, 0, 0, 100, 0),
(@PATH, 4, -5089.733, 473.17883, 402.79395, NULL, 1000, 0, 0, 100, 0),
(@PATH, 5, -5097.547, 464.60764, 403.94888, NULL, 0, 0, 0, 100, 0),
(@PATH, 6, -5107.7446, 457.31076, 401.8087, NULL, 0, 0, 0, 100, 0),
(@PATH, 7, -5116.6787, 453.06946, 398.87387, NULL, 0, 0, 0, 100, 0),
(@PATH, 8, -5123.259, 451.46527, 396.66833, NULL, 1000, 0, 0, 100, 0);

SET @ENTRY := 39819;
SET @PATHOFFSET := 3;
SET @PATH := @ENTRY * 100 + @PATHOFFSET;
UPDATE `creature_addon` SET `path_id`=@PATH WHERE `guid`=@CGUID+113;
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES
(@PATH, 1, -5069.2256, 471.3125, 403.60635, NULL, 0, 0, 0, 100, 0),
(@PATH, 2, -5079.887, 468.8021, 403.3521, NULL, 0, 0, 0, 100, 0),
(@PATH, 3, -5087.047, 465.6111, 404.56604, NULL, 0, 0, 0, 100, 0),
(@PATH, 4, -5088.943, 459.21527, 406.15045, NULL, 0, 0, 0, 100, 0),
(@PATH, 5, -5087.1523, 452.44727, 408.4521, NULL, 1000, 0, 0, 100, 0),
(@PATH, 6, -5088.9434, 459.21484, 406.20013, NULL, 0, 0, 0, 100, 0),
(@PATH, 7, -5087.047, 465.6111, 404.56604, NULL, 0, 0, 0, 100, 0),
(@PATH, 8, -5079.887, 468.8021, 403.3521, NULL, 0, 0, 0, 100, 0),
(@PATH, 9, -5069.2256, 471.3125, 403.60635, NULL, 0, 0, 0, 100, 0),
(@PATH, 10, -5060.5728, 472.1736, 404.02484, NULL, 1000, 0, 0, 100, 0);

SET @ENTRY := 39841;
SET @PATHOFFSET := 0;
SET @PATH := @ENTRY * 100 + @PATHOFFSET;
UPDATE `creature_addon` SET `path_id`=@PATH WHERE `guid`=@CGUID+118;
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES
(@PATH, 1, -5335.8145, 545.21875, 403.1348, NULL, 0, 1, 0, 100, 0),
(@PATH, 2, -5337.099, 544.67883, 403.88538, NULL, 0, 1, 0, 100, 0),
(@PATH, 3, -5329.5903, 541.2031, 408.67224, NULL, 0, 1, 0, 100, 0),
(@PATH, 4, -5335.424, 548.31946, 401.67233, NULL, 0, 1, 0, 100, 0),
(@PATH, 5, -5329.618, 547.0903, 406.5613, NULL, 0, 1, 0, 100, 0),
(@PATH, 6, -5325.625, 544.283, 401.1445, NULL, 0, 1, 0, 100, 0),
(@PATH, 7, -5309.5884, 565.88544, 400.3512, NULL, 0, 1, 0, 100, 0),
(@PATH, 8, -5298.0312, 567.6406, 406.6901, NULL, 0, 1, 0, 100, 0),
(@PATH, 9, -5298.271, 572.2083, 405.19037, NULL, 0, 1, 0, 100, 0),
(@PATH, 10, -5299.6426, 575.1597, 405.2173, NULL, 0, 1, 0, 100, 0),
(@PATH, 11, -5295.0903, 574.07117, 404.9674, NULL, 0, 1, 0, 100, 0),
(@PATH, 12, -5290.9585, 569.4583, 402.49527, NULL, 0, 1, 0, 100, 0),
(@PATH, 13, -5290.7466, 573.42365, 407.1339, NULL, 0, 1, 0, 100, 0),
(@PATH, 14, -5295.514, 578.3125, 404.24518, NULL, 0, 1, 0, 100, 0),
(@PATH, 15, -5318.318, 584.8785, 409.91238, NULL, 0, 1, 0, 100, 0),
(@PATH, 16, -5324.528, 583.7031, 406.21796, NULL, 0, 1, 0, 100, 0),
(@PATH, 17, -5322.6978, 589.25867, 411.66235, NULL, 0, 1, 0, 100, 0),
(@PATH, 18, -5325.2085, 597.2639, 409.05136, NULL, 0, 1, 0, 100, 0),
(@PATH, 19, -5329.9165, 592.0434, 411.99588, NULL, 0, 1, 0, 100, 0),
(@PATH, 20, -5327.297, 587.0417, 405.4404, NULL, 0, 1, 0, 100, 0),
(@PATH, 21, -5332.9097, 581.6528, 411.1069, NULL, 0, 1, 0, 100, 0),
(@PATH, 22, -5344.384, 578.0208, 411.32928, NULL, 0, 1, 0, 100, 0),
(@PATH, 23, -5349.408, 577.0972, 405.0239, NULL, 0, 1, 0, 100, 0),
(@PATH, 24, -5350.0815, 575.2899, 409.77377, NULL, 0, 1, 0, 100, 0),
(@PATH, 25, -5349.924, 572.79517, 405.44025, NULL, 0, 1, 0, 100, 0),
(@PATH, 26, -5356.08, 576.61115, 406.2459, NULL, 0, 1, 0, 100, 0),
(@PATH, 27, -5354.6353, 570.9149, 403.05142, NULL, 0, 1, 0, 100, 0),
(@PATH, 28, -5352.2207, 566.52606, 401.80142, NULL, 0, 1, 0, 100, 0),
(@PATH, 29, -5338.4653, 546.2344, 402.1904, NULL, 0, 1, 0, 100, 0);

SET @ENTRY := 39841;
SET @PATHOFFSET := 1;
SET @PATH := @ENTRY * 100 + @PATHOFFSET;
UPDATE `creature_addon` SET `path_id`=@PATH WHERE `guid`=@CGUID+119;
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES
(@PATH, 1, -5295.0903, 574.07117, 404.9674, NULL, 0, 1, 0, 100, 0),
(@PATH, 2, -5290.9585, 569.4583, 402.49527, NULL, 0, 1, 0, 100, 0),
(@PATH, 3, -5290.7466, 573.42365, 407.1339, NULL, 0, 1, 0, 100, 0),
(@PATH, 4, -5295.514, 578.3125, 404.24518, NULL, 0, 1, 0, 100, 0),
(@PATH, 5, -5318.318, 584.8785, 409.91238, NULL, 0, 1, 0, 100, 0),
(@PATH, 6, -5324.528, 583.7031, 406.21796, NULL, 0, 1, 0, 100, 0),
(@PATH, 7, -5322.6978, 589.25867, 411.66235, NULL, 0, 1, 0, 100, 0),
(@PATH, 8, -5325.2085, 597.2639, 409.05136, NULL, 0, 1, 0, 100, 0),
(@PATH, 9, -5329.9165, 592.0434, 411.99588, NULL, 0, 1, 0, 100, 0),
(@PATH, 10, -5327.297, 587.0417, 405.4404, NULL, 0, 1, 0, 100, 0),
(@PATH, 11, -5332.9097, 581.6528, 411.1069, NULL, 0, 1, 0, 100, 0),
(@PATH, 12, -5344.384, 578.0208, 411.32928, NULL, 0, 1, 0, 100, 0),
(@PATH, 13, -5349.408, 577.0972, 405.0239, NULL, 0, 1, 0, 100, 0),
(@PATH, 14, -5350.0815, 575.2899, 409.77377, NULL, 0, 1, 0, 100, 0),
(@PATH, 15, -5349.924, 572.79517, 405.44025, NULL, 0, 1, 0, 100, 0),
(@PATH, 16, -5356.08, 576.61115, 406.2459, NULL, 0, 1, 0, 100, 0),
(@PATH, 17, -5354.6353, 570.9149, 403.05142, NULL, 0, 1, 0, 100, 0),
(@PATH, 18, -5352.2207, 566.52606, 401.80142, NULL, 0, 1, 0, 100, 0),
(@PATH, 19, -5338.4653, 546.2344, 402.1904, NULL, 0, 1, 0, 100, 0),
(@PATH, 20, -5335.8145, 545.21875, 403.1348, NULL, 0, 1, 0, 100, 0),
(@PATH, 21, -5337.099, 544.67883, 403.88538, NULL, 0, 1, 0, 100, 0),
(@PATH, 22, -5329.5903, 541.2031, 408.67224, NULL, 0, 1, 0, 100, 0),
(@PATH, 23, -5335.424, 548.31946, 401.67233, NULL, 0, 1, 0, 100, 0),
(@PATH, 24, -5329.618, 547.0903, 406.5613, NULL, 0, 1, 0, 100, 0),
(@PATH, 25, -5325.625, 544.283, 401.1445, NULL, 0, 1, 0, 100, 0),
(@PATH, 26, -5309.5884, 565.88544, 400.3512, NULL, 0, 1, 0, 100, 0),
(@PATH, 27, -5298.0312, 567.6406, 406.6901, NULL, 0, 1, 0, 100, 0),
(@PATH, 28, -5298.271, 572.2083, 405.19037, NULL, 0, 1, 0, 100, 0),
(@PATH, 29, -5299.6426, 575.1597, 405.2173, NULL, 0, 1, 0, 100, 0);

-- Gameobject spawns
DELETE FROM `gameobject` WHERE `guid` BETWEEN @OGUID+0 AND @OGUID+27;
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `VerifiedBuild`) VALUES
-- Frostmane Hold
(@OGUID+0, 194498, 0, 1, 133, 1, 256, -5375.14599609375, 482.9757080078125, 384.44903564453125, 0.575957298278808593, 0, 0, 0.284014701843261718, 0.958819925785064697, 120, 255, 1, 54261), -- Gnomeregan Banner (Area: New Tinkertown - Difficulty: 0) CreateObject1
(@OGUID+1, 194498, 0, 1, 133, 1, 256, -5376.38720703125, 472.720489501953125, 384.28338623046875, 5.445427894592285156, 0, 0, -0.40673637390136718, 0.913545548915863037, 120, 255, 1, 54261), -- Gnomeregan Banner (Area: New Tinkertown - Difficulty: 0) CreateObject1
(@OGUID+2, 194498, 0, 1, 133, 1, 256, -5404.91162109375, 462.189239501953125, 384.778717041015625, 5.445427894592285156, 0, 0, -0.40673637390136718, 0.913545548915863037, 120, 255, 1, 54261), -- Gnomeregan Banner (Area: New Tinkertown - Difficulty: 0) CreateObject1
(@OGUID+3, 194498, 0, 1, 133, 1, 256, -5429.35400390625, 547.78302001953125, 386.937896728515625, 0.575957298278808593, 0, 0, 0.284014701843261718, 0.958819925785064697, 120, 255, 1, 54261), -- Gnomeregan Banner (Area: New Tinkertown - Difficulty: 0) CreateObject1
(@OGUID+4, 194498, 0, 1, 133, 1, 256, -5455.15966796875, 515.3975830078125, 387.597808837890625, 3.892086982727050781, 0, 0, -0.93041706085205078, 0.366502493619918823, 120, 255, 1, 54261), -- Gnomeregan Banner (Area: New Tinkertown - Difficulty: 0) CreateObject1
(@OGUID+5, 194498, 0, 1, 133, 1, 256, -5418.6787109375, 459.5850830078125, 386.621673583984375, 3.839725255966186523, 0, 0, -0.93969249725341796, 0.34202045202255249, 120, 255, 1, 54261), -- Gnomeregan Banner (Area: New Tinkertown - Difficulty: 0) CreateObject1
(@OGUID+6, 202564, 0, 1, 135, 1, 256, -5430.0087890625, 535.7430419921875, 386.826568603515625, 4.869470596313476562, 0, 0, -0.64944744110107421, 0.760406434535980224, 120, 255, 1, 54261), -- Gnome Table (Area: Frostmane Hold - Difficulty: 0) CreateObject1
(@OGUID+7, 202713, 0, 1, 135, 1, 256, -5433.61279296875, 528.453125, 388.305389404296875, 1.291541695594787597, 0, 0, 0.60181427001953125, 0.798636078834533691, 120, 255, 1, 54261), -- Hazard Light Red 02 (Area: Frostmane Hold - Difficulty: 0) CreateObject1
(@OGUID+8, 202713, 0, 1, 135, 1, 256, -5440.0380859375, 524.28472900390625, 388.25738525390625, 1.291541695594787597, 0, 0, 0.60181427001953125, 0.798636078834533691, 120, 255, 1, 54261), -- Hazard Light Red 02 (Area: Frostmane Hold - Difficulty: 0) CreateObject1
(@OGUID+9, 202713, 0, 1, 135, 1, 256, -5430.1875, 526.1007080078125, 388.254608154296875, 1.291541695594787597, 0, 0, 0.60181427001953125, 0.798636078834533691, 120, 255, 1, 54261), -- Hazard Light Red 02 (Area: Frostmane Hold - Difficulty: 0) CreateObject1
(@OGUID+10, 202713, 0, 1, 135, 1, 256, -5439.31591796875, 520.19793701171875, 388.265106201171875, 1.291541695594787597, 0, 0, 0.60181427001953125, 0.798636078834533691, 120, 255, 1, 54261), -- Hazard Light Red 02 (Area: Frostmane Hold - Difficulty: 0) CreateObject1
(@OGUID+11, 202713, 0, 1, 135, 1, 256, -5431.72900390625, 518.65972900390625, 388.254974365234375, 1.291541695594787597, 0, 0, 0.60181427001953125, 0.798636078834533691, 120, 255, 1, 54261), -- Hazard Light Red 02 (Area: Frostmane Hold - Difficulty: 0) CreateObject1
(@OGUID+12, 202713, 0, 1, 135, 1, 256, -5437.625, 527.63018798828125, 388.274658203125, 1.291541695594787597, 0, 0, 0.60181427001953125, 0.798636078834533691, 120, 255, 1, 54261), -- Hazard Light Red 02 (Area: Frostmane Hold - Difficulty: 0) CreateObject1
(@OGUID+13, 202713, 0, 1, 135, 1, 256, -5429.4755859375, 522.06597900390625, 388.258941650390625, 1.291541695594787597, 0, 0, 0.60181427001953125, 0.798636078834533691, 120, 255, 1, 54261), -- Hazard Light Red 02 (Area: Frostmane Hold - Difficulty: 0) CreateObject1
(@OGUID+14, 202713, 0, 1, 135, 1, 256, -5435.77099609375, 517.82989501953125, 388.277984619140625, 1.291541695594787597, 0, 0, 0.60181427001953125, 0.798636078834533691, 120, 255, 1, 54261), -- Hazard Light Red 02 (Area: Frostmane Hold - Difficulty: 0) CreateObject1
(@OGUID+15, 202733, 0, 1, 135, 1, 256, -5418.14599609375, 476.55035400390625, 384.067718505859375, 0.663223206996917724, 0, 0, 0.325567245483398437, 0.945518851280212402, 120, 255, 1, 54261), -- Teleporter Pad (Area: Frostmane Hold - Difficulty: 0) CreateObject1
(@OGUID+16, 202733, 0, 1, 135, 1, 256, -5416.7568359375, 471.0382080078125, 383.983642578125, 0.645771682262420654, 0, 0, 0.317304611206054687, 0.948323667049407958, 120, 255, 1, 54261), -- Teleporter Pad (Area: Frostmane Hold - Difficulty: 0) CreateObject1
(@OGUID+17, 202733, 0, 1, 135, 1, 256, -5413.3193359375, 468.84375, 384.210052490234375, 0.575957298278808593, 0, 0, 0.284014701843261718, 0.958819925785064697, 120, 255, 1, 54261), -- Teleporter Pad (Area: Frostmane Hold - Difficulty: 0) CreateObject1
(@OGUID+18, 202733, 0, 1, 135, 1, 256, -5414.51904296875, 474.50347900390625, 383.9737548828125, 0.645771682262420654, 0, 0, 0.317304611206054687, 0.948323667049407958, 120, 255, 1, 54261), -- Teleporter Pad (Area: Frostmane Hold - Difficulty: 0) CreateObject1
(@OGUID+19, 202733, 0, 1, 135, 1, 256, -5420.3837890625, 473.0850830078125, 383.955657958984375, 0.663223206996917724, 0, 0, 0.325567245483398437, 0.945518851280212402, 120, 255, 1, 54261), -- Teleporter Pad (Area: Frostmane Hold - Difficulty: 0) CreateObject1
(@OGUID+20, 202733, 0, 1, 135, 1, 256, -5411.08154296875, 472.30902099609375, 384.00347900390625, 0.575957298278808593, 0, 0, 0.284014701843261718, 0.958819925785064697, 120, 255, 1, 54261), -- Teleporter Pad (Area: Frostmane Hold - Difficulty: 0) CreateObject1
(@OGUID+21, 202760, 0, 1, 135, 1, 256, -5434.7099609375, 523.17706298828125, 386.959228515625, 0.575957298278808593, 0, 0, 0.284014701843261718, 0.958819925785064697, 120, 255, 1, 54261), -- Large Teleporter Pad (Area: Frostmane Hold - Difficulty: 0) CreateObject1
-- New Tinkertown
(@OGUID+22, 202767, 0, 1, 133, 1, 256, -5074.42724609375, 442.46527099609375, 410.96624755859375, 2.548179388046264648, 0, 0, 0.956304550170898437, 0.292372345924377441, 120, 255, 1, 54261), -- Defensive Radiation Pump Control (Area: New Tinkertown - Difficulty: 0) CreateObject1
(@OGUID+23, 202872, 0, 1, 133, 1, 256, -5331.56591796875, 544.982666015625, 384.62469482421875, 4.991643905639648437, 0, 0, -0.60181427001953125, 0.798636078834533691, 120, 255, 1, 54261), -- Rocket Platform (Area: New Tinkertown - Difficulty: 0) CreateObject1
(@OGUID+24, 202872, 0, 1, 133, 1, 256, -5350.48974609375, 574.451416015625, 386.52813720703125, 4.677483558654785156, 0, 0, -0.71933937072753906, 0.694658815860748291, 120, 255, 1, 54261), -- Rocket Platform (Area: New Tinkertown - Difficulty: 0) CreateObject1
(@OGUID+25, 202872, 0, 1, 133, 1, 256, -5324.4306640625, 588.48785400390625, 388.4215087890625, 3.665196180343627929, 0, 0, -0.96592521667480468, 0.258821308612823486, 120, 255, 1, 54261), -- Rocket Platform (Area: New Tinkertown - Difficulty: 0) CreateObject1
(@OGUID+26, 202872, 0, 1, 133, 1, 256, -5294.58349609375, 571.61114501953125, 386.342132568359375, 5.340708732604980468, 0, 0, -0.45398998260498046, 0.891006767749786376, 120, 255, 1, 54261), -- Rocket Platform (Area: New Tinkertown - Difficulty: 0) CreateObject1
(@OGUID+27, 202922, 0, 1, 133, 1, 256, -4934.0380859375, 726.23956298828125, 261.645111083984375, 3.054326534271240234, 0, 0, 0.999048233032226562, 0.043619260191917419, 120, 255, 1, 54261); -- Irradiator 3000 (Area: New Tinkertown - Difficulty: 0) CreateObject1

UPDATE `gameobject` SET `phasemask`=257 WHERE `id`=106318 AND `guid` IN (9477,32370);
UPDATE `gameobject` SET `phasemask`=257 WHERE `id`=152614 AND `guid`=9290;
UPDATE `gameobject` SET `phasemask`=257 WHERE `id` IN (1936,80022,80023,90566,102984,179555);

-- Event spawns
DELETE FROM `game_event_creature` WHERE `eventEntry`=@EVENT AND `guid` BETWEEN @CGUID+0 AND @CGUID+130;
INSERT INTO `game_event_creature` (`eventEntry`, `guid`) VALUES
(@EVENT, @CGUID+0),
(@EVENT, @CGUID+1),
(@EVENT, @CGUID+2),
(@EVENT, @CGUID+3),
(@EVENT, @CGUID+4),
(@EVENT, @CGUID+5),
(@EVENT, @CGUID+6),
(@EVENT, @CGUID+7),
(@EVENT, @CGUID+8),
(@EVENT, @CGUID+9),
(@EVENT, @CGUID+10),
(@EVENT, @CGUID+11),
(@EVENT, @CGUID+12),
(@EVENT, @CGUID+13),
(@EVENT, @CGUID+14),
(@EVENT, @CGUID+15),
(@EVENT, @CGUID+16),
(@EVENT, @CGUID+17),
(@EVENT, @CGUID+18),
(@EVENT, @CGUID+19),
(@EVENT, @CGUID+20),
(@EVENT, @CGUID+21),
(@EVENT, @CGUID+22),
(@EVENT, @CGUID+23),
(@EVENT, @CGUID+24),
(@EVENT, @CGUID+25),
(@EVENT, @CGUID+26),
(@EVENT, @CGUID+27),
(@EVENT, @CGUID+28),
(@EVENT, @CGUID+29),
(@EVENT, @CGUID+30),
(@EVENT, @CGUID+31),
(@EVENT, @CGUID+32),
(@EVENT, @CGUID+33),
(@EVENT, @CGUID+34),
(@EVENT, @CGUID+35),
(@EVENT, @CGUID+36),
(@EVENT, @CGUID+37),
(@EVENT, @CGUID+38),
(@EVENT, @CGUID+39),
(@EVENT, @CGUID+40),
(@EVENT, @CGUID+41),
(@EVENT, @CGUID+42),
(@EVENT, @CGUID+43),
(@EVENT, @CGUID+44),
(@EVENT, @CGUID+45),
(@EVENT, @CGUID+46),
(@EVENT, @CGUID+47),
(@EVENT, @CGUID+48),
(@EVENT, @CGUID+49),
(@EVENT, @CGUID+50),
(@EVENT, @CGUID+51),
(@EVENT, @CGUID+52),
(@EVENT, @CGUID+53),
(@EVENT, @CGUID+54),
(@EVENT, @CGUID+55),
(@EVENT, @CGUID+56),
(@EVENT, @CGUID+57),
(@EVENT, @CGUID+58),
(@EVENT, @CGUID+59),
(@EVENT, @CGUID+60),
(@EVENT, @CGUID+61),
(@EVENT, @CGUID+62),
(@EVENT, @CGUID+63),
(@EVENT, @CGUID+64),
(@EVENT, @CGUID+65),
(@EVENT, @CGUID+66),
(@EVENT, @CGUID+67),
(@EVENT, @CGUID+68),
(@EVENT, @CGUID+69),
(@EVENT, @CGUID+70),
(@EVENT, @CGUID+71),
(@EVENT, @CGUID+72),
(@EVENT, @CGUID+73),
(@EVENT, @CGUID+74),
(@EVENT, @CGUID+75),
(@EVENT, @CGUID+76),
(@EVENT, @CGUID+77),
(@EVENT, @CGUID+78),
(@EVENT, @CGUID+79),
(@EVENT, @CGUID+80),
(@EVENT, @CGUID+81),
(@EVENT, @CGUID+82),
(@EVENT, @CGUID+83),
(@EVENT, @CGUID+84),
(@EVENT, @CGUID+85),
(@EVENT, @CGUID+86),
(@EVENT, @CGUID+87),
(@EVENT, @CGUID+88),
(@EVENT, @CGUID+89),
(@EVENT, @CGUID+90),
(@EVENT, @CGUID+91),
(@EVENT, @CGUID+92),
(@EVENT, @CGUID+93),
(@EVENT, @CGUID+94),
(@EVENT, @CGUID+95),
(@EVENT, @CGUID+96),
(@EVENT, @CGUID+97),
(@EVENT, @CGUID+98),
(@EVENT, @CGUID+99),
(@EVENT, @CGUID+100),
(@EVENT, @CGUID+101),
(@EVENT, @CGUID+102),
(@EVENT, @CGUID+103),
(@EVENT, @CGUID+104),
(@EVENT, @CGUID+105),
(@EVENT, @CGUID+106),
(@EVENT, @CGUID+107),
(@EVENT, @CGUID+108),
(@EVENT, @CGUID+109),
(@EVENT, @CGUID+110),
(@EVENT, @CGUID+111),
(@EVENT, @CGUID+112),
(@EVENT, @CGUID+113),
(@EVENT, @CGUID+114),
(@EVENT, @CGUID+115),
(@EVENT, @CGUID+116),
(@EVENT, @CGUID+117),
(@EVENT, @CGUID+118),
(@EVENT, @CGUID+119),
(@EVENT, @CGUID+120),
(@EVENT, @CGUID+121),
(@EVENT, @CGUID+122),
(@EVENT, @CGUID+123),
(@EVENT, @CGUID+124),
(@EVENT, @CGUID+125),
(@EVENT, @CGUID+126),
(@EVENT, @CGUID+127),
(@EVENT, @CGUID+128),
(@EVENT, @CGUID+129),
(@EVENT, @CGUID+130);

DELETE FROM `game_event_gameobject` WHERE `eventEntry`=@EVENT AND `guid` BETWEEN @OGUID+0 AND @OGUID+27;
INSERT INTO `game_event_gameobject` (`eventEntry`, `guid`) VALUES
(@EVENT, @OGUID+0),
(@EVENT, @OGUID+1),
(@EVENT, @OGUID+2),
(@EVENT, @OGUID+3),
(@EVENT, @OGUID+4),
(@EVENT, @OGUID+5),
(@EVENT, @OGUID+6),
(@EVENT, @OGUID+7),
(@EVENT, @OGUID+8),
(@EVENT, @OGUID+9),
(@EVENT, @OGUID+10),
(@EVENT, @OGUID+11),
(@EVENT, @OGUID+12),
(@EVENT, @OGUID+13),
(@EVENT, @OGUID+14),
(@EVENT, @OGUID+15),
(@EVENT, @OGUID+16),
(@EVENT, @OGUID+17),
(@EVENT, @OGUID+18),
(@EVENT, @OGUID+19),
(@EVENT, @OGUID+20),
(@EVENT, @OGUID+21),
(@EVENT, @OGUID+22),
(@EVENT, @OGUID+23),
(@EVENT, @OGUID+24),
(@EVENT, @OGUID+25),
(@EVENT, @OGUID+26),
(@EVENT, @OGUID+27);

-- Add CREATURE_FLAG_EXTRA_NO_MOVE_FLAGS_UPDATE to Sindragosa
UPDATE `creature_template` SET `flags_extra`=`flags_extra`|512 WHERE `entry`IN(36853,38265,38266,38267);

--
UPDATE `creature` SET `phaseMask` = 195 WHERE `guid` = 98912;

-- Small update for quest Load'er Up!
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 25969;
DELETE FROM `smart_scripts` WHERE `entryorguid` = 25969 AND `source_type` = 0 AND `id` = 5;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(25969, 0, 5, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 41, 3000, 0, 25849, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, "Jenny - Linked with Previous Event - Self: Despawn");
-- Reduce credit range to 15 yards according to some wotlk classic yt videos
UPDATE `smart_scripts` SET `link`=5, `event_param3`=15, `comment`="Jenny - Within 15 yards of Fezzix Geartwist - Give Kill credit" WHERE `entryorguid`=25969 AND `source_type`=0 AND `id`=4;

--
UPDATE `creature_template` SET `flags_extra`=`flags_extra`|512 WHERE `entry`IN(37533,37534,38220,38219);

-- Decrease Timber respawn time to 45 minutes
UPDATE `creature` SET `spawntimesecs`=2700 WHERE `id`=1132;

-- Add 3 gameobjects in Shattrath - Aldor Rise
DELETE FROM `gameobject` WHERE `guid` IN (9898,9899,9900) AND `id` IN (194466,194467,194468);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `VerifiedBuild`) VALUES
(9898, 194466, 530, 0, 0, 1, 1, -1737.48095703125, 5632.6103515625, 128.9701995849609375, 0, 0, 0, 0, 1, 120, 255, 1, '', 54847), -- Alchemy Lab
(9899, 194467, 530, 0, 0, 1, 1, -1745.2545166015625, 5646.84228515625, 128.023193359375, 5.567600727081298828, 0, 0, -0.35020732879638671, 0.936672210693359375, 120, 255, 1, '', 54847), -- Blacksmith's Anvil
(9900, 194468, 530, 0, 0, 1, 1, -1747.6688232421875, 5648.66162109375, 128.023193359375, 4.049167633056640625, 0, 0, -0.89879322052001953, 0.438372820615768432, 120, 255, 1, '', 54847); -- Forge

-- Update two Levers position in Shadowfang Keep
UPDATE `gameobject` SET `orientation`=5.312439441680908203, `rotation0`=-0.58448696136474609, `rotation1`=-0.39796257019042968, `rotation2`=-0.58448696136474609, `rotation3`=0.397964507341384887, `spawntimesecs`=7200, `animprogress`=255, `VerifiedBuild`=54737 WHERE `guid`=32443 AND `id`=101812;
UPDATE `gameobject` SET `position_x`=-113.761627197265625, `position_z`=157.854644775390625, `rotation0`=0.694697380065917968, `rotation1`=-0.13189220428466796, `rotation2`=0.694696426391601562, `rotation3`=0.131897181272506713, `VerifiedBuild`=54737 WHERE `guid`=32480 AND `id`=18899;

-- UPDATE Stratholme Signposts with sniffed values from build: V4_4_0_54737
DELETE FROM `gameobject` WHERE `guid` IN (25329,27141,18209,20638,20733,20746,42972,20747,20748,45054,12152,12153,12155,22034,25119,12045,12145,12158,15560,15561,27561,27562,27587,20777,20850,20871,20873);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `VerifiedBuild`) VALUES
(25329, 175459, 329, 0, 0, 1, 1, 3446.5439453125, -3370.093017578125, 140.9564361572265625, 1.658061861991882324, 0, 0, 0.737277030944824218, 0.67559051513671875, 7200, 255, 1, '', 54737), -- To Stranglethorn Vale
(27141, 175460, 329, 0, 0, 1, 1, 3447.166015625, -3369.943603515625, 140.9246978759765625, 4.7944183349609375, -0.11731481552124023, 0.128026962280273437, -0.66532611846923828, 0.726076781749725341, 7200, 255, 1, '', 54737), -- Market Row
(18209, 175441, 329, 0, 0, 1, 1, 3524.133544921875, -3377.8134765625, 133.0133819580078125, 2.967044830322265625, -0.00380182266235351, -0.04345226287841796, 0.995245933532714843, 0.087080210447311401, 7200, 255, 1, '', 54737), -- Elders' Square

(20638, 175442, 329, 0, 0, 1, 1, 3524.405029296875, -3376.470458984375, 132.17120361328125, 2.967034816741943359, -0.01886367797851562, -0.21561527252197265, 0.9725799560546875, 0.085102535784244537, 7200, 255, 1, '', 54737), -- Festival Lane
(20733, 175443, 329, 0, 0, 1, 1, 3524.434326171875, -3376.182373046875, 133.0558013916015625, 6.108653545379638671, 0, 0, -0.08715534210205078, 0.996194720268249511, 7200, 255, 1, '', 54737), -- Market Row
(20746, 175444, 329, 0, 0, 1, 1, 3523.578369140625, -3377.0380859375, 132.508636474609375, 1.396262884140014648, -0.03341388702392578, -0.02803707122802734, 0.642175674438476562, 0.765315532684326171, 7200, 255, 1, '', 54737), -- Main Gate
(42972, 175824, 329, 0, 0, 1, 1, 3524.500244140625, -3375.92529296875, 132.2577972412109375, 6.109068870544433593, 0.034766674041748046, 0.003041267395019531, -0.08710289001464843, 0.995587825775146484, 7200, 255, 1, '', 54737), -- Crusaders' Square

(20747, 175445, 329, 0, 0, 1, 1, 3558.121337890625, -3320.4375, 130.2953338623046875, 4.450591087341308593, 0.07945871353149414, -0.10355281829833984, -0.78656578063964843, 0.603554010391235351, 7200, 255, 1, '', 54737), -- Market Row
(20748, 175447, 329, 0, 0, 1, 1, 3555.99267578125, -3321.162109375, 129.5000762939453125, 2.879780769348144531, 0.005692958831787109, 0.043245315551757812, 0.990500450134277343, 0.130408123135566711, 7200, 255, 1, '', 54737), -- Main Gate
(45054, 175825, 329, 0, 0, 1, 1, 3557.52685546875, -3320.4375, 129.2545013427734375, 4.455188751220703125, 0.003703594207763671, -0.04522895812988281, -0.79056072235107421, 0.610699892044067382, 7200, 255, 1, '', 54737), -- Crusaders' Square

(12152, 175435, 329, 0, 0, 1, 1, 3652.9052734375, -3325.3388671875, 123.9886703491210937, 2.094393253326416015, 0, 0, 0.866024971008300781, 0.50000077486038208, 7200, 255, 1, '', 54737), -- King's Square
(12153, 175436, 329, 0, 0, 1, 1, 3654.427490234375, -3325.948486328125, 123.5406341552734375, 3.665196418762207031, 0.011289596557617187, -0.04213237762451171, -0.96500587463378906, 0.258575111627578735, 7200, 255, 1, '', 54737), -- Festival Lane
(12155, 175437, 329, 0, 0, 1, 1, 3655.42041015625, -3323.930908203125, 124.335906982421875, 5.235989570617675781, 0.113039016723632812, -0.0652627944946289, -0.49572181701660156, 0.858616769313812255, 7200, 255, 1, '', 54737), -- Crusaders' Square

(22034, 175457, 329, 0, 0, 1, 1, 3704.015625, -3246.3232421875, 127.4420394897460937, 0.69812941551208496, 0, 0, 0.342019081115722656, 0.939693033695220947, 7200, 255, 1, '', 54737), -- Crusaders' Square
(25119, 175458, 329, 0, 0, 1, 1, 3704.120849609375, -3247.52880859375, 126.8948822021484375, 2.268927812576293945, -0.0184335708618164, -0.03953266143798828, 0.905445098876953125, 0.422216206789016723, 7200, 255, 1, '', 54737), -- Market Row

(12045, 175433, 329, 0, 0, 1, 1, 3707.61474609375, -3402.7021484375, 132.40533447265625, 3.310894250869750976, 0, 0.173647880554199218, -0.98106002807617187, 0.085835136473178863, 7200, 255, 1, '', 54737), -- Festival Lane
(12145, 175434, 329, 0, 0, 1, 1, 3707.411376953125, -3402.095458984375, 132.43707275390625, 0.174532130360603332, 0, 0, 0.087155342102050781, 0.996194720268249511, 7200, 255, 1, '', 54737), -- Crusaders' Square

(12158, 175438, 329, 0, 0, 1, 1, 3649.884765625, -3496.593994140625, 137.0592193603515625, 4.799658775329589843, 0.096233844757080078, -0.0881814956665039, -0.66980934143066406, 0.730970919132232666, 7200, 255, 1, '', 54737), -- Market Row
(15560, 175439, 329, 0, 0, 1, 1, 3647.01025390625, -3496.806884765625, 136.71197509765625, 1.658061861991882324, 0, 0, 0.737277030944824218, 0.67559051513671875, 7200, 255, 1, '', 54737), -- King's Square
(15561, 175440, 329, 0, 0, 1, 1, 3648.13232421875, -3498.0029296875, 136.263946533203125, 3.228901147842407226, 0.001902580261230468, -0.04357719421386718, -0.99809646606445312, 0.043598759919404983, 7200, 255, 1, '', 54737), -- Elders' Square

(27561, 175461, 329, 0, 0, 1, 1, 3683.655029296875, -3612.593994140625, 138.91009521484375, 1.83259439468383789, 0.07945871353149414, 0.103552818298339843, 0.786565780639648437, 0.603554010391235351, 7200, 255, 1, '', 54737), -- Service Entrance
(27562, 175462, 329, 0, 0, 1, 1, 3686.44873046875, -3611.885009765625, 138.5628662109375, 4.97418975830078125, 0, 0, -0.60876083374023437, 0.793353796005249023, 7200, 255, 1, '', 54737), -- The Gauntlet
(27587, 175463, 329, 0, 0, 1, 1, 3685.13623046875, -3610.902099609375, 138.1148223876953125, 0.261798620223999023, 0.043245792388916015, 0.005692481994628906, 0.130401611328125, 0.990501284599304199, 7200, 255, 1, '', 54737), -- Festival Lane

(20777, 175449, 329, 0, 0, 1, 1, 3812.270751953125, -3615.736083984375, 145.2386627197265625, 5.445430278778076171, 0.039847850799560546, -0.01774120330810546, -0.40634822845458984, 0.912676572799682617, 7200, 255, 1, '', 54737), -- Slaughter Square
(20850, 175450, 329, 0, 0, 1, 1, 3810.090576171875, -3615.1845703125, 146.033935546875, 0.733037710189819335, 0.121856689453125, 0.04677581787109375, 0.355301856994628906, 0.92559361457824707, 7200, 255, 1, '', 54737), -- Elders' Square

(20871, 175454, 329, 0, 0, 1, 1, 3993.23095703125, -3547.21435546875, 124.4813613891601562, 1.946041464805603027, 0, 0, 0.826589584350585937, 0.56280517578125, 7200, 255, 1, '', 54737), -- Elders' Square
(20873, 175455, 329, 0, 0, 1, 1, 3994.77880859375, -3546.61865234375, 124.4389419555664062, 5.08763742446899414, -0.03605461120605468, 0.024548530578613281, -0.56226825714111328, 0.825803756713867187, 7200, 255, 1, '', 54737); -- Slaughter Square

-- Remove wrong spawned Raging Owlbeast and Zhevra Runner
DELETE FROM `creature` WHERE `guid` IN (41372,18658) AND `id` IN (7451,3242);
DELETE FROM `spawn_group` WHERE `spawnId` IN (41372,18658);

-- Correct spells order for Broken-down Shredder
DELETE FROM `creature_template_spell` WHERE `CreatureID` = 27354 AND `Index` IN (0,1,2);
INSERT INTO `creature_template_spell` (`CreatureID`, `Index`, `Spell`, `VerifiedBuild`) VALUES
(27354, 0, 48548, 54847),
(27354, 1, 48558, 54847),
(27354, 2, 48604, 54847);
UPDATE `creature_template_spell` SET `VerifiedBuild`=54847 WHERE `CreatureID`=27354 AND `Spell`=48610 AND `Index`=4;

-- Update Maraudon Earth Song Falls portal coordinates
UPDATE `spell_target_position` SET `PositionX`=386.27, `PositionY`=33.4144, `PositionZ`=-130.934 WHERE `ID`=21128;

-- Add missing movement flags to Warsong Cannon
DELETE FROM `creature_template_movement` WHERE `CreatureId`=31243;
INSERT INTO `creature_template_movement` (`CreatureId`, `Ground`, `Swim`, `Flight`, `Rooted`, `Chase`, `Random`, `InteractionPauseTimer`) VALUES
(31243, 0, 0, 0, 1, 0, 0, NULL);

-- Some of the NPC's in Sen'jin village should sometimes play the dance emote
UPDATE `creature_template_addon` SET `emote`=0 WHERE `entry`IN (3933,5942,7953);

UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry` IN (3184,3185,3186,3187,3933,5880,5942,7952,7953,10369);

DELETE FROM `smart_scripts` WHERE `entryorguid`=11814 AND `id`=2;
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (3184,3185,3186,3187,3933,5880,5942,7952,7953,10369);
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (318400,318500,318600,318700,393300,588000,594200,795200,795300,1036900,1181400) AND `source_type`=9;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`event_param5`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_param4`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(3184,0,0,0,1,0,100,0,1000,60000,30000,300000,0,80,318500,0,0,0,0,0,1,0,0,0,0,0,0,0,0,"Miao'zan - OoC - Run Script"),
(3185,0,0,0,1,0,100,0,1000,60000,30000,300000,0,80,318500,0,0,0,0,0,1,0,0,0,0,0,0,0,0,"Mishiki - OoC - Run Script"),
(3186,0,0,0,1,0,100,0,1000,60000,30000,300000,0,80,318600,0,0,0,0,0,1,0,0,0,0,0,0,0,0,"K'waii - OoC - Run Script"),
(3187,0,0,0,1,0,100,0,1000,60000,30000,300000,0,80,318700,0,0,0,0,0,1,0,0,0,0,0,0,0,0,"Tai'tasi - OoC - Run Script"),
(3933,0,0,0,1,0,100,0,1000,60000,30000,300000,0,80,393300,0,0,0,0,0,1,0,0,0,0,0,0,0,0,"Hai'zan - OoC - Run Script"),
(5880,0,0,0,1,0,100,0,1000,60000,30000,300000,0,80,588000,0,0,0,0,0,1,0,0,0,0,0,0,0,0,"Un'Thuwa - OoC - Run Script"),
(5942,0,0,0,1,0,100,0,1000,60000,30000,300000,0,80,594200,0,0,0,0,0,1,0,0,0,0,0,0,0,0,"Zansoa  - OoC - Run Script"),
(7952,0,0,0,1,0,100,0,1000,60000,30000,300000,0,80,795200,0,0,0,0,0,1,0,0,0,0,0,0,0,0,"Zjolnir  - OoC - Run Script"),
(7953,0,0,0,1,0,100,0,1000,60000,30000,300000,0,80,795300,0,0,0,0,0,1,0,0,0,0,0,0,0,0,"Xar'Ti - OoC - Run Script"),
(10369,0,0,0,1,0,100,0,1000,60000,30000,300000,0,80,1036900,0,0,0,0,0,1,0,0,0,0,0,0,0,0,"Trayexir - OoC - Run Script"),
(11814,0,2,0,1,0,100,0,1000,60000,30000,300000,0,80,1181400,0,0,0,0,0,1,0,0,0,0,0,0,0,0,"Kali Remik - OoC - Run Script"),

(318400,9,0,0,0,0,100,0,0,0,0,0,0,17,10,0,0,0,0,0,1,0,0,0,0,0,0,0,0,"Miao'zan - On Script - Set Emote State 10"),
(318400,9,1,0,0,0,100,0,30000,120000,0,0,0,17,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,"Miao'zan - On Script - Set Emote State 0"),

(318500,9,0,0,0,0,100,0,0,0,0,0,0,17,10,0,0,0,0,0,1,0,0,0,0,0,0,0,0,"Mishiki - On Script - Set Emote State 10"),
(318500,9,1,0,0,0,100,0,30000,120000,0,0,0,17,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,"Mishiki - On Script - Set Emote State 0"),

(318600,9,0,0,0,0,100,0,0,0,0,0,0,17,10,0,0,0,0,0,1,0,0,0,0,0,0,0,0,"K'waii - On Script - Set Emote State 10"),
(318600,9,1,0,0,0,100,0,30000,120000,0,0,0,17,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,"K'waii - On Script - Set Emote State 0"),

(318700,9,0,0,0,0,100,0,0,0,0,0,0,17,10,0,0,0,0,0,1,0,0,0,0,0,0,0,0,"Tai'tasi - On Script - Set Emote State 10"),
(318700,9,1,0,0,0,100,0,30000,120000,0,0,0,17,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,"Tai'tasi - On Script - Set Emote State 0"),

(393300,9,0,0,0,0,100,0,0,0,0,0,0,17,10,0,0,0,0,0,1,0,0,0,0,0,0,0,0,"Hai'zan - On Script - Set Emote State 10"),
(393300,9,1,0,0,0,100,0,30000,120000,0,0,0,17,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,"Hai'zan - On Script - Set Emote State 0"),

(588000,9,0,0,0,0,100,0,0,0,0,0,0,17,10,0,0,0,0,0,1,0,0,0,0,0,0,0,0,"Un'Thuwa - On Script - Set Emote State 10"),
(588000,9,1,0,0,0,100,0,30000,120000,0,0,0,17,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,"Un'Thuwa - On Script - Set Emote State 0"),

(594200,9,0,0,0,0,100,0,0,0,0,0,0,17,10,0,0,0,0,0,1,0,0,0,0,0,0,0,0,"Zansoa - On Script - Set Emote State 10"),
(594200,9,1,0,0,0,100,0,30000,120000,0,0,0,17,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,"Zansoa - On Script - Set Emote State 0"),

(795200,9,0,0,0,0,100,0,0,0,0,0,0,17,10,0,0,0,0,0,1,0,0,0,0,0,0,0,0,"Zjolnir - On Script - Set Emote State 10"),
(795200,9,1,0,0,0,100,0,30000,120000,0,0,0,17,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,"Zjolnir - On Script - Set Emote State 0"),

(795300,9,0,0,0,0,100,0,0,0,0,0,0,17,10,0,0,0,0,0,1,0,0,0,0,0,0,0,0,"Xar'Ti - On Script - Set Emote State 10"),
(795300,9,1,0,0,0,100,0,30000,120000,0,0,0,17,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,"Xar'Ti - On Script - Set Emote State 0"),

(1036900,9,0,0,0,0,100,0,0,0,0,0,0,17,10,0,0,0,0,0,1,0,0,0,0,0,0,0,0,"Trayexir - On Script - Set Emote State 10"),
(1036900,9,1,0,0,0,100,0,30000,120000,0,0,0,17,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,"Trayexir - On Script - Set Emote State 0"),

(1181400,9,0,0,0,0,100,0,0,0,0,0,0,17,10,0,0,0,0,0,1,0,0,0,0,0,0,0,0,"Kali Remik - On Script - Set Emote State 10"),
(1181400,9,1,0,0,0,100,0,30000,120000,0,0,0,17,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,"Kali Remik - On Script - Set Emote State 0");

DELETE FROM `spell_proc` WHERE `SpellId` IN (44401);
INSERT INTO `spell_proc` (`SpellId`,`SchoolMask`,`SpellFamilyName`,`SpellFamilyMask0`,`SpellFamilyMask1`,`SpellFamilyMask2`,`ProcFlags`,`SpellTypeMask`,`SpellPhaseMask`,`HitMask`,`AttributesMask`,`DisableEffectsMask`,`ProcsPerMinute`,`Chance`,`Cooldown`,`Charges`) VALUES
(44401,0x00,3,0x00000000,0x00000000,0x00000000,0x11000,0x5,0x1,0x0,0x8,0x0,0,0,0,1); -- Missile Barrage

-- Update School of fish coordinates
UPDATE `creature` SET `position_x`=-925.1334228515625, `position_y`=-5133.50732421875, `position_z`=-7.26972579956054687, `orientation`=1.15957343578338623, `spawntimesecs`=120, `VerifiedBuild`=55141 WHERE `guid`=13035 AND `id`=6145;

-- 
DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_ioc_seaforium_blast_credit' AND `spell_id` IN (67813,67814);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(67813, 'spell_ioc_seaforium_blast_credit'),
(67814, 'spell_ioc_seaforium_blast_credit');

--
DELETE FROM `trinity_string` WHERE `entry` IN (397,398);
INSERT INTO `trinity_string` (`entry`, `content_default`) VALUES
(397, "Characters below level 10 are not eligible for faction change."),
(398, "Death Knights below level 60 are not eligible for faction change.");

-- Desolace, Sar'theris Strand GY
DELETE FROM `graveyard_zone` WHERE `ID` = 1422 AND `GhostZone` = 2100;
INSERT INTO `graveyard_zone` (`ID`, `GhostZone`, `Faction`, `Comment`) VALUES
(1422,2100,0,"Desolace, Sar'theris Strand GY");

-- Also delete most likely wrong linked GY
DELETE FROM `graveyard_zone` WHERE `ID`=31 AND `GhostZone`=2100;

-- Ghost Walker Post Spirit Healer Update
UPDATE `creature` SET `position_x`=-1432.9971923828125, `position_y`=1973.572265625, `position_z`=86.70270538330078125, `orientation`=3.246312379837036132, `spawntimesecs`=120, `VerifiedBuild`=55141 WHERE `guid`=40568 AND `id`=6491;

-- Add missing furbolg camp area triggers for quest "How Big a Threat?"
SET @QUEST := 984;
DELETE FROM `areatrigger_involvedrelation` WHERE `quest` = @QUEST;
INSERT INTO `areatrigger_involvedrelation` (`id`, `quest`) VALUES
(231, @QUEST),
(232, @QUEST),
(233, @QUEST),
(234, @QUEST),
(235, @QUEST),
(236, @QUEST),
(237, @QUEST),
(238, @QUEST);

--
UPDATE `creature_template_locale` SET `Name`="Balai Lok'Wein", `Title`="Tränke, Schriftrollen & Reagenzien", `VerifiedBuild`=0 WHERE `entry`=13476 AND `locale`='deDE';
UPDATE `creature_template_locale` SET `Name`="Balai Lok'Wein", `Title`="Pociones, pergaminos y componentes", `VerifiedBuild`=0 WHERE `entry`=13476 AND `locale`='esES';
UPDATE `creature_template_locale` SET `Name`="Balai Lok'Wein", `Title`="Pociones, pergaminos y componentes", `VerifiedBuild`=0 WHERE `entry`=13476 AND `locale`='esMX';
UPDATE `creature_template_locale` SET `Name`="Balai Lok'Wein", `Title`="Potions, Parchemins & Composants", `VerifiedBuild`=0 WHERE `entry`=13476 AND `locale`='frFR';
UPDATE `creature_template_locale` SET `Name`="발라이 로크웨인", `Title`="물약 및 마법용품 상인", `VerifiedBuild`=0 WHERE `entry`=13476 AND `locale`='koKR';
UPDATE `creature_template_locale` SET `Name`="Бала Лок'Вен", `Title`="Зелья, cвитки и pеагенты", `VerifiedBuild`=0 WHERE `entry`=13476 AND `locale`='ruRU';
UPDATE `creature_template_locale` SET `Name`="巴莱·洛克维", `Title`="药剂、卷轴和材料", `VerifiedBuild`=0 WHERE `entry`=13476 AND `locale`='zhCN';
UPDATE `creature_template_locale` SET `Name`="巴萊·洛克維", `Title`="药剂、卷轴和材料", `VerifiedBuild`=0 WHERE `entry`=13476 AND `locale`='zhTW';

-- Forgotten Depths Ambusher
SET @ENTRY := 30204;
-- Update auras
UPDATE `creature_template_addon` SET `auras`='42459 56422' WHERE `entry`=@ENTRY; -- Dual Wield, Nerubian Submerge
-- Update unit flags
UPDATE `creature_template` SET `unit_flags`=512 WHERE `entry`=@ENTRY;
-- Forgotten Depths Ambusher smart ai
UPDATE `creature_template` SET `AIName` = 'SmartAI', `ScriptName` = '' WHERE `entry` = @ENTRY;
DELETE FROM `smart_scripts` WHERE `source_type` = 0 AND `entryOrGuid` = @ENTRY;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES 
(@ENTRY, 0, 0, 1, 54, 0, 100, 1, 0, 0, 0, 0, 28, 56422, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Forgotten Depths Ambusher - On just summoned - Remove 'Nerubian Submerge' aura (No Repeat)"),
(@ENTRY, 0, 1, 2, 61, 0, 100, 1, 0, 0, 0, 0, 11, 56418, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Forgotten Depths Ambusher - On link - Cast spell 'Emerge From Snow' on Self (No Repeat)"),
(@ENTRY, 0, 2, 0, 61, 0, 100, 1, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 21, 40, 0, 0, 0, 0, 0, 0, "Forgotten Depths Ambusher - On link - Attack start on closest player (No Repeat)"),
(@ENTRY, 0, 3, 0, 7, 0, 100, 1, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Forgotten Depths Ambusher - On evade - Despawn instantly (No Repeat)");

-- Add Franklin the Friendly charm immunnity
UPDATE `creature_template` SET `mechanic_immune_mask`=`mechanic_immune_mask`|1 WHERE `entry`=14529;

-- Return to Obadei 9423 / Makuru's Vengeance 9424

-- Add Anchorite Obadei text
DELETE FROM `creature_text` WHERE `CreatureID`=16834;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(16834,0,0,"What have you done, Makuru?!  These are not our ways!",12,0,100,0,0,0,13991,0,'Anchorite Obadei'),
(16834,1,0,"I understand how you feel Makuru.  Sedai was my brother after all.  Yet we can't disgrace his memory by going against his very ideals.",12,0,100,0,0,0,13992,0,'Anchorite Obadei');

-- Add Makuru text
DELETE FROM `creature_text` WHERE `CreatureID` = 16833 AND `GroupID` IN (0,1);
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(16833,0,0,"No!  Not... Sedai!  The orcs must pay!",12,0,100,0,0,0,13997,0,'Makuru'),
(16833,1,0,"The orcs hate us, Obadei!  They've killed many of us before!  They deserve death and worse.",12,0,100,0,0,0,13996,0,'Makuru');

-- "Return to Obadei" Script
DELETE FROM `smart_scripts` WHERE `entryorguid`=16834 AND `source_type`=0 AND `id`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`event_param5`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_param4`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(16834,0,0,0,20,0,100,0,9423,0,0,0,0,1,0,0,0,0,0,0,19,16833,0,0,0,0,0,0,0,"Anchorite Obadei - On Quest 'Return to Obadei' Rewarded - Makuru Say Line 0");

-- "Makurus Vengeance" Script
DELETE FROM `smart_scripts` WHERE `entryorguid`=16833 AND `source_type`=0 AND `id` IN (0,1,2,3);
DELETE FROM `smart_scripts` WHERE `entryorguid`=16834 AND `source_type`=0 AND `id` IN (1,2,3);
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (1683300,1683400) AND `source_type`=9;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`event_param5`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_param4`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(16833,0,1,0,20,0,100,0,9424,25000,25000,0,0,80,1683300,0,0,0,0,0,1,0,0,0,0,0,0,0,0,"Makuru - On Quest 'Makurus Vengeance' Rewarded - Run Script"),

(16834,0,1,2,38,0,100,0,0,1,0,0,0,83,3,0,0,0,0,0,1,0,0,0,0,0,0,0,0,"Anchorite Obadei - On Data Set - Remove Gossip + Quest Giver npc flag"),
(16834,0,2,0,61,0,100,0,0,0,0,0,0,53,0,16834,0,0,0,0,1,0,0,0,0,0,0,0,0,"Anchorite Obadei - On Link - Start WP"),
(16834,0,3,0,40,0,100,0,2,16834,0,0,0,80,1683400,0,0,0,0,0,1,0,0,0,0,0,0,0,0,"Anchorite Obadei - On Waypoint 2 Reached - Run Script"),

(1683300,9,0,0,0,0,100,0,0,0,0,0,0,45,0,1,0,0,0,0,19,16834,0,0,0,0,0,0,0,"Makuru - On Script - Set Data to Anchorite Obadei"),
(1683300,9,1,0,0,0,100,0,5000,5000,0,0,0,66,0,0,0,0,0,0,19,16834,0,0,0,0,0,0,0,"Makuru - On Script - Set Orientation"),
(1683300,9,2,0,0,0,100,0,20000,20000,0,0,0,66,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,"Makuru - On Script - Set Orientation Home Position"),

(1683400,9,3,0,0,0,100,0,0,0,0,0,0,54,20000,0,0,0,0,0,1,0,0,0,0,0,0,0,0,"Anchorite Obadei - On Script - Pause Waypoint"),
(1683400,9,4,0,0,0,100,0,0,0,0,0,0,66,0,0,0,0,0,0,19,16833,0,0,0,0,0,0,0,"Anchorite Obadei - On Script - Set Orientation"),
(1683400,9,5,0,0,0,100,0,1000,1000,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,"Anchorite Obadei - On Script - Say Line 0"),
(1683400,9,6,0,0,0,100,0,7000,7000,0,0,0,1,1,0,0,0,0,0,19,16833,0,0,0,0,0,0,0,"Anchorite Obadei - On Script - Say Line 1 (Makuru)"),
(1683400,9,7,0,0,0,100,0,4000,4000,0,0,0,1,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,"Anchorite Obadei - On Script - Say Line 1"),
(1683400,9,8,0,0,0,100,0,10000,10000,0,0,0,66,0,0,0,0,0,0,8,0,0,0,0,0,0,0,4.643,"Anchorite Obadei - On Script - Set Orientation"),
(1683400,9,9,0,0,0,100,0,1000,1000,0,0,0,82,3,0,0,0,0,0,1,0,0,0,0,0,0,0,0,"Anchorite Obadei - Script Set - Add Gossip + Quest Giver npc flag");

-- Waypoints
DELETE FROM `waypoints` WHERE `entry`=16834;
INSERT INTO `waypoints` (`entry`, `pointid`, `position_x`, `position_y`, `position_z`, `point_comment`) VALUES 
(16834,1,93.944,4345.056,101.698,"Anchorite Obadei"),
(16834,2,96.005,4344.833,101.767,"Anchorite Obadei"),
(16834,3,93.944,4345.056,101.698,"Anchorite Obadei"),
(16834,4,90.838,4351.730,103.178,"Anchorite Obadei");

-- Fix Mmm... Amberseeds! quest requirements
UPDATE `quest_template_addon` SET `NextQuestID`=0 WHERE `ID` IN (12222, 12223); 

-- Iron Rune Construct Movement Flags: 0 (None)
UPDATE `creature_template_movement` SET `Ground` = 0, `Swim` = 0, `Flight` = 0 WHERE `CreatureId` = 24825;
-- Iron Rune Construct - Iron Rune Aura
DELETE FROM `creature_template_addon` WHERE `entry`=24825;
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `MountCreatureID`, `StandState`, `AnimTier`, `VisFlags`, `SheathState`, `PvPFlags`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(24825, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, '44652');
