# Ollama 

Based on the Video [Ollama Embedding: How to Feed Data to AI for Better Response?](https://www.youtube.com/watch?v=jENqvjpkwmw)

Setups up a [Zellij window layout](https://zellij.dev/documentation/creating-a-layout) running Ollama 

## Usage

```bash
nix-shell --pure
```

In the terminal pull the required model e.g.:

Use <ALT> Direction to move between tabs in Zellij

```
ollama pull gemma2:2b
```

## Requirements

Ollama

Models:

- [ ] nomic-embed-text
- [ ] mistral
- [ ] gemma
- [ ] gemma2b


### Ollama Serve

1. Run the Ollama serve
```bash
ollama serve
```

### Download Ollama models

1. Get Mistral
```bash
ollama pull mistral
```

2. Get Nomic Embed Text
```bash
ollama pull nomic-embed-text
```

### Python application

1. Run python app
```bash
python app.py
``` 


## Nix Shell Script:

```nix
with import <nixpkgs> {};

pkgs.mkShell {
  name = "python-study-group";

  nativeBuildInputs = with pkgs; [
    git        # For version control (if needed)
    ollama
    python311Full   
    python311Packages.pip
    python311Packages.pypdf
    python311Packages.langchain
    python311Packages.pytest
    python311Packages.boto3
    python311Packages.chromadb  # unstable channel
    python311Packages.venvShellHook
    python311Packages.pipx
    python311Packages.beautifulsoup4
    python311Packages.tiktoken
    poetry
    zellij
    vim
  ];

  LANGUAGE = "Ollama RAG";
  VERSION  = "python --version";

  shellHook = ''
    # Optional: Set up a virtual environment when entering the shell
    python3 -m venv .venv
    source .venv/bin/activate
    echo "Welcome to $LANGUAGE Development Environment"
    $VERSION
  '';
}
```
