{ pkgs ? import <nixpkgs> { }
# ,  pkgsLinux ? import <nixpkgs> { system = "x86_64-linux"; }
, pkgsLinux ? import <nixpkgs> { system = "aarch64-linux"; }
}:

pkgs.dockerTools.buildImage {
  name = "echo-api";
  tag = "latest";

  fromImage = alpine:3:19;
  fromImageName = null;
  fromImageTag = "latest";

  runAsRoot = ''
    mkdir -p /app
  '';

  config = {
    Cmd = [ "/bin/echo" "{\"message\":\"Hello Docker!\"}" ];
    WorkingDir = "/app";
  };
}
