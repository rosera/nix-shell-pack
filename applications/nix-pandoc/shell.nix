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
