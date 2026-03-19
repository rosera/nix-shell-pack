with import <nixpkgs> {};

{ pkgs ? import <nixpkgs> { }
,  pkgsLinux ? import <nixpkgs> { system = "x86_64-linux"; }
}:

let
echo-api = stdenv.mkDerivation {
  name = "bash-echo";
  dontUnpack = true;
  system = builtins.currentSystem;
  src = ./src;
  buildInputs = [busybox];
  buildPhase = '' '';
  installPhase = '' '';

  shellHook = ''
    # Optional: Script environment start up 
    echo
  '';
};
in
#
pkgs.dockerTools.buildImage {
  name = "echo-api";
  tag = "latest";

  config = {
    Cmd = [ "${echo-api} Hello, World!" ];
  };
}
