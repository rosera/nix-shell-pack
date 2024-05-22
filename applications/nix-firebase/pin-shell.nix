# Example: Pin to a Firebase Tools version
{ pkgs ? import <nixpkgs> {}
}:
let
  # firebase-tools
  firebaseToolPkgs = import (fetchTarball "https://github.com/NixOS/nixpkgs/archive/eb090f7b923b1226e8beb954ce7c8da99030f4a8.tar.gz") {};
in
pkgs.mkShell {
  name = "firebase-dev";

  nativeBuildInputs = with pkgs; [
    nodejs_20
    nodePackages_latest.webpack
    #firebase-tools
    firebaseToolPkgs.firebase-tools
    cacert        # Support certificates
  ];

  LANGUAGE     = "Firebase";
  VERSION      = "firebase --version";

  shellHook = ''
    # Optional: Script environment start up 
    echo "Welcome to $LANGUAGE Development Environment"
    $VERSION
  '';
}
