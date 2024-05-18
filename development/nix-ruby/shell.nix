with import <nixpkgs> {};

pkgs.mkShell {
  name = "ruby-dev";

  nativeBuildInputs = with pkgs; [
   ruby_3_2 
   rubyPackages_3_2.rspec-core
   gemstash
   # gcloud-cloud-sdk
   vim
  ];

  LANGUAGE = "Ruby";
  VERSION  = "ruby --version";

  shellHook = ''
    # Optional: Script environment start up 
    ## Note: Outside of a Google Project - need to authenticate
    # gcloud auth login
    # gcloud auth application-default login
    ## Note: Add required GEMS
    gem install google-cloud-storage
    gem install pp 
    echo "Welcome to $LANGUAGE Development Environment"
    $VERSION
  '';
}
