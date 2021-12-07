#!/bin/bash
mkdir -p out
echo "current directory *** $(ls $PWD)"
for i in $(ls -d */); do
  if [[  $i == ci* || $i == file* ]]; then
    echo $i
      for file in $PWD/${i}/*; do
        echo "$(basename $PWD/${i})-$(basename "$file")"
        cp $file ./out/$(basename $PWD/${i})-$(basename "$file");
      done;
  fi
done
echo "execution directory for deployment *** $(ls $PWD/out)"