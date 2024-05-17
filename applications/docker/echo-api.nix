{ pkgs ? import <nixpkgs> { }
,  pkgsLinux ? import <nixpkgs> { system = "x86_64-linux"; }
}:

pkgs.dockerTools.buildImage {
  name = "echo-api";
  tag = "latest";

  config = {
    Cmd = [ "${pkgsLinux.hello}/bin/hello" ];
  };
}
