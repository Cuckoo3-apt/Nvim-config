return {
  -- change the color of copilot icon
  {
    "nvim-tree/nvim-web-devicons",
    opts = {
      override = {
        copilot = {
          icon = "", -- Copilot icon
          color = "#cba6f7", -- Copilot color
          name = "Copilot",
        },
      },
    },
  },

  {
    "nvim-lualine/lualine.nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
      "AndreM222/copilot-lualine",
    },
    opts = {
      options = {
        theme = "catppuccin",
        always_divide_middle = false,
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch", "diff", "diagnostics" },
        lualine_c = { "filename" },
        lualine_x = {},
        lualine_y = { "encoding", "fileformat", "filetype", "progress" },
        lualine_z = { "location" },
      },
      -- stylua: ignore
      winbar = {
        lualine_a = { "filename", },
        lualine_b = { { function() return " " end, color = "Comment", }, },
        lualine_x = { "lsp_status", },
      },
      inactive_winbar = {
        -- Always show winbar
        -- stylua: ignore
        lualine_b = { function() return " " end, },
      },
    },
    config = function(_, opts)
      local mocha = require("catppuccin.palettes").get_palette("mocha")

      local function show_macro_recording()
        local recording_register = vim.fn.reg_recording()
        if recording_register == "" then
          return ""
        else
          return "󰑋 " .. recording_register
        end
      end
      local macro_recording = {
        show_macro_recording,
        color = { fg = "#333333", bg = mocha.red },
        separator = { left = "", right = "" },
        padding = 0,
      }

      local copilot = {
        "copilot",
        show_colors = true,
        symbols = {
          status = {
            hl = {
              enabled = mocha.green,
              sleep = mocha.overlay0,
              disabled = mocha.surface0,
              warning = mocha.peach,
              unknown = mocha.red,
            },
          },
          spinner_color = mocha.mauve,
        },
      }

      table.insert(opts.sections.lualine_x, 1, macro_recording)
      table.insert(opts.sections.lualine_c, copilot)
      require("lualine").setup(opts)
    end,
  },

  -- babar
  {
    "romgrk/barbar.nvim",
    version = "^1.0.0", -- optional: only update when a new 1.x version is released
    dependencies = {
      "lewis6991/gitsigns.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    init = function()
      vim.g.barbar_auto_setup = false
    end,
    lazy = false,
    -- stylua: ignore
    keys = {
      { "<A-<>", "<CMD>BufferMovePrevious<CR>", mode = {"n"}, desc = "[Buffer] Move buffer left"  },
      { "<A->>", "<CMD>BufferMoveNext<CR>",     mode = {"n"}, desc = "[Buffer] Move buffer right" },
      { "<A-1>", "<CMD>BufferGoto 1<CR>",       mode = {"n"}, desc = "[Buffer] Go to buffer 1"    },
      { "<A-2>", "<CMD>BufferGoto 2<CR>",       mode = {"n"}, desc = "[Buffer] Go to buffer 2"    },
      { "<A-3>", "<CMD>BufferGoto 3<CR>",       mode = {"n"}, desc = "[Buffer] Go to buffer 3"    },
      { "<A-4>", "<CMD>BufferGoto 4<CR>",       mode = {"n"}, desc = "[Buffer] Go to buffer 4"    },
      { "<A-5>", "<CMD>BufferGoto 5<CR>",       mode = {"n"}, desc = "[Buffer] Go to buffer 5"    },
      { "<A-6>", "<CMD>BufferGoto 6<CR>",       mode = {"n"}, desc = "[Buffer] Go to buffer 6"    },
      { "<A-7>", "<CMD>BufferGoto 7<CR>",       mode = {"n"}, desc = "[Buffer] Go to buffer 7"    },
      { "<A-8>", "<CMD>BufferGoto 8<CR>",       mode = {"n"}, desc = "[Buffer] Go to buffer 8"    },
      { "<A-9>", "<CMD>BufferGoto 9<CR>",       mode = {"n"}, desc = "[Buffer] Go to buffer 9"    },
      { "<A-h>", "<CMD>BufferPrevious<CR>",     mode = {"n"}, desc = "[Buffer] Previous buffer"   },
      { "<A-l>", "<CMD>BufferNext<CR>",         mode = {"n"}, desc = "[Buffer] Next buffer"       },
    },
    opts = {
      animation = false,
      -- Automatically hide the tabline when there are this many buffers left.
      -- Set to any value >=0 to enable.
      auto_hide = 1,

      -- Set the filetypes which barbar will offset itself for
      sidebar_filetypes = {
        NvimTree = true, -- Use the default values: {event = 'BufWinLeave', text = '', align = 'left'}
      },
    },
  },

  {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    keys = {
      { "<leader>e", "<CMD>NvimTreeToggle<CR>", mode = { "n" }, desc = "[NvimTree] Toggle NvimTree" },
    },
    opts = {},
  },

  {
    "HiPhish/rainbow-delimiters.nvim",
    submodules = false,
    main = "rainbow-delimiters.setup",
    opts = {},
  },

  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      "MunifTanjim/nui.nvim",
      -- OPTIONAL:
      --   `nvim-notify` is only needed, if you want to use the notification view.
      --   If not available, we use `mini` as the fallback
      -- {"rcarriga/nvim-notify", opts = {background_colour = "#000000"}}
    },
    keys = {
      { "<leader>sN", "<CMD>Noice pick<CR>", desc = "[Noice] Pick history messages" },
      { "<leader>N", "<CMD>Noice<CR>", desc = "[Noice] Show history messages" },
    },

    opts = {
      popupmenu = {
        enabled = false,
      },
      notify = {
        enabled = false,
      },
      lsp = {

        -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = false,
          ["vim.lsp.util.stylize_markdown"] = false,
        },
      },
      -- you can enable a preset for easier configuration
      presets = {
        bottom_search = false, -- use a classic bottom cmdline for search
        command_palette = true, -- position the cmdline and popupmenu together
        long_message_to_split = true, -- long messages will be sent to a split
        inc_rename = false, -- enables an input dialog for inc-rename.nvim
        lsp_doc_border = true, -- add a border to hover docs and signature help
      },
      routes = {
        -- Hide search count
        { filter = { event = "msg_show", kind = "search_count" }, opts = { skip = true } },
        -- Hide written message
        { filter = { event = "msg_show", kind = "" }, opts = { skip = true } },
      },
    },
  },

  {
    "echasnovski/mini.diff",
    event = "VeryLazy",
    version = "*",
    opts = {},
  },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      ---@type false | "classic" | "modern" | "helix"
      preset = "helix",
      win = {
        -- no_overlap = true,
        title = false,
        width = 0.5,
      },
      -- stylua: ignore
      spec = {
        { "<leader>cc", group = "<CodeCompanion>", icon = "" },
        { "<leader>s",  group = "<Snacks>"                    },
        { "<leader>t",  group = "<Snacks> Toggle"             },
      },
      -- expand all nodes wighout a description
      expand = function(node)
        return not node.desc
      end,
    },
    keys = {
      -- stylua: ignore
      { "<leader>?", function() require("which-key").show({ global = false }) end, desc = "[Which-key] Buffer Local Keymaps", },
    },
  },

  {
    "lewis6991/gitsigns.nvim",
  },

  {
    "echasnovski/mini.diff",
    event = "BufReadPost",
    version = "*",
    -- stylua: ignore
    keys = {
      { "<leader>to", function() require("mini.diff").toggle_overlay(vim.api.nvim_get_current_buf()) end, mode = "n", desc = "[Mini.Diff] Toggle diff overlay", },
    },
    opts = {
      -- Module mappings. Use `''` (empty string) to disable one.
      -- NOTE: Mappings are handled by gitsigns.
      mappings = {
        -- Apply hunks inside a visual/operator region
        apply = "",
        -- Reset hunks inside a visual/operator region
        reset = "",
        -- Hunk range textobject to be used inside operator
        -- Works also in Visual mode if mapping differs from apply and reset
        textobject = "",
        -- Go to hunk range in corresponding direction
        goto_first = "",
        goto_prev = "",
        goto_next = "",
        goto_last = "",
      },
    },
  },

  {
    "petertriho/nvim-scrollbar",
    opts = {
      handelers = {
        gitsigns = true, -- Requires gitsigns
        search = true, -- Requires hlslens
      },
      marks = {
        Search = {
          color = "#CBA6F7",
        },
        GitAdd = { text = "┃" },
        GitChange = { text = "┃" },
        GitDelete = { text = "_" },
      },
    },
  },

  {
    "kevinhwang91/nvim-hlslens",
    -- stylua: ignore
    keys = {
      { "n",  "nzz<Cmd>lua require('hlslens').start()<CR>", mode = "n", desc = "Next match",      noremap = true, silent = true },
      { "N",  "Nzz<Cmd>lua require('hlslens').start()<CR>", mode = "n", desc = "Previous match",  noremap = true, silent = true },
      { "*",  "*<Cmd>lua require('hlslens').start()<CR>",   mode = "n", desc = "Next match",      noremap = true, silent = true },
      { "#",  "#<Cmd>lua require('hlslens').start()<CR>",   mode = "n", desc = "Previous match",  noremap = true, silent = true },
      { "g*", "g*<Cmd>lua require('hlslens').start()<CR>",  mode = "n", desc = "Next match",      noremap = true, silent = true },
      { "g#", "g#<Cmd>lua require('hlslens').start()<CR>",  mode = "n", desc = "Previous match",  noremap = true, silent = true },
      { "//", "<Cmd>noh<CR>",                               mode = "n", desc = "Clear highlight", noremap = true, silent = true },

      { "/" },
      { "?" },
    },
    opts = {
      nearest_only = true,
    },
    config = function(_, opts)
      -- require('hlslens').setup() is not required
      require("scrollbar.handlers.search").setup(opts)
      vim.api.nvim_set_hl(0, "HlSearchLens", { link = "CurSearch" })
      vim.api.nvim_set_hl(0, "HlSearchLensNear", { fg = "#CBA6F7" })
    end,
  },

  {
    "norcalli/nvim-colorizer.lua",
    config = function(_, _)
      require("colorizer").setup()
    end,
  },

  {
    "nvzone/showkeys",
    cmd = "ShowkeysToggle",
    opts = {
      maxkeys = 5,
    },
  },

  -- TODO:configrure later when having an LSP with code actions
  {
    "kosayoda/nvim-lightbulb",
  },

  -- TODO:configrure later when having an LSP with code actions
  {
    "rachartier/tiny-code-action.nvim",
    dependencies = {
      { "nvim-lua/plenary.nvim" },
      {
        "folke/snacks.nvim",
        opts = {
          terminal = {},
        },
      },
    },
    event = "LspAttach",
    opts = {},
  },

  {
    "kevinhwang91/nvim-ufo",
    dependencies = { "kevinhwang91/promise-async" },
    opts = {
      provider_selector = function(_, _, _)
        return { "treesitter", "indent" }
      end,

      open_fold_hl_timeout = 0,
      fold_virt_text_handler = function(virtText, lnum, endLnum, width, truncate)
        local newVirtText = {}
        local suffix = (" 󰁂 %d "):format(endLnum - lnum)
        local sufWidth = vim.fn.strdisplaywidth(suffix)
        local targetWidth = width - sufWidth
        local curWidth = 0
        for _, chunk in ipairs(virtText) do
          local chunkText = chunk[1]
          local chunkWidth = vim.fn.strdisplaywidth(chunkText)
          if targetWidth > curWidth + chunkWidth then
            table.insert(newVirtText, chunk)
          else
            chunkText = truncate(chunkText, targetWidth - curWidth)
            local hlGroup = chunk[2]
            table.insert(newVirtText, { chunkText, hlGroup })
            chunkWidth = vim.fn.strdisplaywidth(chunkText)
            -- str width returned from truncate() may less than 2nd argument, need padding
            if curWidth + chunkWidth < targetWidth then
              suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
            end
            break
          end
          curWidth = curWidth + chunkWidth
        end
        table.insert(newVirtText, { suffix, "MoreMsg" })
        return newVirtText
      end,
    },

    init = function()
      vim.o.foldenable = true
      vim.o.foldcolumn = "0" -- '0' is not bad
      vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
      vim.o.foldlevelstart = 99
      vim.opt.fillchars = {
        fold = " ",
        foldopen = "▾",
        foldsep = "│",
        foldclose = "▸",
      }
    end,

    config = function(_, opts)
      require("ufo").setup(opts)
      -- Ensure our ufo foldlevel is set for the buffer
      vim.api.nvim_create_autocmd("BufReadPre", {
        callback = function()
          vim.b.ufo_foldlevel = 0
        end,
      })

      ---@param num integer Set the fold level to this number
      local set_buf_foldlevel = function(num)
        vim.b.ufo_foldlevel = num
        require("ufo").closeFoldsWith(num)
      end

      ---@param num integer The amount to change the UFO fold level by
      local change_buf_foldlevel_by = function(num)
        local foldlevel = vim.b.ufo_foldlevel or 0
        -- Ensure the foldlevel can't be set negatively
        if foldlevel + num >= 0 then
          foldlevel = foldlevel + num
        else
          foldlevel = 0
        end
        set_buf_foldlevel(foldlevel)
      end

      -- Keymaps
      vim.keymap.set("n", "K", function()
        local winid = require("ufo").peekFoldedLinesUnderCursor()
        if not winid then
          vim.lsp.buf.hover()
        end
      end)

      -- stylua: ignore
      vim.keymap.set("n", "zM", function() set_buf_foldlevel(0) end, { desc = "[UFO] Close all folds" })
      vim.keymap.set("n", "zR", require("ufo").openAllFolds, { desc = "[UFO] Open all folds" })

      vim.keymap.set("n", "zm", function()
        local count = vim.v.count
        if count == 0 then
          count = 1
        end
        change_buf_foldlevel_by(-count)
      end, { desc = "[UFO] Fold More" })
      vim.keymap.set("n", "zr", function()
        local count = vim.v.count
        if count == 0 then
          count = 1
        end
        change_buf_foldlevel_by(count)
      end, { desc = "[UFO] Fold Less" })

      -- 99% sure `zS` isn't mapped by default
      vim.keymap.set("n", "zS", function()
        if vim.v.count == 0 then
          vim.notify("No foldlevel given to set!", vim.log.levels.WARN)
        else
          set_buf_foldlevel(vim.v.count)
        end
      end, { desc = "[UFO] Set foldlevel" })

      -- Delete some predefined keymaps as they are not compatible with nvim-ufo
      vim.keymap.set("n", "zE", "<NOP>", { desc = "Disabled" })
      vim.keymap.set("n", "zx", "<NOP>", { desc = "Disabled" })
      vim.keymap.set("n", "zX", "<NOP>", { desc = "Disabled" })
    end,
  },
}
