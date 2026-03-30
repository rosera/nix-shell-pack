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
