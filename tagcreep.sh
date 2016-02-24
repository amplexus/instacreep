#!/bin/bash
savepath=""
creep(){
username="$1"
if cd "$savepath"
then
   if [[ -d "${username}" ]]
   then
      echo "${username} exists, crawling."
   else
      mkdir "${username}"
   fi
   if cd "${username}"
   then
      mapfile -t links < <(wget --quiet -O - "https://www.instagram.com/explore/tags/${username}/" | sed -e 's/\\//g' -e 's/code/\n/g' | grep is_video\"\:false | sed -e 's/.*display_src"\:"//g' -e 's/".*//g')
      for i in "${links[@]}"
      do
            wget -nc "${i%%\?*}"
      done
      mapfile -t videos < <( wget --quiet -O - $(wget --quiet -O - "https://www.instagram.com/explore/tags/${username}/" | sed -e 's/\\//g' -e 's/code/\n/g' | grep is_video\"\:true | sed -e 's/"\:"/https\:\/\/www.instagram.com\/p\//g' -e 's/".*//g')|  grep secure_url | sed -e 's/.*content="//g' -e 's/".*//g')
      for i in "${videos[@]}"
      do
         wget -nc "${i%%\?*}"
      done
   fi
else
   echo "INSTACREEP FAILED"
fi
}
while true
do
   if cd "$savepath"
   then
      mapfile -t usernames < <(cat tags.txt)
      for i in "${usernames[@]}"
      do
         creep "$i"
      done
   else
      echo "COULD NOT ENTER DIRECTORY"
   fi
   let random=$RANDOM%360
   let sleepy=45+$random
   echo "sleeping $sleepy on $(date)"
   sleep $sleepy
done
