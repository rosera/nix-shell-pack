# NodeJS 

Local development environment for NodeJS.

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

pkgs.mkShell {
  name = "nodejs-dev";

  nativeBuildInputs = with pkgs; [
    nodejs_20
  ];

  LANGUAGE = "NodeJS";
  VERSION  = "node --version";

  shellHook = ''
    # Optional: Script environment start up 
    echo "Welcome to $LANGUAGE Development Environment"
    $VERSION
  '';
}
```
