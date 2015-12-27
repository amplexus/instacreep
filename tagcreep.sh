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
      mapfile -t links < <( wget --quiet -O - "https://www.instagram.com/explore/tags/${username}/" | grep -e "window._sharedData" | sed -e 's/\\//g' -e 's/display_src"\:"/\n/g' | sed -e 's/".*//g' | grep -v script )
      for i in "${links[@]}"
      do
            mpv "$i"
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
