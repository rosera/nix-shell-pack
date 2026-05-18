with import <nixpkgs> {};

let
  # External Script: This reads './dev.kdl' and puts it into a binary named 'dev-zellij'
  scriptZellijLayout = pkgs.writeText "dev.kdl" (builtins.readFile ./dev.kdl);
  zellijLayout = pkgs.writeShellScriptBin "dev-zellij" ''
    ${pkgs.zellij}/bin/zellij --layout ${scriptZellijLayout}
  '';
in
pkgs.mkShell {
  name = "gemini-cli";

  nativeBuildInputs = with pkgs; [
    gemini-cli 
    lit
    ollama
    vim
    zellij
    zellijLayout
  ];

  APPLICATION = "Gemini CLI";
  # VERSION  = "gemini --version";

  shellHook = ''
    # gemini --model X 

    # DEV ENV
    exec dev-zellij
  '';
}
