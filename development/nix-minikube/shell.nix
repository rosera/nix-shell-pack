with import <nixpkgs> {};

pkgs.mkShell {
  name = "minikube-dev";

  nativeBuildInputs = with pkgs; [
    minikube 
  ];

  # Docker configuration
  # users.extraGroups.docker.members = [ "rosera" ]; 
  # virtualisation.docker.enable = { true; } 
  users.users.rosera = {
    extraGroups = ["docker"];
  };
  dockerEnabled = true;
  extraBinds = [
    # "/var/run/docker.sock:/var/run/docker.sock"
    "unix:///Users/rosera/.docker/run/docker.sock:unix:///Users/rosera/.docker/run/docker.sock"
  ];

  APPLICATION = "Minikube";
  VERSION  = "minikube version";

  shellHook = ''
    # Optional: Script environment start up 
    echo "Welcome to $APPLICATION Development Environment"
    $VERSION
  '';
}
