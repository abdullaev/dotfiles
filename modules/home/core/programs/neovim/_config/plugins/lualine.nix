{
  enable = true;
  settings = {
    options = {
      section_separators = {
        left = "";
        right = "";
      };
      component_separators = {
        left = "⁞";
        right = "";
      };
    };
    sections = {
      lualine_a = [ "mode" ];
      lualine_b = [ "branch" "diff" "diagnostics" ];
      lualine_c = [
        {
          __unkeyed-1 = "filename";
          path = 1;
          shorting_target = 40;
        }
      ];
      lualine_x = [ "lsp_status" ];
      lualine_y = [ "progress" ];
      lualine_z = [ "location" ];
    };
  };
}
