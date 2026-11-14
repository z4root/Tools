local function mode_icon()
	local mode = vim.fn.mode()
	local map = {
		n = "  NORMAL ",
		i = "  INSERT ",
		v = "  VISUAL ",
		V = "  V-LINE ",
		c = "  COMMAND ",
		R = "  REPLACE ",
		t = "  TERMINAL ",
	}
	return map[mode] or mode
end

return {
	icon = mode_icon,
}
