local format_on_save = vim.api.nvim_create_augroup("LspFormatOnSave", { clear = true })
local diagnostic_undercurl = vim.api.nvim_create_augroup("DiagnosticUndercurl", { clear = true })

vim.api.nvim_create_autocmd("BufWritePre", {
  group = format_on_save,
  callback = function(args)
    if #vim.lsp.get_clients({ bufnr = args.buf }) == 0 then
      return
    end

    vim.lsp.buf.format({ bufnr = args.buf, timeout_ms = 2000 })
  end,
})

local function set_diagnostic_undercurl()
  for _, hl in ipairs({
    "DiagnosticUnderlineError",
    "DiagnosticUnderlineWarn",
    "DiagnosticUnderlineInfo",
    "DiagnosticUnderlineHint",
  }) do
    local current = vim.api.nvim_get_hl(0, { name = hl, link = false })
    current.undercurl = true
    vim.api.nvim_set_hl(0, hl, current)
  end
end

vim.diagnostic.config({
  underline = true,
  severity_sort = true,
})

set_diagnostic_undercurl()

vim.api.nvim_create_autocmd("ColorScheme", {
  group = diagnostic_undercurl,
  callback = set_diagnostic_undercurl,
})
