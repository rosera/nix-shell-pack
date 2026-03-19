with import <nixpkgs> {};

{ pkgs ? import <nixpkgs> { }
,  pkgsLinux ? import <nixpkgs> { system = "x86_64-linux"; }
}:

let
echo-api = pkgs.dockerTools.streamNixShellImage {
  name = "bash-echo";
  tag  = "latest";
  drv = pkgs.mkShell {
    shellHook = ''
      # Optional: Script environment start up 
      echo Hello Docker
    '';
  };
};
in
#
pkgs.dockerTools.buildImage {
  name = "echo-api";
  tag = "latest";

  config = {
    Cmd = [ "${echo-api}" ];
  };
}
