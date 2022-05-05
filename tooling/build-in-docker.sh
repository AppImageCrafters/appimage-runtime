#!/bin/bash

SCRIPT_PATH=$(realpath "$0")
SCRIPT_DIR=$(dirname "$SCRIPT_PATH")
PROJECT_SRCS=$(dirname "$SCRIPT_DIR")
TOOLCHAIN_DIR="$PROJECT_SRCS/cmake/"

BUILD_TYPE=$1
if [ -z "$BUILD_TYPE" ]; then
  echo "Missing BUILD_TYPE, please provide one as follows:"
  echo "    ./$(basename "$0") ( Debug | Release )"
  exit 1
fi

## Check Arch
if [ -z "$TOOLCHAIN" ]; then
  echo ""
  echo "Missing TOOLCHAIN environment. Please define it before calling $(basename "$0")"
  echo ""
  exit 1
else
  TOOLCHAIN_PATH="$TOOLCHAIN_DIR/$TOOLCHAIN-toolchain.cmake"
  if [[ ! -f "$TOOLCHAIN_PATH" ]]; then
    echo "Unknown TOOLCHAIN: $TOOLCHAIN"
    exit
  fi
fi

DOCKER_IMAGE_NAME="azubieta/appimage-runtime-build-env-$TOOLCHAIN"
docker run -v "$PROJECT_SRCS:/src" "$DOCKER_IMAGE_NAME" tooling/build.sh "$BUILD_TYPE"
