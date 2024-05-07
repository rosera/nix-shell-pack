with import <nixpkgs> {};

pkgs.mkShell {
  name = "nodejs-dev";

  nativeBuildInputs = with pkgs; [
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
