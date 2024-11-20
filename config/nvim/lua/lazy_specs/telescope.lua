return {
    {
        'nvim-telescope/telescope.nvim',
        event = 'VimEnter',
        branch = '0.1.x',
        dependencies = {
            'nvim-lua/plenary.nvim',
            {
                'nvim-telescope/telescope-fzf-native.nvim',
                build = 'make',
                cond = function()
                    return vim.fn.executable 'make' == 1
                end,
            },
            { 'nvim-telescope/telescope-ui-select.nvim' },

            -- Useful for getting pretty icons, but requires a Nerd Font.
            { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
        },
        config = function()
            require('telescope').setup({
                extensions = {
                    ['ui-select'] = {
                        require('telescope.themes').get_dropdown(),
                    },
                    ['fzf'] = {
                        fuzzy = true,                    -- false will only do exact matching
                        override_generic_sorter = true,  -- override the generic sorter
                        override_file_sorter = true,     -- override the file sorter
                        case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
                                                         -- the default case_mode is "smart_case"
                    },
                },
            })

            -- Enable Telescope extensions if they are installed
            pcall(require('telescope').load_extension, 'fzf')
            pcall(require('telescope').load_extension, 'ui-select')

            local builtin = require('telescope.builtin')
            vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = 'Help' })
            vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = 'Keymaps' })
            vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = 'Files' })
            vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = 'Select Telescope' })
            vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = 'by Grep' })
            vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = 'Diagnostics' })
            vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = 'Resume' })
            vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = 'Recent Files ("." for repeat)' })
            vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '  Find existing buffers' })

            vim.keymap.set('n', '<leader>sw', function()
                local word = vim.fn.expand("<cword>")
                builtin.grep_string({ search = word })
            end, { desc = 'current Word' })

            vim.keymap.set('n', '<leader>sW', function()
                local word = vim.fn.expand("<cWORD>")
                builtin.grep_string({ search = word })
            end, { desc = 'current WORD' })

            vim.keymap.set('n', '<leader>s/', function()
                builtin.live_grep {
                    grep_open_files = true,
                    prompt_title = 'Live Grep in Open Files',
                }
            end, { desc = 'Search / in Open Files' })

            -- Shortcut for searching your Neovim configuration files
            vim.keymap.set('n', '<leader>sn', function()
                builtin.find_files { cwd = vim.fn.stdpath 'config' }
            end, { desc = 'Neovim files' })
        end
    },

}
