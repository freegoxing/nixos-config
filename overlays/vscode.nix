_final: prev: {
  vscode =
    if prev.stdenv.hostPlatform.system == "x86_64-linux" then
      prev.vscode.overrideAttrs (old: {
        # VS Code 1.144.0 ships rg under ripgrep-universal in the ASAR archive.
        postPatch =
          builtins.replaceStrings
            [ "resources/app/node_modules/@vscode/ripgrep/bin/rg" ]
            [ "resources/app/node_modules/@vscode/ripgrep-universal/bin/linux-x64/rg" ]
            old.postPatch;
      })
    else
      prev.vscode;
}
