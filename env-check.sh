#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
VERSION_FILE=$DIR/version

set -e

if [ -z $CROSS_COMPILE ]; then
	export CROSS_COMPILE="${CROSS_COMPILE:-${CROSS_COMPILE-${TARGET_PREFIX}}}"
fi

if [ -z $CROSS_COMPILE ]; then
	echo "Please set the CROSS_COMPILE environment variable."
	echo "e.g. export CROSS_COMPILE=/space/workspaces/gcc-linaro-6.3.1-2017.05-x86_64_aarch64-linux-gnu/bin/aarch64-linux-gnu-"
fi

VERSION=6.2.4

export TMP_FOLDER=$DIR/tmp
export GPU_VIV_FOLDER=$DIR
export ARCH=arm64
export SOC_PLATFORM=freescale-s32v234

# Driver build
export GPU_VIV_DRIVER=$GPU_VIV_FOLDER/driver
export DRIVER_GPU_VIV_OUT=$TMP_FOLDER/driver-package
export GPU_BIN_ARCHIVE_HARDFP=$DIR/gpu-viv-bin-s32v234-$VERSION-hardfp.tar.gz
export GPU_BIN_ARCHIVE_SOFTFP=$DIR/gpu-viv-bin-s32v234-$VERSION-softfp.tar.gz

# Samples
FILE_PREFIX="file://"
if [ -z $VIVANTE_USERSPACE ]; then
	echo "Please set the VIVANTE_USERSPACE environment variable. VIVANTE_USERSPACE path must contain Vivante_userspace_libraries_and_demos."
	echo "e.g. export VIVANTE_USERSPACE=/space/workspaces/Vivante_userspace_libraries_and_demos/"
	export VIVANTE_USERSPACE="/"
	echo "Using default VIVANTE_USERSPACE=/"
fi

# Remove file prefix
export VIVANTE_USERSPACE=${VIVANTE_USERSPACE#"$FILE_PREFIX"}

# Launch EULA
if ! [ "$1" == "clean" ] && [ -f ${VIVANTE_USERSPACE}/gpu-viv-bin-s32v234-6.2.4.p2-hardfp.run ]; then
	if [ -d ${VIVANTE_USERSPACE}/gpu-viv-bin-s32v234-6.2.4.p2-hardfp ]; then
		export VIVANTE_USERSPACE=${VIVANTE_USERSPACE}/gpu-viv-bin-s32v234-6.2.4.p2-hardfp
	else
		cd ${VIVANTE_USERSPACE}
		./gpu-viv-bin-s32v234-6.2.4.p2-hardfp.run
		export VIVANTE_USERSPACE=${VIVANTE_USERSPACE}/gpu-viv-bin-s32v234-6.2.4.p2-hardfp
		cd $DIR
	fi
fi

export GPU_VIV_TEST=$GPU_VIV_FOLDER/test
export SAMPLE_GPU_VIV_OUT=$TMP_FOLDER/samples-package
export SAMPLES_BIN_ARCHIVE_HARDFP=$DIR/gpu-viv-samples-s32v234-$VERSION-hardfp.tar.gz
export SAMPLES_BIN_ARCHIVE_SOFTFP=$DIR/gpu-viv-samples-s32v234-$VERSION-softfp.tar.gz

# Sources
export GPU_SOURCES_ARCHIVE=$DIR/galcore_s32v234_${VERSION}.tar.gz
export GPU_SOURCES=$TMP_FOLDER/galcore_sources_$VERSION

# Self-extracting archive
ARCHIVE_FOLDER=$TMP_FOLDER/
export ORIG_CFLAGS=" ${CFLAGS} -DDISABLE_WAIT_FOR_VSYNC_IN_PAN_DISPLAY"
