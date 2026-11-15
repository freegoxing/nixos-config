{ ... }:

{
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "free";
        email = "mpdf2023@outlook.com";
      };

      init.defaultBranch = "master";

      pull.rebase = true;

      rebase.autoStash = true;

      push.autoSetupRemote = true;

      core.autocrlf = "input";
    };
  };

  programs.delta = {
    enable = true;
    enableGitIntegration = true;

    options = {
      navigate = true;
      line-numbers = true;
      side-by-side = true;
      syntax-theme = "Dracula";
    };
  };
}
