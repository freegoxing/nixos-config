{ pkgs, inputs, ... }:

{
  home.packages = [ (import inputs.nur { inherit pkgs; }).lceda-pro ];
}
