# Ruby 

Local development environment for Rubdy + Googleapis.

## Run

Start the environnmebt by entering the following command:

```
nix-shell
```


## Script

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
  APP_PATH = ".local/share/gem/ruby/3.2.0/bin";

  shellHook = ''
    # Optional: Script environment start up 
    ## Update PATH
    export PATH=$PATH:$HOME/$APP_PATH
    ## Note: Add required GEMS
    gem install google-cloud-storage
    gem install google-iam-v1
    gem install pp 
    gem install minitest 
    gem install mocha 
    echo "Welcome to $LANGUAGE Development Environment"
    $VERSION
  '';
}
```
