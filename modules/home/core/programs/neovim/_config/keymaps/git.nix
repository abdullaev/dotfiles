[
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
    key = "<leader>gw";
    action = "function() Snacks.gitbrowse.open() end";
    lua = true;
    desc = "Open origin";
  }
  {
    mode = "n";
    key = "<leader>gt";
    action = "function() MiniDiff.toggle_overlay() end";
    lua = true;
    desc = "Git hunk toggle overlay";
  }
]
