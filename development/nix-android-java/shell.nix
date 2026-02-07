with import <nixpkgs> {};

pkgs.mkShell {
  name = "python-dev";

  nativeBuildInputs = with pkgs; [
    javaPackages.compiler.temurin-bin.jdk-21
    android-tools
  ];

  LANGUAGE = "Android Java";
  VERSION  = "java --version";

  shellHook = ''
    # Optional: Script environment start up
    echo "Welcome to $LANGUAGE Development Environment"
    $VERSION
  '';
}
