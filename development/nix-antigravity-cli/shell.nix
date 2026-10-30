with import <nixpkgs> {};

## Antigravity requires the `allowUnfree` flag
{ pkgs ? import <nixpkgs> {
    config.allowUnfree = true;
  }
}:

let
  # Use the antigravity-cli package
  antigravity-cli = pkgs.callPackage ./nix/antigravity-cli/package.nix {};

  # External Script: This reads './dev.kdl' and puts it into a binary named 'dev-zellij'
  scriptZellijLayout = pkgs.writeText "dev.kdl" (builtins.readFile ./dev.kdl);

  ## Zellij Mode: Normal
  zellijConfig = pkgs.writeText "config.kdl" ''
    default_mode "normal"
  '';

  ## Zellij Window Layout
  zellijLayout = pkgs.writeShellScriptBin "dev-zellij" ''
    ${pkgs.zellij}/bin/zellij --layout ${scriptZellijLayout}
  '';
in
pkgs.mkShell {
  name = "antigravity-dev";

  nativeBuildInputs = with pkgs; [
    antigravity-cli  # Google antigravity
    lit              # Test LLVM
    ollama           # OLLAMA API Model Runner
    vim              # Vim Editor
    zellij           # Zellij Window Multiplexer
    zellijLayout     # Zellij window custom config
  ];

  APPLICATION = "Antigravity CLI";
  # VERSION  = "gemini --version";

  shellHook = ''
    # DEV ENV
    exec dev-zellij
  '';
}
