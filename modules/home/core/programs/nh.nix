{
  den.aspects.nh = { user, ... }: {
    homeManager = {
      programs.nh = {
        enable = true;
        flake = user.dotfilesPath or "/home/${user.userName}/dotfiles";
      };
    };
  };
}
