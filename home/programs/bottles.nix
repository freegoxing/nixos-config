{ pkgs, ... }:

{
  nixpkgs.overlays = [
    (final: prev: {
      bottles-unwrapped = prev.bottles-unwrapped.overrideAttrs (old: {
        postPatch = (old.postPatch or "") + ''
          # Fix connectivity check:
          # unavailable endpoint, HEAD request and blocked PycURL User-Agent
          substituteInPlace bottles/backend/utils/connection.py \
            --replace-fail \
            '"https://ping.usebottles.com"' \
            '"https://proxy.usebottles.com/repo/components/index.yml"'

          substituteInPlace bottles/backend/utils/connection.py \
            --replace-fail \
            'c.setopt(c.NOBODY, True)' \
            $'c.setopt(c.NOBODY, False)\n            c.setopt(c.WRITEFUNCTION, lambda data: len(data))\n            c.setopt(pycurl.USERAGENT, "curl/8.18.0")'

          # Fix repository index checks
          substituteInPlace bottles/backend/managers/repository.py \
            --replace-fail \
            'c.setopt(c.NOBODY, True)' \
            $'c.setopt(c.NOBODY, False)\n                    c.setopt(c.WRITEFUNCTION, lambda data: len(data))\n                    c.setopt(pycurl.USERAGENT, "curl/8.18.0")'

          # Fix catalog and manifest downloads
          substituteInPlace bottles/backend/repos/repo.py \
            --replace-fail \
            'c.setopt(c.FOLLOWLOCATION, True)' \
            $'c.setopt(c.FOLLOWLOCATION, True)\n            c.setopt(pycurl.USERAGENT, "curl/8.18.0")'

          # Validate patched Python files
          python3 -m py_compile \
            bottles/backend/utils/connection.py \
            bottles/backend/managers/repository.py \
            bottles/backend/repos/repo.py
        '';

        nativeBuildInputs =
          (old.nativeBuildInputs or []) ++ [ final.python3 ];
      });
    })
  ];

  home.packages = [
    (pkgs.bottles.override {
      removeWarningPopup = true;
    })
  ];
}
