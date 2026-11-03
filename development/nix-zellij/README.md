# Zellij 

Local development environment for Zellij.

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
  # External Script: This reads './dev.kdl' and puts it into a binary named 'dev-zellij'
  scriptZellijLayout =
    pkgs.writeText "dev.kdl" (builtins.readFile ./dev.kdl);

  zellijConfig = pkgs.writeText "config.kdl" ''
    default_mode "normal"
  '';

  zellijLayout = pkgs.writeShellScriptBin "dev-zellij" ''
    ${pkgs.zellij}/bin/zellij \
      --config ${zellijConfig} \
      --layout ${scriptZellijLayout}
  '';

in
pkgs.mkShell {

  name = "zellij-dev";
  nativeBuildInputs = with pkgs; [
    zellij
    zellijLayout
  ];

  LANGUAGE = "Zellij";
  VERSION  = "zellij --version";

  shellHook = ''
    # Optional: Script environment start up
    echo "Welcome to $LANGUAGE Development Environment"
    $VERSION

    # Perform Zellij Dev Layout
    exec dev-zellij
  '';
}
```

## Example: Ollama + Go dev.tmux
Setup a `Ollama` + `go` development environment using zellij dev configuration.

```bash
layout {
    default_tab_template {
        pane size=1 borderless=true {
            plugin location="zellij:tab-bar"
        }
        children
        pane size=2 borderless=true {
            plugin location="zellij:status-bar"
        }
    }

    // Go Dev
    tab name="Go Dev" {
        pane name="Dev" size="80%" {
            command "zsh"
        }
        pane name="Build" size="20%" {
            command "zsh"
        }
    }

    // Ollama Dev

    tab name="Ollama" focus=true {

     pane split_direction="vertical" {
       pane {
         name "Terminal"
       }

       pane split_direction="horizontal" {

         pane command="ollama" {
           name "Ollama Server"
           args "serve"
         }

         pane command="ollama" {
           name "Ollama Server"
           /* args "run" "llama3.2" */
           args "run" "gemma4:e4b"
           start_suspended true
         }

       }

     }
   }

}
```
