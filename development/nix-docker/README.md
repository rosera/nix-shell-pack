# Docker 

Nix Shell Script:

```nix
{ pkgs ? import <nixpkgs> {} }:

pkgs.dockerTools.buildImage {
  name = "hello-world";
  tag = "latest";
  # contents = pkgs.bash; # Include bash in the image
  # Copy the entrypoint script to the container
  # Use copyToRoot to include the directory in the image
  copyToRoot = pkgs.buildEnv {
    name = "image-root";
    # paths = [ pkgs.bashInteractive ];
    paths = [ pkgs.coreutils ];
    pathsToLink = [ "/bin" ];
    # buildInputs = [ pkgs.writeText "entrypoint.sh" $entrypoint ];
  };
  config = {
    Entrypoint = [ "echo" ];
    Cmd = [ "Hello World!" ];
  };
}
```
