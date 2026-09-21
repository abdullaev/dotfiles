{
  flake.modules.homeManager.steam = {
    # Limit shader compilation parallelism to avoid exhausting RAM and swap.
    xdg.dataFile."Steam/steam_dev.cfg".text = ''
      unShaderBackgroundProcessingThreads 8
      unShaderHighPriorityProcessingThreads 8
    '';
  };
}
