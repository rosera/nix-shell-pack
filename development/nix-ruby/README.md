# Ruby 

Initialise a build environment using a Google Cloud Engine virtual instance.

## Usage

Use the following to run the default `shell.nix` script.

```
nix-shell --pure
```


## Script

The following is a basic Ruby environment.

Nix Shell Script:

```nix
with import <nixpkgs> {};

pkgs.mkShell {
  name = "ruby-dev";

  nativeBuildInputs = with pkgs; [
   ruby_3_2 
   rubyPackages_3_4.rubocop
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
    gem install pp 
    gem install minitest 
    gem install mocha 
    echo "Welcome to $LANGUAGE Development Environment"
    $VERSION
  '';
}
```
