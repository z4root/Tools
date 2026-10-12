local M = {}

function M.apply(t)
	local highlights = {

		-- Transparencia
		Normal = { fg = t.fg, bg = "NONE" },
		NormalNC = { fg = t.fg, bg = "NONE" },
		SignColumn = { bg = "NONE" },
		EndOfBuffer = { fg = t.comment, bg = "NONE" },
		StatusLine = { fg = t.fg, bg = "NONE" },
		TabLine = { fg = t.fg, bg = "NONE" },

		-- Lineas y comentarios
		LineNr = { fg = t.comment, bg = "NONE" },
		CursorLineNr = { fg = t.constant, bg = "NONE", bold = true },
		Comment = { fg = t.comment, bg = "NONE", italic = true },

		-- Sintaxis tradicional
		Keyword = { fg = t.keyword },
		Statement = { fg = t.keyword },
		Conditional = { fg = t.keyword },
		Repeat = { fg = t.keyword },
		Function = { fg = t.function_col },
		Identifier = { fg = t.variable },
		Operator = { fg = t.operator },
		String = { fg = t.string },
		Character = { fg = t.string },
		Constant = { fg = t.constant },
		Number = { fg = t.constant },
		Boolean = { fg = t.constant },
		Type = { fg = t.type },
		Structure = { fg = t.type },
		Special = { fg = t.operator },

		-- Tree-sitter
		["@keyword"] = { fg = t.keyword },
		["@function"] = { fg = t.function_col },
		["@variable"] = { fg = t.variable },
		["@operator"] = { fg = t.operator },
		["@string"] = { fg = t.string },
		["@constant"] = { fg = t.constant },
		["@type"] = { fg = t.type },
		["@comment"] = { fg = t.comment, italic = true },

		-- Autocompletado y ventanas flotantes (No tengo pero para quien tenga)
		Pmenu = { fg = t.fg, bg = "NONE" },
		PmenuSel = { fg = t.bg, bg = t.keyword, bold = true },
		FloatBorder = { fg = t.comment, bg = "NONE" },
		NormalFloat = { fg = t.fg, bg = "NONE" },

		-- Seleccion y búsqueda
		Visual = { bg = t.comment },
		Search = { fg = t.bg, bg = t.constant },
		IncSearch = { fg = t.bg, bg = t.keyword },

		-- Diagnosticos
		Error = { fg = "#ff5555", bold = true },
		WarningMsg = { fg = t.constant },
		DiagnosticError = { fg = "#ff5555" },
		DiagnosticWarn = { fg = t.constant },
		DiagnosticInfo = { fg = t.function_col },
		DiagnosticHint = { fg = t.operator },
	}

	for group, opts in pairs(highlights) do
		vim.api.nvim_set_hl(0, group, opts)
	end

	-- Telescope transparente
	local telescope_groups = {
		"TelescopeNormal",
		"TelescopeBorder",
		"TelescopePromptNormal",
		"TelescopePromptBorder",
		"TelescopePreviewNormal",
		"TelescopePreviewBorder",
		"TelescopeResultsNormal",
		"TelescopeResultsBorder",
	}

	for _, group in ipairs(telescope_groups) do
		vim.api.nvim_set_hl(0, group, { bg = "NONE" })
	end
end

return M
