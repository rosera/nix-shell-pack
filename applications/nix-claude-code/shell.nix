with import <nixpkgs> {};

let
  # External Script: This reads './dev.kdl' and puts it into a binary named 'dev-zellij'
  scriptZellijLayout = pkgs.writeText "dev.kdl" (builtins.readFile ./dev.kdl);
  zellijLayout = pkgs.writeShellScriptBin "dev-zellij" ''
    ${pkgs.zellij}/bin/zellij --layout ${scriptZellijLayout}
  '';
in
pkgs.mkShell {
  name = "claude-code";

  nativeBuildInputs = with pkgs; [
    ollama
    claude-code 
    zellij
    zellijLayout
    vim
  ];

  APPLICATION = "Claude";
  # VERSION  = "claude --version";

  shellHook = ''
    # ANTHROPIC ENV 
    # ANTHROPIC_BASE_URL=http://localhost:1234
    # ANTHROPIC_AUTH_TOKEN=ollama
    # ollama launch claude --model X 

    # DEV ENV
    exec dev-zellij
  '';
}
