#!/bin/bash

set -e

lib_path="../../lib/"
source ${lib_path}path.sh
source ${lib_path}util.sh

runner_name=$(get_runner)
root_dir=$(pwd)
source_dir="${root_dir}/${runner_name}-src"
build_dir="${root_dir}/${runner_name}-build"
bin_dir="${root_dir}/${runner_name}"
arch=$(uname -m)
version="1.14.4"

deps="cmake libsdl2-dev"
install_deps $deps

clone https://github.com/hrydgard/ppsspp.git $source_dir true v1.14.4

mkdir -p $build_dir
cd $build_dir
cmake ${source_dir}
make -j$(getconf _NPROCESSORS_ONLN)

cd ..
mkdir -p ${bin_dir}
cp -a ${build_dir}/assets ${bin_dir}
cp ${build_dir}/PPSSPPSDL ${bin_dir}

dest_file="${runner_name}-${version}-${arch}.tar.gz"
tar czf ${dest_file} ${runner_name}
mkdir -p $publish_dir
cp $dest_file $publish_dir
rm -rf ${build_dir} ${source_dir} ${bin_dir}
