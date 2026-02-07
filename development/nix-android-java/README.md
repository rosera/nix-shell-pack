# Android Java 

Local development environment for Android + Java.

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
    javaPackages.compiler.temurin-bin.jdk-21
    android-tools
  ];

  LANGUAGE = "Android Java";
  VERSION  = "java --version";

  shellHook = ''
    # Optional: Script environment start up
    echo "Welcome to $LANGUAGE Development Environment"
    $VERSION
  '';
}
```
