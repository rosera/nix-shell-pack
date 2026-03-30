# Include the build packages for Nix expressions
with import <nixpkgs> {};

let
  alpineImage = pkgs.writeShellScriptBin 
    # Add shebang for the script
    "Echo API"
    ''
    #!/bin/sh
    echo "{Hello, World\n}"
  '';
in    
# Build the base Alpine image
stdenv.mkDerivation {
  name = "echo-api";
  description = "Alpine image demo echo-api";
  buildInputs = [ alpineImage ];
}
