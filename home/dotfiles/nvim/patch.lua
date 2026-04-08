-- --- [ i ] - Helpers ---
local function safe(name, fn)
    local ok, err = pcall(fn)
    if not ok then
        vim.notify(("[patch] %s: %s"):format(name, err), vim.log.levels.WARN)
    end
end

-- --- [ i ] - Editor (forced overrides) ---
safe("editor", function()
    vim.opt.number = true
    vim.opt.relativenumber = true

    vim.opt.list = true
    vim.opt.listchars = {
        tab = "→ ",
        trail = "·",
        nbsp = "␣",
        lead = "·",
    }

    vim.opt.expandtab = true
    vim.opt.tabstop = {{@@ tab_space @@}}
    vim.opt.shiftwidth = {{@@ tab_space @@}}
    vim.opt.softtabstop = {{@@ tab_space @@}}

    vim.opt.wrap = true
    vim.opt.linebreak = true
    vim.opt.scrolloff = 8
    vim.opt.sidescrolloff = 8
    vim.opt.signcolumn = "yes"

    vim.opt.ignorecase = true
    vim.opt.smartcase = true

    vim.opt.splitright = true
    vim.opt.splitbelow = true

    vim.opt.undofile = true
    vim.opt.swapfile = false
end)

-- --- [ i ] - Clipboard ---
safe("clipboard", function()
    if vim.fn.has("wsl") == 1 then
        vim.g.clipboard = {
            name = "wsl",
            copy = {
                ["+"] = "clip.exe",
                ["*"] = "clip.exe",
            },
            paste = {
                ["+"] = 'powershell.exe -NoLogo -NoProfile -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
                ["*"] = 'powershell.exe -NoLogo -NoProfile -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
            },
            cache_enabled = false,
        }
    elseif vim.env.SSH_TTY or vim.env.SSH_CONNECTION or vim.env.SSH_CLIENT then
        vim.g.clipboard = {
            name = "OSC52",
            copy = {
                ["+"] = require("vim.ui.clipboard.osc52").copy,
                ["*"] = require("vim.ui.clipboard.osc52").copy,
            },
            paste = {
                ["+"] = require("vim.ui.clipboard.osc52").paste,
                ["*"] = require("vim.ui.clipboard.osc52").paste,
            },
        }
    end
    vim.opt.clipboard = "unnamedplus"
end)

-- --- [ i ] - UI ---
safe("ui", function()
    vim.opt.termguicolors = true
    vim.opt.title = true
    vim.opt.titlestring = "🐹 %f"
    vim.opt.cursorline = true
    vim.opt.smoothscroll = true
    vim.opt.pumblend = 10
    vim.opt.winblend = 10
    vim.opt.shortmess:append("c")
    vim.opt.fillchars = { eob = " " }
    vim.opt.fillchars:append({
        horiz = "━",
        horizup = "┻",
        horizdown = "┳",
        vert = "┃",
        vertleft = "┨",
        vertright = "┣",
        verthoriz = "╋",
    })
    vim.opt.guicursor = "n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50"
        .. ",a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor"
        .. ",sm:block-blinkwait175-blinkoff150-blinkon175"
end)

-- --- [ i ] - Keymaps ---
safe("keymaps", function()
    pcall(vim.fn.system, "stty -ixon")

    vim.keymap.set({ "n", "i", "v" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save file" })
    vim.keymap.set("v", "<C-c>", '"+y', { noremap = true, silent = true })
    vim.keymap.set("v", "<C-x>", '"+d', { noremap = true, silent = true })
    vim.keymap.set("n", "<C-v>", '"+p', { noremap = true, silent = true })
    vim.keymap.set("i", "<C-v>", '<C-r>+', { noremap = true, silent = true })
end)

-- --- [ i ] - Autocmds ---
safe("autocmds", function()
    vim.api.nvim_create_autocmd("TextYankPost", {
        callback = function() vim.highlight.on_yank({ timeout = 200 }) end,
    })

    local cl = vim.api.nvim_create_augroup("PatchCursorLine", { clear = true })
    vim.api.nvim_create_autocmd({ "WinEnter", "BufEnter" }, {
        group = cl, command = "setlocal cursorline",
    })
    vim.api.nvim_create_autocmd("WinLeave", {
        group = cl, command = "setlocal nocursorline",
    })

    local clear_bg = function()
        for _, g in ipairs({ "Normal", "NormalNC", "NormalFloat", "SignColumn", "EndOfBuffer" }) do
            vim.api.nvim_set_hl(0, g, { bg = "NONE", ctermbg = "NONE" })
        end
    end
    clear_bg()
    vim.api.nvim_create_autocmd("ColorScheme", { pattern = "*", callback = clear_bg })
end)

-- --- [ i ] - Diagnostics ---
safe("diagnostics", function()
    local s = vim.diagnostic.severity
    vim.diagnostic.config({
        signs = {
            text = {
                [s.ERROR] = "󰅚 ",
                [s.WARN]  = "󰀪 ",
                [s.HINT]  = "󰌶 ",
                [s.INFO]  = "󰋽 ",
            },
        },
    })
end)

-- --- [ i ] - Statusline (only if no plugin handles it) ---
safe("statusline", function()
    for _, p in ipairs({ "lualine", "heirline", "feline", "staline" }) do
        if pcall(require, p) then return end
    end
    vim.opt.laststatus = 3
    vim.opt.showmode = false
    _G._patch_stl = function() return " %f %y %m %= %l:%c " end
    vim.opt.statusline = "%!v:lua._patch_stl()"
end)

-- --- [ i ] - Snippets ---
safe("snippets", function()
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

    for k, _ in pairs(_G.my_custom_snippets) do
        vim.cmd(("inoreabbrev <expr> %s v:lua.expand_my_snippet('%s')"):format(k, k))
    end

    vim.keymap.set({ "i", "s" }, "<C-l>", function()
        if vim.snippet.active({ direction = 1 }) then
            vim.snippet.jump(1)
        end
    end, { silent = true, desc = "Jump to next snippet node" })
end)
