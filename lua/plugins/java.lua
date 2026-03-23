return {
	{
		"mfussenegger/nvim-jdtls",
		ft = "java",
config = function()
			local jdtls = require("jdtls")

			local jdtls_bin = vim.fn.stdpath("data") .. "/mason/packages/jdtls/bin/jdtls"

			local function start_jdtls()
				-- Use full project path (slashes replaced) to avoid workspace collisions
				local project_id = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:gs?/?_?")
				local workspace_dir = vim.fn.stdpath("data") .. "/jdtls-workspace/" .. project_id

				jdtls.start_or_attach({
					cmd = {
						jdtls_bin,
						"--data", workspace_dir,
					},
					root_dir = jdtls.setup.find_root({ ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" }),
					settings = {
						java = {
							configuration = {
								updateBuildConfiguration = "interactive",
							},
						},
					},
				})
			end

			-- Start for the buffer that triggered this load
			start_jdtls()

			-- Start for any subsequent Java buffers opened in this session
			vim.api.nvim_create_autocmd("FileType", {
				pattern = "java",
				callback = start_jdtls,
			})
		end,
	},
}
