#!/bin/bash
mkdir -p stage-apis
mkdir -p stage-portals
echo "current directory *** $(ls $PWD)"
export $(cat ./qa.env | egrep -v "(^#.*|^$)" | xargs)
for i in $(ls -d */); do
  if [[  $i == ci-* || $i == file* || $i == ciapi-* ]]; then
    echo $i
      for file in $PWD/${i}/*; do
        echo "CIAPIs >>> $(basename $PWD/${i})-$(basename "$file")"
        cp $file ./stage-apis/$(basename $PWD/${i})-$(basename "$file");
      done;
  fi
  if [[  $i == cif-* || $i == westid-* ]]; then
    echo $i
      for file in $PWD/${i}/*; do
        echo "portals >>> $(basename $PWD/${i})-$(basename "$file")"
        cp $file ./stage-portals/$(basename $PWD/${i})-$(basename "$file");
      done;
  fi
done
echo "Execution directory for apis deployment *** $(ls $PWD/stage-apis)"
echo "Execution directory for portals deployment *** $(ls $PWD/stage-portals)"