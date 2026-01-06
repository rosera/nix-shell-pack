with import <nixpkgs> {};

pkgs.mkShell {
  name = "python-ollama-rag";
  description = "Python Ollama + RAG demo";

  nativeBuildInputs = with pkgs; [
    chroma
    curl
    git        # For version control (if needed)
    jq
    ollama
    # open-webui
    # poetry
    # Python Libraries 
    # python311Full   
    # python311Packages.beautifulsoup4
    # python311Packages.boto3
    # python311Packages.ollama
    # python311Packages.pip
    # python311Packages.pypdf
    # python311Packages.langchain
    # python311Packages.sentence-transformers
    # python311Packages.pydantic
    # python311Packages.pytest
    # python311Packages.pipx
    # python311Packages.tiktoken
    # python311Packages.chromadb  # unstable channel
    # python311Packages.venvShellHook
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
    zellij --layout ollama-layout.kdl
  '';
}
