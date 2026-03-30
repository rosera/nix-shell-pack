# Ollama 

Local development environment for Ollama.

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

pkgs.mkShell {
  name = "ollama-app";

  nativeBuildInputs = with pkgs; [
    ollama 
  ];

  APPLICATION = "ollama";
  VERSION  = "ollama --version";

  shellHook = ''
    # Optional: Script environment start up 
    echo "Welcome to $APPLICATION Environment"
    $VERSION
  '';
}
```
