#!/bin/sh
set -e

BUILDER=${BUILDER:-"buildah"}
REGISTRY=${REGISTRY:-"docker://ghcr.io"}

LIT_VERSION=${LIT_VERSION:-"3.10.0"}
LUVI_VERSION=${LUVI_VERSION:-"2.15.0.1"}
LUVIT_VERSION=${LUVIT_VERSION:-"2.19.0"}

echo "Building an OCI Alpine image of my-luvit/lit"
$BUILDER build \
  --build-arg LIT_VERSION="${LIT_VERSION}" \
  --build-arg LUVI_VERSION="${LUVI_VERSION}" \
  --build-arg LUVIT_VERSION="${LUVIT_VERSION}" \
  --target lit \
  -t my-luvit/lit:"${LIT_VERSION}" \
  -t my-luvit/lit:latest \
  ./lit-runtime

echo "Building an OCI Alpine image of my-luvit/luvi"
$BUILDER build \
  --build-arg LIT_VERSION="${LIT_VERSION}" \
  --build-arg LUVI_VERSION="${LUVI_VERSION}" \
  --build-arg LUVIT_VERSION="${LUVIT_VERSION}" \
  --target luvi \
  -t my-luvit/luvi:"${LUVI_VERSION}" \
  -t my-luvit/luvi:latest \
  ./lit-runtime

echo "Building an OCI Alpine image of my-luvit/luvit"
$BUILDER build \
  --build-arg LIT_VERSION="${LIT_VERSION}" \
  --build-arg LUVI_VERSION="${LUVI_VERSION}" \
  --build-arg LUVIT_VERSION="${LUVIT_VERSION}" \
  --target luvit \
  -t my-luvit/luvit:"${LUVIT_VERSION}" \
  -t my-luvit/luvit:latest \
  ./lit-runtime

echo "Building an OCI Alpine image of my-luvit/all"
$BUILDER build \
  --build-arg LIT_VERSION="${LIT_VERSION}" \
  --build-arg LUVI_VERSION="${LUVI_VERSION}" \
  --build-arg LUVIT_VERSION="${LUVIT_VERSION}" \
  --target all \
  -t my-luvit/all:"${LUVIT_VERSION}" \
  -t my-luvit/all:latest \
  ./lit-runtime

echo "Building an OCI Alpine image of my-luvit/lit-server"
$BUILDER build \
  --build-arg LIT_VERSION="${LIT_VERSION}" \
  --build-arg LUVI_VERSION="${LUVI_VERSION}" \
  --build-arg LUVIT_VERSION="${LUVIT_VERSION}" \
  -t my-luvit/lit-server:"${LIT_VERSION}" \
  -t my-luvit/lit-server:latest \
  ./lit-server

if [ "$1" = "--push" ]; then
  echo "Pushing runtime images to registry ${REGISTRY}"
  $BUILDER push localhost/my-luvit/lit:latest "${REGISTRY}/my-luvit/lit:latest"
  $BUILDER push localhost/my-luvit/lit:latest "${REGISTRY}/my-luvit/lit:${LIT_VERSION}"
  $BUILDER push localhost/my-luvit/luvi:latest "${REGISTRY}/my-luvit/luvi:latest"
  $BUILDER push localhost/my-luvit/luvi:latest "${REGISTRY}/my-luvit/luvi:${LUVI_VERSION}"
  $BUILDER push localhost/my-luvit/luvit:latest "${REGISTRY}/my-luvit/luvit:latest"
  $BUILDER push localhost/my-luvit/luvit:latest "${REGISTRY}/my-luvit/luvit:${LUVIT_VERSION}"
  $BUILDER push localhost/my-luvit/all:latest "${REGISTRY}/my-luvit/all:latest"
  $BUILDER push localhost/my-luvit/all:latest "${REGISTRY}/my-luvit/all:${LUVIT_VERSION}"

  echo "Pushing lit-server images to registry ${REGISTRY}"
  $BUILDER push localhost/my-luvit/lit-server:latest "${REGISTRY}/my-luvit/lit-server:latest"
  $BUILDER push localhost/my-luvit/lit-server:latest "${REGISTRY}/my-luvit/lit-server:${LIT_VERSION}"
fi

echo "Done."
