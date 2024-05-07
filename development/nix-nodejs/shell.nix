with import <nixpkgs> {};

stdenv.mkDerivation {
  name = "nodejs-dev";

  buildInputs = [
    nodejs_20
  ];

  LANGUAGE = "Nodejs";
  VERSION  = "node --version";

  shellHook = ''
    # Optional: Script environment start up 
    echo "Welcome to $LANGUAGE Development Environment"
    $VERSION
  '';
}
