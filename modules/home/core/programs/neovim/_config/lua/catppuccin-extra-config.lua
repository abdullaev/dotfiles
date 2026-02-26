do
	local catppuccin = require("catppuccin")
	local original_setup = catppuccin.setup

	catppuccin.setup = function(opts)
		opts = opts or {}
		opts.integrations = opts.integrations or {}

		opts.integrations.snacks = vim.tbl_deep_extend("force", opts.integrations.snacks or {}, { enabled = true })

		opts.integrations.mini = vim.tbl_deep_extend("force", opts.integrations.mini or {}, { enabled = true })

		return original_setup(opts)
	end
end
