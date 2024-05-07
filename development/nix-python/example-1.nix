with import <nixpkgs> {};

stdenv.mkDerivation {
  name = "python-dev";

  buildInputs = [
    python313
  ];

  LANGUAGE = "Python";

  shellHook = ''
    # Optional: Script environment start up 
    echo "Welcome to $LANGUAGE Development Environment"
  '';
}
