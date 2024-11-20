-- colorscheme is set in lua/lazy_init.lua
return {
    {
        "rose-pine/neovim",
        name = "rose-pine",
        lazy=true,
        priority=1000,
        config = function ()
            vim.opt.laststatus = 2 -- Or 3 for global statusline
            vim.opt.statusline = " %f %m %= %l:%c ♥ "

            require("rose-pine").setup({
                variant = "main",
                -- styles = {
                --     italic = false,
                -- },
                highlight_groups = {
                    -- Stuff stolen from wiki/Recipes
                    -- Lovely Statusline
                    StatusLine = { fg = "love", bg = "love", blend = 10 },
                    StatusLineNC = { fg = "subtle", bg = "surface" },

                    -- Leafy Search
                    CurSearch = { fg = "base", bg = "leaf", inherit = false },
                    Search = { fg = "text", bg = "leaf", blend = 20, inherit = false },
                    IncSearch = { fg = "text", bg = "leaf", blend = 20, inherit = false },

                    -- BorderLess Telescope
                    TelescopeBorder = { fg = "overlay", bg = "overlay" },
                    TelescopeNormal = { fg = "subtle", bg = "overlay" },
                    TelescopeSelection = { fg = "text", bg = "highlight_med" },
                    TelescopeSelectionCaret = { fg = "love", bg = "highlight_med" },
                    TelescopeMultiSelection = { fg = "text", bg = "highlight_high" },

                    TelescopeTitle = { fg = "base", bg = "love" },
                    TelescopePromptTitle = { fg = "base", bg = "pine" },
                    TelescopePreviewTitle = { fg = "base", bg = "iris" },

                    TelescopePromptNormal = { fg = "text", bg = "surface" },
                    TelescopePromptBorder = { fg = "surface", bg = "surface" },
                },
            })
        end
    },

    {
        "folke/tokyonight.nvim",
        lazy=true,
        priority=1000,
        opts = {
            style = "storm",
            terminal_colors = true,
            styles = {
                comment = { italic = false },
                keywords = { italic = false },
                sidebars = "dark",
                floats = "dark",
            },
        },
    }
}
