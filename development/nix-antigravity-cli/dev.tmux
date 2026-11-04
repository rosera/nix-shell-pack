#!/usr/bin/env bash

SESSION_NAME="dev"

# Check if session already exists; if so, attach to it
tmux has-session -t "$SESSION_NAME" 2>/dev/null
if [ $? -eq 0 ]; then
    tmux attach-session -t "$SESSION_NAME"
    exit 0
fi

# ==========================================
# WINDOW 1: Antigravity
# ==========================================
# Create a new session and rename the first window to "Antigravity"
tmux new-session -d -s "$SESSION_NAME" -n "Antigravity"

# In Zellij, the pane was set to start_suspended true with args.
# We launch agy with the gemini model, but leave it ready/suspended or just running.
# To replicate starting suspended/ready without executing immediately, we can pass the command 
# or prime the prompt. Here we send the command to run agy.
tmux send-keys -t "$SESSION_NAME:Antigravity.0" 'agy --model gemini-3.8-flash'

# Split horizontally for the bottom pane (acting like the Zellij tab-bar equivalent / status area)
tmux split-window -v -t "$SESSION_NAME:Antigravity" -l 1

# Optional: You can run a custom status bar or leave it blank to mimic the minimal look
tmux send-keys -t "$SESSION_NAME:Antigravity.1" 'echo " [Tab Bar / Status]"'


# ==========================================
# WINDOW 2: Terminal
# ==========================================
# Create the second window named "Terminal"
tmux new-window -t "$SESSION_NAME" -n "Terminal"

# Split horizontally for the bottom status/bar line
tmux split-window -v -t "$SESSION_Name:Terminal" -l 1
tmux send-keys -t "$SESSION_NAME:Terminal.1" 'echo " [Tab Bar / Status]"'

# Focus back on the first window and pane
tmux select-window -t "$SESSION_NAME:Antigravity"
tmux select-pane -t "$SESSION_NAME:Antigravity.0"

# Attach to the newly created session
tmux attach-session -t "$SESSION_NAME"
