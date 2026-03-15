[
  {
    mode = "i";
    key = "<A-;>";
    action = "function() return insert_char_at_end_of_line(';') end";
    lua = true;
    expr = true;
    desc = "Insert ; at end of line";
  }
  {
    mode = "i";
    key = "<A-S-;>";
    action = "function() return insert_char_at_end_of_line(':') end";
    lua = true;
    expr = true;
    desc = "Insert : at end of line";
  }
  {
    mode = "i";
    key = "<A-,>";
    action = "function() return insert_char_at_end_of_line(',') end";
    lua = true;
    expr = true;
    desc = "Insert , at end of line";
  }
]
