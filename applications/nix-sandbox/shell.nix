with import <nixpkgs> {};

pkgs.mkShell {
  name = "docker-app";

  nativeBuildInputs = with pkgs; [
    docker_20_10
    nixVersions.nix_2_19
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
