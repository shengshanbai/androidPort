#!/bin/bash

. abi_settings.sh $1 $2 $3

pushd freetype2

export PKG_CONFIG="${BASEDIR}/ffmpeg-pkg-config"
#export PKG_CONFIG_PATH="${BASEDIR}/build/$1/lib/pkgconfig"

make clean
./autogen.sh
./configure \
  --with-pic \
  --with-sysroot="$NDK_SYSROOT" \
  --host="$NDK_TOOLCHAIN_ABI" \
  --disable-static \
  --enable-shared \
  --with-png=yes \
  --with-zlib=no \
  --prefix="${BASEDIR}/build/$1" || exit 1

make -j${NUMBER_OF_CORES} && make install || exit 0
