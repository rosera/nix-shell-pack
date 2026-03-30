# Python 

Local development environment for Python.

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
  name = "python-dev";

  nativeBuildInputs = with pkgs; [
    python313
  ];

  LANGUAGE = "Python";
  VERSION  = "python --version";

  shellHook = ''
    # Optional: Script environment start up 
    echo "Welcome to $LANGUAGE Development Environment"
    $VERSION
  '';
}
```
