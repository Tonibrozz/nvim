-- Установка Lazy.nvim.
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Основные настройки
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.mouse = "a"
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = false
vim.opt.wrap = true
vim.opt.breakindent = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.termguicolors = true
vim.opt.cursorline = true
vim.opt.signcolumn = "yes"
vim.opt.clipboard = "unnamedplus"
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Включение вкладок
vim.opt.showtabline = 2 -- Всегда показывать панель вкладок

-- Центрирование интерфейса
vim.opt.winblend = 20
vim.opt.pumblend = 20
vim.opt.cmdheight = 1

-- Отключение навязчивых подсказок
vim.o.completeopt = "menuone,noinsert,noselect"
vim.o.shortmess = vim.o.shortmess .. "c"

-- Глобальные переменные для ключевых映射
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Плагины
require("lazy").setup({
  -- Ваши плагины из Vim
  {
    "scrooloose/nerdtree",
    config = function()
      -- Настройки NERDTree
      vim.g.NERDTreeShowHidden = 1
      vim.g.NERDTreeMinimalUI = 1
      vim.g.NERDTreeIgnore = { '^node_modules$', '^.git$', '^__pycache__$' }
    end
  },
  {
    "preservim/nerdcommenter",
    config = function()
      -- Настройки NERDCommenter
      vim.g.NERDSpaceDelims = 1
      vim.g.NERDCompactSexyComs = 1
      vim.g.NERDDefaultAlign = 'left'
    end
  },
  {
    "ryanoasis/vim-devicons",
    config = function()
      -- Настройки иконок
      vim.g.WebDevIconsUnicodeDecorateFolderNodes = 1
      vim.g.DevIconsEnableFoldersOpenClose = 1
    end
  },
  {
    "vim-airline/vim-airline",
    config = function()
      -- Настройки Airline
      vim.g.airline_powerline_fonts = 1
      vim.g.airline_extensions_tabline_enabled = 1
      vim.g.airline_theme = 'deus'
    end
  },
  {
    "vim-airline/vim-airline-themes"
  },
  {
    "neoclide/coc.nvim",
    branch = "release",
    build = "npm install",
    config = function()
      -- Настройки CoC
      vim.g.coc_global_extensions = {
        'coc-json',
        'coc-tsserver',
        'coc-pyright',
        'coc-rust-analyzer',
        'coc-html',
        'coc-css',
        'coc-lua'
      }
    end
  },

  -- Улучшенные иконки для Neovim
  {
    "kyazdani42/nvim-web-devicons",
    config = function()
      require("nvim-web-devicons").setup({
        default = true,
      })
    end,
  },

  -- Плавный скроллинг
  {
    "karb94/neoscroll.nvim",
    config = function()
      require("neoscroll").setup()
    end
  },

  -- Подсветка цветов в коде
  {
    "norcalli/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup()
    end
  },

  -- Мультикурсор как в VSCode
  {
    "mg979/vim-visual-multi",
    init = function()
      vim.g.VM_maps = {
        ["Find Under"] = "<C-n>",
        ["Find Subword Under"] = "<C-n>",
      }
    end,
  },

  -- GitHub Copilot
  {
    "github/copilot.vim",
    config = function()
      vim.keymap.set('i', '<C-J>', 'copilot#Accept("\\<CR>")', { expr = true, replace_keycodes = false })
      vim.g.copilot_no_tab_map = true
    end,
  },

  -- Цветовая схема
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("tokyonight").setup({
        style = "night",
        transparent = true,
        terminal_colors = true,
      })
      vim.cmd.colorscheme("tokyonight")
    end,
  },

  -- Красивые вкладки
  {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = "nvim-tree/nvim-web-devicons",
    config = function()
      require("bufferline").setup({
        options = {
          mode = "tabs", -- Режим вкладок вместо буферов
          style_preset = require("bufferline").style_preset.minimal,
          themable = true,
          numbers = "ordinal",
          close_command = "bdelete! %d",
          right_mouse_command = "bdelete! %d",
          left_mouse_command = "buffer %d",
          middle_mouse_command = nil,
          indicator = {
            style = "underline",
          },
          buffer_close_icon = "",
          modified_icon = "●",
          close_icon = "",
          left_trunc_marker = "",
          right_trunc_marker = "",
          max_name_length = 18,
          max_prefix_length = 15,
          truncate_names = true,
          tab_size = 18,
          diagnostics = "nvim_lsp",
          diagnostics_update_in_insert = false,
          offsets = {
            {
              filetype = "neo-tree",
              text = "File Explorer",
              highlight = "Directory",
              text_align = "left",
            },
          },
          color_icons = true,
          show_buffer_icons = true,
          show_buffer_close_icons = true,
          show_close_icon = true,
          show_tab_indicators = true,
          persist_buffer_sort = true,
          separator_style = "thin",
          enforce_regular_tabs = true,
          always_show_bufferline = true,
        },
      })
    end,
  },

  -- Файловый менеджер
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    config = function()
      require("neo-tree").setup({
        close_if_last_window = true,
        popup_border_style = "rounded",
        enable_git_status = true,
        enable_diagnostics = true,
        filesystem = {
          filtered_items = {
            visible = true,
            hide_dotfiles = false,
            hide_gitignored = true,
          },
          follow_current_file = {
            enabled = true,
          },
        },
        window = {
          position = "left",
          width = 35,
        },
      })
    end,
  },

  -- Стартовый экран
  {
    "goolord/alpha-nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      local alpha = require("alpha")
      local dashboard = require("alpha.themes.dashboard")

      -- Ваш баннер
      dashboard.section.header.val = {
        "██████  ██░ ██  ▄▄▄      ▓█████▄  ▒█████   █     █░",
        "▒██    ▒ ▓██░ ██▒▒████▄    ▒██▀ ██▌▒██▒  ██▒▓█░ █ ░█░",
        "░ ▓██▄   ▒██▀▀██░▒██  ▀█▄  ░██   █▌▒██░  ██▒▒█░ █ ░█ ",
        "  ▒   ██▒░▓█ ░██ ░██▄▄▄▄██ ░▓█▄   ▌▒██   ██░░█░ █ ░█ ",
        "▒██████▒▒░▓█▒░██▓ ▓█   ▓██▒░▒████▓ ░ ████▓▒░░░██▒██▓ ",
        "▒ ▒▓▒ ▒ ░ ▒ ░░▒░▒ ▒▒   ▓▒█░ ▒▒▓  ▒ ░ ▒░▒░▒░ ░ ▓░▒ ▒  ",
        "░ ░▒  ░ ░ ▒ ░▒░ ░  ▒   ▒▒ ░ ░ ▒  ▒   ░ ▒ ▒░   ▒ ░ ░  ",
        "░  ░  ░   ░  ░░ ░  ░   ▒    ░ ░  ░ ░ ░ ░ ▒    ░   ░  ",
        "      ░   ░  ░  ░      ░  ░   ░        ░ ░      ░    ",
        "                            ░                        ",
      }

      -- Кнопки меню
      dashboard.section.buttons.val = {
        dashboard.button("e", "  Новый файл", ":ene <BAR> startinsert <CR>"),
        dashboard.button("f", "  Найти файл", ":Telescope find_files<CR>"),
        dashboard.button("r", "  Недавние файлы", ":Telescope oldfiles<CR>"),
        dashboard.button("t", "  Найти текст", ":Telescope live_grep<CR>"),
        dashboard.button("c", "  Конфигурация", ":e ~/.config/nvim/init.lua<CR>"),
        dashboard.button("m", "  Вернуться в меню", ":Alpha<CR>"),
        dashboard.button("q", "  Выход", ":qa<CR>"),
      }

      -- Футер
      dashboard.section.footer.val = "Добро пожаловать в Neovim! Используй Tab для навигации по вкладкам"

      alpha.setup(dashboard.config)
    end,
  },

  -- Поиск файлов
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.5",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-ui-select.nvim",
    },
    config = function()
      local telescope = require("telescope")
      telescope.setup({
        defaults = {
          layout_strategy = "vertical",
          layout_config = {
            vertical = { width = 0.9, height = 0.9 },
          },
          border = true,
          borderchars = {
            prompt = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
            results = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
            preview = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
          },
        },
        pickers = {
          find_files = {
            theme = "dropdown",
          },
          live_grep = {
            theme = "dropdown",
          },
        },
      })

      telescope.load_extension("ui-select")

      -- Клавиши для Telescope (как в VSCode)
      local builtin = require("telescope.builtin")
      vim.keymap.set("n", "<C-p>", builtin.find_files, { desc = "Find files" })
      vim.keymap.set("n", "<C-f>", builtin.live_grep, { desc = "Live grep" })
      vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find files" })
      vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Live grep" })
      vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Find buffers" })
      vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Help tags" })
    end,
  },

  -- Статусная строка
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lualine").setup({
        options = {
          theme = "tokyonight",
          component_separators = { left = "│", right = "│" },
          section_separators = { left = "", right = "" },
        },
        sections = {
          lualine_a = { "mode" },
          lualine_b = { "branch", "diff", "diagnostics" },
          lualine_c = { "filename" },
          lualine_x = { "encoding", "fileformat", "filetype" },
          lualine_y = { "progress" },
          lualine_z = { "location" },
        },
      })
    end,
  },

  -- Дерево LSP и навигация
  {
    "simrat39/symbols-outline.nvim",
    config = function()
      require("symbols-outline").setup({
        position = "right",
        width = 30,
        show_guides = true,
      })
    end,
  },

  -- Which-Key (подсказки комбинаций клавиш)
  {
    "folke/which-key.nvim",
    config = function()
      local wk = require("which-key")
      wk.setup({
        plugins = {
          spelling = { enabled = true },
        },
        window = {
          border = "rounded",
          position = "bottom",
          margin = { 1, 0, 1, 0 },
        },
      })

      -- Подсказки для префиксов
      wk.register({
        f = {
          name = "File",
          f = "Find files",
          g = "Live grep",
          b = "Find buffers",
          h = "Help tags",
        },
        e = { "Toggle file explorer" },
        o = { "Toggle symbols outline" },
        s = { "Search & replace" },
        w = { "Save file" },
        m = { "Return to main menu" },
        t = {
          name = "Tabs",
          n = "New tab",
          c = "Close tab",
          h = "Previous tab",
          l = "Next tab",
          x = "Close current tab",
        },
        c = {
          name = "Close",
          c = "Close window",
          e = "Close explorer",
          o = "Close outline",
          b = "Close buffer",
          a = "Close all",
        },
        g = {
          name = "Git",
          s = "Git status",
          b = "Git blame",
          d = "Git diff",
        },
        d = {
          name = "Debug",
        },
      }, { prefix = "<leader>" })
    end,
  },

  -- LSP и автодополнение
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/nvim-cmp",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
      "rafamadriz/friendly-snippets",
    },
    config = function()
      -- Mason (установка LSP серверов)
      require("mason").setup()
      require("mason-lspconfig").setup({
        ensure_installed = { "lua_ls", "rust_analyzer", "pyright", "tsserver", "bashls", "html", "cssls" },
      })

      -- LSP настройки
      local lspconfig = require("lspconfig")
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- Настройки для разных LSP серверов
      lspconfig.lua_ls.setup({
        capabilities = capabilities,
        settings = {
          Lua = {
            diagnostics = {
              globals = { "vim" }
            }
          }
        }
      })
      lspconfig.rust_analyzer.setup({ capabilities = capabilities })
      lspconfig.pyright.setup({ capabilities = capabilities })
      lspconfig.tsserver.setup({ capabilities = capabilities })

      -- Глобальные mapping для LSP
      vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, { desc = "Open diagnostic" })
      vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = "Previous diagnostic" })
      vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = "Next diagnostic" })
      vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, { desc = "Diagnostic list" })

      -- Автодополнение (cmp)
      local cmp = require("cmp")
      local luasnip = require("luasnip")

      require("luasnip.loaders.from_vscode").lazy_load()

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
        }, {
          { name = "buffer" },
          { name = "path" },
        }),
      })
    end,
  },

  -- Комментарии
  {
    "numToStr/Comment.nvim",
    config = function()
      require("Comment").setup()
    end,
  },

  -- Авто-парные скобки
  {
    "windwp/nvim-autopairs",
    config = function()
      local npairs = require("nvim-autopairs")
      npairs.setup({
        check_ts = true,
      })

      -- Интеграция с cmp
      local cmp_autopairs = require('nvim-autopairs.completion.cmp')
      local cmp = require('cmp')
      cmp.event:on(
        'confirm_done',
        cmp_autopairs.on_confirm_done()
      )
    end,
  },

  -- Подсветка синтаксиса
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          "lua", "rust", "python", "javascript", "typescript",
          "html", "css", "json", "yaml", "markdown", "bash"
        },
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        },
        indent = { enable = true },
      })
    end,
  },

  -- Git интеграция
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup({
        signs = {
          add = { text = "│" },
          change = { text = "│" },
          delete = { text = "_" },
          topdelete = { text = "‾" },
          changedelete = { text = "~" },
        },
      })
    end,
  },

  -- Поиск и замена
  {
    "windwp/nvim-spectre",
    config = function()
      require("spectre").setup()
    end,
  },

  -- Терминал
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function()
      require("toggleterm").setup({
        open_mapping = [[<c-\>]],
        direction = "float",
        float_opts = {
          border = "curved",
        },
      })
    end,
  },

  -- Dashboard для быстрых действий
  {
    "natecraddock/sessions.nvim",
    config = function()
      require("sessions").setup()
    end,
  },

  -- Notifications
  {
    "rcarriga/nvim-notify",
    config = function()
      vim.notify = require("notify")
    end,
  },
})

