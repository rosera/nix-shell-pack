with import <nixpkgs> {};

pkgs.mkShell {
  name = "hugo-dev";

  nativeBuildInputs = with pkgs; [
    hugo
  ];

  LANGUAGE     = "Hugo";
  VERSION      = "hugo --version";

  shellHook = ''
    # Optional: Script environment start up 
    echo "Welcome to $LANGUAGE Development Environment"
    $VERSION
  '';
}
