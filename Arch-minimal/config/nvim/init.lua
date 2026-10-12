-- Opciones y keymaps
require("core.options")
require("core.keymaps")

-- Plugins
require("plugins")

-- Configs
require("config.mason") -- mason.nvim
require("config.lsp") -- nvim-lspconfig + mason-lspconfig
require("config.conform").setup() -- formateadores (Dolor de cabeza)
require("config.emmet") -- emmet (miau)
require("markdown-plus")

-- UI (sip)
-- require("ui.statusline")
require("ui.themes.init")
