local function git_branch()
	local cached_branch = ""
	local last_check = 0
	local now = vim.loop.now()
	if now - last_check > 2000 then
		cached_branch = vim.fn.system("git branch --show-current 2>/dev/null | tr -d '\n'")
		last_check = now
	end
	if cached_branch ~= "" then
		return " " .. cached_branch .. " "
	end
	return ""
end

local function git_modify()
	local now = vim.loop.now()
	local number_modified = ""
	local last_check = 0
	if now - last_check > 2000 then
		number_modified =
			vim.fn.system("git status --show-stash -uno -s 2>/dev/null | grep -E '^ M' | wc -l | tr -d '\n'")
		last_check = now
	end
	if number_modified ~= "0" then
		return " " .. number_modified .. " "
	end
	return ""
end

local function git_remove()
	local now = vim.loop.now()
	local number_deleted = ""
	local last_check = 0
	if now - last_check > 2000 then
		number_deleted =
			vim.fn.system("git status --show-stash -uno -s 2>/dev/null | grep -E '^ D' | wc -l | tr -d '\n'")
		last_check = now
	end
	if number_deleted ~= "0" then
		return " " .. number_deleted .. ""
	end
	return ""
end

local function git_untracked()
	local now = vim.loop.now()
	local number_untracked = ""
	local last_check = 0
	if now - last_check > 2000 then
		number_untracked =
			vim.fn.system("git status --show-stash -u -s 2>/dev/null | grep -E '^.[^ M|R|D|A] '| wc -l | tr -d '\n'")
		last_check = now
	end
	if number_untracked ~= "0" then
		return " " .. number_untracked .. " "
	end
	return ""
end

local function git_stage()
	local now = vim.loop.now()
	local number_staged = ""
	local last_check = 0
	if now - last_check > 2000 then
		number_staged = vim.fn.system("git status -s 2>/dev/null| grep -E '^ A' | wc -l | tr -d '\n'")
		last_check = now
	end
	if number_staged ~= "0" then
		return " " .. number_staged .. " "
	end
	return ""
end

local function git_commit()
	local now = vim.loop.now()
	local number_commit = ""
	local last_check = 0
	if now - last_check > 2000 then
		number_commit = vim.fn.system("git log @{u}..HEAD --oneline 2>/dev/null | wc -l | tr -d '\n'")
		last_check = now
	end
	if number_commit ~= "0" then
		return " " .. number_commit .. " "
	end
	return ""
end

return {
	branch = git_branch,
	untracked = git_untracked,
	stage = git_stage,
	modify = git_modify,
	commit = git_commit,
	remove = git_remove,
}
