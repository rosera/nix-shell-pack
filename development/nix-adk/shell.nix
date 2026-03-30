with import <nixpkgs> {};

pkgs.mkShell {
  name = "adk-dev";

  nativeBuildInputs = with pkgs; [
    google-cloud-sdk
    python312
    python312Packages.pipx
    virtualenv
  ];

  LANGUAGE = "Agent Development Kit";
  VERSION  = "gcloud --version";

  shellHook = ''
    # Optional: Script environment start up 
    echo "Welcome to $LANGUAGE Environment"
    $VERSION
    # pip install google-adk
    python -m venv ./venv
    source ./venv/bin/activate
    python -m pip install google-adk
  '';
}
