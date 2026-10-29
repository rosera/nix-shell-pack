#!/usr/bin/env bash

# DEFAULT_PORT
DEFAULT_PORT=8089

# Detect if we are on a Mac
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

# Create new session matching the dev.kdl layout if it doesn't exist
if [ $? != 0 ]; then
  # ----------------------------------------------------
  # Window 1: Pi Agent (matches "Pi Agent" tab in dev.kdl)
  # ----------------------------------------------------
  tmux new-session -d -s "$SESSION" -n "Pi Agent" "$SHELL_CMD"
  tmux send-keys -t "$SESSION:Pi Agent" "ollama launch pi --model gemma4:e2b" C-m

  # ----------------------------------------------------
  # Window 2: Ollama (matches "Ollama" tab in dev.kdl)
  # ----------------------------------------------------
  # Create second window
  tmux new-window -t "$SESSION" -n "Ollama" "$SHELL_CMD"

  # Split window horizontally: Left pane (Terminal, 70% width), Right pane (30% width)
  tmux split-window -h -p 30 -t "$SESSION:Ollama"

  # Split the right pane vertically to create top and bottom sections
  tmux split-window -v -p 40 -t "$SESSION:Ollama.1"

  # Assign commands to the respective panes in the Ollama window
  # Pane 0 (Left): Terminal shell (left as default shell)
  # Pane 1 (Top Right): Ollama Server
  tmux send-keys -t "$SESSION:Ollama.1" "ollama serve" C-m

  # Pane 2 (Bottom Right): Ollama Run Model
  tmux send-keys -t "$SESSION:Ollama.2" "ollama run gemma4:e2b" C-m
fi

# Attach to the tmux session
tmux attach-session -t "$SESSION"
