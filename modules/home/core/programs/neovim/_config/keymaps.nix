{
  keymaps = [
    # Snacks
    {
      mode = [
        "n"
        "t"
        "i"
        "x"
      ];
      key = "<C-`>";
      action = "function() Snacks.terminal.toggle() end";
      lua = true;
      desc = "Terminal Toggle";
    }
    {
      mode = "n";
      key = "<leader>,";
      action = "function() Snacks.picker.buffers() end";
      lua = true;
      desc = "Buffers";
    }
    {
      mode = "n";
      key = "<leader>/";
      action = "function() Snacks.picker.grep() end";
      lua = true;
      desc = "Grep";
    }
    {
      mode = "n";
      key = "<leader>:";
      action = "function() Snacks.picker.command_history() end";
      lua = true;
      desc = "Command History";
    }
    {
      mode = "n";
      key = "<leader>n";
      action = "function() Snacks.picker.notifications() end";
      lua = true;
      desc = "Notification History";
    }
    {
      mode = "n";
      key = "<leader>e";
      action = "function() Snacks.explorer() end";
      lua = true;
      desc = "File Explorer";
    }
    {
      mode = "n";
      key = "<leader>fb";
      action = "function() Snacks.picker.buffers() end";
      lua = true;
      desc = "Buffers";
    }
    {
      mode = "n";
      key = "<leader>ff";
      action = "function() Snacks.picker.files() end";
      lua = true;
      desc = "Find Files";
    }
    {
      mode = "n";
      key = "<leader>fg";
      action = "function() Snacks.picker.git_files() end";
      lua = true;
      desc = "Find Git Files";
    }
    {
      mode = "n";
      key = "<leader>fp";
      action = "function() Snacks.picker.projects() end";
      lua = true;
      desc = "Projects";
    }
    {
      mode = "n";
      key = "<leader>fr";
      action = "function() Snacks.picker.recent() end";
      lua = true;
      desc = "Recent";
    }
    {
      mode = "n";
      key = "<leader>gb";
      action = "function() Snacks.picker.git_branches() end";
      lua = true;
      desc = "Git Branches";
    }
    {
      mode = "n";
      key = "<leader>gl";
      action = "function() Snacks.picker.git_log() end";
      lua = true;
      desc = "Git Log";
    }
    {
      mode = "n";
      key = "<leader>gL";
      action = "function() Snacks.picker.git_log_line() end";
      lua = true;
      desc = "Git Log Line";
    }
    {
      mode = "n";
      key = "<leader>gs";
      action = "function() Snacks.picker.git_status() end";
      lua = true;
      desc = "Git Status";
    }
    {
      mode = "n";
      key = "<leader>gS";
      action = "function() Snacks.picker.git_stash() end";
      lua = true;
      desc = "Git Stash";
    }
    {
      mode = "n";
      key = "<leader>gd";
      action = "function() Snacks.picker.git_diff() end";
      lua = true;
      desc = "Git Diff (Hunks)";
    }
    {
      mode = "n";
      key = "<leader>gf";
      action = "function() Snacks.picker.git_log_file() end";
      lua = true;
      desc = "Git Log File";
    }
    {
      mode = "n";
      key = "<leader>gi";
      action = "function() Snacks.picker.gh_issue() end";
      lua = true;
      desc = "GitHub Issues (open)";
    }
    {
      mode = "n";
      key = "<leader>gI";
      action = "function() Snacks.picker.gh_issue({ state = \"all\" }) end";
      lua = true;
      desc = "GitHub Issues (all)";
    }
    {
      mode = "n";
      key = "<leader>go";
      action = "function() Snacks.picker.gh_pr() end";
      lua = true;
      desc = "GitHub Pull Requests (open)";
    }
    {
      mode = "n";
      key = "<leader>gO";
      action = "function() Snacks.picker.gh_pr({ state = \"all\" }) end";
      lua = true;
      desc = "GitHub Pull Requests (all)";
    }
    {
      mode = "n";
      key = "<leader>sb";
      action = "function() Snacks.picker.lines() end";
      lua = true;
      desc = "Buffer Lines";
    }
    {
      mode = "n";
      key = "<leader>sB";
      action = "function() Snacks.picker.grep_buffers() end";
      lua = true;
      desc = "Grep Open Buffers";
    }
    {
      mode = "n";
      key = "<leader>sg";
      action = "function() Snacks.picker.grep() end";
      lua = true;
      desc = "Grep";
    }
    {
      mode = "n";
      key = "<leader>sw";
      action = "function() Snacks.picker.grep_word() end";
      lua = true;
      desc = "Visual selection or word";
    }
    {
      mode = "x";
      key = "<leader>sw";
      action = "function() Snacks.picker.grep_word() end";
      lua = true;
      desc = "Visual selection or word";
    }
    {
      mode = "n";
      key = "<leader>s\"";
      action = "function() Snacks.picker.registers() end";
      lua = true;
      desc = "Registers";
    }
    {
      mode = "n";
      key = "<leader>s/";
      action = "function() Snacks.picker.search_history() end";
      lua = true;
      desc = "Search History";
    }
    {
      mode = "n";
      key = "<leader>sa";
      action = "function() Snacks.picker.autocmds() end";
      lua = true;
      desc = "Autocmds";
    }
    {
      mode = "n";
      key = "<leader>sc";
      action = "function() Snacks.picker.command_history() end";
      lua = true;
      desc = "Command History";
    }
    {
      mode = "n";
      key = "<leader>sC";
      action = "function() Snacks.picker.commands() end";
      lua = true;
      desc = "Commands";
    }
    {
      mode = "n";
      key = "<leader>sd";
      action = "function() Snacks.picker.diagnostics() end";
      lua = true;
      desc = "Diagnostics";
    }
    {
      mode = "n";
      key = "<leader>sD";
      action = "function() Snacks.picker.diagnostics_buffer() end";
      lua = true;
      desc = "Buffer Diagnostics";
    }
    {
      mode = "n";
      key = "<leader>sh";
      action = "function() Snacks.picker.help() end";
      lua = true;
      desc = "Help Pages";
    }
    {
      mode = "n";
      key = "<leader>sH";
      action = "function() Snacks.picker.highlights() end";
      lua = true;
      desc = "Highlights";
    }
    {
      mode = "n";
      key = "<leader>si";
      action = "function() Snacks.picker.icons() end";
      lua = true;
      desc = "Icons";
    }
    {
      mode = "n";
      key = "<leader>sj";
      action = "function() Snacks.picker.jumps() end";
      lua = true;
      desc = "Jumps";
    }
    {
      mode = "n";
      key = "<leader>sk";
      action = "function() Snacks.picker.keymaps() end";
      lua = true;
      desc = "Keymaps";
    }
    {
      mode = "n";
      key = "<leader>sl";
      action = "function() Snacks.picker.loclist() end";
      lua = true;
      desc = "Location List";
    }
    {
      mode = "n";
      key = "<leader>sm";
      action = "function() Snacks.picker.marks() end";
      lua = true;
      desc = "Marks";
    }
    {
      mode = "n";
      key = "<leader>sM";
      action = "function() Snacks.picker.man() end";
      lua = true;
      desc = "Man Pages";
    }
    {
      mode = "n";
      key = "<leader>sq";
      action = "function() Snacks.picker.qflist() end";
      lua = true;
      desc = "Quickfix List";
    }
    {
      mode = "n";
      key = "<leader>sR";
      action = "function() Snacks.picker.resume() end";
      lua = true;
      desc = "Resume";
    }
    {
      mode = "n";
      key = "<leader>su";
      action = "function() Snacks.picker.undo() end";
      lua = true;
      desc = "Undo History";
    }
    {
      mode = "n";
      key = "<leader>uC";
      action = "function() Snacks.picker.colorschemes() end";
      lua = true;
      desc = "Colorschemes";
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
      action = "function() Snacks.words.jump(vim.v.count1) end";
      lua = true;
      desc = "Next Reference";
    }
    {
      mode = "n";
      key = "[w";
      action = "function() Snacks.words.jump(-vim.v.count1) end";
      lua = true;
      desc = "Previous Reference";
    }

    # Mini
    {
      mode = "n";
      key = "<leader>gt";
      action = "function() MiniDiff.toggle_overlay() end";
      lua = true;
      desc = "Git hunk toggle overlay";
    }

    # Sidekick
    {
      mode = [
        "n"
        "t"
        "i"
        "x"
      ];
      key = "<C-.>";
      action = "function() require('sidekick.cli').toggle() end";
      lua = true;
      desc = "Sidekick Toggle";
    }
    {
      mode = "n";
      key = "<leader>as";
      action = "function() require('sidekick.cli').select() end";
      lua = true;
      desc = "Sidekick Select CLI";
    }
    {
      mode = "n";
      key = "<leader>ad";
      action = "function() require('sidekick.cli').close() end";
      lua = true;
      desc = "Detach Sidekick Session";
    }
    {
      mode = [
        "n"
        "x"
      ];
      key = "<leader>at";
      action = "function() require('sidekick.cli').send({ msg = '{this}' }) end";
      lua = true;
      desc = "Sidekick Send This";
    }
    {
      mode = "n";
      key = "<leader>af";
      action = "function() require('sidekick.cli').send({ msg = '{file}' }) end";
      lua = true;
      desc = "Sidekick Send File";
    }
    {
      mode = "x";
      key = "<leader>av";
      action = "function() require('sidekick.cli').send({ msg = '{selection}' }) end";
      lua = true;
      desc = "Sidekick Send Selection";
    }
    {
      mode = [
        "n"
        "x"
      ];
      key = "<leader>aa";
      action = "function() require('sidekick.cli').prompt() end";
      lua = true;
      desc = "Sidekick Prompt";
    }

    # Custom
    {
      mode = "n";
      key = "<Space>q";
      action = "<cmd>qa<CR>";
      desc = "Quit all";
    }
    {
      mode = "n";
      key = "<Space>k";
      action = "<cmd>bd<CR>";
      desc = "Delete buffer";
    }
    {
      mode = "n";
      key = "<Esc>";
      action = "<cmd>nohlsearch<CR>";
      desc = "Clear search highlight";
    }
  ];
}
