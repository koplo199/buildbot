#!/bin/bash

set -e
lib_path="../../lib/"
source ${lib_path}path.sh
source ${lib_path}util.sh

runner_name=$(get_runner)
root_dir=$(pwd)
source_dir="${root_dir}/${runner_name}-src"
build_dir=${root_dir}/${runner_name}
version="1.33"
arch=$(uname -m)
repo_url="git://git.code.sf.net/p/dgen/dgen"
publish_dir="/builds/runners/${runner_name}"

clone ${repo_url} ${source_dir}

cd ${source_dir}
./autogen.sh
./configure --prefix=${build_dir}
make
make install

cd ..

dest_file="${runner_name}-${version}-${arch}.tar.gz"
tar czf ${dest_file} ${runner_name}
mkdir -p $publish_dir
cp $dest_file $publish_dir
