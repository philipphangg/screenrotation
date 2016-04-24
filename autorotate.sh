#!/bin/bash
#(C) Alberto Pianon, April 2016
# licensed under MIT license
#
# based on: http://pastebin.com/742KTaS6
#
# Works for Lenovo Yoga 3 11, Ubuntu 16.04 (tested on 64bit version)
# (does not work for Ubuntu previous versions)
#
# IMPORTANT: this script should never be killed and restarted,
# (unles when suspending and resuming)
# otherwise for some reason the kernel module may hang

echo "Autorotate" > $HOME/.screen_orientation

xpath=`find /sys/devices/pci0000:00 | grep in_accel_x_raw`
ypath=`find /sys/devices/pci0000:00 | grep in_accel_y_raw`

if [[ -z $xpath ]]; then
  zenity --error --text="ERROR: accelerometer not detected by linux kernel"
  exit 1
fi


current_case=0
counter=0
num_iterations=2
max_iterations=4
 
function increaseCounter
{
    c=$1
    if [[ $c -eq $current_case ]]; then
        counter=$((counter + 1))
    else
        current_case=$c
        counter=1
    fi
}
 
sleep 1
 
while true; do
 
  HDMIConn=`xrandr --query | grep "HDMI1 connected"`
  if [[ $HDMIConn ]]; then
      #echo -en "\rHDMI connected, no rotation";
      HDMIConn=""
      continue
  fi 
  
  response_time=`/usr/bin/time -f "%e" cat "$xpath" 2>&1 | sed -n 2p`

  if (( `echo "$response_time > 1" | bc -l` )); then
    zenity --error --text="ERROR: accelerometer kernel module hanging, please restart computer"
    exit 1
  fi

  x=`cat "$xpath"`
  y=`cat "$ypath"`


  o=`cat $HOME/.screen_orientation`


    if [[ ($x -gt 65400 && $y -gt 50000 && $o == "Autorotate") || $o == "Laptop-Mode" ]]; then
        increaseCounter 0
        if [[ $counter -gt $num_iterations && $counter -lt $max_iterations ]]; then
        screenrotation.sh -l
        fi
    fi
    
    if [[ ($x -lt 1100 && $x -gt 500 && ($y -lt 701 || $y -gt 5000) && $o == "Autorotate") || $o == "Tablet-Left-Mode" ]]; then
        increaseCounter 3
        if [[ $counter -gt $num_iterations && $counter -lt $max_iterations ]]; then
        screenrotation.sh -tl
        fi
    fi

    if [[ (($x -gt 50000  || $x -lt 1100) && $y -gt 700 && $y -lt 1100 && $o == "Autorotate") || $o == "Stand-Mode" ]]; then
        increaseCounter 2
        if [[ $counter -gt $num_iterations && $counter -lt $max_iterations ]]; then
        screenrotation.sh -s
        fi
    fi

    if [[ ($x -gt 50000 && $x -lt 65401 && $y -lt 300 && $o == "Autorotate") || $o == "Tablet-Right-Mode"  ]]; then
        increaseCounter 1
        if [[ $counter -gt $num_iterations && $counter -lt $max_iterations ]]; then
          screenrotation.sh -tr
        fi
    fi
    
    if [[ $o == "Tablet-Mode" ]]; then
        increaseCounter 4
        if [[ $counter -gt $num_iterations && $counter -lt $max_iterations ]]; then
          screenrotation.sh -t
        fi
    fi
  
  sleep 0.05

done
