local chunk = require("hlchunk")

chunk.setup({
    chunk = {
        enable = true,
        use_treesitter = true,
        notify = true, -- notify if some situation(like disable chunk mod double time)
        exclude_filetypes = {
            aerial = true,
            dashboard = true,
        },
        support_filetypes = {
            "*.lua",
            "*.js",
            "*.cpp",
            "*.json",
            "*.py",
            "*.cl",
        },
        chars = {
            horizontal_line = "─",
            vertical_line = "│",
            left_top = "╭",
            left_bottom = "╰",
            right_arrow = ">",
        },
        style = {
            { fg = "#806d9c" },
        },
    },

    indent = {
        enable = true,
        use_treesitter = false,
        chars = {
            "│",
        },
        style = {
            { fg = vim.fn.synIDattr(vim.fn.synIDtrans(vim.fn.hlID("Whitespace")), "fg", "gui") }
        },
    },

    line_num = {
        enable = true,
        use_treesitter = false,
        style = "#806d9c",
    },

    blank = {
        enable = true,
        chars = {
            "․",
        },
        style = {
            vim.fn.synIDattr(vim.fn.synIDtrans(vim.fn.hlID("Whitespace")), "fg", "gui"),
        },
    },
})
