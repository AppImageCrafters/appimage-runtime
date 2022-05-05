#!/bin/bash
set -x

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

BUILD_DIR=$PROJECT_SRCS/cmake-build-"$BUILD_TYPE"-"$TOOLCHAIN"
#rm -rf "$BUILD_DIR" || true
mkdir -p "$BUILD_DIR" && cd "$BUILD_DIR" || exit 1

cmake "$PROJECT_SRCS" -DCMAKE_INSTALL_PREFIX=/usr -DCMAKE_BUILD_TYPE="$BUILD_TYPE" \
  -DCMAKE_TOOLCHAIN_FILE="$TOOLCHAIN_PATH"

cmake --build .
