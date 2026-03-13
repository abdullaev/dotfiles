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

-- Fix opencode orphan process
-- TODO: Remove after fix https://github.com/anomalyco/opencode/issues/13001
local function kill_session_opencode()
	local nvim_pid = tostring(vim.fn.getpid())
	local ps = vim.system({ "ps", "-eo", "pid=,ppid=,comm=,args=" }, { text = true }):wait()

	if ps.code ~= 0 or not ps.stdout then
		return
	end

	local processes = {}
	local targets = {}
	local seen_targets = {}

	for line in ps.stdout:gmatch("[^\r\n]+") do
		local pid, ppid, comm, args = line:match("^%s*(%d+)%s+(%d+)%s+(%S+)%s+(.+)$")
		if pid and ppid and comm and args then
			local argv0 = args:match("^%S+")
			local argv0_basename = argv0 and argv0:match("([^/]+)$") or ""

			processes[pid] = {
				ppid = ppid,
				is_opencode = comm == "opencode" or argv0_basename == "opencode",
			}
		end
	end

	for pid, process in pairs(processes) do
		if process.is_opencode then
			local current = pid
			while current and current ~= "0" do
				if current == nvim_pid then
					if not seen_targets[pid] then
						targets[#targets + 1] = pid
						seen_targets[pid] = true
					end
					break
				end

				local parent_process = processes[current]
				local parent = parent_process and parent_process.ppid
				if not parent or parent == current then
					break
				end

				current = parent
			end
		end
	end

	for _, pid in ipairs(targets) do
		vim.system({ "kill", "-TERM", pid }):wait()
	end
end

local opencode_cleanup_group = vim.api.nvim_create_augroup("OpencodeSessionCleanup", { clear = true })

vim.api.nvim_create_autocmd("VimLeavePre", {
	group = opencode_cleanup_group,
	callback = kill_session_opencode,
})

-- Misc
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
