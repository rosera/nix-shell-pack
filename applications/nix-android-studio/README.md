# Android Studio

Local development environment for Android Studio.

## Run

Start the environment by entering the following command:

```
nix-shell
```

## Usage

Use the following to run the default `shell.nix` script.

```
nix-shell --pure
```

## Script

The following is a basic environment.

Nix Shell Script:

```nix
with (import <nixpkgs> { config = { LIBGL_ALWAYS_SOFTWARE=1; android_sdk.accept_license = true; allowUnfree = true; }; });
let
  # Ref: https://github.com/NixOS/nixpkgs/blob/master/pkgs/development/mobile/androidenv/compose-android-packages.nix
  # Add options as required 
  android = pkgs.androidenv.composeAndroidPackages {
    buildToolsVersions = [ "34.0.0" "33.0.1" "31.0.0" "30.0.3" "28.0.3" ];
    includeNDK = false;
    ndkVersions = [ "25.1.8937393" ];
    cmakeVersions = [ "3.22.1" ];
    abiVersions = [ "armeabi-v7a" "arm64-v8a" ];
    cmdLineToolsVersion = "11.0";
    platformToolsVersion = "34.0.5";
    includeEmulator = true;
  };
  sdk = android.androidsdk;
in
pkgs.mkShell rec {
  ANDROID_SDK_ROOT = "${sdk}/libexec/android-sdk";
  CHROME_EXECUTABLE = "${pkgs.chromium}/bin/chromium";
  nativeBuildInputs = [
    android-studio
    git
    clang 
    cmake 
    dart
    flutter
    google-chrome
    gnome.gdm
    gtk4
    jdk17
    nodejs_20
    mesa
    pkg-config 
    tmux
    vim
    vimPlugins.coc-flutter
    zellij
  ];
}
```
