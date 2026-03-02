# Go 

Local development environment for Go.

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

- [x] shell.nix
- [x] dev.tmux

### nix.shell:

```nix
with import <nixpkgs> {};

let
  # External Script: This reads './dev.tmux' and puts it into a binary named 'dev-tmux'
  tmuxLayout   = pkgs.writeShellScriptBin "dev-tmux" (builtins.readFile ./dev.tmux);
in
pkgs.mkShell {

  name = "tmux-dev";
  nativeBuildInputs = with pkgs; [
    go 
    tmux
    tmuxLayout
  ];

  LANGUAGE = "Go";
  VERSION  = "go version";
  SESSION  = "go-dev";

  shellHook = ''
    # Optional: Script environment start up
    echo "Welcome to $LANGUAGE Development Environment"
    $VERSION

    # The Trap: This kills the tmux session as soon as you exit the nix-shell
    # It ensures no "ghost" sessions stay running in the background.
    trap "tmux kill-session -t go-dev" EXIT

    # Perform Tmux Dev Layout
    exec dev-tmux $SESSION
  '';
}
```


### dev.tmux

A basic script to access a parameter for the session name.
If a session name is not provided, it will default to `go-dev`.


```bash
#!/bin/bash

# Use the first argument if provided, otherwise default to "go-dev"
SESSION=${1:-"go-dev"}

# Check if the session already exists
tmux has-session -t $SESSION 2>/dev/null

if [ $? != 0 ]; then
  # Create session, split panes
  tmux new-session -d -s $SESSION
  tmux split-window -h -t $SESSION
  tmux split-window -v -t $SESSION
fi

# Smart attach: Switch if already inside tmux, otherwise attach
if [ -z "$TMUX" ]; then
    tmux attach-session -t "$SESSION"
else
    tmux switch-client -t "$SESSION"
fi
```
