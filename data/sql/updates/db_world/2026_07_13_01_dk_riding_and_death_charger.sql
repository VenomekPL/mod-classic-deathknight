-- Classic DK: auto-grant riding + Death Charger at 60 (Acherus questline skipped)
DELETE FROM `classic_dk_spell_progression` WHERE `spell_id` IN (33388, 33391, 48778);
INSERT INTO `classic_dk_spell_progression` (`spell_id`, `level`, `requires_progression`) VALUES
(33388, 60, 0),
(33391, 60, 0),
(48778, 60, 0);
