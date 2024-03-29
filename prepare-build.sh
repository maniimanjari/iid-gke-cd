#!/bin/bash
mkdir -p stage-apis
mkdir -p stage-portals
#mkdir -p push-name-space
#apt-get install envsubst
echo "current directory *** $(ls $PWD)"
#export $(cat ./qa.env | egrep -v "(^#.*|^$)" | xargs)
echo "$_APPLICTION_PROFILE  rams >>> $_APPLICTION_PROFILE"
echo "CLOUDSDK_CORE_PROJECT >>> rams $CLOUDSDK_CORE_PROJECT"
echo "portals CLOUDSDK_CONTAINER_CLUSTER >>> $CLOUDSDK_CONTAINER_CLUSTER"
for i in $(ls -d */); do
  if [[  $i == ci-* || $i == ciapi-* ]]; then
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
#  if [[  $i == name-spa* ]]; then
#    echo $i
#      for file in $PWD/${i}/*; do
#        echo "push-name-space >>> $(basename $PWD/${i})-$(basename "$file")"
#        cp $file  ./push-name-space/$(basename $PWD/${i})-$(basename "$file");
#      done;
#  fi
done
echo "Execution directory for apis deployment *** $(ls $PWD/stage-apis)"
find $PWD/env-config/ -type f -exec sed -i "s/_APP_PROFILE/${_APPLICTION_PROFILE}/g" {} +
#find $PWD/stage-apis/ -type f -exec sed -i "s/_APP_PROFILE/${_APPLICTION_PROFILE}/g" {} +
#find $PWD/stage-portals/ -type f -exec sed -i "s/_APP_PROFILE/${_APPLICTION_PROFILE}/g" {} +
#echo "UUID >>>  rams >>> $(cat /proc/sys/kernel/random/uuid)"
echo "Execution directory for portals deployment *** $(ls $PWD/stage-portals)"
#echo "Execution directory for name space deployment *** $(ls $PWD/push-name-space)"

#restart all
#for v in $(kubectl get deployments | grep -v  ^NAME | awk '{print $1}'); do kubectl rollout restart deployment/$v;  done