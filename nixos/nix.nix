{ ... }:
{
  nix.settings = {
    substituters = [
      "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store"
      "https://mirrors.ustc.edu.cn/nix-channels/store"
      "https://cache.nixos.org/"
      "https://freegoxing.cachix.org"
    ];
    extra-trusted-public-keys = [
      "freegoxing.cachix.org-1:Ia2BQ6nVNVGtsD90NNrEsN1QEiykaRVBUIu61xZZVBY="
    ];
    experimental-features = [
      "nix-command"
      "flakes"
    ];
    auto-optimise-store = true;
  };
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 14d";
  };
  nixpkgs.config.allowUnfree = true;
}
