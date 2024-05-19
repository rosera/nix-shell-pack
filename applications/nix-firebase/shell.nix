with import <nixpkgs> {};

pkgs.mkShell {
  name = "firebase-dev";

  nativeBuildInputs = with pkgs; [
    nodejs_20
    nodePackages_latest.webpack
    firebase-tools
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
