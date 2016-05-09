#!/bin/bash
old_screen_scale=""
tmpdir="/tmp/screen_management"

while true; do
   if [ -a $tmpdir/screen_scale ]; then
      screen_scale=`cat $tmpdir/screen_scale`
   else
      continue
   fi
   
   isOnboardRunning=`ps -A | grep onboard`
   normal_scale=8
   touchscreen_scale=12
   if [ "$old_screen_scale" != "$screen_scale" ]; then
      old_screen_scale=$screen_scale
      echo $screen_scale
      case "$screen_scale" in
         normal)
           if [[ -n $isOnboardRunning ]]; then
              killall onboard
           fi
           gsettings set com.ubuntu.user-interface scale-factor "{'eDP1': $normal_scale}"
           ;;
         touchscreen)
           gsettings set com.ubuntu.user-interface scale-factor "{'eDP1': $touchscreen_scale}"
           if [[ -z $isOnboardRunning ]]; then
              onboard &
           fi
           ;;
      esac
   fi
sleep 0.5
done

