# instacreep
===========
---
**DISCLAIMER:**

This code is posted for informational purposes only. Use of Instagram is governed by the company's Terms of Use (http://instagram.com/legal/terms/). Any user content posted to Instagram is governed by the Privacy Policy (http://instagram.com/legal/privacy/).

===========
---
**Requirements**
Nothing fancy, wget, bash, sed, tail, grep, echo.  Standard GNU/bash.

===========
---
**Setup**

Edit instacreep.sh and instacreep-full.sh 'savepath=""' to point to the directory to save files in.

In the same directory, add a text file named instacreep.rc with a newline delimited list of usernames.

If savepath="/home/user/Pictures/instacreep/" for example,

then file /home/user/Pictures/instacreep/instacreep.rc should contain your list.

===========
---
**Usage**

instacreep-full.sh bootstraps the backup, grabbing all posts.  May only need to run this initially, or as a cron to check for items missed by instacreep.sh updates.

instacreep.sh monitors the last 20 posts of the user for updates.  Checks in a range of 45 seconds and 6m45s.

instacreep will populate your savepath with a simple directory structure with the usernames supplied.
