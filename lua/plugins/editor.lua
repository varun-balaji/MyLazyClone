local Util = require("util")

return {

  -- TODO check if we need this
  -- file explorer
  -- {
  --   "nvim-neo-tree/neo-tree.nvim",
  --   cmd = "Neotree",
  --   keys = {
  --     {
  --       "<leader>fe",
  --       function()
  --         require("neo-tree.command").execute({ toggle = true, dir = require("util").get_root() })
  --       end,
  --       desc = "Explorer NeoTree (root dir)",
  --     },
  --     {
  --       "<leader>fE",
  --       function()
  --         require("neo-tree.command").execute({ toggle = true, dir = vim.loop.cwd() })
  --       end,
  --       desc = "Explorer NeoTree (cwd)",
  --     },
  --     { "<leader>e", "<leader>fe", desc = "Explorer NeoTree (root dir)", remap = true },
  --     { "<leader>E", "<leader>fE", desc = "Explorer NeoTree (cwd)", remap = true },
  --   },
  --   deactivate = function()
  --     vim.cmd([[Neotree close]])
  --   end,
  --   init = function()
  --     vim.g.neo_tree_remove_legacy_commands = 1
  --     if vim.fn.argc() == 1 then
  --       local stat = vim.loop.fs_stat(vim.fn.argv(0))
  --       if stat and stat.type == "directory" then
  --         require("neo-tree")
  --       end
  --     end
  --   end,
  --   opts = {
  --     filesystem = {
  --       bind_to_cwd = false,
  --       follow_current_file = true,
  --       use_libuv_file_watcher = true,
  --     },
  --     window = {
  --       mappings = {
  --         ["<space>"] = "none",
  --       },
  --     },
  --     default_component_configs = {
  --       indent = {
  --         with_expanders = true, -- if nil and file nesting is enabled, will enable expanders
  --         expander_collapsed = "",
  --         expander_expanded = "",
  --         expander_highlight = "NeoTreeExpander",
  --       },
  --     },
  --   },
  --   config = function(_, opts)
  --     require("neo-tree").setup(opts)
  --     vim.api.nvim_create_autocmd("TermClose", {
  --       pattern = "*lazygit",
  --       callback = function()
  --         if package.loaded["neo-tree.sources.git_status"] then
  --           require("neo-tree.sources.git_status").refresh()
  --         end
  --       end,
  --     })
  --   end,
  -- },
  --
  -- -- search/replace in multiple files
  -- {
  --   "nvim-pack/nvim-spectre",
  --   -- stylua: ignore
  --   keys = {
  --     { "<leader>sr", function() require("spectre").open() end, desc = "Replace in files (Spectre)" },
  --   },
  -- },

  -- fuzzy finder
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    version = false, -- telescope did only one release, so use HEAD for now
    dependencies = {
      -- FZF for telescope
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        -- NOTE: If you are having trouble with this installation, refer to the README for telescope-fzf-native for more instructions.
        build = "make",
        cond = function()
          return vim.fn.executable("make") == 1
        end,
      },
    },
    keys = {
      -- [f]ind words
      { "<leader>/", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Fuzzy find in the current buffer" },
      {
        "<leader>fg",
        Util.telescope("live_grep", { search_dirs = { vim.fn.expand("%:p") } }),
        desc = "Grep (current buffer)",
      },
      { "<leader>fb", Util.telescope("live_grep", { grep_open_files = true }), desc = "Grep (open buffers)" },
      -- TODO figure out what the diff is between the root dir and cwd. Maybe change fc/sc to current buffer dir search?
      { "<leader>ff", Util.telescope("live_grep"), desc = "Grep (root dir)" },
      { "<leader>fc", Util.telescope("live_grep", { cwd = false }), desc = "Grep (cwd)" },
      {
        "<leader>fs",
        Util.telescope("lsp_document_symbols", {
          symbols = {
            "Class",
            "Function",
            "Method",
            "Constructor",
            "Interface",
            "Module",
            "Struct",
            "Trait",
            "Field",
            "Property",
          },
        }),
        desc = "Goto Symbol",
      },
      {
        "<leader>fw",
        Util.telescope("lsp_dynamic_workspace_symbols", {
          symbols = {
            "Class",
            "Function",
            "Method",
            "Constructor",
            "Interface",
            "Module",
            "Struct",
            "Trait",
            "Field",
            "Property",
          },
        }),
        desc = "Goto Symbol (Workspace)",
      },

      -- [s]earch files
      { "<leader>sb", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
      { "<leader>sf", Util.telescope("files"), desc = "Files (root dir)" },
      { "<leader>sc", Util.telescope("files", { cwd = false }), desc = "Files (cwd)" },
      { "<leader>sr", "<cmd>Telescope oldfiles<cr>", desc = "Recent files (root dir)" },
      { "<leader>sR", Util.telescope("oldfiles", { cwd = vim.loop.cwd() }), desc = "Recent files (cwd)" },

      -- [d]iagnostics
      { "<leader>dc", "<cmd>Telescope diagnostics bufnr=0<cr>", desc = "Current buffer diagnostics" },
      { "<leader>dw", "<cmd>Telescope diagnostics<cr>", desc = "Workspace diagnostics" },

      -- [g]it
      -- TODO add more git stuff
      { "<leader>gc", "<cmd>Telescope git_commits<CR>", desc = "commits" },
      { "<leader>gs", "<cmd>Telescope git_status<CR>", desc = "status" },

      -- [o]ther stuff
      { "<leader>:", "<cmd>Telescope command_history<cr>", desc = "Command History" },
      { "<leader>or", "<cmd>Telescope resume<cr>", desc = "Resume" },
      { "<leader>oa", "<cmd>Telescope autocommands<cr>", desc = "Auto Commands" },
      { "<leader>oc", "<cmd>Telescope commands<cr>", desc = "Commands" },
      { "<leader>oh", "<cmd>Telescope help_tags<cr>", desc = "Help Pages" },
      { "<leader>oH", "<cmd>Telescope highlights<cr>", desc = "Search Highlight Groups" },
      { "<leader>ok", "<cmd>Telescope keymaps<cr>", desc = "Key Maps" },
      { "<leader>oM", "<cmd>Telescope man_pages<cr>", desc = "Man Pages" },
      { "<leader>om", "<cmd>Telescope marks<cr>", desc = "Jump to Mark" },
      { "<leader>oo", "<cmd>Telescope vim_options<cr>", desc = "Options" },
      { "<leader>ow", Util.telescope("grep_string"), desc = "Word (root dir)" },
      { "<leader>oW", Util.telescope("grep_string", { cwd = false }), desc = "Word (cwd)" },
      { "<leader>oC", Util.telescope("colorscheme", { enable_preview = true }), desc = "Colorscheme with preview" },
    },
    opts = {
      defaults = {
        prompt_prefix = " ",
        selection_caret = " ",
        mappings = {
          i = {
            ["<C-w>"] = function(...)
              return require("trouble.providers.telescope").open_with_trouble(...)
            end,
            ["<C-W>"] = function(...)
              return require("trouble.providers.telescope").open_selected_with_trouble(...)
            end,
            ["<C-i>"] = function()
              Util.telescope("find_files", { no_ignore = true })()
            end,
            ["<C-h>"] = function()
              Util.telescope("find_files", { hidden = true })()
            end,
            ["<C-Down>"] = function(...)
              return require("telescope.actions").cycle_history_next(...)
            end,
            ["<C-Up>"] = function(...)
              return require("telescope.actions").cycle_history_prev(...)
            end,
            ["<C-f>"] = function(...)
              return require("telescope.actions").preview_scrolling_down(...)
            end,
            ["<C-b>"] = function(...)
              return require("telescope.actions").preview_scrolling_up(...)
            end,
            ["<C-Q>"] = function(...) -- Replace default mapping of <M-q>.
              return require("telescope.actions").send_selected_to_qflist(...)
            end,
          },
          n = {
            ["q"] = function(...)
              return require("telescope.actions").close(...)
            end,
          },
        },
      },
    },
  },

  -- Telescope file browser
  {
    "nvim-telescope/telescope-file-browser.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {},
    -- Don't think it should be verylazy
    -- event = "VeryLazy",
    config = function(_, opts)
      require("telescope").setup(opts)
      require("telescope").load_extension("file_browser")
    end,
    keys = {
      { "<leader>ee", "<Cmd>Telescope file_browser<CR>", desc = "File browser" },
      {
        "<leader>ec",
        "<Cmd>Telescope file_browser path=%:p:h select_buffer=true<CR>",
        desc = "File browser (from buffer path)",
      },
    },
  },

  -- easily jump to any location and enhanced f/t motions for Leap
  -- {
  --   "ggandor/flit.nvim",
  --   keys = function()
  --     ---@type LazyKeys[]
  --     local ret = {}
  --     for _, key in ipairs({ "f", "F", "t", "T" }) do
  --       ret[#ret + 1] = { key, mode = { "n", "x", "o" }, desc = key }
  --     end
  --     return ret
  --   end,
  --   opts = { labeled_modes = "nx" },
  -- },
  -- {
  --   "ggandor/leap.nvim",
  --   keys = {
  --     { "s", mode = { "n", "x", "o" }, desc = "Leap forward to" },
  --     { "S", mode = { "n", "x", "o" }, desc = "Leap backward to" },
  --     { "gs", mode = { "n", "x", "o" }, desc = "Leap from windows" },
  --   },
  --   config = function(_, opts)
  --     local leap = require("leap")
  --     for k, v in pairs(opts) do
  --       leap.opts[k] = v
  --     end
  --     leap.add_default_mappings(true)
  --     vim.keymap.del({ "x", "o" }, "x")
  --     vim.keymap.del({ "x", "o" }, "X")
  --   end,
  -- },

  -- which-key
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      plugins = { spelling = true },
      defaults = {
        mode = { "n", "v" },
        ["g"] = { name = "+goto" },
        ["gz"] = { name = "+surround" },
        ["]"] = { name = "+next" },
        ["["] = { name = "+prev" },
        ["<leader><tab>"] = { name = "+tabs" },
        ["<leader>b"] = { name = "+buffer" },
        ["<leader>c"] = { name = "+code" },
        ["<leader>d"] = { name = "+diagnostics" },
        ["<leader>f"] = { name = "+find word" },
        ["<leader>g"] = { name = "+git" },
        ["<leader>gh"] = { name = "+hunks" },
        ["<leader>q"] = { name = "+quit/session" },
        ["<leader>s"] = { name = "+search files" },
        ["<leader>u"] = { name = "+ui" },
        ["<leader>w"] = { name = "+windows" },
        ["<leader>x"] = { name = "+diagnostics/quickfix" },
      },
    },
    config = function(_, opts)
      local wk = require("which-key")
      wk.setup(opts)
      wk.register(opts.defaults)
    end,
  },

  -- git signs
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      signs = {
        add = { text = "▎" },
        change = { text = "▎" },
        -- TODO think about what signs to change these to
        delete = { text = "" },
        topdelete = { text = "" },
        changedelete = { text = "▎" },
        untracked = { text = "▎" },
      },
      on_attach = function(buffer)
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, desc)
          vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
        end

        -- stylua: ignore start
        map("n", "]h", gs.next_hunk, "Next Hunk")
        map("n", "[h", gs.prev_hunk, "Prev Hunk")
        map({ "n", "v" }, "<leader>ghs", ":Gitsigns stage_hunk<CR>", "Stage Hunk")
        map({ "n", "v" }, "<leader>ghr", ":Gitsigns reset_hunk<CR>", "Reset Hunk")
        map("n", "<leader>ghS", gs.stage_buffer, "Stage Buffer")
        map("n", "<leader>ghu", gs.undo_stage_hunk, "Undo Stage Hunk")
        map("n", "<leader>ghR", gs.reset_buffer, "Reset Buffer")
        map("n", "<leader>ghp", gs.preview_hunk, "Preview Hunk")
        map("n", "<leader>ghb", function() gs.blame_line({ full = true }) end, "Blame Line")
        map("n", "<leader>ghd", gs.diffthis, "Diff This")
        map("n", "<leader>ghD", function() gs.diffthis("~") end, "Diff This ~")
        map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "GitSigns Select Hunk")
      end,
    },
  },

  -- TODO add more functionalities and keybinds
  -- Git goodness
  {
    "tpope/vim-fugitive",
    event = { "BufReadPre", "BufNewFile" },
  },
  {
    "tpope/vim-rhubarb",
    event = { "BufReadPre", "BufNewFile" },
  },

  -- Detect tabstop and shiftwidth automatically
  {
    "tpope/vim-sleuth",
    event = { "BufReadPre", "BufNewFile" },
  },

  -- TODO check if we need this
  -- references
  -- {
  --   "RRethy/vim-illuminate",
  --   event = { "BufReadPost", "BufNewFile" },
  --   opts = { delay = 200 },
  --   config = function(_, opts)
  --     require("illuminate").configure(opts)
  --
  --     local function map(key, dir, buffer)
  --       vim.keymap.set("n", key, function()
  --         require("illuminate")["goto_" .. dir .. "_reference"](false)
  --       end, { desc = dir:sub(1, 1):upper() .. dir:sub(2) .. " Reference", buffer = buffer })
  --     end
  --
  --     map("]]", "next")
  --     map("[[", "prev")
  --
  --     -- also set it after loading ftplugins, since a lot overwrite [[ and ]]
  --     vim.api.nvim_create_autocmd("FileType", {
  --       callback = function()
  --         local buffer = vim.api.nvim_get_current_buf()
  --         map("]]", "next", buffer)
  --         map("[[", "prev", buffer)
  --       end,
  --     })
  --   end,
  --   keys = {
  --     { "]]", desc = "Next Reference" },
  --     { "[[", desc = "Prev Reference" },
  --   },
  -- },

  -- buffer remove
  {
    "echasnovski/mini.bufremove",
    -- stylua: ignore
    keys = {
      { "<leader>bd", function() require("mini.bufremove").delete(0, false) end, desc = "Delete Buffer" },
      { "<leader>bD", function() require("mini.bufremove").delete(0, true) end, desc = "Delete Buffer (Force)" },
    },
  },

  -- TODO check if we need this
  -- better diagnostics list and others
  -- {
  --   "folke/trouble.nvim",
  --   cmd = { "TroubleToggle", "Trouble" },
  --   opts = { use_diagnostic_signs = true },
  --   keys = {
  --     { "<leader>xx", "<cmd>TroubleToggle document_diagnostics<cr>", desc = "Document Diagnostics (Trouble)" },
  --     { "<leader>xX", "<cmd>TroubleToggle workspace_diagnostics<cr>", desc = "Workspace Diagnostics (Trouble)" },
  --     { "<leader>xL", "<cmd>TroubleToggle loclist<cr>", desc = "Location List (Trouble)" },
  --     { "<leader>xQ", "<cmd>TroubleToggle quickfix<cr>", desc = "Quickfix List (Trouble)" },
  --     {
  --       "[q",
  --       function()
  --         if require("trouble").is_open() then
  --           require("trouble").previous({ skip_groups = true, jump = true })
  --         else
  --           vim.cmd.cprev()
  --         end
  --       end,
  --       desc = "Previous trouble/quickfix item",
  --     },
  --     {
  --       "]q",
  --       function()
  --         if require("trouble").is_open() then
  --           require("trouble").next({ skip_groups = true, jump = true })
  --         else
  --           vim.cmd.cnext()
  --         end
  --       end,
  --       desc = "Next trouble/quickfix item",
  --     },
  --   },
  -- },

  -- todo comments
  {
    "folke/todo-comments.nvim",
    cmd = { "TodoTrouble", "TodoTelescope" },
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      -- I don't want signs in the column
      signs = false,
      highlight = {
        multiline = false,
        before = "fg",
        keyword = "bg",
        pattern = [[.*<(KEYWORDS)\s*]], -- pattern or table of patterns, used for highlighting (vim regex)
      },
      search = {
        pattern = [[\b(KEYWORDS)\b]], -- match without the extra colon. Keep an eye out for false positives
      },
    },
    config = true,
    -- stylua: ignore
    keys = {
      { "]t", function() require("todo-comments").jump_next() end, desc = "Next todo comment" },
      { "[t", function() require("todo-comments").jump_prev() end, desc = "Previous todo comment" },
      -- TODO figure these out if we use Trouble.nvim
      -- { "<leader>xt", "<cmd>TodoTrouble<cr>", desc = "Todo (Trouble)" },
      -- { "<leader>xT", "<cmd>TodoTrouble keywords=TODO,FIX,FIXME<cr>", desc = "Todo/Fix/Fixme (Trouble)" },
      { "<leader>st", "<cmd>TodoTelescope<cr>", desc = "Todo" },
      { "<leader>sT", "<cmd>TodoTelescope keywords=TODO,FIX,FIXME<cr>", desc = "Todo/Fix/Fixme" },
    },
  },
}
