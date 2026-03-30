with import <nixpkgs> {};

{ pkgs ? import <nixpkgs> { }
,  pkgsLinux ? import <nixpkgs> { system = "x86_64-linux"; }
}:

pkgs.dockerTools.streamNixShellImage {
  name = "bash-echo";
  tag  = "latest";
  drv = pkgs.mkShell {
    shellHook = ''
      # Optional: Script environment start up 
      echo Hello Docker
    '';
  };
}
