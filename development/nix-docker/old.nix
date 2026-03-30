with import <nixpkgs> {};

redis = buildImage {
  name = "bash";
  tag = "latest";

  # for example's sake, we can layer redis on top of bash or debian
  fromImage = bash;
  # fromImage = debian;

  copyToRoot = pkgs.buildEnv {
    name = "image-root";
    paths = [ pkgs.bashInteractive];
    # paths = [ pkgs.redis ];
    pathsToLink = [ "/bin" ];
  };

  runAsRoot = ''
    mkdir -p /data
  '';

  config = {
    # Cmd = [ "/bin/redis-server" ];
    Cmd = [ "/bin/ls" ];
    WorkingDir = "/data";
    Volumes = {
      "/data" = {};
    };
  };
};
