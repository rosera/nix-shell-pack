with import <nixpkgs> {};

let

  ## External Script: This reads './dev.kdl' and puts it into a binary named 'dev-zellij'

  ## Tmux Custom Script -------------------------------------------------------

  # tmuxLayout   = pkgs.writeShellScriptBin "dev-tmux" (builtins.readFile ./dev.tmux);

  ## --------------------------------------------------------------------------


  ## Zellij Custom Script -----------------------------------------------------

  scriptZellijLayout = pkgs.writeText "dev.kdl" (builtins.readFile ./dev.kdl);
  
  ## Zellij Configuration File 
  zellijConfig = pkgs.writeText "config.kdl" ''
    default_mode "normal"
  '';

  ## Zellij Layout ------------------------------------------------------------
  zellijLayout = pkgs.writeShellScriptBin "dev-zellij" ''
    ${pkgs.zellij}/bin/zellij \
      --config ${zellijConfig} \
      --layout ${scriptZellijLayout}
  '';

  ## --------------------------------------------------------------------------

in
pkgs.mkShell {
  name = "ollama-app";

  nativeBuildInputs = with pkgs; [
    ollama                  # Ollama application

    ## tmux                 # Tmux application
    ## tmuxLayout           # Tmux layout

    python314               # Python Version

    vim                     # vim application
    
    zellij                  # Zellij application
    zellijLayout            # Zellij layout
  ];

  APPLICATION = "Ollama";
  # VERSION  = "ollama --version";

  shellHook = ''
    ## # Optional: Set up a virtual environment when entering the shell
    ## python3 -m venv .venv
    ## source .venv/bin/activate
    ## echo "Welcome to $LANGUAGE Development Environment"
    ## $VERSION

    ## Zellij Custom Script ---------------------------------------------------

    # zellij --layout ollama-layout.kdl
    # Optional: Script environment start up 
    zellij action new-tab --layout ollama-layout-file.kdl

    exec dev-zellij

    ## Tmux Custom Script -----------------------------------------------------

    ## # The Trap: This kills the tmux session as soon as you exit the nix-shell
    ## # It ensures no "ghost" sessions stay running in the background.
    ## trap "tmux kill-session -t go-dev" EXIT

    ## exec dev-tmux
  '';
}
