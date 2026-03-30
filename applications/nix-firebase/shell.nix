with import <nixpkgs> {};

pkgs.mkShell {
  name = "firebase-dev";

  nativeBuildInputs = with pkgs; [
    cacert        # Support certificates
    firebase-tools
    git
    nodejs_20
    nodePackages_latest.webpack
    vim
    zellij
  ];

  LANGUAGE     = "Firebase";
  VERSION      = "firebase --version";

  shellHook = ''
    # Optional: Script environment start up 
    echo "Welcome to $LANGUAGE Development Environment"
    $VERSION
    # Set a layout using Zellij
    zellij --layout layout.kdl
  '';
}
