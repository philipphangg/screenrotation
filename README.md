# screenrotation
Ubuntu Unity indicator to rotate the screen for convertibles like Lenovo Yoga (by Philipp Hangg)  
and autorotate scripts (by Alberto Pianon)

**IMPORTANT: autorotate scripts should work only on Ubuntu 16.04, and accelerometer values in autorotate.sh are tweaked for Lenovo Yoga 3 - for other models they may need to be changed**  

*With kernel 4.4 accelerometer sensor module works, but loading it may be an issue (if loaded during a cold boot, very often it freezes the system): however, if it is not loaded on a cold boot but only after a reboot (and only at the end of the reboot process), everything works fine.  
Until this problem will be fixed, these scripts take care of rebooting the system after a cold boot and then loading the kernel module at the right moment so that it works flawlessly*

installation:

1. download file from github and unzip

2. open terminal and cd to directory  
*~$ cd /path/to/screenrotation/*

3. copy screenrotation.svg to /usr/share/pixmaps/  
*~$ sudo cp ./screenrotation.svg /usr/share/pixmaps/*

4. copy configuration files  
*~$ sudo mkdir -p /etc/lightdm/lightdm.conf.d  
~$ sudo cp autorotate-lightdm.conf /etc/lightdm/lightdm.conf.d  
~$ sudo cp blacklist-sensor.conf /etc/modprobe.d
*

5. copy executables to the right directories  
*~$ sudo cp ./autorotate.sh /usr/local/bin  
~$ sudo cp ./accessibility_fix.sh /usr/local/bin  
~$ sudo cp ./screenrotation.sh /usr/local/bin  
~$ sudo cp ./screenrotation-indicator.py /usr/local/bin  
~$ sudo cp ./set_scale.sh /usr/local/bin  
~$ sudo cp ./99_restart_autorotate /lib/systemd/system-sleep/*  

6. make all files executable  
*~$ sudo chmod +x /usr/local/bin/\*  
~$ sudo chmod a+x /lib/systemd/system-sleep/99_restart_autorotate*

7. add screenrotation-indicator.py as startup program

8. add keyboard-shortcut  command: [/usr/local/bin/screenrotation.sh -key]  
   for lenovo yoga 3 11 you can take Super+O. thats the extra button on the right-hand side, originaly intended to lock automatic screen rotation


**How to make the screen autorotate service work correctly:**  

* at the end of a cold boot, when you see the dialog box, you have to click on "Reboot"; at the end of the reboot process, you have instead to click on "Proceed"
* in this way, the accelerometer kernel module is fairly stable, and almost never crashes (if it happens, the autorotate script displays a notificaton)

** Onboard tweaks **  
  
note: enabling tooltips is required to have the close ("x") button in the "Small" layout

*gsettings set org.onboard layout /usr/share/onboard/layouts/Small.onboard  
gsettings set org.onboard show-tooltips true  
gsettings set org.onboard.auto-show enabled true  
gsettings set org.onboard.auto-show hide-on-key-press true  
gsettings set org.onboard.window docking-enabled true  
gsettings set org.onboard.window docking-shrink-workarea true  
gsettings set org.onboard.window force-to-top true  
gsettings set org.onboard.window.landscape dock-expand true
gsettings set org.onboard.window.portrait dock-expand true
gsettings set org.onboard.window.landscape dock-height 405  
gsettings set org.onboard.window.portrait dock-height 405*  

Enjoy!
  
---
  
blog article (german):                                                                                          
http://hangg.com/2015/09/ubuntu-screen-rotation-indicator-fuer-lenovo-yoga-3-11/

based on:                                                                                                          
http://askubuntu.com/questions/405628/touchscreen-input-doesnt-rotate-lenovo-yoga-13-yoga-2-pro
https://gist.github.com/rubo77/daa262e0229f6e398766

Autorotate part based on:
http://pastebin.com/742KTaS6


