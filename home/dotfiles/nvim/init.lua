local function clear_bg()
    for _, group in ipairs({ "Normal", "NormalNC", "NormalFloat", "SignColumn", "EndOfBuffer" }) do
        vim.api.nvim_set_hl(0, group, { bg = "none" })
    end
end

vim.api.nvim_create_autocmd("ColorScheme", { callback = clear_bg })

require("config.lazy")

-- [ i ]: Options ---
local options = {
    tabstop = {{@@ tab_space @@}},
    softtabstop = {{@@ tab_space @@}},
    shiftwidth = {{@@ tab_space @@}},
    expandtab = true,
    breakindent = true,
    linebreak = true,
    list = true,
    listchars = { lead = ".", tab = "» " },

    termguicolors = true,
    wrap = true,
    number = true,
    relativenumber = true,
    fillchars = { eob = " " },
}

for key, value in pairs(options) do
    vim.opt[key] = value
end
