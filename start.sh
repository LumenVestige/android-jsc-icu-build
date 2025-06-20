#!/bin/bash -e

export ANDROID_NDK="/home/sanyinchen/Android/Sdk/ndk/27.1.12297006"
export ANDROID_HOME="/home/sanyinchen/Android/Sdk"

export ANDROID_API_FOR_ABI_32=24
export ANDROID_API_FOR_ABI_64=24
export ROOTDIR=$PWD
export FLAVOR=no-intl
export ENABLE_INTL=0
export BUILD_TYPE=Release

CROSS_COMPILE_PLATFORM_arm="arm-linux-androideabi"
CROSS_COMPILE_PLATFORM_arm64="aarch64-linux-android"
CROSS_COMPILE_PLATFORM_x86="i686-linux-android"
CROSS_COMPILE_PLATFORM_x86_64="x86_64-linux-android"
CROSS_COMPILE_PLATFORM_CC_arm="armv7a-linux-androideabi"
CROSS_COMPILE_PLATFORM_CC_arm64="$CROSS_COMPILE_PLATFORM_arm64"
CROSS_COMPILE_PLATFORM_CC_x86="$CROSS_COMPILE_PLATFORM_x86"
CROSS_COMPILE_PLATFORM_CC_x86_64="$CROSS_COMPILE_PLATFORM_x86_64"




# settings
PLATFORM_CFLAGS_arm=""
PLATFORM_LDFLAGS_arm=""
JNI_ARCH_arm=armeabi-v7a

PLATFORM_LDFLAGS_arm64=""
JNI_ARCH_arm64=arm64-v8a

PLATFORM_CFLAGS_x86=""
PLATFORM_LDFLAGS_x86=""
JNI_ARCH_x86=x86

PLATFORM_CFLAGS_x86_64=""
PLATFORM_LDFLAGS_x86_64=""
JNI_ARCH_x86_64=x86_64



# options flags
# INTL
SWITCH_COMMON_CFLAGS_INTL_OFF="-DUCONFIG_NO_COLLATION=1 -DUCONFIG_NO_FORMATTING=1"
SWITCH_BUILD_WEBKIT_OPTIONS_INTL_OFF="--no-intl"
SWITCH_BUILD_WEBKIT_OPTIONS_INTL_ON="--intl"

# functions
fix_zero_value_flag() {
  flag=$1
  var="ENABLE_$flag"
  if [[ ${!var} == 0 ]]; then unset "$var"; fi
}
process_switch_options() {
  flag=$1
  var="ENABLE_$flag"
  if [[ ${!var} ]]; then
    suffix="ON"
  else
    suffix="OFF"
  fi
  var2="SWITCH_COMMON_CFLAGS_${flag}_${suffix}"
  readonly "SWITCH_COMMON_CFLAGS_${flag}"="${!var2}"
  var2="SWITCH_BUILD_WEBKIT_OPTIONS_${flag}_${suffix}"
  readonly "SWITCH_BUILD_WEBKIT_OPTIONS_${flag}"="${!var2}"
  var2="SWITCH_BUILD_WEBKIT_CMAKE_ARGS_${flag}_${suffix}"
  readonly "SWITCH_BUILD_WEBKIT_CMAKE_ARGS_${flag}"="${!var2}"
  var2="SWITCH_JSC_CFLAGS_${flag}_${suffix}"
  readonly "SWITCH_JSC_CFLAGS_${flag}"="${!var2}"
}
geticuversion() {
    sed -n 's/^[ 	]*#[ 	]*define[ 	]*U_ICU_VERSION[ 	]*"\([^"]*\)".*/\1/p' "$@"
}


# switches
fix_zero_value_flag "INTL"
process_switch_options "INTL"

export I18N=false



####

DEBUG_SYMBOL_LEVEL="-g2"
if [[ "$BUILD_TYPE" = "Release" ]]
then
    FRAME_POINTER_FLAG="-fomit-frame-pointer"
    CFLAGS_BUILD_TYPE="-DNDEBUG -g0 -Oz -flto=full"
    ICU_CFLAGS_BUILD_TYPE="-Oz"
else
    FRAME_POINTER_FLAG="-fno-omit-frame-pointer"
    CFLAGS_BUILD_TYPE=""
    ICU_CFLAGS_BUILD_TYPE=$DEBUG_SYMBOL_LEVEL
fi

####

COMMON_LDFLAGS=" \
-Wl,-z,noexecstack \
-Wl,--gc-sections \
-Wl,--exclude-libs,libgcc.a \
-Wl,--no-undefined \
-Wl,-z,max-page-size=16384 \
"

COMMON_CFLAGS=" \
-fstack-protector \
-ffunction-sections \
$FRAME_POINTER_FLAG \
-fno-strict-aliasing \
-funwind-tables \
-DPIC \
-fPIC \
-fvisibility=hidden \
-DCUSTOMIZE_REACT_NATIVE \
$SWITCH_COMMON_CFLAGS_INTL \
$CFLAGS_BUILD_TYPE \
-D__ANDROID_MIN_SDK_VERSION__=${ANDROID_API} \
"

