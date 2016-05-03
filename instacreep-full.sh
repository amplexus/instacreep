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
      mapfile -t links < <(wget --quiet -O - "https://www.instagram.com/${username}/media" | sed -e 's/standard/\n/g' | sed -e 's/_resolution": {"url": "//g'| grep -v status | sed -e 's/".*//g' -e 's/\\//g')
      maxid=$(wget --quiet -O - "https://www.instagram.com/${username}/media" | sed -e 's/standard/\n/g' | grep -e "\"image\",\"id\"" | sed -e 's/.*\"image\",\"id\"\:\"//g' -e 's/\".*//g' | tail -n 1)
      for i in "${links[@]}"
      do
            wget -nc "${i%%\?*}"
      done
      until [[ "$maxid" == "" ]]
      do
         mapfile -t links < <(wget --quiet -O - "https://www.instagram.com/${username}/media/?max_id=${maxid}" | sed -e 's/standard/\n/g' | sed -e 's/_resolution": {"url": "//g'| grep -v status | sed -e 's/".*//g' -e 's/\\//g')
         maxid=$(wget --quiet -O - "https://www.instagram.com/${username}/media/?max_id=${maxid}" | sed -e 's/standard/\n/g' | grep -e "\"image\",\"id\"" | sed -e 's/.*\"image\",\"id\"\:\"//g' -e 's/\".*//g' | tail -n 1)
         for i in "${links[@]}"
         do
               wget -nc "${i%%\?*}"
         done
         sleep 1
      done
   fi
else
   echo "INSTACREEP FAILED"
fi
}
if cd "$savepath"
then
   mapfile -t usernames < <(cat instacreep.txt)
   for i in "${usernames[@]}"
   do
      creep "$i"
   done
else
   echo "COULD NOT ENTER DIRECTORY"
fi
