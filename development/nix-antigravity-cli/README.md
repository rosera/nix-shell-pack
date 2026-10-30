# Antigravity CLI

Development environment for Antigravity Cli.

This setup packages the Antigravity CLI directly rather than installing the Antigravity IDE. The CLI package is defined locally in `nix/antigravity-cli/package.nix` and added to the development shell from `shell.nix`.


## Run

1. Set the environment variable

```
export NIXPKGS_ALLOW_UNSUPPORTED_SYSTEM=1
```

2. Start the environment by entering the following command:

```
nix-shell
```

## Usage

```bash
nix-shell --pure
```

## Configuration

The following is a basic environment.

Nix Shell Script:

```nix
with import <nixpkgs> {};

let
  # External Script: This reads './dev.kdl' and puts it into a binary named 'dev-zellij'
  scriptZellijLayout = pkgs.writeText "dev.kdl" (builtins.readFile ./dev.kdl);
  zellijLayout = pkgs.writeShellScriptBin "dev-zellij" ''
    ${pkgs.zellij}/bin/zellij --layout ${scriptZellijLayout}
  '';
in
pkgs.mkShell {
  name = "antigravity-dev";

  nativeBuildInputs = with pkgs; [
    # gemini-cli 
    antigravityi-fhs # Google Antigravity
    lit              # Test LLVM
    ollama           # OLLAMA API Model Runner
    vim              # Vim Editor
    zellij           # Zellij Window Multiplexer
    zellijLayout     # Zellij window custom config
  ];

  APPLICATION = "Antigravity CLI";
  # VERSION  = "gemini --version";

  shellHook = ''
    # gemini --model X 

    # DEV ENV
    exec dev-zellij
  '';
}
```

---
# ANTIGRAVITY MAINTAINANCE (CUSTOM PACKAGE)

## Project layout

```text
.
├── README.md
├── shell.nix
├── dev.kdl
└── nix/
    └── antigravity-cli/
        └── package.nix
```

The local `antigravity-cli` package is intended to support:

- `x86_64-linux`
- `aarch64-linux`
- `x86_64-darwin`
- `aarch64-darwin`

## Requirements

- Nix
- `<nixpkgs>` available through `NIX_PATH`
- `nix/antigravity-cli/package.nix` containing the platform-specific Antigravity CLI source URLs and hashes

Antigravity is proprietary software, so the development shell imports nixpkgs with:

```nix
config.allowUnfree = true;
```

You should not need `NIXPKGS_ALLOW_UNSUPPORTED_SYSTEM=1` when the local package declares support for your platform.

## Updating the Antigravity CLI

When Google publishes a new CLI build:

1. Update `version` in `nix/antigravity-cli/package.nix`.
2. Update the source URL for each supported platform if necessary.
3. Recalculate the fixed-output hash for each artifact.
4. Test the package on the architectures available to you.

For example, to calculate a current Nix-compatible hash directly from an artifact URL:

```bash
nix store prefetch-file '<artifact-url>'
```

Use the returned SRI value, for example `sha256-...`, as the `hash` in `package.nix`.

Do not paste a hexadecimal digest after an SRI prefix such as `sha512-`. SRI hashes use a base64-encoded digest; using a hexadecimal digest there produces errors such as `invalid SRI hash`.

## Troubleshooting

### Unfree package error

Make sure nixpkgs is imported with:

```nix
config.allowUnfree = true;
```

This is already configured in the supplied `shell.nix`.
