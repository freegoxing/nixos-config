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
  };
}
