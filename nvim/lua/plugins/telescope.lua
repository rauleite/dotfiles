return {
  'nvim-telescope/telescope.nvim',
  tag = '0.1.8',
  -- or: branch = '0.1.x',
  dependencies = {
    'nvim-lua/plenary.nvim'
  },
  keys = function()
    local builtin = require("telescope.builtin") -- Instanciado UMA vez
    return {
      { "<leader>ff", builtin.find_files, desc = "Find Files" },
      { "<leader>fg", builtin.live_grep,  desc = "Live Grep" },
      { "<leader>fb", builtin.buffers,    desc = "Buffers" },
      { "<leader>fh", builtin.help_tags,  desc = "Help Tags" },
    }
  end
}
