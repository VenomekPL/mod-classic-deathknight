-- Classic DK: record the mod-classic-deathknight submodule pointer in the module repo's
-- gitmodules file so the worldserver's module updater picks it up on the next startup/reload.
--
-- Reversible: delete this file to stop tracking the pointer.
-- Apply: worldserver module updater (fresh realms) or .reload
 spell_area (GM).

UPDATE mod-classic-deathknight
SET Subproject commit = '469a69b445d488a2fe3008fb7e33e2e70876c4d9';
