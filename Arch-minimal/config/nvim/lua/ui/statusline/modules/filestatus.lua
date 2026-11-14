local function file_type()
	local ft = vim.bo.filetype
	local map_icons = {
		lua = " ",
		html = " ",
		css = " ",
		javascript = " ",
		typescript = " ",
		rust = " ",
		c = " ",
		cpp = " ",
		python = " ",
		json = " ",
		sh = "  ",
		netrw = " ",
		text = " ",
		asm = " ",
		go = " ",
		java = " ",
		sql = " ",
		ruby = " ",
		php = " ",
		toml = " ",
		markdown = " ",
	}
	return ft ~= "" and map_icons[ft] or " "
end

local function file_size()
	local size = vim.fn.getfsize(vim.fn.expand("%"))
	if size < 0 then
		return " "
	elseif size < 1024 then
		return size .. "B "
	elseif size < 1024 * 1024 then
		return string.format("%.1fK ", size / 1024)
	else
		return string.format("%.1fM ", size / 1024 / 1024)
	end
end

return {
	icon = file_type,
	size = file_size,
}
