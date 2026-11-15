{
  programs.ssh.settings = {
    ubuntu-ts = {
      HostName = "100.108.211.1";
      User = "free";
      HostKeyAlias = "ddnsv6.556756.xyz";
      IdentityFile = "~/.ssh/id_ed25519";
      Port = 22;
      ConnectTimeout = 5;
      ConnectionAttempts = 1;
      BatchMode = true;
    };

    vmubuntu = {
      HostName = "172.16.31.129";
      User = "vwmare";
      Port = 22;
      IdentityFile = "~/.ssh/vmubuntu_id_ed25519";
    };

    "211" = {
      HostName = "10.202.214.51";
      User = "free";
      Port = 22;
    };

    vmnixos = {
      HostName = "192.168.122.148";
      User = "kvm";
      Port = 22;
    };

    "211-wsl" = {
      HostName = "10.202.129.107";
      User = "a";
      Port = 22;
    };
  };
}
