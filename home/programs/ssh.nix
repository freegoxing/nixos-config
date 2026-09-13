{ ... }:
{
  programs.ssh = {
    enable = true;
    addKeysToAgent = "yes";
    matchBlocks.github = {
      hostname = "github.com";
      user = "git";
      identityFile = "~/.ssh/id_25519_github";
    };
  };
}
