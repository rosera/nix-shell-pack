# Minikube 
## Config

```bash
minikube start --driver qemu --network socket_vmnet
```


Nix Shell Script:

```nix
with import <nixpkgs> {};

pkgs.mkShell {
  name = "minikube-dev";

  nativeBuildInputs = with pkgs; [
    minikube 
    docker
  ];

  APPLICATION = "Minikube";
  VERSION  = "minikube version";

  shellHook = ''
    # Optional: Script environment start up 
    echo "Welcome to $APPLICATION Development Environment"
    $VERSION
  '';
}
```
