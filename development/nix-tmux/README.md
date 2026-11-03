# Tmux 

Local development environment for Tmux.

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

Nix Shell Script:

```nix
with import <nixpkgs> {};

let
  # External Script: This reads './dev.tmux' and puts it into a binary named 'dev-tmux'
  tmuxLayout   = pkgs.writeShellScriptBin "dev-tmux" (builtins.readFile ./dev.tmux);
in
pkgs.mkShell {

  name = "tmux-dev";
  nativeBuildInputs = with pkgs; [
    tmux
    tmuxLayout
  ];

  LANGUAGE = "Tmux";
  VERSION  = "tmux -V";

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


## Example: Ollama + Go dev.tmux
Setup a `Ollama` + `go` development environment using tmux dev configuration.

```bash
#!/usr/bin/env bash
# DEFAULT_PORT
DEFAULT_PORT=8080

# Detect OS shell
if [[ "$OSTYPE" == "darwin"* ]]; then
  SHELL_CMD="zsh"
else
  SHELL_CMD="bash"
fi

# Generate random Docker-like name
generate_session_name() {
  ADJECTIVES=(happy brave calm eager fancy gentle jolly kind lucky nice proud quick shiny witty bold clever)
  NOUNS=(tiger panda eagle otter fox whale lion falcon wolf bear koala shark)
  adj=${ADJECTIVES[$RANDOM % ${#ADJECTIVES[@]}]}
  noun=${NOUNS[$RANDOM % ${#NOUNS[@]}]}
  echo "${adj}-${noun}-dev"
}

SESSION=${2:-$(generate_session_name)}
echo "Using SESSION=$SESSION"

# Check if the session already exists
tmux has-session -t "$SESSION" 2>/dev/null

# Create new session if it doesn't exist
if [ $? != 0 ]; then
  # ==========================================
  # Window 1: Go Dev (Equivalent to "Go Dev" tab)
  # ==========================================
  tmux new-session -d -s "$SESSION" -n "Go Dev" "$SHELL_CMD"

  # Split vertically (-v) with -p 20 to allocate 20% for Build and 80% for Dev
  tmux split-window -v -p 20 -t "$SESSION:0" "$SHELL_CMD"

  # Select back to the top "Dev" pane
  tmux select-pane -t "$SESSION:0.0"

  # ==========================================
  # Window 2: Ollama (Equivalent to "Ollama" tab)
  # ==========================================
  # Create the second window named "Ollama" (this will be window index 1)
  tmux new-window -t "$SESSION" -n "Ollama" "$SHELL_CMD"

  # Split window horizontally (-h) to create left ("Terminal") and right sides
  tmux split-window -h -t "$SESSION:1.0" "$SHELL_CMD"

  # Split the right pane vertically (-v) into top and bottom halves
  tmux split-window -v -t "$SESSION:1.1" "$SHELL_CMD"

  # Run commands in the Ollama panes on the right side
  # Top-right pane: ollama serve
  tmux send-keys -t "$SESSION:1.1" "ollama serve" C-m

  # Bottom-right pane: ollama run gemma4:e4b
  tmux send-keys -t "$SESSION:1.2" "ollama run gemma4:e4b" C-m

  # Focus on the "Ollama" window by default (matching focus=true in dev.kdl)
  tmux select-window -t "$SESSION:1"
fi

tmux attach-session -t "$SESSION"
```

## Example: Hugo dev.tmux
Setup a `Hugo` development environment using tmux dev configuration.

```bash
#!/usr/bin/env bash

set -euo pipefail

DEFAULT_PORT=8088

PORT="${1:-$DEFAULT_PORT}"

# Docker-style random session names
# ADJECTIVES=(
#     admiring bold clever eager festive focused
#     gifted happy kind lucid nifty quirky
#     relaxed serene stoic vibrant wonderful zealous
# )
#
# NAMES=(
#     babbage berners_lee dijkstra hopper knuth
#     lovelace mccarthy ritchie shannon stallman
#     thompson torvalds turing von_neumann wozniak
# )

random_item() {
    local -n array=$1
    printf '%s' "${array[RANDOM % ${#array[@]}]}"
}


generate_session_name() {
  local adjectives=(
    happy brave calm eager fancy gentle jolly kind
    lucky nice proud quick shiny witty bold clever
  )

  local nouns=(
    tiger panda eagle otter fox whale lion falcon
    wolf bear koala shark
  )

  local adj="${adjectives[RANDOM % ${#adjectives[@]}]}"
  local noun="${nouns[RANDOM % ${#nouns[@]}]}"

  echo "${adj}-${noun}-dev"
}

if [[ -n "${2:-}" ]]; then
    SESSION="$2"
else
    SESSION="$(generate_session_name)"

    # Avoid collisions with existing sessions.
    while tmux has-session -t "$SESSION" 2>/dev/null; do
        SESSION="$(generate_session_name)"
    done
fi

echo "Using PORT=$PORT"
echo "Using SESSION=$SESSION"


# -----------------------------------------------------------------------------
# Attach to an existing session
# -----------------------------------------------------------------------------

# Check if the session already exists
if ! tmux has-session -t "$SESSION" 2>/dev/null; then

    # -----------------------------------------------------------------------------
    # Create session
    # -----------------------------------------------------------------------------
    tmux new-session -d -s "$SESSION" "zsh -i"

    tmux split-window \
        -h \
        -t "$SESSION" \
        "hugo server -D -p $PORT --disableFastRender --cleanDestinationDir; exec zsh -i"

    tmux split-window \
        -v \
        -t "$SESSION:0.0" \
        "zsh -i"

    tmux select-layout -t "$SESSION:0" main-vertical
    tmux select-pane -t "$SESSION:0.0"

    tmux send-keys \
        -t "$SESSION:0.0" \
        "hugo version; tree -L 2" \
        C-m
fi

# -----------------------------------------------------------------------------
# If TMPDIR points to a stale nix-shell folder, fall back to /tmp
# -----------------------------------------------------------------------------
if [ ! -d "$TMPDIR" ]; then
   export TMPDIR="/tmp"
fi

# -----------------------------------------------------------------------------
# Attach
# -----------------------------------------------------------------------------
exec tmux attach-session -t "$SESSION"
```

## Example: Go dev.tmux

Setup a Go Dev environment using tmux dev configuration.

```bash
#!/usr/bin/env bash

set -euo pipefail

DEFAULT_PORT=8088

PORT="${1:-$DEFAULT_PORT}"

# Docker-style random session names
# ADJECTIVES=(
#     admiring bold clever eager festive focused
#     gifted happy kind lucid nifty quirky
#     relaxed serene stoic vibrant wonderful zealous
# )
#
# NAMES=(
#     babbage berners_lee dijkstra hopper knuth
#     lovelace mccarthy ritchie shannon stallman
#     thompson torvalds turing von_neumann wozniak
# )

random_item() {
    local -n array=$1
    printf '%s' "${array[RANDOM % ${#array[@]}]}"
}


generate_session_name() {
  local adjectives=(
    happy brave calm eager fancy gentle jolly kind
    lucky nice proud quick shiny witty bold clever
  )

  local nouns=(
    tiger panda eagle otter fox whale lion falcon
    wolf bear koala shark
  )

  local adj="${adjectives[RANDOM % ${#adjectives[@]}]}"
  local noun="${nouns[RANDOM % ${#nouns[@]}]}"

  echo "${adj}-${noun}-dev"
}

if [[ -n "${2:-}" ]]; then
    SESSION="$2"
else
    SESSION="$(generate_session_name)"

    # Avoid collisions with existing sessions.
    while tmux has-session -t "$SESSION" 2>/dev/null; do
        SESSION="$(generate_session_name)"
    done
fi

echo "Using PORT=$PORT"
echo "Using SESSION=$SESSION"


# -----------------------------------------------------------------------------
# Attach to an existing session
# -----------------------------------------------------------------------------

# Check if the session already exists
if ! tmux has-session -t "$SESSION" 2>/dev/null; then

    # -----------------------------------------------------------------------------
    # Create session
    # -----------------------------------------------------------------------------
    tmux new-session -d -s "$SESSION" "zsh -i"

    tmux split-window \
        -h \
        -t "$SESSION" \
        "go version; exec zsh -i"

    tmux split-window \
        -v \
        -t "$SESSION:0.0" \
        "zsh -i"

    tmux select-layout -t "$SESSION:0" main-vertical
    tmux select-pane -t "$SESSION:0.0"

    tmux send-keys \
        -t "$SESSION:0.0" \
        "tree -L 2" \
        C-m
fi

# -----------------------------------------------------------------------------
# If TMPDIR points to a stale nix-shell folder, fall back to /tmp
# -----------------------------------------------------------------------------
if [ ! -d "$TMPDIR" ]; then
   export TMPDIR="/tmp"
fi

# -----------------------------------------------------------------------------
# Attach
# -----------------------------------------------------------------------------
exec tmux attach-session -t "$SESSION"
```
