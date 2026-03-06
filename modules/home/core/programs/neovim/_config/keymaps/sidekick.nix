[
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
]
