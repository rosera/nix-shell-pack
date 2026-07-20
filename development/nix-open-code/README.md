# Ollama Open Code

Local development environment for Ollama with Open Code.

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
  name = "opencode";

  nativeBuildInputs = with pkgs; [
    ollama
    opencode 
    zellij
    zellijLayout
    vim
  ];

  APPLICATION = "OpenCode";
  # VERSION  = "claude --version";

  shellHook = ''
    # DEV ENV
    exec dev-zellij
  '';
}
```
