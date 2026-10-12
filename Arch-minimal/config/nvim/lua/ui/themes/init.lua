-- =============================================================================
-- CONFIGURACION DE TEMAS MINIMALISTAS PARA NEOVIM
-- =============================================================================

local tema_elegido = 20

temas = require("ui.themes.palettes")
highlights = require("ui.themes.highlights")

local t = assert(temas[tema_elegido], "No existe el tema seleccionado: " .. tema_elegido)

highlights.apply(t)
