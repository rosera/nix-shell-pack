with import <nixpkgs> {};

pkgs.mkShell {
  name = "docker-app";

  nativeBuildInputs = with pkgs; [
    docker_25
    nixVersions.nix_2_21
    vim
  ];

  APPLICATION = "Docker";
  VERSION  = "docker --version";

  shellHook = ''
    # Optional: Script environment start up 
    echo "Welcome to $APPLICATION Environment"
    $VERSION
  '';
}
