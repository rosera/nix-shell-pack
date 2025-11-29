# Minikube 

Local development environment for Minikube.

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


## Config

The driver needs to be set to the machine specific configuration:

```bash
minikube start --driver qemu --network socket_vmnet
```

## Script

The following is a basic environment.

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
