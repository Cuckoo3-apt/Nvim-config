return {
-- Copilot plugin configuration
{
    "zbirenbaum/copilot.lua", -- Plugin repository
    cmd = "Copilot",           -- Command to trigger Copilot
    event = "VeryLazy",        -- Lazy load event
    opts = {
      suggestion = { enabled = false }, -- Disable inline suggestions
      panel = { enabled = false },      -- Disable Copilot panel
      filetypes = {
        markdown = true,                -- Enable Copilot for markdown files
        help = true,                    -- Enable Copilot for help files
      },
    },
  },
  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "echasnovski/mini.nvim",
      "j-hui/fidget.nvim",
    },
    
    init = function()
      require("utils.codecompanion_fidget_spinner"):init()
    end,

     -- stylua: ignore
    keys = {
      {"<leader>cca", "<CMD>CodeCompanionActions<CR>",     mode = {"n", "v"}, noremap = true, silent = true, desc = "CodeCompanion actions"      },
      {"<leader>cci", "<CMD>CodeCompanion<CR>",            mode = {"n", "v"}, noremap = true, silent = true, desc = "CodeCompanion inline"       },
      {"<leader>ccc", "<CMD>CodeCompanionChat Toggle<CR>", mode = {"n", "v"}, noremap = true, silent = true, desc = "CodeCompanion chat (toggle)"},
      {"<leader>ccp", "<CMD>CodeCompanionChat Add<CR>",    mode = {"v"}     , noremap = true, silent = true, desc = "CodeCompanion chat add code"},
    },

    opts = {
      display = {
        diff = {
          enabled = true,
          provider = "mini_diff",
        },
      },

      strategies = {
        chat = { adapter = "copilot" },
        inline = { adapter = "copilot" },
      },

      opts = {
        language = "English", -- "English"|"Chinese"
      },
    },
  },
}
