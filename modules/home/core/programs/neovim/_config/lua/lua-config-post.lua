-- DAP symbols
vim.fn.sign_define("DapBreakpoint", { text = " ", texthl = "DiagnosticError" })
vim.fn.sign_define("DapBreakpointCondition", { text = " ", texthl = "DiagnosticError" })
vim.fn.sign_define("DapLogPoint", { text = " ", texthl = "DiagnosticInfo" })
vim.fn.sign_define("DapStopped", { text = " ", texthl = "DiagnosticOk", linehl = "debugPC" })
vim.fn.sign_define("DapBreakpointRejected", { text = " ", texthl = "DiagnosticError" })

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
