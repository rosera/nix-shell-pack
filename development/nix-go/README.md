# Go 

Nix Shell Script:

```nix
with import <nixpkgs> {};

pkgs.mkShell {
  name = "go-dev";

  nativeBuildInputs = with pkgs; [
    go 
  ];

  LANGUAGE = "Go";
  VERSION  = "go version";

  shellHook = ''
    # Optional: Script environment start up 
    echo "Welcome to $LANGUAGE Development Environment"
    $VERSION
  '';
}
```