-- === КЛАВИШИ ДЛЯ VIM ПЛАГИНОВ === --

-- NERDTree
vim.keymap.set("n", "<leader>nt", ":NERDTreeToggle<CR>", { desc = "Toggle NERDTree" })
vim.keymap.set("n", "<leader>nf", ":NERDTreeFind<CR>", { desc = "Find file in NERDTree" })

-- CoC настройки
vim.keymap.set("i", "<Tab>", "coc#pum#visible() ? coc#pum#confirm() : \"\\<Tab>\"",
  { expr = true, desc = "CoC complete" })

-- === УПРАВЛЕНИЕ ВКЛАДКАМИ === --
vim.keymap.set("n", "<Tab>", ":BufferLineCycleNext<CR>", { desc = "Next tab" })
vim.keymap.set("n", "<S-Tab>", ":BufferLineCyclePrev<CR>", { desc = "Previous tab" })

-- Создание и закрытие вкладок
vim.keymap.set("n", "<leader>tn", ":tabnew<CR>", { desc = "New tab" })
vim.keymap.set("n", "<leader>tx", ":tabclose<CR>", { desc = "Close tab" })

-- Быстрая навигация по вкладкам
for i = 1, 9 do
  vim.keymap.set("n", "<leader>" .. i, ":BufferLineGoToBuffer " .. i .. "<CR>", { desc = "Go to tab " .. i })
