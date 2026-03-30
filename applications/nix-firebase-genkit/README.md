# Firebase Genkit 

Firebase Genkit + Tools with Node. 
* Optional: Added webpack npm packages for development

Nix Shell Script:

```nix
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
  ];

  LANGUAGE     = "Firebase Genkit";
  VERSION      = "firebase --version";

  shellHook = ''
    # Optional: Script environment start up 
    echo "Welcome to $LANGUAGE Development Environment"
    $VERSION

    # Installl
    npm i --save genkitx-ollama

    # Install genkit
    npm i -g genkit

    # Set a layout using Zellij
    zellij --layout layout.kdl
  '';
}
```
