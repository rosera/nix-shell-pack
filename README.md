# Nix Shell Pack ❄️

A curated collection of Nix configurations for reproducible application environments and development shells.

![Nix](https://img.shields.io/badge/Nix-5277C3?style=for-the-badge&logo=nixos&logoColor=white)

## 🚀 Quick Start

To use any of these configurations, ensure you have [Nix](https://nixos.org/download.html) installed. You can run these shells directly via the GitHub URL (if using Flakes) or by cloning and running:

```bash
nix-shell <path-to-directory>/shell.nix
```

## 🛠 Applications

Ready-to-use environments for specific software tools.

### AI & Machine Learning

General configuration for LLM based environments.

* [Ollama](https://github.com/rosera/nix-shell-pack/tree/main/applications/ollama/README.md) - Local LLM runner.
* [Ollama Retrieval Augmented Generation (RAG) demo](https://github.com/rosera/nix-shell-pack/tree/main/applications/ollama-rag/README.md) - Retrieval Augmented Generation example.


### Mobile & Web Development

General configuration for web and mobile environments.

* [Android Studio](https://github.com/rosera/nix-shell-pack/tree/main/applications/nix-android-studio/README.md) - Full Android SDK environment.
* [Flutter/Dart](https://github.com/rosera/nix-shell-pack/tree/main/applications/nix-flutter/README.md) - Cross-platform mobile development.
* [Firebase](https://github.com/rosera/nix-shell-pack/tree/main/applications/nix-firebase/README.md) - Google Cloud/Firebase tools.

### Utilities

General configuration for utilities and tooling.

* [Imagemagick](https://github.com/rosera/nix-shell-pack/tree/main/applications/nix-imagemagick/README.md) - CLI image manipulation.
* [Minikube](https://github.com/rosera/nix-shell-pack/blob/main/development/nix-minikube/README.md) - Local Kubernetes orchestration.

## 💻 Development Environments

Standardized shells for various programming languages and workflows.

### Programming Languages

Language Config Path

| Script | Description | Language
| :--- | :--- | :----
| [Go](https://github.com/rosera/nix-shell-pack/blob/main/development/nix-go/README.md) | development/nix-go | ![Go](https://img.shields.io/badge/go-%2300ADD8.svg?style=for-the-badge&logo=go&logoColor=white)
| [Nodejs](https://github.com/rosera/nix-shell-pack/blob/main/development/nix-nodejs/README.md) | development/nix-nodejs | ![JavaScript](https://img.shields.io/badge/javascript-%23323330.svg?style=for-the-badge&logo=javascript&logoColor=%23F7DF1E) 
| [Python](https://github.com/rosera/nix-shell-pack/blob/main/development/nix-python/README.md) | development/nix-python | ![Python](https://img.shields.io/badge/python-3670A0?style=for-the-badge&logo=python&logoColor=ffdd54) 
| [Python Shell](https://github.com/rosera/nix-shell-pack/blob/main/development/nix-python-shell/README.md) | development/nix-python-shell | ![Python](https://img.shields.io/badge/python-3670A0?style=for-the-badge&logo=python&logoColor=ffdd54) 
| [Ruby](https://github.com/rosera/nix-shell-pack/blob/main/development/nix-ruby/README.md) | development/nix-ruby | ![Nix](https://img.shields.io/badge/ruby-5277C3?style=for-the-badge&logo=ruby&logoColor=white)

### Terminal & Workflow

Standardized window management configuration.

* [Tmux](https://github.com/rosera/nix-shell-pack/blob/main/development/nix-tmux/README.md) - Terminal multiplexer configuration.
* [Zellij](https://github.com/rosera/nix-shell-pack/blob/main/development/nix-zellij/README.md) - A modern, Rust-based terminal workspace.