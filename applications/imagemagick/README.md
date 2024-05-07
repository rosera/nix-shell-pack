# Imagemagick

Nix Shell Script:

```nix
with import <nixpkgs> {};

pkgs.mkShell {
  name = "imagickmagick-app";

  nativeBuildInputs = with pkgs; [
    imagemagick 
  ];

  APPLICATION = "Imagemagick";
  VERSION  = "convert -version";

  shellHook = ''
    # Optional: Script environment start up 
    echo "Welcome to $APPLICATION Environment"
    $VERSION
  '';
}
```
