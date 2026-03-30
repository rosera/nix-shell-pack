# Thonny 

Thonny IDE + Python + Browser. 

Nix Shell Script:

```nix
with import <nixpkgs> {};

pkgs.mkShell {
  name = "esptool-dev";
  description  = "Thonny Python IDE";

  nativeBuildInputs = with pkgs; [
    chromium
    dbus
    # firefox-unwrapped
    python310
    # python310Packages.glad2
    python310Packages.pip
    python310Packages.tkinter
    python311Packages.venvShellHook
    thonny
    xdg-utils
  ];

  LANGUAGE     = "Python310";
  VERSION      = "python -m esptool version";

  shellHook = ''
    # Optional: Script environment start up 
    # Optional: Set up a virtual environment when entering the shell
    python3 -m venv .venv
    source .venv/bin/activate
    pip install esptool
    echo "Welcome to $LANGUAGE Development Environment"
    $VERSION
  '';
}
```

## Browsers Supported

*  x-www-browser
*  firefox
*  iceweasel
*  seamonkey
*  mozilla
*  epiphany
*  konqueror

