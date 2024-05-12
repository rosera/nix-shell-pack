FROM nixos/nix:latest as builder
LABEL maintainer "Rich Rose"

WORKDIR /tmp/build
RUN MKDIR /tmp/nix-store-closure

RUN \
    --mount=type-cache,target=/nix,from=nixos/nix:latest,source=/nix \
    --mount=type-cache,target=/root/.cache \
    --mount=type-cache,target=/tmp/build \
    <<EOF
      nix \
        --extra-experimental-features "nix-command flakes" \
        --option filter-syscalls false false \
        --show-trace \
        --log-format raw \
        build . --out-link /tmp/output/result
      cp -R $(nix-store -qR /tmp/output/result) /tmp/nix-store-closure
    EOF

FROM scratch

WORK /app
    
COPY --from=build /tmp/nix-store-closure /nix/store
COPY --from=build /tmp/output/ /app/ 
