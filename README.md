# screenrotation
ubuntu unity indicator to rotate the screen for convertibles (like lenovo yoga)

NOTE: autorotate should work only on Ubuntu 16.04

installation:

1. download file from github and unzip

2. open terminal and cd to file                                                                      
~$ cd /path/to/screenrotation/

3. copy screenrotation.svg to /usr/share/pixmaps/

~$ sudo cp ./screenrotation.svg /usr/share/pixmaps/

4. copy executables to the right directories (please note that first you have to change $USER to your actual user name in 99_restart_autorotate 

~$ sudo cp ./autorotate.sh /usr/local/bin
~$ sudo cp ./screenrotation.sh /usr/local/bin
~$ sudo cp ./screenrotation-indicator.py /usr/local/bin
~$ sudo cp ./set_scale.sh /usr/local/bin
~$ sudo cp ./99_restart_autorotate /lib/systemd/system-sleep/

5. make all files executable

~$ sudo chmod +x /usr/local/bin/autorotate.sh
~$ sudo chmod +x /usr/local/bin/screenrotation-indicator.py
~$ sudo chmod +x /usr/local/bin/screenrotation.sh
~$ sudo chmod +x /usr/local/bin/set_scale.sh
~$ sudo chmod a+x /lib/systemd/system-sleep/99_restart_autorotate

6. add screenrotation-indicator.py and autorotate.sh as startup programs       

7. add keyboard-shortcut  command: [/usr/local/bin/screenrotation.sh -key] 
   for lenovo yoga 3 11 you can take Super+O. thats the extra button on the right-hand side, originaly intended to lock automatic screen rotation 

8. edit sudoers file to allow the use of sudo without password for the rmmod and modprobe commands

~$ sudo visudo

add the following lines:
%sudo ALL=(ALL:ALL) NOPASSWD: /sbin/rmmod
%sudo ALL=(ALL:ALL) NOPASSWD: /sbin/modprobe

9. edit blacklist.conf to avoid loading of sensors modules at startup (70% of the times it hangs, we will load it later with autorotate.sh)

~$ sudo nano /etc/modprobe.d/blacklist.conf

add the following line at the end
blacklist hid_sensor_hub


blog article (german):                                                                                          
http://hangg.com/2015/09/ubuntu-screen-rotation-indicator-fuer-lenovo-yoga-3-11/

based on:                                                                                                          
http://askubuntu.com/questions/405628/touchscreen-input-doesnt-rotate-lenovo-yoga-13-yoga-2-pro
https://gist.github.com/rubo77/daa262e0229f6e398766

Autorotate part based on:
http://pastebin.com/742KTaS6


