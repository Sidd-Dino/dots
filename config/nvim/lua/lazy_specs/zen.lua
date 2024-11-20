return {
    "folke/zen-mode.nvim",
    config = function()
        vim.keymap.set("n", "<leader>tz", function()
            require("zen-mode").setup {
                window = {
                    width = 80,
                },
            }
            require("zen-mode").toggle()
        end, { desc = 'zen mode', })


        vim.keymap.set("n", "<leader>tZ", function()
            require("zen-mode").setup {
                window = {
                    width = 80,
                },
                plugins = {
                    tmux = { enabled = true, },
                    alacritty = {
                        enabled = true,
                        font = "10",
                    },
                },
            }
            require("zen-mode").toggle()
        end, { desc = 'ZEN mode', })
    end,
}
