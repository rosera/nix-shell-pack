with import <nixpkgs> {};

pkgs.mkShell {
  name = "ollama-app";

  nativeBuildInputs = with pkgs; [
    ollama 
    # haskellPackages.cuda
    zellij
    vim
  ];

  APPLICATION = "Ollama";
  # VERSION  = "ollama --version";

  shellHook = ''
    # Optional: Set up a virtual environment when entering the shell
    python3 -m venv .venv
    source .venv/bin/activate
    echo "Welcome to $LANGUAGE Development Environment"
    $VERSION
    zellij --layout ollama-layout.kdl
    # Optional: Script environment start up 
    # echo "Welcome to $APPLICATION Environment"
    # zellij action new-tab --layout ollama-layout-file.kdl
  '';
}
