# Pandoc 

## Markdown

```
pandoc --css=cv.css -s -f markdown+smart --toc --metadata pagetitle="R ROSE CV" --to=html5 cv.md -o cv-1.html
```

Nix Shell Script:

```nix
with import <nixpkgs> {};

pkgs.mkShell {
  name = "pandoc-app";
  description = "Pandoc environment";

  nativeBuildInputs = with pkgs; [
    pandoc 
    # wkhtmltopdf
  ];

  APPLICATION = "Pandoc";
  VERSION  = "pandoc --version";

  shellHook = ''
    # Optional: Script environment start up 
    echo "Welcome to $APPLICATION Environment"
    $VERSION
  '';
}
```