end

-- Клавиши для навигации (как в VSCode)
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Go to left window" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Go to down window" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Go to up window" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Go to right window" })

-- Ресайз окон с Ctrl+стрелки
vim.keymap.set("n", "<C-Up>", "<cmd>resize +2<CR>", { desc = "Increase window height" })
vim.keymap.set("n", "<C-Down>", "<cmd>resize -2<CR>", { desc = "Decrease window height" })
vim.keymap.set("n", "<C-Left>", "<cmd>vertical resize -2<CR>", { desc = "Decrease window width" })
vim.keymap.set("n", "<C-Right>", "<cmd>vertical resize +2<CR>", { desc = "Increase window width" })

-- === VSCode-like КОМБИНАЦИИ === --
vim.keymap.set({ "n", "i", "v" }, "<C-s>", "<cmd>w<CR>", { desc = "Save file" })
vim.keymap.set("v", "<C-c>", '"+y', { desc = "Copy to clipboard" })
vim.keymap.set({ "n", "i" }, "<C-v>", '"+p', { desc = "Paste from clipboard" })
vim.keymap.set("v", "<C-v>", '"+p', { desc = "Paste from clipboard" })
vim.keymap.set("v", "<C-x>", '"+d', { desc = "Cut to clipboard" })
vim.keymap.set("n", "<C-a>", "ggVG", { desc = "Select all" })
vim.keymap.set({ "n", "i" }, "<C-z>", "<cmd>undo<CR>", { desc = "Undo" })
vim.keymap.set({ "n", "i" }, "<C-y>", "<cmd>redo<CR>", { desc = "Redo" })

