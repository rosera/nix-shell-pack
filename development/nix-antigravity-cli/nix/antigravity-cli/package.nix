{
  lib,
  stdenv,
  fetchurl,
  autoPatchelfHook,
}:

let
  version = "1.4.11-5180209989812224";

  # Dev: Version needs to match Hash sha256
  sources = {
    x86_64-linux = {
      url = "https://storage.googleapis.com/antigravity-public/antigravity-cli/${version}/linux-x64/cli_linux_x64.tar.gz";
      hash = lib.fakeHash;
      # hash = "";
    };

    aarch64-linux = {
      url = "https://storage.googleapis.com/antigravity-public/antigravity-cli/${version}/linux-arm/cli_linux_arm64.tar.gz";
      hash = lib.fakeHash;
      # hash = "";
    };

    aarch64-darwin = {
      url = "https://storage.googleapis.com/antigravity-public/antigravity-cli/${version}/darwin-arm/cli_mac_arm64.tar.gz";
      # hash = lib.fakeHash;
      hash = "sha256-CEiHtNRIXVpErEftbfarf5K6ATNwUFJPCpimkMhmIig=";
    };

    x86_64-darwin = {
      url = "https://storage.googleapis.com/antigravity-public/antigravity-cli/${version}/darwin-x64/cli_mac_x64.tar.gz";
      hash = lib.fakeHash;
      # hash = "";
    };

  };

  source =
    sources.${stdenv.hostPlatform.system}
      or (throw "antigravity-cli: unsupported platform ${stdenv.hostPlatform.system}");

in
stdenv.mkDerivation {
  pname = "antigravity-cli";
  inherit version;

  src = fetchurl {
    inherit (source) url hash;
  };

  nativeBuildInputs =
    lib.optionals stdenv.hostPlatform.isLinux [
      autoPatchelfHook
    ];

  sourceRoot = ".";

  installPhase = ''
    runHook preInstall

    install -Dm755 antigravity $out/bin/agy

    runHook postInstall
  '';

  meta = {
    description = "Command-line interface for Google Antigravity";
    homepage = "https://antigravity.google";
    license = lib.licenses.unfree;
    sourceProvenance = with lib.sourceTypes; [ binaryNativeCode ];
    mainProgram = "agy";
    platforms = builtins.attrNames sources;
  };
}
