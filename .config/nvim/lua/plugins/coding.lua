return {
	-- Incremental rename
	{
		"smjonas/inc-rename.nvim",
		cmd = "IncRename",
		config = true,
	},

	-- Go forward/backward with square brackets
	{
		"echasnovski/mini.bracketed",
		event = "BufReadPost",
		config = function()
			local bracketed = require("mini.bracketed")
			bracketed.setup({
				file = { suffix = "" },
				window = { suffix = "" },
				quickfix = { suffix = "" },
				yank = { suffix = "" },
				treesitter = { suffix = "n" },
			})
		end,
	},
	{
		"numToStr/Comment.nvim",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			-- Set a vim motion to <Space> + / to comment the line under the cursor in normal mode
			vim.keymap.set("n", "<leader>/", "<Plug>(comment_toggle_linewise_current)", { desc = "Comment Line" })
			-- Set a vim motion to <Space> + / to comment all the lines selected in visual mode
			vim.keymap.set("v", "<leader>/", "<Plug>(comment_toggle_linewise_visual)", { desc = "Comment Selected" })
		end,
	},
	-- Better increase/descrease
	-- {
	-- 	"monaqa/dial.nvim",
	--   keys = {
	--     { "<C-a>", function() return require("dial.map").inc_normal() end, expr = true, desc = "Increment" },
	--     { "<C-x>", function() return require("dial.map").dec_normal() end, expr = true, desc = "Decrement" },
	--   },
	-- 	config = function()
	-- 		local augend = require("dial.augend")
	-- 		require("dial.config").augends:register_group({
	-- 			default = {
	-- 				augend.integer.alias.decimal,
	-- 				augend.integer.alias.hex,
	-- 				augend.date.alias["%Y/%m/%d"],
	-- 				augend.constant.alias.bool,
	-- 				augend.semver.alias.semver,
	-- 				augend.constant.new({ elements = { "let", "const" } }),
	-- 			},
	-- 		})

	-- 	end,
	-- },
}
