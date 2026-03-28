#!/bin/sh
set -e

BUILDER=${BUILDER:-"buildah"}

LIT_VERSION=${LIT_VERSION:-"3.9.0"}
LUVI_VERSION=${LUVI_VERSION:-"2.15.0"}
LUVIT_VERSION=${LUVIT_VERSION:-"2.18.1"}

echo "Building an OCI Alpine image of my-luvit/lit"
$BUILDER build \
  --build-arg LIT_VERSION="${LIT_VERSION}" \
  --build-arg LUVI_VERSION="${LUVI_VERSION}" \
  --build-arg LUVIT_VERSION="${LUVIT_VERSION}" \
  --target lit \
  -t my-luvit/lit:"${LIT_VERSION}" \
  -t my-luvit/lit:latest \
  ./lit-runtime

echo "Building an OCI Alpine image of my-luvit/lit-server"
$BUILDER build \
  --build-arg LIT_VERSION="${LIT_VERSION}" \
  --build-arg LUVI_VERSION="${LUVI_VERSION}" \
  --build-arg LUVIT_VERSION="${LUVIT_VERSION}" \
  -t my-luvit/lit-server:"${LIT_VERSION}" \
  -t my-luvit/lit-server:latest \
  ./lit-server

echo "Done."
