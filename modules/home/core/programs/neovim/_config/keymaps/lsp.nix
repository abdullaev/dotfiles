[
  {
    mode = [
      "n"
      "i"
    ];
    key = "<A-s>";
    action = "function() vim.lsp.buf.signature_help() end";
    lua = true;
    desc = "Signature help";
  }
  {
    mode = [
      "n"
      "i"
    ];
    key = "<A-d>";
    action = "function() vim.diagnostic.open_float(nil, { scope = \"cursor\" }) end";
    lua = true;
    desc = "Open diagnostic float";
  }
  {
    mode = "n";
    key = "\\t";
    action = "function() toggle_diagnostic_virtual_text() end";
    lua = true;
    desc = "Toggle diagnostic virtual text";
  }
  {
    mode = "n";
    key = "\\e";
    action = "function() toggle_diagnostic_virtual_lines() end";
    lua = true;
    desc = "Toggle diagnostic virtual lines";
  }
  {
    mode = "n";
    key = "\\p";
    action = "function() toggle_snacks_indent_chunk() end";
    lua = true;
    desc = "Toggle indent chunk display";
  }
  {
    mode = "n";
    key = "gd";
    action = "function() Snacks.picker.lsp_definitions() end";
    lua = true;
    desc = "Goto Definition";
  }
  {
    mode = "n";
    key = "gD";
    action = "function() Snacks.picker.lsp_declarations() end";
    lua = true;
    desc = "Goto Declaration";
  }
  {
    mode = "n";
    key = "gr";
    action = "function() Snacks.picker.lsp_references() end";
    lua = true;
    nowait = true;
    desc = "References";
  }
  {
    mode = "n";
    key = "gI";
    action = "function() Snacks.picker.lsp_implementations() end";
    lua = true;
    desc = "Goto Implementation";
  }
  {
    mode = "n";
    key = "gy";
    action = "function() Snacks.picker.lsp_type_definitions() end";
    lua = true;
    desc = "Goto Type Definition";
  }
  {
    mode = "n";
    key = "gai";
    action = "function() Snacks.picker.lsp_incoming_calls() end";
    lua = true;
    desc = "Calls Incoming";
  }
  {
    mode = "n";
    key = "gao";
    action = "function() Snacks.picker.lsp_outgoing_calls() end";
    lua = true;
    desc = "Calls Outgoing";
  }
  {
    mode = "n";
    key = "<leader>ss";
    action = "function() Snacks.picker.lsp_symbols() end";
    lua = true;
    desc = "LSP Symbols";
  }
  {
    mode = "n";
    key = "<leader>sS";
    action = "function() Snacks.picker.lsp_workspace_symbols() end";
    lua = true;
    desc = "LSP Workspace Symbols";
  }
  {
    mode = "n";
    key = "]w";
    action = "function() Snacks.words.jump(vim.v.count1, true) end";
    lua = true;
    desc = "Next Reference";
  }
  {
    mode = "n";
    key = "[w";
    action = "function() Snacks.words.jump(-vim.v.count1, true) end";
    lua = true;
    desc = "Previous Reference";
  }
]
