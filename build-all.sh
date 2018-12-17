#!/usr/bin/env bash

#build base scripts
echo "## Building Base ##"

mkdir -p output

#sudo singularity build ../output/base_ubuntu_1604.img ubuntu1604.Singularity
#sudo singularity build ../output/base_ubuntu_1804.img ubuntu1804.Singularity

for dirs in * ; do
  if [ -d ${dirs} ]; then
    if [[ ${dirs} != "base" ]] && [[ ${dirs} != ".git" ]] && [[ ${dirs} != "output" ]]; then
      echo "## Building: " $dirs "##"
      if [ -f ./${dirs}/Singularity ]; then
        sudo singularity build ../output/${dirs}.img ./${dirs}/Singularity > ./${dirs}/build.log
      fi
    fi
  fi
done
