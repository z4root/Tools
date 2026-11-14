-- ===================================================
----
-- CONFIGURACION DE TEMAS MINIMALISTAS PARA NEOVIM
-- z3root
----
-- ====================================================

themes = require("ui.themes.palettes")
highlights = require("ui.themes.highlights")
local function get_theme_id()
	local f = io.open(os.getenv("HOME") .. "/.config/bspwm/.current_theme", "r")
	local theme_id = f:read("*all"):gsub("%s+", "")
	f:close()
	return theme_id
end
local theme_id = get_theme_id()

local palette = (themes[theme_id] ~= "") and themes[theme_id] or themes["3"] -- default

highlights.apply(palette)
