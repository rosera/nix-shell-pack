#!/usr/bin/env bash

set -euo pipefail

# Generate random session names
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

  echo "${adj}-${noun}-ollama"
}

if [[ -n "${1:-}" ]]; then
    SESSION="$1"
else
    SESSION="$(generate_session_name)"

    # Avoid collisions with existing sessions.
    while tmux has-session -t "$SESSION" 2>/dev/null; do
        SESSION="$(generate_session_name)"
    done
fi

echo "Using SESSION=$SESSION"

# -----------------------------------------------------------------------------
# Create session if it doesn't exist
# -----------------------------------------------------------------------------
if ! tmux has-session -t "$SESSION" 2>/dev/null; then

    # -----------------------------------------------------------------------------
    # Window 1: Instructions Tab
    # -----------------------------------------------------------------------------
    tmux new-session -d -s "$SESSION" -n "Instructions" \
        "cat << 'EOF'
======================================================
               OLLAMA ENVIRONMENT GUIDE
======================================================

1. Switch to the 'Ollama' window using Prefix + n.
2. To see available models, check the 'Ollama List' pane 
   or run: ollama list
3. To download and chat with a model, use 'Ollama Models':
   ollama run <model-name>
   (Example: ollama run gemma4:e4b)
4. Type /bye to exit an active model session.
5. To terminate the session: 
   Detach using Prefix + d, then run:
   tmux kill-session -t $SESSION
======================================================
EOF
exec zsh -i"

    # -----------------------------------------------------------------------------
    # Window 2: Ollama Workspace
    # -----------------------------------------------------------------------------
    # Create the main workspace window with the left "Terminal" pane (70% width)
    tmux new-window -t "$SESSION" -n "Ollama" "zsh -i"

    # Split horizontally: Right column gets 30% width, running "ollama serve"
    tmux split-window -h -t "$SESSION:Ollama.0" -p 30 "ollama serve"

    # Split the right column vertically to carve out the bottom 35% for "Ollama Models"
    tmux split-window -v -t "$SESSION:Ollama.1" -p 35 "zsh -i"

    # Split the remaining top section (65% height) to create "Ollama List" (30% of total height -> ~46% of top section)
    # tmux split-window -v -t "$SESSION:Ollama.1" -p 46 "ollama list"
    # Split the remaining top section (65% height) for "Ollama List" and keep it alive
    tmux split-window -v -t "$SESSION:Ollama.1" -p 46 \
      "bash -c 'while true; do clear; ollama list; echo \"\"; read -p \"Press Enter to refresh list...\"; done'"


    # Focus the interactive "Ollama Models" terminal by default
    tmux select-pane -t "$SESSION:Ollama.2"
fi

# -----------------------------------------------------------------------------
# Attach
# -----------------------------------------------------------------------------
exec tmux attach-session -t "$SESSION"
