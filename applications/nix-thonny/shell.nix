with import <nixpkgs> {};

pkgs.mkShell {
  name = "thonny-dev";
  description  = "Thonny Python development";

  nativeBuildInputs = with pkgs; [
    chromium
    dbus
    # firefox-unwrapped
    python311
    python311Packages.pip
    # python311Packages.glad2
    python311Packages.tkinter
    python311Packages.venvShellHook
    thonny              # Uses Python311
    xdg-utils
    # mesa
    # virtualgl
    # virtualglLib
    # glxinfo
  ];

  LANGUAGE     = "Python311";
  VERSION      = "python -m esptool version";

  shellHook = ''
    # Optional: Script environment start up 
    # Optional: Set up a virtual environment when entering the shell
    python3 -m venv .venv
    source .venv/bin/activate
    pip install esptool
    echo "Welcome to $LANGUAGE Development Environment"
    $VERSION
    ## ENV VARIABLES
    export LIBGL_ALWAYS_INDIRECT=1
    export XDG_RUNTIME_DIR="/run/user/1000"
    export DBUS_SESSION_BUS_ADDRESS=unix:path=$XDG_RUNTIME_DIR/bus
    # dbus-daemon --session --address=$DBUS_SESSION_BUS_ADDRESS --nofork --nopidfile --syslog-only &
  '';
}
