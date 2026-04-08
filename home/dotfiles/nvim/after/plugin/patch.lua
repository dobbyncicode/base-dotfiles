-- --- [ i ] - Line numbers ---
vim.opt.number = true
vim.opt.relativenumber = true

-- --- [ i ] - Whitespaces ---
vim.opt.list = true
vim.opt.listchars = {
    tab = "→ ",
    trail = "·",
    nbsp = "␣",
    lead = "·",
}

-- --- [ i ] - Tabs to space ---
vim.opt.expandtab = true
vim.opt.tabstop = {{@@ space_tab @@}}
vim.opt.shiftwidth = {{@@ space_tab @@}}
vim.opt.softtabstop = {{@@ space_tab @@}}

-- --- [ i ] - Line wrap ---
vim.opt.wrap = true
vim.opt.linebreak = true
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8
vim.opt.signcolumn = "yes"

-- --- [ i ] - Search ---
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- --- [ i ] - Split view ---
vim.opt.splitright = true
vim.opt.splitbelow = true

-- --- [ i ] - Clipboard and file
vim.opt.clipboard = "unnamedplus"
vim.opt.undofile = true
vim.opt.swapfile = false
vim.keymap.set({ "n", "i", "v" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save file" })
vim.keymap.set("v", "<C-c>", '"+y', { noremap = true, silent = true })
vim.keymap.set("v", "<C-x>", '"+d', { noremap = true, silent = true })
vim.keymap.set("n", "<C-v>", '"+p', { noremap = true, silent = true })
vim.keymap.set("i", "<C-v>", '<C-r>+', { noremap = true, silent = true })
vim.api.nvim_create_autocmd({ "TextYankPost" }, {
  callback = function() vim.highlight.on_yank({ timeout = 200 }) end,
})

-- --- [ i ] - UI stuff (transparency and colors) ---
vim.opt.title = true
vim.opt.titlestring = "🐹 %f"
vim.opt.termguicolors = true
vim.opt.fillchars = { eob = " " }
vim.opt.cursorline = true
vim.opt.smoothscroll = true
vim.opt.pumblend = 10
vim.opt.winblend = 10
vim.opt.laststatus = 3
vim.opt.showmode = false
vim.opt.shortmess:append("c")

vim.opt.fillchars:append({
    horiz = "━",
    horizup = "┻",
    horizdown = "┳",
    vert = "┃",
    vertleft = "┨",
    vertright = "┣",
    verthoriz = "╋",
})

local cl_group = vim.api.nvim_create_augroup("CursorLine", { clear = true })

vim.api.nvim_create_autocmd({ "WinEnter", "BufEnter" }, {
    group = cl_group, command = "setlocal cursorline",
})

vim.api.nvim_create_autocmd("WinLeave", {
  group = cl_group, command = "setlocal nocursorline",
})

vim.opt.guicursor = "n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50"
    .. ",a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor"
    .. ",sm:block-blinkwait175-blinkoff150-blinkon175"

local function clear_bg()
    local groups = {
      "Normal", "NormalNC", "NormalFloat",
      "SignColumn", "EndOfBuffer",
    }
    for _, g in ipairs(groups) do
      vim.api.nvim_set_hl(0, g, { bg = "NONE", ctermbg = "NONE" })
    end
end

clear_bg()
vim.api.nvim_create_autocmd("ColorScheme", {
    pattern  = "*",
    callback = clear_bg,
})

local signs = { Error = "󰅚 ", Warn = "󰀪 ", Hint = "󰌶 ", Info = "󰋽 " }
for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end


function MyStatusLine()
    return " %f %y %m %= %l:%c "
end

vim.opt.statusline = "%!v:lua.MyStatusLine()"

-- --- [ i ] - Snippets ---
_G.my_custom_snippets = {
    cmi = "--- [ i ] - $1 ---$0",
    cmx = "--- [ x ] - $1 ---$0",
    cmw = "--- [ ! ] - $1 ---$0",
    cmt = "--- [ ~ ] - $1 ---$0",
    cmq = "--- [ ? ] - $1 ---$0",
}

_G.expand_my_snippet = function(key)
    local macro = string.format(
        "<BS><Cmd>lua vim.snippet.expand(_G.my_custom_snippets['%s'])<CR>", 
        key
    )
    local keys = vim.api.nvim_replace_termcodes(macro, true, false, true)
    vim.api.nvim_feedkeys(keys, "n", false)
    return ""
end

vim.cmd("inoreabbrev <expr> cmi v:lua.expand_my_snippet('cmi')")
vim.cmd("inoreabbrev <expr> cmx v:lua.expand_my_snippet('cmx')")
vim.cmd("inoreabbrev <expr> cmw v:lua.expand_my_snippet('cmw')")
vim.cmd("inoreabbrev <expr> cmt v:lua.expand_my_snippet('cmt')")
vim.cmd("inoreabbrev <expr> cmq v:lua.expand_my_snippet('cmq')")

vim.keymap.set({ "i", "s" }, "<C-l>", function()
    if vim.snippet.active({ direction = 1 }) then
        vim.snippet.jump(1)
    end
end, { silent = true, desc = "Jump to next snippet node" })
