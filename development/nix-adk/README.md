# Agent Development Kit 

## Quickstart Tutorial

[Build an agent with the Agent Development Kit](https://cloud.google.com/vertex-ai/generative-ai/docs/agent-development-kit/quickstart)

- [ ] Google Cloud Project
- [ ] Nix Development Environment

## Nix Shell

1. Start Nix Shell
```
nix-shell --pure
```


## Nix Script

Nix Shell Script:

```nix
with import <nixpkgs> {};

pkgs.mkShell {
  name = "adk-dev";

  nativeBuildInputs = with pkgs; [
    python313
  ];

  LANGUAGE = "Agent Development Kit";
  VERSION  = "python --version";

  shellHook = ''
    # Optional: Script environment start up 
    echo "Welcome to $LANGUAGE Environment"
    $VERSION
    python -m venv ./venv
    source ./venv/bin/activate
    python -m pip install google-adk
  '';
}
```
