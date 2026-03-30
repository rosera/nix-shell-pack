# Imagemagick

Local development environment for Imagemagick.

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
  name = "imagickmagick-app";

  nativeBuildInputs = with pkgs; [
    imagemagick 
  ];

  APPLICATION = "Imagemagick";
  VERSION  = "convert -version";

  shellHook = ''
    # Optional: Script environment start up 
    echo "Welcome to $APPLICATION Environment"
    $VERSION
  '';
}
```
