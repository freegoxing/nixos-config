{ ... }:

{
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    
    settings = {
      "*" = {
        AddKeysToAgent = "yes";
      };
      
      "github.com" = {
        HostName = "github.com";
        User = "git";
        IdentityFile = "~/.ssh/id_ed25519_github";
        IdentitiesOnly = true;
      };
    };
  };
}
