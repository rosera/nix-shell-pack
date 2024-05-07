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
