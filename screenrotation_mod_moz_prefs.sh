#!/bin/bash
# Firefox property layout.css.devPixelsPerPx is set by default to "-1.0"
# that means that firefox uses the system screen scale
# When using tablet mode, set_scale.sh sets screen scale to more than 1.0, 
# and web pages are not displayed correctly in Firefox (they go outside borders)
# so we need to manually set devPixelsPerPx to "1.0"  so that Firefox 
# sticks with scale 1.0 regardless of system settings
#
# See:
#
# https://support.mozilla.org/en-US/questions/963759
#
# http://askubuntu.com/questions/313483/how-do-i-change-firefoxs-aboutconfig-from-a-shell-script
# (but the file is not user.js but prefs.js)
#
# http://stackoverflow.com/questions/15065010/how-to-perform-a-for-each-file-loop-by-using-find-in-shell-bash

if [[ -e $HOME/.mozilla ]]; then
 find $HOME/.mozilla -type f -iname "prefs.js" -print0 | while IFS= read -r -d $'\0' line; do
    sed -i 's/user_pref("layout.css.devPixelsPerPx",.*);/user_pref("layout.css.devPixelsPerPx","1\.0");/' $line
    grep -q layout.css.devPixelsPerPx "$line" || echo "user_pref(\"layout.css.devPixelsPerPx\",\"1.0\");" >> $line
 done
fi


