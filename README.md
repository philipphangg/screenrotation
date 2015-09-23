# screenrotation
ubuntu unity indicator to rotate the screen for convertibles (like lenovo yoga)

installation:

1. download file from github and unzip

2. open terminal and cd to file                                                                      
~$ cd /path/to/screenrotation/

3. copy screenrotation.svg to /usr/share/pixmaps/                                                              
~$ sudo cp ./screenrotation.svg /usr/share/pixmaps/

4. copy screenrotation.sh and screenrotation-indicator.py to /usr/local/bin/                                       
~$ sudo cp ./screenrotation.sh /usr/local/bin                                                                    
~$ sudo cp ./screenrotation-indicator.py /usr/local/bin

5. make both files executable                                                                                     
~$ sudo chmod +x /usr/local/bin/screenrotation-indicator.py                                              
~$ sudo chmod +x /usr/local/bin/screenrotation.sh

6. add screenrotation-indicator.py as startup program                                                          

7. add keyboard-shortcut  command: [/usr/local/bin/screenrotation.sh -key]                                   
   for lenovo yoga 3 11 you can take Super+O. thats the extra button on the right-hand side, originaly intended 
   to lock automatic screen rotation 


blog article (german):                                                                                          
http://hangg.com/2015/09/ubuntu-screen-rotation-indicator-fuer-lenovo-yoga-3-11/

based on:                                                                                                          
http://askubuntu.com/questions/405628/touchscreen-input-doesnt-rotate-lenovo-yoga-13-yoga-2-pro
https://gist.github.com/rubo77/daa262e0229f6e398766

