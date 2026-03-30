vim.keymap.set("n", "<ESC>", "<cmd>nohlsearch<CR>", { desc = "Exit search" })

vim.keymap.set("n", "<leader>w", "<cmd>write<CR>", { desc = "Save file" })
vim.keymap.set("n", "<leader>q", "<cmd>quit<CR>", { desc = "Quit window" })

vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Move to lower window" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Move to upper window" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })

vim.keymap.set("v", ">", ">gv", { desc = "Indent and reselect" })
vim.keymap.set("v", "<", "<gv", { desc = "Dedent and reselect" })

vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- Vertical split (side by side)
vim.keymap.set("n", "<leader>|", "<cmd>vsplit<cr>", { desc = "Split vertical" })

-- Horizontal split (top and bottom)
vim.keymap.set("n", "<leader>\\", "<cmd>split<cr>", { desc = "Split horizontal" })

-- Resize mode: <leader>r to enter, hjkl to resize, <Esc>/<CR>/q to exit
-- Uses buffer-local keymaps so they override plugin maps (e.g. neo-tree's h/l/q).
-- Saves and restores any existing buffer-local maps that get shadowed.
local function enter_resize_mode()
  local step = 3
  local bufnr = vim.api.nvim_get_current_buf()
  local keys = { "h", "l", "j", "k", "<Esc>", "<CR>", "q" }
  local saved = {}

  for _, key in ipairs(keys) do
    local m = vim.fn.maparg(key, "n", false, true)
    if m.lhs ~= nil then
      saved[key] = m
    end
  end

  local function exit_resize_mode()
    for _, key in ipairs(keys) do
      pcall(vim.keymap.del, "n", key, { buffer = bufnr })
    end
    for _, m in pairs(saved) do
      vim.fn.mapset("n", false, m)
    end
    vim.notify("Resize mode off", vim.log.levels.INFO)
  end

  local opts = { noremap = true, silent = true, buffer = bufnr }
  vim.keymap.set("n", "h", function() vim.cmd("vertical resize -" .. step) end, opts)
  vim.keymap.set("n", "l", function() vim.cmd("vertical resize +" .. step) end, opts)
  vim.keymap.set("n", "k", function() vim.cmd("resize +" .. step) end, opts)
  vim.keymap.set("n", "j", function() vim.cmd("resize -" .. step) end, opts)
  vim.keymap.set("n", "<Esc>", exit_resize_mode, opts)
  vim.keymap.set("n", "<CR>", exit_resize_mode, opts)
  vim.keymap.set("n", "q", exit_resize_mode, opts)

  vim.notify("Resize mode — hjkl to resize, <Esc>/<CR>/q to exit", vim.log.levels.INFO)
end

vim.keymap.set("n", "<leader>r", enter_resize_mode, { desc = "Resize mode" })
