with import <nixpkgs> {};

stdenv.mkDerivation {
  name = "go-dev";

  buildInputs = [
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
