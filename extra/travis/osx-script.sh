#!/bin/sh
set -eux

. ./extra/travis/env.sh

cmake . \
  -DCMAKE_INCLUDE_PATH="$CACHE_DIR/usr/include" \
  -DCMAKE_LIBRARY_PATH="$CACHE_DIR/usr/lib" \
  -DUTOX_STATIC=ON \
  -DENABLE_TESTS=ON \
  -DENABLE_WERROR=OFF
make
sudo make package
./run_tests.sh
