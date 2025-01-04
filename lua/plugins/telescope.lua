return {
  'nvim-telescope/telescope.nvim',
  event = 'VimEnter',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-treesitter/nvim-treesitter',
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'make',
      cond = function()
        return vim.fn.executable 'make' == 1
      end,
    },
    { 'nvim-telescope/telescope-ui-select.nvim' },
    { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
  },
  config = function()
    -- Two important keymaps to use while in Telescope are:
    --  - Insert mode: <c-/>
    --  - Normal mode: ?
    --
    -- This opens a window that shows you all of the keymaps for the current
    -- Telescope picker. This is really useful to discover what Telescope can
    -- do as well as how to actually do it!

    -- [[ Configure Telescope ]]
    -- See `:help telescope` and `:help telescope.setup()`
    require('telescope').setup {
      -- You can put your default mappings / updates / etc. in here
      --  All the info you're looking for is in `:help telescope.setup()`
      --
      -- defaults = {
      --   mappings = {
      --     i = { ['<c-enter>'] = 'to_fuzzy_refine' },
      --   },
      -- },
      -- pickers = {}
      defaults = {
        prompt_prefix = '   ',
        selection_caret = ' ',
        entry_prefix = ' ',
        sorting_strategy = 'ascending',
        layout_config = {
          horizontal = {
            prompt_position = 'top',
            preview_width = 0.6,
          },
          width = 0.9,
          height = 0.8,
        },
        mappings = {
          n = { ['q'] = require('telescope.actions').close },
        },
      },
      extensions = {
        ['ui-select'] = {
          require('telescope.themes').get_dropdown(),
        },
      },
    }

    -- Enable Telescope extensions if they are installed
    pcall(require('telescope').load_extension, 'fzf')
    pcall(require('telescope').load_extension, 'ui-select')

    -- See `:help telescope.builtin`
    local builtin = require 'telescope.builtin'
    vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'telescope [F]ind [H]elp' })
    vim.keymap.set('n', '<leader>fk', builtin.keymaps, { desc = 'telescope [F]ind [K]eymaps' })
    vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'telescope [F]ind [F]iles' })
    vim.keymap.set('n', '<leader>fs', builtin.builtin, { desc = 'telescope [F]ind [S]elect Telescope' })
    vim.keymap.set('n', '<leader>fw', builtin.grep_string, { desc = 'telescope [F]ind current [W]ord' })
    vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'telescope [F]ind by [G]rep' })
    vim.keymap.set('n', '<leader>fd', builtin.diagnostics, { desc = 'telescope [F]ind [D]iagnostics' })
    vim.keymap.set('n', '<leader>fr', builtin.resume, { desc = 'telescope [F]ind [R]esume' })
    vim.keymap.set('n', '<leader>fo', builtin.oldfiles, { desc = 'telescope [F]ind [O]ld Files ("." for repeat)' })
    vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'telescope [F]ind existing [B]uffers' })

    -- Slightly advanced example of overriding default behavior and theme
    vim.keymap.set('n', '<leader>fc', function()
      -- You can pass additional configuration to Telescope to change the theme, layout, etc.
      builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
        winblend = 10,
        previewer = false,
      })
    end, { desc = '[F]uzzily search in [C]urrent buffer' })

    -- It's also possible to pass additional configuration options.
    --  See `:help telescope.builtin.live_grep()` for information about particular keys
    vim.keymap.set('n', '<leader>f/', function()
      builtin.live_grep {
        grep_open_files = true,
        prompt_title = 'Live Grep in Open Files',
      }
    end, { desc = 'telescope [F]ind [/] in Open Files' })

    -- Shortcut for searching your Neovim configuration files
    vim.keymap.set('n', '<leader>fn', function()
      builtin.find_files { cwd = vim.fn.stdpath 'config' }
    end, { desc = 'telescope [F]ind [N]eovim files' })

    vim.keymap.set('n', '<leader>fa', '<cmd>Telescope find_files follow=true no_ignore=true hidden=true<CR>', { desc = 'telescope find all files' })
  end,
}
