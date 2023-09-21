#!/bin/bash

set -e
lib_path="../../lib/"

source ${lib_path}path.sh
source ${lib_path}util.sh

runner_name=$(get_runner)
root_dir="$(pwd)"
source_dir="${root_dir}/${runner_name}-src"
build_dir="${root_dir}/${runner_name}"
publish_dir="/builds/runners/${runner_name}"
arch="$(uname -m)"
version="1.18"

deps="liballegro4-dev"
install_deps $deps

repo_url="https://github.com/lutris/o2em.git"
clone $repo_url ${source_dir}

cd ${source_dir}
make

mkdir ${build_dir}
mv o2em dis48 README ${build_dir}

cd ..
dest_file=${runner_name}-${version}-${arch}.tar.gz
tar czf ${dest_file} ${runner_name}
mkdir -p $publish_dir
cp $dest_file $publish_dir
rm -rf ${build_dir} ${source_dir}
