{ pkgs ? import <nixpkgs> {}
, version ? "0.75.3"
}:

let
  lib = pkgs.lib;

  targets = {
    aarch64-darwin = {
      artifact = "pi-darwin-arm64";
      ext = "tar.gz";
      executable = "pi";
      sha256 = "sha256-NS3aWSEFbXBtm3JV9L9fcI1bVMvafZgqJiXhj81aLM0=";
    };

    x86_64-linux = {
      artifact = "pi-linux-x64";
      ext = "tar.gz";
      executable = "pi";
      sha256 = lib.fakeSha256;
    };

    x86_64-windows = {
      artifact = "pi-windows-x64";
      ext = "zip";
      executable = "pi.exe";
      sha256 = lib.fakeSha256;
    };
  };

  target =
    targets.${pkgs.stdenv.hostPlatform.system}
      or (throw "Unsupported platform");

in

pkgs.stdenv.mkDerivation rec {
  pname = "pi";
  inherit version;

  src = pkgs.fetchzip {
    url =
      "https://github.com/earendil-works/pi/releases/download/v${version}/"
      + "${target.artifact}.${target.ext}";

    sha256 = target.sha256;
  };

  nativeBuildInputs = [ pkgs.makeWrapper ];

  dontConfigure = true;
  dontBuild = true;

  installPhase = ''
    mkdir -p $out/bin
    mkdir -p $out/share/${pname}

    cp -r ./* $out/share/${pname}/

    makeWrapper \
      $out/share/${pname}/${target.executable} \
      $out/bin/pi \
      --run "cd $out/share/${pname}"
  '';
}
