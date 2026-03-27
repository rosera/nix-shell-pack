#!/usr/bin/env bash

# DEFAULT_PORT
DEFAULT_PORT=8080
SHELL="zsh"

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

# Create new sessions [Optional: ZSH default shell]
if [ $? != 0 ]; then
  tmux new-session -d -s "$SESSION" ${SHELL}
  tmux split-window -h -t "$SESSION" ${SHELL}
  tmux split-window -v -t "$SESSION" ${SHELL}

  tmux send-keys -t "$SESSION":0
fi

tmux attach-session -t "$SESSION"
