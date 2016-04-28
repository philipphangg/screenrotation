#!/bin/bash
old_screen_scale=""

while true; do
   if [ -a $HOME/.screen_scale ]; then
      screen_scale=`cat $HOME/.screen_scale`
   else
      continue
   fi

   normal_scale=8
   touchscreen_scale=12
   if [ "$old_screen_scale" != "$screen_scale" ]; then
      old_screen_scale=$screen_scale
      echo $screen_scale
      case "$screen_scale" in
         normal)
           gsettings set com.ubuntu.user-interface scale-factor "{'eDP1': $normal_scale}"
           ;;
         touchscreen)
           gsettings set com.ubuntu.user-interface scale-factor "{'eDP1': $touchscreen_scale}"
           ;;
      esac
   fi
sleep 0.5
done

