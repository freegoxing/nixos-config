{ ... }:
{
  programs.zsh.shellAliases = {
    rar = "unrar";
    kdiff = "kitty +kitten diff";
    kicat = "kitty +kitten icat";
    kssh = "kitty +kitten ssh";
    knotify = "kitten notify";
    zed = "zeditor";
    pdfocr = "ocrmypdf -l chi_sim+eng --deskew --jobs 15";
  };
}
