GENCCODE_ASSEMBLY_TYPE=-a gcc
SO=so
SOBJ=so
A=a
LIBPREFIX=lib
LIB_EXT_ORDER=.64.2
COMPILE=x86_64-linux-android24-clang -ffunction-sections -fdata-sections -D_REENTRANT  -DU_HAVE_ELF_H=1 -DU_ENABLE_DYLOAD=0 -DU_HAVE_STRTOD_L=0  -DU_ATTRIBUTE_DEPRECATED= -fstack-protector -ffunction-sections -fomit-frame-pointer -fno-strict-aliasing -funwind-tables -DPIC -fPIC -fvisibility=hidden -DCUSTOMIZE_REACT_NATIVE -DUCONFIG_NO_COLLATION=1 -DUCONFIG_NO_FORMATTING=1 -DNDEBUG -g0 -Oz -flto=full -D__ANDROID_MIN_SDK_VERSION__=24   -Oz   -c
LIBFLAGS=-I/mnt/extra/worksapce/github/jsc-android-buildscripts/build/target/icu/x86_64-linux-android-no-intl/prebuilts/include -DPIC -fPIC
GENLIB=x86_64-linux-android24-clang -fstack-protector -ffunction-sections -fomit-frame-pointer -fno-strict-aliasing -funwind-tables -DPIC -fPIC -fvisibility=hidden -DCUSTOMIZE_REACT_NATIVE -DUCONFIG_NO_COLLATION=1 -DUCONFIG_NO_FORMATTING=1 -DNDEBUG -g0 -Oz -flto=full -D__ANDROID_MIN_SDK_VERSION__=24   -Oz   -Wl,-z,noexecstack -Wl,--gc-sections -Wl,--exclude-libs,libgcc.a -Wl,--no-undefined -Wl,-z,max-page-size=16384    -Wl,--gc-sections  -shared -Wl,-Bsymbolic
LDICUDTFLAGS=-nodefaultlibs -nostdlib
LD_SONAME=-Wl,-soname -Wl,
RPATH_FLAGS=
BIR_LDFLAGS=-Wl,-Bsymbolic
AR=/home/sanyinchen/Android/Sdk/ndk/27.1.12297006/toolchains/llvm/prebuilt/linux-x86_64//bin/llvm-ar
ARFLAGS=r
RANLIB=/home/sanyinchen/Android/Sdk/ndk/27.1.12297006/toolchains/llvm/prebuilt/linux-x86_64//bin/llvm-ranlib
INSTALL_CMD=/usr/bin/install -c
