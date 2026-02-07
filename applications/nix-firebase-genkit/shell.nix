with import <nixpkgs> {};

let
  # External Script: This reads './dev.kdl' and puts it into a binary named 'dev-zellij'
  scriptZellijLayout = pkgs.writeText "dev.kdl" (builtins.readFile ./dev.kdl);
  zellijLayout = pkgs.writeShellScriptBin "dev-zellij" ''
    ${pkgs.zellij}/bin/zellij --layout ${scriptZellijLayout}
  '';
in
pkgs.mkShell {
  name = "firebase-dev";

  nativeBuildInputs = with pkgs; [
    cacert                         # Support certificates
    firebase-tools                 # firebase tools
    git                            # git support
    nodePackages_latest.webpack    # webpack support
    nodejs_20                      # nodejs support
    ollama                         # ollam support
    vim                            # vim support
    zellij                         # zellij support
    zellijLayout                   # zellij layout definition
  ];

  LANGUAGE     = "Firebase Genkit";
  VERSION      = "firebase --version";

  shellHook = ''
    # Optional: Script environment start up 
    echo "Welcome to $LANGUAGE Development Environment"
    $VERSION

    # Installl packages
    # npm i --save genkitx-ollama
    npm i genkitx-ollama

    # Install genkit
    # npm i -g genkit
    npm i genkit

    # Set a layout using Zellij
    # zellij --layout layout.kdl
    dev-zellij
  '';
}
