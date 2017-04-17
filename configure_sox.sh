#!/bin/bash
pushd `dirname $0`
. settings.sh

if [[ $DEBUG == 1 ]]; then
  echo "DEBUG = 1"
  DEBUG_FLAG="--disable-stripping"
fi

pushd sox
#patch -N -p1 --reject-file=- < ../sox-update-ffmpeg-api.patch
autoreconf --install --force --verbose

./configure \
        CFLAGS="-I$LOCAL/include -fPIE -pie" \
        LDFLAGS="-L$LOCAL/lib -L$DESTDIR/x264 -fPIE -pie -fPIC" \
        LIBS="-lavformat -lavcodec -lavutil -lz -lx264 -lc -lgcc" \
        CC="$CC" \
        LD="$LD" \
        RANLIB="$RANLIB" \
        AR="$AR" \
        STRIP="$STRIP" \
        APP_STL=gnustl_static \
        --host=$HOST \
        --with-sysroot="$NDK_SYSROOT" \
        --enable-static \
        --disable-shared \
        --with-ffmpeg \
        --with-pic \
        --without-libltdl


popd; popd


