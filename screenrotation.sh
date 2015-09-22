#!/bin/bash
# This script rotates the screen and touchscreen input, disables/enables touchpad and virtual keyboard.
# This script is used with the unity-desctop-launcher yoga-indicator.py
#
# Philipp Hangg https://github.com/philipphangg/yogarotation

#### configuration
# find your Touchscreen and Touchpad device with the command `xinput`
TouchscreenDevice='ELAN Touchscreen'
TouchpadDevice='SYNA2B23:00 06CB:2714'

if [ "$1" = "--help"  ] || [ "$1" = "-h"  ] ; then
echo 'Usage: screenrotation.sh [OPTION]'
echo
echo 'This script rotates the screen and touchscreen input, disables/enables touchpad and virtual keyboard.'
echo 'This script is used with screenrotation-indicator'
echo
echo 'Usage:'
echo ' -h --help display help'
echo ' -l laptop-mode: touchpad enabled and onboard disabled'
echo ' -s stand-mode: screen inverted, touchpad disabled and onboard enabled'
echo ' -t tablet-mode: normal screen orientation,touchpad disabled and onboard enabled'
echo ' -tl tablet-left-mode: screen 90° left, touchpad disabled and onboard enabled'
echo ' -tr tablet-right-mode: screen 90° right, touchpad disabled and onboard enabled'
echo ' -key tablet-left-mode (set keyboard shortcut): screen 90° left, touchpad disabled and onboard enabled'
exit 0
fi

touchpadEnabled=$(xinput --list-props "$TouchpadDevice" | awk '/Device Enabled/{print $NF}')
screenMatrix=$(xinput --list-props "$TouchscreenDevice" | awk '/Coordinate Transformation Matrix/{print $5$6$7$8$9$10$11$12$NF}')

# Matrix for rotation
#
# Normal
# ⎡ 1 0 0 ⎤
# ⎜ 0 1 0 ⎥
# ⎣ 0 0 1 ⎦
normal='1 0 0 0 1 0 0 0 1'
normal_float='1.000000,0.000000,0.000000,0.000000,1.000000,0.000000,0.000000,0.000000,1.000000'

# Inverted
#⎡ -1  0 1 ⎤
#⎜  0 -1 1 ⎥
#⎣  0  0 1 ⎦
inverted='-1 0 1 0 -1 1 0 0 1'
inverted_float='-1.000000,0.000000,1.000000,0.000000,-1.000000,1.000000,0.000000,0.000000,1.000000'

# 90° to the left 
# ⎡ 0 -1 1 ⎤
# ⎜ 1  0 0 ⎥
# ⎣ 0  0 1 ⎦
left='0 -1 1 1 0 0 0 0 1'
left_float='0.000000,-1.000000,1.000000,1.000000,0.000000,0.000000,0.000000,0.000000,1.000000'

# 90° to the right
#⎡  0 1 0 ⎤
#⎜ -1 0 1 ⎥
#⎣  0 0 1 ⎦
right='0 1 0 -1 0 1 0 0 1'


if [ "$1" == "-l" ]
then
  echo "laptop-mode"
  xrandr -o normal
  xinput set-prop "$TouchscreenDevice" 'Coordinate Transformation Matrix' $normal
  xinput enable "$TouchpadDevice"
  killall onboard
elif [ "$1" == "-s" ]
then
  echo "stand-mode"
  xrandr -o inverted
  xinput set-prop "$TouchscreenDevice" 'Coordinate Transformation Matrix' $inverted
  xinput disable "$TouchpadDevice"
  onboard &
elif [ "$1" == "-t" ]
then
  echo "tablet-mode"
  xrandr -o normal
  xinput set-prop "$TouchscreenDevice" 'Coordinate Transformation Matrix' $normal
  xinput disable "$TouchpadDevice"
  onboard &
elif [ "$1" == "-tl" ]
then
  echo "left-mode"
  xrandr -o left
  xinput set-prop "$TouchscreenDevice" 'Coordinate Transformation Matrix' $left
  xinput disable "$TouchpadDevice"
  onboard &
elif [ "$1" == "-tr" ]
then
  echo "right-mode"
  xrandr -o right
  xinput set-prop "$TouchscreenDevice" 'Coordinate Transformation Matrix' $right
  xinput disable "$TouchpadDevice"
  onboard &
elif [ $screenMatrix == $normal_float ] && [ "$1" == "-key" ]
then
  echo "left-mode"
  xrandr -o left
  xinput set-prop "$TouchscreenDevice" 'Coordinate Transformation Matrix' $left
  xinput disable "$TouchpadDevice"
  onboard &
else
  echo "laptop-mode"
  xrandr -o normal
  xinput set-prop "$TouchscreenDevice" 'Coordinate Transformation Matrix' $normal
  xinput enable "$TouchpadDevice"
  killall onboard
fi
