# dev.tmux
SESSION="go-dev"

# Check if the session already exists
tmux has-session -t $SESSION 2>/dev/null

if [ $? != 0 ]; then
  # Create session, split panes
  tmux new-session -d -s $SESSION
  tmux split-window -h -t $SESSION
  tmux split-window -v -t $SESSION
fi

# Attach
tmux attach-session -t $SESSION
