# KWOK 

## Kubernetes Without Kubelet 

Nix Shell Script:

```nix
with import <nixpkgs> {};

pkgs.mkShell {
  name = "kwok-app";
  description = "Kubernetes without Kubelet environment";

  nativeBuildInputs = with pkgs; [
    coreutils
    jq 
    wget
  ];

  APPLICATION = "KWOK";
  KWOK_REPO=kubernetes-sigs/kwok

  shellHook = ''
    # Get latest
    KWOK_LATEST_RELEASE=$(curl "https://api.github.com/repos/${KWOK_REPO}/releases/latest" | jq -r '.tag_name')

    # Check if kwokctl exists
    if [ ! -f "kwok" ]; then
      echo "kwok not found. Downloading..."
    
      # Install kwok
      wget -O kwok -c "https://github.com/${KWOK_REPO}/releases/download/${KWOK_LATEST_RELEASE}/kwok-$(go env GOOS)-$(go env GOARCH)"
      chmod +x kwok
    else
      echo "kwok already exists."
    fi

    # Check if kwokctl exists
    if [ ! -f "kwokctl" ]; then
      echo "kwokctl not found. Downloading..."
    
      # Download and install kwokctl
      wget -O kwokctl -c "https://github.com/${KWOK_REPO}/releases/download/${KWOK_LATEST_RELEASE}/kwokctl-$(go env GOOS)-$(go env GOARCH)"
      chmod +x kwokctl
      # sudo mv kwokctl /usr/local/bin/kwokctl
    else
      echo "kwokctl already exists."
    fi

    # Optional: Script environment start up 
    echo "Welcome to $APPLICATION Environment"
    $
  '';
}
```
