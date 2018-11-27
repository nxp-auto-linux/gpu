#!/bin/bash

export BUILD_OPTION_EGL_API_FB=1
export BUILD_OPTION_EGL_API_DFB=0
export BUILD_OPTION_EGL_API_DRI=0


set -e

########################################################
# establish build environment and build options value
# Please modify the following items according your build environment

if [ -z $ARCH ]; then
ARCH=arm-yocto
fi

export AQROOT=`pwd`
export VIVANTE_SDK_DIR=$AQROOT/sdk

if [ -z $VIVANTE_SDK_DIR ]; then
    if [ ! -d "$AQROOT/sdk/drivers" ] || [ ! -d "$AQROOT/sdk/include" ]; then
        echo
        echo "ERROR: not found Vivante driver SDK."
        echo "Vivante driver SDK includes driver libraries and driver header files exported."
        echo
        echo "By default, VIVANTE_SDK_DIR=$AQROOT/sdk"
        echo "Your can just copy Vivante driver SDK to $AQROOT/sdk to make sure the tool-chain can find it, "
        echo "or export VIVANTE_SDK_DIR enironment varaible which directed to Vivante dirver SDK."
        echo "for example,"
        echo "export VIVANTE_SDK_DIR=$AQROOT/../DRIVER/build/sdk"
        echo
        echo
        exit
    fi
fi

export SDK_DIR=$AQROOT/build/sdk
shopt -s extglob

export ARCH=arm64
export ARCH_TYPE=$ARCH
export CPU_TYPE=cortex-a53
export CPU_ARCH=armv8-a
export PATH=$TOOLCHAIN/bin:$PATH
BUILD_YOCTO_DRI_BUILD=1
BUILD_OPTION_USE_OPENCL=1
BUILD_OPTION_USE_VULKAN=1
BUILD_OPTION_USE_OPENVX=1
BUILD_OPTION_VIVANTE_ENABLE_2D=0


BUILD_OPTION_DEBUG=0
BUILD_OPTION_ABI=0
BUILD_OPTION_LINUX_OABI=0
BUILD_OPTION_NO_DMA_COHERENT=0
BUILD_OPTION_gcdSTATIC_LINK=0
BUILD_OPTION_CUSTOM_PIXMAP=0
BUILD_OPTION_USE_VDK=1
if [ -z $BUILD_OPTION_EGL_API_FB ]; then
    BUILD_OPTION_EGL_API_FB=1
fi
if [ -z $BUILD_OPTION_EGL_API_DFB ]; then
    BUILD_OPTION_EGL_API_DFB=0
fi
if [ -z $BUILD_OPTION_EGL_API_DRI ]; then
    BUILD_OPTION_EGL_API_DRI=0
fi
if [ -z $BUILD_OPTION_USE_OPENCL ]; then
    BUILD_OPTION_USE_OPENCL=0
fi
if [ -z $BUILD_OPTION_USE_OPENVX ]; then
    BUILD_OPTION_USE_OPENVX=0
fi
if [ -z $BUILD_OPTION_USE_VULKAN ]; then
    BUILD_OPTION_USE_VULKAN=0
fi

if [ -z $BUILD_YOCTO_DRI_BUILD ]; then
    BUILD_YOCTO_DRI_BUILD=0
fi
BUILD_OPTION_VIVANTE_ENABLE_3D=1
if [ -z $BUILD_OPTION_VIVANTE_ENABLE_2D ]; then
    BUILD_OPTION_VIVANTE_ENABLE_2D=0
fi
if [ -z $BUILD_OPTION_VIVANTE_ENABLE_VG ]; then
    BUILD_OPTION_VIVANTE_ENABLE_VG=0
fi

if [ -z $BUILD_OPTION_MAXCPUS ]; then
    BUILD_OPTION_MAXCPUS=4
fi

BUILD_OPTION_DIRECTFB_MAJOR_VERSION=1
BUILD_OPTION_DIRECTFB_MINOR_VERSION=7
BUILD_OPTION_DIRECTFB_MICRO_VERSION=4

