#!/bin/bash
mkdir -p stage-apis
mkdir -p stage-portals
mkdir -p push-name-space
apt-get install envsubst
echo "current directory *** $(ls $PWD)"
export $(cat ./qa.env | egrep -v "(^#.*|^$)" | xargs)
for i in $(ls -d */); do
  if [[  $i == ci-* || $i == file* || $i == ciapi-* ]]; then
    echo $i
      for file in $PWD/${i}/*; do
        echo "CIAPIs >>> $(basename $PWD/${i})-$(basename "$file")"
        cp $file  ./stage-apis/$(basename $PWD/${i})-$(basename "$file");
      done;
  fi
  if [[  $i == cif-* || $i == westid-* ]]; then
    echo $i
      for file in $PWD/${i}/*; do
        echo "portals >>> $(basename $PWD/${i})-$(basename "$file")"
        cp $file  ./stage-portals/$(basename $PWD/${i})-$(basename "$file");
      done;
  fi
  if [[  $i == name-spa* ]]; then
    echo $i
      for file in $PWD/${i}/*; do
        echo "push-name-space >>> $(basename $PWD/${i})-$(basename "$file")"
        cp $file  ./push-name-space/$(basename $PWD/${i})-$(basename "$file");
      done;
  fi
done
echo "Execution directory for apis deployment *** $(ls $PWD/stage-apis)"
echo "Execution directory for portals deployment *** $(ls $PWD/stage-portals)"
echo "Execution directory for name space deployment *** $(ls $PWD/push-name-space)"