#!/usr/bin/env bash

#build base scripts
echo "###### Building base image ######"

mkdir -p ./output

cd ./0_base
touch base_ubuntu_1604.log
touch base_ubuntu_1804.log
if [ ! -f ../output/base_ubuntu_1604.img ]; then
  sudo singularity build ../output/base_ubuntu_1604.img ubuntu1604.Singularity > ./base_ubuntu_1604.log
else
  echo "    >> Not building base_ubuntu_1604, file exists!"
fi
if [ ! -f ../output/base_ubuntu_1804.img ]; then
  sudo singularity build ../output/base_ubuntu_1804.img ubuntu1804.Singularity > ./base_ubuntu_1804.log
else
  echo "    >> Not building base_ubuntu_1804, file exists!"
fi
cd ..

for dirs in * ; do
  if [ -d ${dirs} ]; then
    IMAGE=`cut -d'_' -f2,3 <<< "${dirs}"`

    if [[ $IMAGE != "base" ]] && [[ $IMAGE != ".git" ]] && [[ $IMAGE != "output" ]]; then
      echo "###### Building: " ${IMAGE} "######"
      if [ -f ./${dirs}/Singularity ]; then
        #echo "hi"
        cd ${dirs}
        OUTIMAGE=../output/${IMAGE}.img
        echo $OUTIMAGE
        if [ -f $OUTIMAGE ]; then
          echo "    >> Not building $IMAGE, file exists!"
        else
          touch ./build.log
          sudo singularity build $OUTIMAGE ./Singularity > ./build.log
        fi
        cd .. 
      fi
    fi
  fi
done
