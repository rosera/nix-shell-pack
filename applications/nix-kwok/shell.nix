with import <nixpkgs> {};

pkgs.mkShell {
  name = "kwok-app";
  description = "Kubernetes without Kubelet environment";

  nativeBuildInputs = with pkgs; [
    cacert
    coreutils
    curl
    go_1_21
    jq 
    kubectl
    wget
  ];

  APPLICATION = "KWOK";
  KWOK_REPO="kubernetes-sigs/kwok";
  KWOK_RELEASE="https://api.github.com/repos/kubernetes-sigs/kwok/releases/latest";
  KWOK_DOWNLOAD="https://github.com/kubernetes-sigs/kwok/releases/download";

  shellHook = ''
    # Get latest
    # KWOK_LATEST_RELEASE=$(curl $KWOK_RELEASE | jq -r '.tag_name')
    
    # Check if kwokctl exists
    if [ ! -f "kwok" ]; then
      echo "kwok not found. Downloading..."
    
      # Install kwok
      wget -O kwok -c "$KWOK_DOWNLOAD/$(curl $KWOK_RELEASE | jq -r '.tag_name')/kwok-$(go env GOOS)-$(go env GOARCH)"
      chmod +x kwok
    else
      echo "kwok already exists."
    fi

    # Check if kwokctl exists
    if [ ! -f "kwokctl" ]; then
      echo "kwokctl not found. Downloading..."
    
      # Download and install kwokctl
      wget -O kwokctl -c "$KWOK_DOWNLOAD/$(curl $KWOK_RELEASE | jq -r '.tag_name')/kwokctl-$(go env GOOS)-$(go env GOARCH)"
      chmod +x kwokctl
      # sudo mv kwokctl /usr/local/bin/kwokctl
    else
      echo "kwokctl already exists."
    fi

    # Optional: Script environment start up 
    echo "Welcome to $APPLICATION Environment"
  '';
}
