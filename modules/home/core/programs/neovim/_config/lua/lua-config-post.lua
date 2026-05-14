vim.opt.iskeyword:append("-")

-- Workaround for blink.cmp 1.10.1 race in win:close (Invalid window id from
-- nvim_win_close in lib/window/init.lua). Drop once upstream validates self.id.
do
	local function patch()
		local ok, win = pcall(require, "blink.cmp.lib.window")
		if not ok or win.__patched_close then
			return ok
		end
		win.__patched_close = true
		local original = win.close
		win.close = function(self)
			if self.id and not vim.api.nvim_win_is_valid(self.id) then
				self.id = nil
			end
			return original(self)
		end
		return true
	end
	if not patch() then
		vim.api.nvim_create_autocmd("InsertEnter", {
			once = true,
			callback = function()
				vim.schedule(patch)
			end,
		})
	end
end

-- DAP symbols
vim.fn.sign_define("DapBreakpoint", { text = " ", texthl = "DiagnosticError" })
vim.fn.sign_define("DapBreakpointCondition", { text = " ", texthl = "DiagnosticError" })
vim.fn.sign_define("DapLogPoint", { text = " ", texthl = "DiagnosticInfo" })
vim.fn.sign_define("DapStopped", { text = " ", texthl = "DiagnosticOk", linehl = "debugPC" })
vim.fn.sign_define("DapBreakpointRejected", { text = " ", texthl = "DiagnosticError" })

-- Diagnostic symbols
vim.fn.sign_define("DiagnosticSignError", { text = "", texthl = "DiagnosticError" })
vim.fn.sign_define("DiagnosticSignWarn", { text = "", texthl = "DiagnosticWarn" })
vim.fn.sign_define("DiagnosticSignInfo", { text = "", texthl = "DiagnosticInfo" })
vim.fn.sign_define("DiagnosticSignHint", { text = "󰌵", texthl = "DiagnosticHint" })

-- LSP progress
vim.api.nvim_create_autocmd("LspProgress", {
	callback = function(ev)
		local value = ev.data.params.value
		vim.api.nvim_echo({ { value.message or "done" } }, false, {
			id = "lsp." .. ev.data.client_id,
			kind = "progress",
			source = "vim.lsp",
			title = value.title,
			status = value.kind ~= "end" and "running" or "success",
			percent = value.percentage,
		})
	end,
})

-- Toggles
local function toggle_diagnostic_setting(option, label)
	local current = vim.diagnostic.config()[option]
	local backup_key = "diagnostic_" .. option .. "_config"

	if current == false or current == nil then
		vim.diagnostic.config({ [option] = vim.g[backup_key] or true })
		vim.notify(label .. " enabled")
		return
	end

	if type(current) == "table" then
		vim.g[backup_key] = current
	end

	vim.diagnostic.config({ [option] = false })
	vim.notify(label .. " disabled")
end

_G.toggle_diagnostic_virtual_text = function()
	toggle_diagnostic_setting("virtual_text", "Diagnostic virtual text")
end

_G.toggle_diagnostic_virtual_lines = function()
	toggle_diagnostic_setting("virtual_lines", "Diagnostic virtual lines")
end

_G.toggle_snacks_indent_chunk = function()
	local chunk = Snacks.config.indent.chunk or {}
	local enabled = not chunk.enabled

	Snacks.config.indent.chunk = vim.tbl_deep_extend("force", chunk, { enabled = enabled })

	if Snacks.indent.enabled then
		Snacks.indent.disable()
		Snacks.indent.enable()
	end

	Snacks.notify((enabled and "Enabled" or "Disabled") .. " indent chunk display", { title = "Snacks Indent" })
end

_G.toggle_quickfix = function()
	local windows = vim.fn.getwininfo()
	for _, win in pairs(windows) do
		if win["quickfix"] == 1 then
			vim.cmd.cclose()
			return
		end
	end
	if not vim.tbl_isempty(vim.fn.getqflist()) then
		vim.cmd.copen()
	end
end
