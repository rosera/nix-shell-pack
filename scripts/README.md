# Scripts

## Nix: General Install

Multi-plaform instructions for Nix installation

* [Install Nix](https://nix.dev/install-nix)

## Nix: Unattended Install 

Additional script to perform the above:

* Reference: [Link](https://discourse.nixos.org/t/how-to-run-the-nix-installer-silently-from-a-shell-script/25633)


```bash
#!/usr/bin/env bash

curl -L https://nixos.org/nix/install | sh -s -- --daemon --yes

if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
      . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
fi

# Testing whether Nix is available in subsequent commands
nix --version
```