BUILD_OPTIONS="NO_DMA_COHERENT=$BUILD_OPTION_NO_DMA_COHERENT"
BUILD_OPTIONS="$BUILD_OPTIONS USE_VDK=$BUILD_OPTION_USE_VDK"
BUILD_OPTIONS="$BUILD_OPTIONS EGL_API_FB=$BUILD_OPTION_EGL_API_FB"
BUILD_OPTIONS="$BUILD_OPTIONS EGL_API_DFB=$BUILD_OPTION_EGL_API_DFB"
BUILD_OPTIONS="$BUILD_OPTIONS EGL_API_DRI=$BUILD_OPTION_EGL_API_DRI"
BUILD_OPTIONS="$BUILD_OPTIONS gcdSTATIC_LINK=$BUILD_OPTION_gcdSTATIC_LINK"
BUILD_OPTIONS="$BUILD_OPTIONS ABI=$BUILD_OPTION_ABI"
BUILD_OPTIONS="$BUILD_OPTIONS LINUX_OABI=$BUILD_OPTION_LINUX_OABI"
BUILD_OPTIONS="$BUILD_OPTIONS DEBUG=$BUILD_OPTION_DEBUG"
BUILD_OPTIONS="$BUILD_OPTIONS CUSTOM_PIXMAP=$BUILD_OPTION_CUSTOM_PIXMAP"
BUILD_OPTIONS="$BUILD_OPTIONS USE_OPENCL=$BUILD_OPTION_USE_OPENCL"
BUILD_OPTIONS="$BUILD_OPTIONS USE_OPENVX=$BUILD_OPTION_USE_OPENVX"
BUILD_OPTIONS="$BUILD_OPTIONS USE_VULKAN=$BUILD_OPTION_USE_VULKAN"
BUILD_OPTIONS="$BUILD_OPTIONS VIVANTE_ENABLE_VG=$BUILD_OPTION_VIVANTE_ENABLE_VG"
BUILD_OPTIONS="$BUILD_OPTIONS VIVANTE_ENABLE_3D=$BUILD_OPTION_VIVANTE_ENABLE_3D"
BUILD_OPTIONS="$BUILD_OPTIONS VIVANTE_ENABLE_2D=$BUILD_OPTION_VIVANTE_ENABLE_2D"
BUILD_OPTIONS="$BUILD_OPTIONS DIRECTFB_MAJOR_VERSION=$BUILD_OPTION_DIRECTFB_MAJOR_VERSION"
BUILD_OPTIONS="$BUILD_OPTIONS DIRECTFB_MINOR_VERSION=$BUILD_OPTION_DIRECTFB_MINOR_VERSION"
BUILD_OPTIONS="$BUILD_OPTIONS DIRECTFB_MICRO_VERSION=$BUILD_OPTION_DIRECTFB_MICRO_VERSION"
BUILD_OPTIONS="$BUILD_OPTIONS YOCTO_DRI_BUILD=$BUILD_YOCTO_DRI_BUILD"
BUILD_OPTIONS="$BUILD_OPTIONS -j$BUILD_OPTION_MAXCPUS"

#export PATH=$TOOLCHAIN/bin:$PATH
# ltib uses BUILDCC for host build
if [ -n "${BUILDCC}" ]; then
	export HOSTCC=${BUILDCC}
fi
# yocto uses BUILD_CC for host build
if [ -n "${BUILD_CC}" ]; then
	export HOSTCC=${BUILD_CC}
fi
if [ "$YOCTO_BUILD" = "1" ];then
	export VIVANTE_SDK_INC=${SDK_INC}
	export VIVANTE_SDK_LIB=${SDK_LIB}
fi
########################################################
# clean/build driver and samples
# build results will save to $SDK_DIR/
#
(
set -o pipefail
if [ "clean" == "$1" ]; then
cd $AQROOT; make -f makefile.linux $BUILD_OPTIONS clean
else
cd $AQROOT; make -f makefile.linux $BUILD_OPTIONS install 2>&1 | tee $AQROOT/linux_build.log
fi
)

unset BUILD_OPTION_EGL_API_DRI
unset BUILD_OPTION_EGL_API_DFB
unset BUILD_OPTION_EGL_API_FB
