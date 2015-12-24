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
      mapfile -t links < <(wget --quiet -O - "https://www.instagram.com/${username}/media" | sed -e 's/standard/\n/g' | sed -e 's/_resolution":{"url":"//g'| grep -v status | sed -e 's/".*//g' -e 's/\\//g')
      for i in "${links[@]}"
      do
            wget --quiet -nc "$i"
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
      mapfile -t usernames < <(cat instacreep.rc)
      for i in "${usernames[@]}"
      do
         creep "$i"
      done
   else
      echo "COULD NOT ENTER DIRECTORY"
   fi
   let random=$RANDOM%360
   let sleepy=45+$random
   echo "sleeping $sleepy"
   sleep $sleepy
done
