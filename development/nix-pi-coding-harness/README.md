# Pi Coding Agent

Local development environment for Pi Coding Harness + Ollama using Tmux|Zellij.

## Run

Start the environment by entering the following command:

```
nix-shell
```

## Usage

Use the following to run the default `shell.nix` script.

```
nix-shell --pure
```

## Script

## Tmux Environment

```nix
with import <nixpkgs> {};

let
  ## Tmux Custom Script
  ##  External Script: This reads './dev.tmux' and puts it into a binary named 'dev-tmux'
  tmuxLayout   = pkgs.writeShellScriptBin "dev-tmux" (builtins.readFile ./dev.tmux);

in
pkgs.mkShell {

  name = "pi-agent";

  nativeBuildInputs = with pkgs; [
    oh-my-zsh
    ollama
    pi-coding-agent
    tmux
    tmuxLayout
    vim
  ];

  LANGUAGE = "Pi Coding Agent";
  VERSION  = "ollama --version";

  shellHook = ''
    # Optional: Script environment start up
    echo "Welcome to $LANGUAGE Development Environment"
    $VERSION

    # The Trap: This kills the tmux session as soon as you exit the nix-shell
    # It ensures no "ghost" sessions stay running in the background.
    trap "tmux kill-session -t go-dev" EXIT

    # Perform Tmux Dev Layout
    exec dev-tmux
  '';
}
```


## Zellij Environment

Pi Coding Harness with Ollama in a Zellij Environment Nix Shell Script:

```nix
with import <nixpkgs> {};

let
  ## Tmux Custom Script
  # External Script: This reads './dev.kdl' and puts it into a binary named 'dev-zellij'
  scriptZellijLayout = pkgs.writeText "dev.kdl" (builtins.readFile ./dev.kdl);
  
  zellijConfig = pkgs.writeText "config.kdl" ''
    default_mode "normal"
  '';

  zellijLayout = pkgs.writeShellScriptBin "dev-zellij" ''
    ${pkgs.zellij}/bin/zellij \
      --config ${zellijConfig} \
      --layout ${scriptZellijLayout}
  '';

in
pkgs.mkShell {

  name = "pi-agent";

  nativeBuildInputs = with pkgs; [
    oh-my-zsh
    ollama
    pi-coding-agent
    vim
    zellij
    zellijLayout
  ];

  LANGUAGE = "Pi Coding Agent";
  VERSION  = "ollama --version";

  shellHook = ''
    # Optional: Script environment start up
    echo "Welcome to $LANGUAGE Development Environment"
    $VERSION

    exec dev-zellij
  '';
}
```
