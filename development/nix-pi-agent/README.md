# Pi Coding Agent

Local development environment for Pi using Tmux.

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

The following is a basic environment.

Zellij Environment Nix Shell Script:

```nix
with import <nixpkgs> {};

let
  # External Script: This reads './dev.tmux' and puts it into a binary named 'dev-tmux'
  # tmuxLayout   = pkgs.writeShellScriptBin "dev-tmux" (builtins.readFile ./dev.tmux);

  # External Script: This reads './dev.kdl' and puts it into a binary named 'dev-zellij'
  scriptZellijLayout = pkgs.writeText "dev.kdl" (builtins.readFile ./dev.kdl);
  zellijLayout = pkgs.writeShellScriptBin "dev-zellij" ''
    ${pkgs.zellij}/bin/zellij --layout ${scriptZellijLayout}
  '';

  # Path to the default.nix folder we just built
  pi-agent = import ./pca-0.75.3/default.nix { inherit pkgs; };
in
pkgs.mkShell {

  name = "pi-agent";
  nativeBuildInputs = with pkgs; [
    ollama
    pi-agent
    # tmux
    # tmuxLayout
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

    # The Trap: This kills the tmux session as soon as you exit the nix-shell
    # It ensures no "ghost" sessions stay running in the background.
    trap "tmux kill-session -t go-dev" EXIT

    # Perform Tmux Dev Layout
    # exec dev-tmux

    exec dev-zellij
  '';
}
```
