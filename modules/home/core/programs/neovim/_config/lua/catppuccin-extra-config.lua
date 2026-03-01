do
	local catppuccin = require("catppuccin")

	local base_setup = catppuccin.setup
	catppuccin.setup = function(opts)
		opts = opts or {}

		opts.lsp_styles = opts.lsp_styles or {}
		opts.lsp_styles.underlines = vim.tbl_deep_extend("force", opts.lsp_styles.underlines or {}, {
			errors = { "undercurl" },
			hints = { "undercurl" },
			warnings = { "undercurl" },
			information = { "undercurl" },
			ok = { "undercurl" },
		})

		return base_setup(opts)
	end
end
