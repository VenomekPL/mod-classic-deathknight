-- Strip talent-gated spells from classic DK auto-progression and trainer.
-- Talent Rank 1 comes from the talent tree; higher ranks stay on trainer 130
-- with ReqAbility1 pointing at the talent Rank 1.

DELETE FROM `classic_dk_spell_progression` WHERE `spell_id` IN (
    49020, -- Obliterate Rank 1 (talent)
    51423, -- Obliterate Rank 2
    51416, -- Frost Strike Rank 2
    51417, -- Frost Strike Rank 3
    55258, -- Heart Strike Rank 2
    55259, -- Heart Strike Rank 3
    51325  -- Corpse Explosion Rank 2
);

-- Obliterate Rank 1 must not be freely trainable (talent only).
DELETE FROM `trainer_spell` WHERE `TrainerId` = 130 AND `SpellId` = 49020;
