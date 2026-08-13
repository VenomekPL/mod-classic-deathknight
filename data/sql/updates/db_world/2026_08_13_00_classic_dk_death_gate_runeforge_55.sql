-- Classic DK: auto-teach Runeforging and Death Gate at 55 with no IP gate.
-- Acherus is already in the world (spirit rez works nearby); Runeforging is
-- usable as soon as the character can reach it.

DELETE FROM `classic_dk_spell_progression` WHERE `spell_id` IN (53428, 50977);
INSERT INTO `classic_dk_spell_progression` (`spell_id`, `level`, `requires_progression`) VALUES
(53428, 55, 0), -- Runeforging
(50977, 55, 0); -- Death Gate
