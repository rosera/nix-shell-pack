# GEMINI CLI

Local development environment for Ollama with Claude Code.

## Run

Start the environment by entering the following command:

```
nix-shell
```

## Usage

```bash
nix-shell --pure
```

## Configuration

The following is a basic environment.

Nix Shell Script:

```nix
with import <nixpkgs> {};

let
  # External Script: This reads './dev.kdl' and puts it into a binary named 'dev-zellij'
  scriptZellijLayout = pkgs.writeText "dev.kdl" (builtins.readFile ./dev.kdl);
  zellijLayout = pkgs.writeShellScriptBin "dev-zellij" ''
    ${pkgs.zellij}/bin/zellij --layout ${scriptZellijLayout}
  '';
in
pkgs.mkShell {
  name = "gemini-cli";

  nativeBuildInputs = with pkgs; [
    gemini-cli 
    vim
    zellij
    zellijLayout
  ];

  APPLICATION = "Gemini CLI";
  # VERSION  = "gemini --version";

  shellHook = ''
    # gemini --model X 

    # DEV ENV
    exec dev-zellij
  '';
}
```
