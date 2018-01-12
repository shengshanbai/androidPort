#!/bin/bash

. abi_settings.sh $1 $2 $3

pushd x264

make clean

case $1 in
  armeabi-v7a | armeabi-v7a-neon)
    HOST=arm-linux
  ;;
  x86)
    HOST=i686-linux
  ;;
esac

echo $CFLAGS

./configure \
  --cross-prefix="$CROSS_PREFIX" \
  --sysroot="$NDK_SYSROOT" \
  --host="$HOST" \
  --enable-asm \
  --enable-pic \
  --enable-thread \
  --enable-strip \
  --enable-static \
  --disable-shared \
  --prefix="${BASEDIR}/build/$1" \
  --extra-cflags="-Os -fpic $CFLAGS -march=armv7-a  -mfloat-abi=softfp -mfpu=neon" \
  --disable-cli || exit 1

make -j${NUMBER_OF_CORES} install || exit 1

popd
