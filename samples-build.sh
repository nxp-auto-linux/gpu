#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

source "$DIR/env-check.sh"

set -e

# source $DIR/../driver/environment
HARD_VFP_COMPILER=1

if [ "clean" == "$1" ]; then
	cd $GPU_VIV_TEST

	rm -rf $SAMPLE_GPU_VIV_OUT || true
	rm -rf $SAMPLES_BIN_ARCHIVE_HARDFP || true
	rm -rf $SAMPLES_BIN_ARCHIVE_SOFTFP || true

	exit
fi

if [ "fb" == "$1" ]; then
	cd $GPU_VIV_TEST
	./test_build_sample_fb.sh
else
	echo "Use one of these: fb, wl"
	exit
fi

###### Making the archive

mkdir -p $SAMPLE_GPU_VIV_OUT/opt/viv_samples
mkdir -p $SAMPLE_GPU_VIV_OUT/opt/fsl_tools

# Copying samples files for packaging
cp -axr $GPU_VIV_TEST/build/sdk/samples/* $SAMPLE_GPU_VIV_OUT/opt/viv_samples

# Making the archive
cd $SAMPLE_GPU_VIV_OUT/..
if [ "$HARD_VFP_COMPILER" == "1" ]; then
	tar -zcvf $SAMPLES_BIN_ARCHIVE_HARDFP -C $SAMPLE_GPU_VIV_OUT .
else
	tar -zcvf $SAMPLES_BIN_ARCHIVE_SOFTFP -C $SAMPLE_GPU_VIV_OUT .
fi
