require("code-shot").setup({
	---@return string output file path
	output = function()
		local core = require("core")
		local buf_name = vim.api.nvim_buf_get_name(0)
		return "~/Pictures/" .. core.file.name(buf_name) .. ".png"
	end,
	---@return string[]
	-- select_area: {s_start: {row: number, col: number}, s_end: {row: number, col: number}} | nil
	options = function(select_area)
		vim.notify(select_area)
        -- Whole file picture
		if not select_area then
			return { "--to-clipboard" }
		end
        -- Visual selection
        vim.api.nvim_buf_get_lines(0, select_area.s_start.row, select_area.s_end.row, true)
        vim.fn.setreg("*", table.concat(vim.api.nvim_buf_get_lines(0, select_area.s_start.row, select_area.s_end.row, true), "\n"))
		return {
          "--from-clipboard",
          "--to-clipboard",
		}
	end,
})
