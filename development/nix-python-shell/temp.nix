with import <nixpkgs> {};

stdenv.mkDerivation {
  name = "python-dev";
  builder = "/bin/bash";
  system = builtins.currentSystem;

  buildInputs = [
    python313
  ];

  shellHook = ''
    # Optional: Script environment start up 
    echo "Welcome to Nix Development Environment"
  '';
}
