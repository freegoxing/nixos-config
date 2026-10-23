{ pkgs, ... }:
{ home.packages = with pkgs; [ fastfetch which eza nix-output-monitor ]; }