COMMON_CXXFLAGS=" \
"

ICU_CFLAGS="$COMMON_CFLAGS $PLATFORM_CFLAGS $ICU_CFLAGS_BUILD_TYPE"
ICU_CXXFLAGS="$COMMON_CXXFLAGS $ICU_CFLAGS $ICU_CFLAGS_BUILD_TYPE"
ICU_LDFLAGS="$COMMON_LDFLAGS \
$PLATFORM_LDFLAGS \
"

compile_arch() {

# arch
var="CROSS_COMPILE_PLATFORM_$JSC_ARCH"
CROSS_COMPILE_PLATFORM=${!var}

# checks
err=false
if ! [[ $ANDROID_API_FOR_ABI_32 ]]; then echo "set ANDROID_API_FOR_ABI_32 to the minimum supported Android platform version for arm and x86 (e.g. 16)"; err=true; fi
if ! [[ $ANDROID_API_FOR_ABI_64 ]]; then echo "set ANDROID_API_FOR_ABI_64 to the minimum supported Android platform version for arm64 and x86_64 (e.g. 21)"; err=true; fi
if ! [[ $FLAVOR ]]; then echo "set FLAVOR to the name of the flavor"; err=true; fi
if ! [[ $CROSS_COMPILE_PLATFORM ]]; then echo "set JSC_ARCH to one of {arm,arm64,x86,x86_64}"; err=true; fi
if ! [[ $ANDROID_HOME ]]; then echo "set ANDROID_HOME to android sdk dir"; err=true; fi
if ! [[ $ANDROID_NDK ]]; then echo "set ANDROID_NDK to android ndk dir"; err=true; fi

if [[ $err = true ]]; then exit 1; fi


var="CROSS_COMPILE_PLATFORM_CC_$JSC_ARCH"
CROSS_COMPILE_PLATFORM_CC=${!var}${ANDROID_API}
TOOLCHAIN_PLATFORM=$(ls -1 $ANDROID_NDK/toolchains/llvm/prebuilt | head -1)
TOOLCHAIN_DIR="$ANDROID_NDK/toolchains/llvm/prebuilt/$TOOLCHAIN_PLATFORM/"

# arch
var="PLATFORM_CFLAGS_$JSC_ARCH"
PLATFORM_CFLAGS=${!var}
var="PLATFORM_LDFLAGS_$JSC_ARCH"
PLATFORM_LDFLAGS=${!var}
var="JNI_ARCH_$JSC_ARCH"
JNI_ARCH=${!var}


BUILD_DIR=$ROOTDIR/icu/${CROSS_COMPILE_PLATFORM}-${FLAVOR}
ICU_VERSION=`geticuversion icu/source/common/unicode/uvernum.h`
echo "BUILD_DIR:$BUILD_DIR"
cd $BUILD_DIR

CROSS_BUILD_DIR=$(realpath $ROOTDIR/icu/host)
PATH=$TOOLCHAIN_DIR/bin:$PATH
INSTALL_DIR=${BUILD_DIR}/prebuilts

if [[ "$BUILD_TYPE" = "Release" ]]
then
    BUILD_TYPE_CONFIG="--enable-release=yes"
else
    BUILD_TYPE_CONFIG="--enable-debug=yes"
fi

ICU_DATA_FILTER_FILE="${ROOTDIR}/icu/filters/android.json" \
$ROOTDIR/icu/source/configure --prefix=${INSTALL_DIR} \
    $BUILD_TYPE_CONFIG \
    --host=$CROSS_COMPILE_PLATFORM \
    --enable-static=yes \
    --enable-shared=no \
    --enable-extras=no \
    --enable-strict=no \
    --enable-icuio=no \
    --enable-layout=no \
    --enable-layoutex=no \
    --enable-tests=no \
    --enable-samples=no \
    --enable-dyload=no \
    --with-cross-build=$CROSS_BUILD_DIR \
    CFLAGS="$ICU_CFLAGS" \
    CXXFLAGS="$ICU_CXXFLAGS" \
    LDFLAGS="$ICU_LDFLAGS" \
    CC=$CROSS_COMPILE_PLATFORM_CC-clang \
    CXX=$CROSS_COMPILE_PLATFORM_CC-clang++ \
    AR=$TOOLCHAIN_DIR/bin/llvm-ar \
    LD=$TOOLCHAIN_DIR/bin/ld \
    RANLIB=$TOOLCHAIN_DIR/bin/llvm-ranlib \
    STRIP=$TOOLCHAIN_DIR/bin/llvm-strip \
    --with-data-packaging=static

pwd
make clean
make -j5 install

}


for arch in arm x86
do
  export ANDROID_API=$ANDROID_API_FOR_ABI_32
  export JSC_ARCH=$arch
  compile_arch
done

for arch in arm64 x86_64
do
  export ANDROID_API=$ANDROID_API_FOR_ABI_64
  export JSC_ARCH=$arch
  compile_arch
done
