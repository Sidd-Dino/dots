return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            require("nvim-treesitter.configs").setup({
                ensure_installed = {
                    "awk",
                    "bash",
                    "c",
                    "diff",
                    "fish",
                    "haskell",
                    "lua",
                    "tmux", "toml",
                    "vim", "vimdoc",
                },

                ignore_install = { "javascript" },

                -- Install parsers synchronously (only applied to `ensure_installed`)
                sync_install = true,

                -- Automatically install missing parsers when entering buffer
                -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
                auto_install = true,


                highlight = {
                    enable = true,
                    additional_vim_regex_highlighting = { "markdown" },
                },

                indent = { enable = true },
            })
        end,
    },

    {
        "nvim-treesitter/nvim-treesitter-context",
        dependencies = { "nvim-treesitter/nvim-treesitter" },
        config = function(_, opts)
            require("treesitter-context").setup({
                enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
                max_lines = 8, -- How many lines the window should span. Values <= 0 mean no limit.
                min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
            })

            vim.keymap.set({ 'n' , 'v' }, '<leader>tc', function()
                require("treesitter-context").toggle()
            end, { desc = '[T]oggle treesitter-[C]ontext' })
        end,
    },
}
