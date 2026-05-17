# Pi Coding Agent

Ref: https://github.com/NixOS/nixpkgs/blob/b3da656039dc7a6240f27b2ef8cc6a3ef3bccae7/pkgs/by-name/pi/pi-coding-agent/package.nix#L83


## Build

1. Create `package.nix` based on above

2. Create `default.nix`:

   ```nix
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
   ```

3. Build the package
   ```bash
   nix-build default.nix
   ```

   > Generates a nix symlink for the result package

4. Result symlink can now be used:
   ```bash
   nix-shell -p '(import ./default.nix {})'
   ```
