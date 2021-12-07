#!/bin/bash
mkdir -p out
for i in $(ls -d */); do
  if [[  $i == ci* ]]; then
    echo $i
      for file in $PWD/${i}/*; do
        echo "$(basename $PWD/${i})-$(basename "$file")"
        cp $file ./out/$(basename $PWD/${i})-$(basename "$file");
      done;
  fi
done
echo $(ls $PWD/out)