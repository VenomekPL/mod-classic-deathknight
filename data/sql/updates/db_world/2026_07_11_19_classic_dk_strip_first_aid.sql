-- Classic DK: ensure no bootstrap First Aid (WotLK rank 4 artisan) at creation.
DELETE FROM `playercreateinfo_skills`
WHERE `classMask` = 32 AND `skill` = 129;
