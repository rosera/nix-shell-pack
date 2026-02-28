with import <nixpkgs> {};

let
  # External Script: This reads './dev.kdl' and puts it into a binary named 'dev-zellij'
  scriptZellijLayout = pkgs.writeText "dev.kdl" (builtins.readFile ./dev.kdl);
  zellijLayout = pkgs.writeShellScriptBin "dev-zellij" ''
    ${pkgs.zellij}/bin/zellij --layout ${scriptZellijLayout}
  '';
in
pkgs.mkShell {

  name = "zellij-dev";
  nativeBuildInputs = with pkgs; [
    go
    zellij
    zellijLayout
  ];

  LANGUAGE = "Zellij";
  VERSION  = "zellij --version";

  shellHook = ''
    # Optional: Script environment start up
    echo "Welcome to $LANGUAGE Development Environment"
    $VERSION

    # Perform Zellij Dev Layout
    dev-zellij
  '';
}
