local M = {}
-- Git
local git_status = require("ui.statusline.modules.gitstatus")
-- Files
local file_status = require("ui.statusline.modules.filestatus")
-- Mode
local mode_status = require("ui.statusline.modules.modestatus")

function M.setup()
	vim.opt.laststatus = 3
	vim.opt.statusline = table.concat({

		"%t ",
		"%{v:lua.require'ui.statusline.init'.file_icon()}",
		"%{v:lua.require'ui.statusline.init'.size()}",
		"%=",
		"[ %{v:lua.require'ui.statusline.init'.git()}",
		"%{v:lua.require'ui.statusline.init'.git_untracked()}",
		"%{v:lua.require'ui.statusline.init'.git_stage()}",
		"%{v:lua.require'ui.statusline.init'.git_modify()}",
		"%{v:lua.require'ui.statusline.init'.git_commit()}",
		"%{v:lua.require'ui.statusline.init'.git_remove()}]",

		"%=%",
		"#StatusLineNormal#%{v:lua.require'ui.statusline.init'.mode()}",
	})
end

function M.git()
	return git_status.branch()
end

function M.git_remove()
	return git_status.remove()
end

function M.git_modify()
	return git_status.modify()
end

function M.git_untracked()
	return git_status.untracked()
end

function M.git_stage()
	return git_status.stage()
end

function M.git_commit()
	return git_status.commit()
end

function M.file_icon()
	return file_status.icon()
end

function M.size()
	return file_status.size()
end
function M.mode()
	return mode_status.icon()
end

return M
