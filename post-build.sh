#!/bin/bash

for i in $(ls -d */ | cut -f1 -d'/'); do
  if [[  $i == ci-* || $i == ciapi-* || $i == cif-* || $i == westid-* || $i == merope-* || $i == dps-* ]]; then
    echo $i
    src_image=$(kubectl get pods --all-namespaces -o jsonpath="{.items[*].spec.containers[*].image}" -l app=$i)
    dest_image=$(kubectl get pods --all-namespaces -o jsonpath="{.items[*].spec.containers[*].image}" -l app="$i"| sed "s/$PROJECT_ID/$_DESTINATION_PROJECT_ID/g")
    docker pull $src_image
    docker tag $src_image $dest_image
    docker push $dest_image
  fi
done
