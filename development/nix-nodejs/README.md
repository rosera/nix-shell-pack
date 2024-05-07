# NodeJS 

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
