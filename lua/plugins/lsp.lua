return {
	{
		"mason-org/mason.nvim",
		build = ":MasonUpdate",
		opts = {},
	},
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		config = function()
			require("mason-tool-installer").setup({
				ensure_installed = {
					-- language servers
					"lua-language-server",
					"pyright",
					"typescript-language-server",
					"angular-language-server",
					"emmet-language-server",
					"css-lsp",
					"jdtls",
					"rust-analyzer",
					"tailwindcss-language-server",

					-- formatters
					"stylua",
					"ruff",
					"prettierd",
				},
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"mason-org/mason.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",
			"saghen/blink.cmp",
		},
		config = function()
			local servers = {
				"lua_ts",
				"pyright",
				"ts_ls",
				"angularls",
				"emmet_language_server",
				"cssls",
				"rust_analyzer",
				"tailwindcss",
			}

			-- pass blink capabilities to all servers
			vim.lsp.config("*", {
				capabilities = require("blink.cmp").get_lsp_capabilities(),
			})

			-- server-specific overrides
			vim.lsp.config("rust_analyzer", {
				settings = {
					["rust-analyzer"] = {
						check = {
							command = "clippy",
						},
					},
				},
			})

			vim.lsp.config("tailwindcss", {
				filetypes = {
					"html",
					"htmlangular",
					"css",
					"javascript",
					"typescript",
					"javascriptreact",
					"typescriptreact",
					"rust",
				},
				settings = {
					tailwindCSS = {
						includeLanguages = {
							rust = "html",
						},
						experimental = {
							classRegex = {
								[=[class:\s*["']([^"']*)["']]=],
								[=[class:\s*`([^`]*)`]=],
							},
						},
					},
				},
			})

			vim.lsp.config("lua_ls", {
				settings = {
					Lua = {
						diagnostics = {
							globals = { "vim" },
						},
					},
				},
			})

			-- enable inline diagnostics
			vim.diagnostic.config({
				virtual_text = true,
				signs = true,
				underline = true,
				update_in_insert = true,
			})

			-- enable servers
			vim.lsp.enable(servers)

			-- keymaps on attach
			vim.api.nvim_create_autocmd("LspAttach", {
				callback = function(event)
					local map = function(keys, func, desc)
						vim.keymap.set("n", keys, func, { buffer = event.buf, desc = desc })
					end

					map("gd", "<cmd>FzfLua lsp_definitions<cr>", "Go to definition")
					map("gD", "<cmd>FzfLua lsp_declarations<cr>", "Go to declaration")
					map("gr", "<cmd>FzfLua lsp_references<cr>", "Go to references")
					map("gi", "<cmd>FzfLua lsp_implementations<cr>", "Go to implementation")
					map("K", vim.lsp.buf.hover, "Hover documentation")
					map("<leader>lr", vim.lsp.buf.rename, "Rename symbol")
					map("<leader>la", vim.lsp.buf.code_action, "Code action")
					map("<leader>ld", vim.diagnostic.open_float, "Line diagnostics")
					map("]d", vim.diagnostic.goto_next, "Next diagnostic")
					map("[d", vim.diagnostic.goto_prev, "Previous diagnostic")
				end,
			})

			-- Restart pyright when package manifests are saved (picks up newly installed packages)
			vim.api.nvim_create_autocmd("BufWritePost", {
				pattern = { "requirements*.txt", "pyproject.toml", "setup.py", "setup.cfg" },
				callback = function()
					vim.cmd("LspRestart pyright")
				end,
			})

			-- Notify pyright when a new Python file is opened (picks up new modules)
			vim.api.nvim_create_autocmd("BufAdd", {
				pattern = "*.py",
				callback = function(event)
					local clients = vim.lsp.get_clients({ name = "pyright" })
					for _, client in ipairs(clients) do
						client.notify("workspace/didChangeWatchedFiles", {
							changes = {
								{ uri = vim.uri_from_fname(event.file), type = 1 },
							},
						})
					end
				end,
			})
		end,
	},
	{
		"stevearc/conform.nvim",
		config = function()
			require("conform").setup({
				formatters_by_ft = {
					lua = { "stylua" },
					python = { "ruff_format", "ruff_organize_imports" },
					javascript = { "prettierd" },
					typescript = { "prettierd" },
					javascriptreact = { "prettierd" },
					typescriptreact = { "prettierd" },
					html = { "prettierd" },
					htmlangular = { "prettierd" },
					css = { "prettierd" },
					json = { "prettierd" },
					rust = { "rustfmt" },
				},
				format_on_save = function(bufnr)
					if vim.b[bufnr].disable_autoformat then
						return
					end
					return { timeout_ms = 500, lsp_fallback = true }
				end,
			})

			vim.keymap.set("n", "<leader>bf", function()
				require("conform").format({ async = true })
			end, { desc = "Format buffer" })

			vim.keymap.set("n", "<leader>bF", function()
				vim.b.disable_autoformat = not vim.b.disable_autoformat
				vim.notify("Format on save: " .. (vim.b.disable_autoformat and "disabled" or "enabled"))
			end, { desc = "Toggle format on save (buffer)" })
		end,
	},
}