-- Основные команды
vim.keymap.set("n", "<leader>e", ":Neotree toggle<CR>", { desc = "Toggle file explorer" })
vim.keymap.set("n", "<leader>o", ":SymbolsOutline<CR>", { desc = "Toggle symbols outline" })
vim.keymap.set("n", "<leader>w", ":w<CR>", { desc = "Save file" })
vim.keymap.set("n", "<leader>q", ":q<CR>", { desc = "Quit" })
vim.keymap.set("n", "<leader>tt", ":ToggleTerm<CR>", { desc = "Toggle terminal" })

-- Комментарии
vim.keymap.set({ "n", "v" }, "<C-/>", "gcc", { remap = true, desc = "Toggle comment" })
vim.keymap.set("i", "<C-/>", "<Esc>gcci", { desc = "Toggle comment" })

-- LSP mapping
vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { desc = "Go to declaration" })
vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = "Go to definition" })
vim.keymap.set('n', 'K', vim.lsp.buf.hover, { desc = "Hover documentation" })
vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, { desc = "Go to implementation" })
vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, { desc = "Signature help" })
vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, { desc = "Rename" })
vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, { desc = "Code action" })
vim.keymap.set('n', 'gr', vim.lsp.buf.references, { desc = "References" })
vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, { desc = "Format" })

