with import <nixpkgs> {};

pkgs.mkShell {
  name = "ollama-app";

  nativeBuildInputs = with pkgs; [
    ollama 
    # haskellPackages.cuda
    # zellij
    # vim
  ];

  APPLICATION = "Ollama";
  VERSION  = "ollama --version";

  shellHook = ''
    # Optional: Script environment start up 
    echo "Welcome to $APPLICATION Environment"
    $VERSION
  '';
}
