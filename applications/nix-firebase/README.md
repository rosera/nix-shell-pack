# Firebase 

Local development environment for Firebase.

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

Firebase + Tools with Node. 
* Optional: Added webpack npm packages for development

Nix Shell Script:

```nix
with import <nixpkgs> {};

pkgs.mkShell {
  name = "firebase-dev";

  nativeBuildInputs = with pkgs; [
    nodejs_20
    nodePackages_latest.webpack
    firebase-tools
    cacert        # Support certificates
  ];

  LANGUAGE     = "Firebase";
  VERSION      = "firebase --version";

  shellHook = ''
    # Optional: Script environment start up 
    echo "Welcome to $LANGUAGE Development Environment"
    $VERSION
  '';
}
```
