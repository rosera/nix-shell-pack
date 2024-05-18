# Ruby 

Initialise a build environment using a Google Cloud Engine virtual instance.

Nix Shell Script:

```nix
with import <nixpkgs> {};

pkgs.mkShell {
  name = "ruby-dev";

  nativeBuildInputs = with pkgs; [
   ruby_3_2 
   gemstash
   vim
  ];

  LANGUAGE = "Ruby";
  VERSION  = "ruby --version";

  shellHook = ''
    # Optional: Script environment start up 
    ## Note: Add required GEMS
    gem install google-cloud-storage
    gem install pp 
    gem install minitest 
    gem install mocha 
    echo "Welcome to $LANGUAGE Development Environment"
    $VERSION
  '';
}
```
