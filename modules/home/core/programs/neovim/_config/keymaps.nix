{
  keymaps = [
    {
      mode = "n";
      key = "<leader>e";
      action = "function() Snacks.explorer() end";
      lua = true;
      desc = "Snacks Explorer";
    }
    {
      mode = "n";
      key = "<leader>ff";
      action = "function() Snacks.picker.files() end";
      lua = true;
      desc = "Find files";
    }
    {
      mode = "n";
      key = "<leader>fg";
      action = "function() Snacks.picker.grep() end";
      lua = true;
      desc = "Live grep";
    }
    {
      mode = "n";
      key = "<leader>fb";
      action = "function() Snacks.picker.buffers() end";
      lua = true;
      desc = "Find buffers";
    }
    {
      mode = "n";
      key = "<leader>fh";
      action = "function() Snacks.picker.help() end";
      lua = true;
      desc = "Help tags";
    }
    {
      mode = "n";
      key = "<leader>gl";
      action = "function() Snacks.picker.git_log() end";
      lua = true;
      desc = "Git commits";
    }
    {
      mode = "n";
      key = "<leader>gL";
      action = "function() Snacks.picker.git_log_line() end";
      lua = true;
      desc = "Git commits (line)";
    }
    {
      mode = "n";
      key = "<leader>gb";
      action = "function() Snacks.picker.git_branches() end";
      lua = true;
      desc = "Git branches";
    }
    {
      mode = "n";
      key = "<leader>gd";
      action = "function() Snacks.picker.git_diff() end";
      lua = true;
      desc = "Git diff hunks";
    }
    {
      mode = "n";
      key = "<leader>gD";
      action = "function() Snacks.picker.git_diff({ staged = true }) end";
      lua = true;
      desc = "Git staged hunks";
    }
    {
      mode = "n";
      key = "<leader>gS";
      action = "function() Snacks.picker.git_stash() end";
      lua = true;
      desc = "Git stash";
    }
    {
      mode = "n";
      key = "<leader>gf";
      action = "function() Snacks.picker.git_log_file() end";
      lua = true;
      desc = "Git commits (file)";
    }
    {
      mode = "n";
      key = "<leader>go";
      action = "function() MiniDiff.toggle_overlay() end";
      lua = true;
      desc = "Git hunk overlay";
    }
  ];
}
