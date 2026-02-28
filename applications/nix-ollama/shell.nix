with import <nixpkgs> {};

let
  # External Script: This reads './dev.kdl' and puts it into a binary named 'dev-zellij'
  scriptZellijLayout = pkgs.writeText "dev.kdl" (builtins.readFile ./dev.kdl);
  zellijLayout = pkgs.writeShellScriptBin "dev-zellij" ''
    ${pkgs.zellij}/bin/zellij --layout ${scriptZellijLayout}
  '';
in
pkgs.mkShell {
  name = "ollama-app";

  nativeBuildInputs = with pkgs; [
    ollama 
    # haskellPackages.cuda
    zellij
    zellijLayout
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
    # zellij --layout ollama-layout.kdl
    # Optional: Script environment start up 
    # echo "Welcome to $APPLICATION Environment"
    # zellij action new-tab --layout ollama-layout-file.kdl
    exec dev-zellij
  '';
}
