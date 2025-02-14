-- Clipboard for WSL
if vim.fn.has("wsl") == 1 then
  vim.g.clipboard = {
    name = "WslClipboard",
    copy = {
      ["+"] = "clip.exe",
      ["*"] = "clip.exe",
    },
    paste = {
      ["+"] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
      ["*"] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
    },
    cache_enabled = 0,
  }
end

if vim.fn.has("gui_running") == 1 then
  vim.opt.guifont = { "BerkeleyMono Nerd Font:h10" }
end

-- Options
local opt = vim.opt
vim.g.mapleader = " " -- Set <space> as the leader key
vim.g.maplocalleader = " "
vim.g.nofsync = true
vim.o.showtabline = 2 -- always display tabs/buffers
opt.mouse = "a"
opt.autowrite = true -- Enable auto write
opt.clipboard = "unnamedplus" -- Sync with system clipboard
opt.conceallevel = 0
opt.confirm = true -- Confirm to save changes before exiting modified buffer
opt.splitbelow = true -- Put new windows below current
opt.splitkeep = "screen"
opt.splitright = true -- Put new windows right of current
opt.timeoutlen = 500
opt.undofile = true
opt.undolevels = 10000
opt.updatetime = 200 -- Save swap file and trigger CursorHold
opt.virtualedit = "block" -- Allow cursor to move where there is no text in visual block mode
opt.winminwidth = 5 -- Minimum window width
opt.fillchars = {
  foldopen = "",
  foldclose = "",
  fold = " ",
  foldsep = " ",
  diff = "╱",
  eob = " ",
}

-- shell: pwsh for win
if vim.fn.has("win32") == 1 then
  vim.o.shell = "powershell"
  vim.o.shellcmdflag = "-NoLogo -NoProfile -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;"
  vim.o.shellredir = "2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode"
  vim.o.shellpipe = "2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode"
  vim.o.shellquote = ""
  vim.o.shellxquote = ""
end

-- search and replace
opt.ignorecase = true -- Ignore case
opt.inccommand = "split" -- preview incremental substitute
opt.smartcase = true -- Don't ignore case with capitals

-- editor gui
opt.wrap = false -- Disable line wrap
opt.termguicolors = true -- True color support
opt.cursorline = true -- Enable highlighting of the current line
opt.cursorcolumn = false -- Enable highlighting of the current column
opt.laststatus = 3 -- global statusline
opt.signcolumn = "yes" -- Always show the signcolumn, otherwise it would shift the text each time
opt.number = true -- Print line number
opt.relativenumber = true -- Relative line numbers
opt.scrolloff = 7 -- Lines of context
opt.sidescrolloff = 8 -- Columns of context

-- spaces, tabs and indents
opt.expandtab = true -- Use spaces instead of tabs
opt.tabstop = 2 -- Number of spaces tabs count for
opt.shiftwidth = 2 -- Size of an indent
opt.shiftround = true -- Round indent
opt.smartindent = true -- Insert indents automatically

-- Folding
opt.foldcolumn = "1"
opt.foldlevel = 99
opt.foldlevelstart = 99
opt.foldenable = true
opt.foldmethod = "expr"
opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
opt.foldtext = ''
opt.fillchars = 'fold: '

-- title
vim.opt.title = true
vim.opt.titlestring = [[%t – %{fnamemodify(getcwd(), ':t')}]]

-- Language
opt.spelllang = { "en" }
vim.cmd("language en_US")
