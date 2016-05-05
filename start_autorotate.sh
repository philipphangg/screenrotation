#!/bin/bash

function zenityNotification
{
   echo "message:$1" | zenity --notification --listen &
   mypid=$!
   sleep 0.5
   kill $mypid
}

# make screen accessible from root
export DISPLAY=":0.0"
xhost local:root

# init vars
tmpdir="/tmp/screen_management"
mkdir $tmpdir
echo "Autorotate" > $tmpdir/screen_orientation
echo "normal" > $tmpdir/screen_scale
chmod -R 777 $tmpdir

# check if this script has already been run
isModuleLoaded=`lsmod | grep hid_sensor_hub`
if [[ -n $isModuleLoaded ]]; then
   # check if autorotate.sh is already running, otherwise start it
   isAutorotateRunning=`ps -A | grep autorotate.sh`
   if [ -z $isAutorotateRunning ]; then
      autorotate.sh > /tmp/autorotate.log 2>&1 &
   fi
   # nothing more to do here
   exit 0
fi


# self-explanatory...
zenity --question --ok-label="Proceed" --cancel-label="Reboot" --text="If this is a <b>cold boot</b>, please click on <b>'Reboot'</b> in order to allow screen autorotate to work\n\nif you have just rebooted the system, click on 'Proceed'" 

case $? in
   0) zenityNotification "Starting screen autorotate service...\nplease wait, it will take about 5 secs"
   ;;
   *) reboot
esac   

modprobe hid_sensor_hub
sleep 2
#sometimes the first time it doesn't work...
modprobe hid_sensor_hub
sleep 3

autorotate.sh > /tmp/autorotate.log 2>&1 &

exit 0

