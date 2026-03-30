# Docker 

Nix Shell Script:

```nix
with import <nixpkgs> {};

pkgs.mkShell {
  name = "docker-app";

  nativeBuildInputs = with pkgs; [
    docker_25 
  ];

  APPLICATION = "Docker";
  VERSION  = "docker --version";

  shellHook = ''
    # Optional: Script environment start up 
    echo "Welcome to $APPLICATION Environment"
    $VERSION
  '';
}
```
