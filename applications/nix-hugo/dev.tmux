#!/usr/bin/env bash
DEFAULT_PORT=8080

# Detect if we are on a Mac
if [[ "$OSTYPE" == "darwin"* ]]; then
  SHELL_CMD="zsh"
else
  SHELL_CMD="bash"
fi

# TMUX PORT
#-----------------------------------------------------------------------------

# Check if port is in use
port_in_use() {
  lsof -i :"$1" >/dev/null 2>&1
}

# Find next available port
find_free_port() {
  local port=$1
  while port_in_use "$port"; do
    echo "Port $port is in use, trying $((port + 1))..."
    port=$((port + 1))
  done
  echo "$port"
}

# Args
REQUESTED_PORT=${1:-$DEFAULT_PORT}

# Resolve port
PORT=$(find_free_port "$REQUESTED_PORT")

echo "Using PORT=$PORT"

# TMUX SESSION
#-----------------------------------------------------------------------------

# Generate random Docker-like name
generate_session_name() {
  ADJECTIVES=(happy brave calm eager fancy gentle jolly kind lucky nice proud quick shiny witty bold clever)
  NOUNS=(tiger panda eagle otter fox whale lion falcon wolf bear koala shark)

  adj=${ADJECTIVES[$RANDOM % ${#ADJECTIVES[@]}]}
  noun=${NOUNS[$RANDOM % ${#NOUNS[@]}]}
  echo "${adj}-${noun}-dev"
}

# Session Names are generated
SESSION=${2:-$(generate_session_name)}
echo "Using SESSION=$SESSION"

# Check if the session already exists
tmux has-session -t "$SESSION" 2>/dev/null

if [ $? != 0 ]; then
  tmux new-session -d -s "$SESSION" "$SHELL_CMD"
  tmux split-window -h -t "$SESSION" "$SHELL_CMD"
  tmux split-window -v -t "$SESSION" "$SHELL_CMD"

  # Set prompt to Session 0
  # tmux send-keys -t "$SESSION":0

  # Send the hugo command to pane 0
  # C-m at the end simulates pressing "Enter"
  tmux send-keys -t $SESSION:0 "until hugo serve -D -p $PORT; do echo 'Command failed. Press Enter to retry...'; read; done" C-m
fi

tmux attach-session -t "$SESSION"
