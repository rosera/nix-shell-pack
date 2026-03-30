with import <nixpkgs> {};

let
  # External Script: This reads './dev.kdl' and puts it into a binary named 'dev-zellij'
  scriptZellijLayout = pkgs.writeText "dev.kdl" (builtins.readFile ./dev.kdl);
  zellijLayout = pkgs.writeShellScriptBin "dev-zellij" ''
    ${pkgs.zellij}/bin/zellij --layout ${scriptZellijLayout}
  '';
in
pkgs.mkShell {
  name = "hugo-dev";

  nativeBuildInputs = with pkgs; [
    hugo
    zellij                         # zellij support
    zellijLayout                   # zellij layout definition
  ];

  LANGUAGE     = "Hugo";
  VERSION      = "hugo version";

  shellHook = ''
    # Optional: Script environment start up 
    echo "Welcome to $LANGUAGE Development Environment"
    $VERSION
    # Set a layout using Zellij
    exec dev-zellij
  '';
}
