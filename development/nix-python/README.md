# Python 

Nix Shell Script:

```nix
with import <nixpkgs> {};

stdenv.mkDerivation {
  name = "python-dev";

  buildInputs = [
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
