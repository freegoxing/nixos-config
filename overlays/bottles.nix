final: prev: {
  bottles-unwrapped = prev.bottles-unwrapped.overrideAttrs (old: {
    postPatch = (old.postPatch or "") + ''
      # Fix connectivity check:
      # Replace HEAD with GET and discard response body
      substituteInPlace bottles/backend/utils/connection.py \
        --replace-fail \
        'c.setopt(c.NOBODY, True)' \
        $'c.setopt(c.NOBODY, False)\n        c.setopt(c.WRITEFUNCTION, lambda data: len(data))'

      # Use a compatible User-Agent for network requests
      for file in \
        bottles/backend/utils/connection.py \
        bottles/backend/managers/repository.py \
        bottles/backend/repos/repo.py
      do
        substituteInPlace "$file" \
          --replace-fail \
          'f"Bottles/{APP_VERSION}"' \
          '"curl/8.18.0"'
      done

      # Validate patched Python files
      python3 -m py_compile \
        bottles/backend/utils/connection.py \
        bottles/backend/managers/repository.py \
        bottles/backend/repos/repo.py
    '';

    nativeBuildInputs = (old.nativeBuildInputs or [ ]) ++ [ final.python3 ];
  });
}
