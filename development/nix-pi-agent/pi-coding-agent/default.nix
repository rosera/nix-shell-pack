{ pkgs ? import <nixpkgs> {} }:

let
  # The package snippet expects these hooks, which are available in modern nixpkgs.
  # If your channel doesn't have them, we can mock them or provide fallbacks.
  versionCheckHook = pkgs.versionCheckHook or (pkgs.writeText "mock-hook" "");
  writableTmpDirAsHomeHook = pkgs.writableTmpDirAsHomeHook or (pkgs.writeText "mock-hook" "");
  nix-update-script = pkgs.nix-update-script or (_: []);
in
pkgs.callPackage ./package.nix {
  inherit versionCheckHook writableTmpDirAsHomeHook nix-update-script;
}
