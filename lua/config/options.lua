-- Setting the leader to space.
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Number of spaces a tab counts for
vim.o.expandtab = true
vim.o.tabstop = 4
vim.o.shiftwidth = 4

-- Line numbers
vim.o.number = true
vim.o.relativenumber = true
-- Align numbers to the right, hide virtual lines.
vim.opt.statuscolumn = "%s%=%{v:virtnum?'':v:relnum?v:relnum:v:lnum} "
vim.opt.fillchars = { eob = " " }

-- highlights current line.
vim.o.cursorline = true

-- Enable mouse mode all ('a'). Other options: https://neovim.io/doc/user/options/#'mouse'
vim.o.mouse = "a"

vim.o.showmode = false

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  See https://neovim.io/doc/user/provider/#_clipboard-integration
vim.schedule(function()
	vim.o.clipboard = "unnamedplus"
end)

-- Enable break indent
vim.o.breakindent = true

-- Enable undo/redo changes even after closing and reopening a file
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.o.ignorecase = true
vim.o.smartcase = true

-- Decrease update time
vim.o.updatetime = 250

-- Decrease mapped sequence wait time
vim.o.timeoutlen = 300

-- Configure how new splits should be opened
vim.o.splitright = true
vim.o.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
--
--  Notice listchars is set using `vim.opt` instead of `vim.o`.
--  It is very similar to `vim.o` but offers an interface for conveniently interacting with tables.
--   See `:help lua-options`
--   and `:help lua-guide-options`
vim.o.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
-- Keep signcolumn always visible so the gutter doesn't jump
-- when LSP diagnostics or git signs appear
vim.o.signcolumn = "yes"

-- Preview search and replace live, as you type!
vim.o.inccommand = "split"

-- Minimal number of screen lines to keep above and below the cursor.
vim.o.scrolloff = 5
-- if performing an operation that would fail due to unsaved changes in the buffer (like `:q`),
-- instead raise a dialog asking if you wish to save the current file(s)
-- See `:help 'confirm'`
vim.o.confirm = true

-- Wrap lines.
vim.o.wrap = true
vim.o.linebreak = true -- break on word boundaries

-- Clear statuscolumn in neo-tree to suppress line numbers.
-- vim.schedule is needed because neo-tree resets window options after the
-- FileType event fires, so we defer until the current event loop cycle finishes.
vim.api.nvim_create_autocmd("FileType", {
	pattern = "neo-tree",
	callback = function()
		vim.schedule(function()
			vim.opt_local.statuscolumn = ""
		end)
	end,
})

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank({ higroup = "Visual", timeout = 200 })
	end,
})
