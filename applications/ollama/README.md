# Ollama 

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