-- === ВОЗВРАТ В МЕНЮ === --
vim.keymap.set("n", "<leader>m", ":Alpha<CR>", { desc = "Return to main menu" })

-- Безопасное управление шрифтом
local function change_font_size(delta)
  if vim.fn.has('gui_running') == 1 then
    vim.cmd('set guifont=' .. vim.o.guifont .. ':h' .. (vim.o.guifont:match(':h(%d+)') or 12 + delta))
  end
end

vim.keymap.set('n', '<A-i>', function() change_font_size(1) end, { desc = 'Increase font size' })
vim.keymap.set('n', '<A-d>', function() change_font_size(-1) end, { desc = 'Decrease font size' })

-- === АВТОКОМАНДЫ === --


-- Автоматическое включение Copilot при запуске
vim.api.nvim_create_autocmd("VimEnter", {
  pattern = "*",
  callback = function()
    -- Ждем немного чтобы все плагины загрузились
    vim.defer_fn(function()
      -- Проверяем доступность Copilot и включаем его
      if vim.fn.exists(':Copilot') > 0 then
        vim.cmd('Copilot enable')
        print('🤖 Copilot автоматически включен')
      else
        print('⚠️ Copilot не доступен')
      end
    end, 1000) -- Задержка 1 секунда
  end,
})

-- Автосохранение
vim.api.nvim_create_autocmd({ "FocusLost", "BufLeave" }, {
  callback = function()
    if vim.bo.modified and not vim.bo.readonly then
      vim.cmd('silent! write')
    end
  end,
})

-- Автоформатирование при сохранении
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  callback = function()
    vim.lsp.buf.format({ async = false })
  end,
})

-- Стартовый экран
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    if vim.fn.argc() == 0 then
      require("alpha").start(true)
    end
  end,
})




-- Подсветка на yank
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank({ timeout = 300 })
  end,
})

-- Убрать всплывающие окна диагностики
vim.diagnostic.config({
  virtual_text = false,
  signs = true,
  underline = true,
  update_in_insert = false,
})
