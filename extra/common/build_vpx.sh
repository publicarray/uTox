#/usr/bin/env zsh

LIBVPX_VERSION="1.7.0"

# install libvpx, needed for video encoding/decoding
if ! [ -d libvpx ]; then
  git clone --depth=1 --branch=v${LIBVPX_VERSION} https://chromium.googlesource.com/webm/libvpx
fi
cd libvpx
git rev-parse HEAD > libvpx.sha
if ! ([ -f "${CACHE_DIR}/libvpx.sha" ] && diff "${CACHE_DIR}/libvpx.sha" libvpx.sha); then
  ./configure ${TARGET_TRGT} \
              --prefix="${CACHE_DIR}/usr" \
              --enable-static \
              --enable-pic \
              --disable-examples \
              --disable-unit-tests \
              --disable-shared
  make -j`sysctl -n hw.ncpu`
  make install
  mv libvpx.sha "${CACHE_DIR}/libvpx.sha"
fi
cd ..
rm -rf libvpx
