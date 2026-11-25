_final: prev: {
  # Remove once nixpkgs no longer depends on the insecure PyPDF2 package.
  krop = prev.krop.override {
    python3Packages = prev.python3Packages // {
      pypdf2 = prev.python3Packages.pypdf;
    };
  };
}
