-- Wrapping silicon to take pretty code snippet photos
-- Note that this requires a keybinding to be set otherwise the mode selection
-- won't work correctly
local M = {}

local function get_visual_selection()
	local s_start = vim.fn.getpos("'<")
	local s_end = vim.fn.getpos("'>")
	local n_lines = math.abs(s_end[2] - s_start[2]) + 1
	local lines = vim.api.nvim_buf_get_lines(0, s_start[2] - 1, s_end[2], false)
	lines[1] = string.sub(lines[1], s_start[3], -1)
	if n_lines == 1 then
		lines[n_lines] = string.sub(lines[n_lines], 1, s_end[3] - s_start[3] + 1)
	else
		lines[n_lines] = string.sub(lines[n_lines], 1, s_end[3])
	end
	return table.concat(lines, '\n')
end

M.capture = function()
	local source_file = vim.api.nvim_buf_get_name(0)
	local ending = string.match(source_file, "%.%a+$")
	if ending == nil then
		vim.notify("Unable to find the file type")
		return
	end

	ending = string.sub(ending, 2)

	local mode = vim.api.nvim_get_mode().mode
	if mode == "V" then
		vim.fn.setreg("+", get_visual_selection())

		local suc = os.execute("silicon --from-clipboard --to-clipboard --language " .. ending)
		if suc then
			vim.notify("Silicon succeeded!", vim.log.levels.INFO, { title = "silicon" })
		else
			vim.notify("Silicon did not succeed", vim.log.levels.ERROR, { title = "silicon" })
		end
	elseif mode == "n" then
		local command = "silicon --to-clipboard --language " .. ending .. " " .. source_file
		vim.notify(command)
		local suc = os.execute(command)
		if suc then
			vim.notify("Silicon succeeded!", vim.log.levels.INFO, { title = "silicon" })
		else
			vim.notify("Silicon did not succeed", vim.log.levels.ERROR, { title = "silicon" })
		end
	else
		vim.notify("Unsupported mode!", vim.log.levels.ERROR)
	end
end

return M
