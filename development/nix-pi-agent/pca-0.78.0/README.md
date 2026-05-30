# Pi Coding Agent

![Beta](https://img.shields.io/badge/Release%20Status-Beta-red)
![Nix Version](https://img.shields.io/badge/nix-2.34.7-blue)

## CHANGELOG

| Version | Description |
|---------|-------------|
| 0.78.0  | http://github.com/earendil-works/pi/releases/tag/v0.78.0 |
| 0.73.3  | Version update + Migrate from badlogic/pi-mono to earendil-works/pi repo |

**Note**: Added multi-platform build for Linux/MacOS/Windows

## BUILD

1. Build the package

   ```bash
   nix-build default.nix
   ```

   > Generates a nix symlink for the result package

2. Optional: Result symlink can now be used automatically:

   ```bash
   nix-shell -p '(import ./default.nix {})'
   ```

## CONFIGURATION

1. Create `default.nix`:

   ```nix
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
   ```

