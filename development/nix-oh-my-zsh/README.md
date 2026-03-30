# OH MY ZSH 

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
  tmuxLayout = pkgs.writeShellScriptBin "dev-tmux" (builtins.readFile ./dev.tmux);
in
pkgs.mkShell {
  name = "oh-my-zsh-env";

  nativeBuildInputs = with pkgs; [
    coreutils
    meslo-lgs-nf
    ncurses
    oh-my-zsh
    tmuxLayout
    zsh
    zsh-powerlevel10k
  ];

  shellHook = ''
    # 1. Fix the 'locale' error by ensuring basic system paths exist
    export PATH="/usr/bin:/bin:/usr/sbin:/sbin:$PATH"

    # 2. Setup a writable workspace for Zsh
    export ZDOTDIR=$(mktemp -d)
    
    # 3. Handle the p10k config file
    # If .p10k.zsh exists in your project folder, copy it to the writable ZDOTDIR
    if [ -f ./.p10k.zsh ]; then
      cp ./.p10k.zsh "$ZDOTDIR/.p10k.zsh"
    fi

    # 4. Create the .zshrc inside the writable ZDOTDIR
    cat <<EOF > "$ZDOTDIR/.zshrc"
    # Load p10k config if it exists in this writable dir
    [[ ! -f "\$ZDOTDIR/.p10k.zsh" ]] || source "\$ZDOTDIR/.p10k.zsh"

    export ZSH="${pkgs.oh-my-zsh}/share/oh-my-zsh"
    source "${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme"
    
    plugins=(git)
    source \$ZSH/oh-my-zsh.sh

    # Alias to help you save your changes back to the project folder
    alias save-p10k='cp "\$ZDOTDIR/.p10k.zsh" ./.p10k.zsh && echo "Config saved to project folder!"'
EOF

    echo "---"
    echo "Welcome! To get the look in your screenshot:"
    echo "1. Run 'p10k configure'"
    echo "2. When finished, run 'save-p10k' to keep your settings permanently."
    echo "---"

    exec zsh
  '';
}

```
