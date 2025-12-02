return{
  {
     "nvim-telescope/telescope.nvim",
     tag = "0.1.8",
     dependencies = { "nvim-lua/plenary.nvim" },
     config = function()
	     local builtin = require("telescope.builtin")
	     vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
	     vim.keymap.set("n", "<leader>fg", builtin.live_grep, {}) -- 文字列検索用
	     vim.keymap.set("n", "<leader>ff", builtin.buffers, {})  -- 開いているバッファ検索
	     vim.keymap.set("n", "<leader>ff", builtin.help_tags, {}) -- ヘルプ検索
	end,
  },
}
