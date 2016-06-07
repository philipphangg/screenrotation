#!/usr/bin/python3

import os
import signal
from gi.repository import Gtk as gtk
from gi.repository import AppIndicator3 as appindicator
from gi.repository import Notify as notify

APPINDICATOR_ID = 'screenrotationindicator'

menu_items = {}

os.system('echo "Autorotate" > /tmp/screen_management/screen_orientation')
os.system('killall set_scale.sh; set_scale.sh &')
os.system('screenrotation_mod_moz_prefs.sh')


def main():
    indicator = appindicator.Indicator.new(APPINDICATOR_ID, '/usr/share/pixmaps/screenrotation.svg', appindicator.IndicatorCategory.SYSTEM_SERVICES)
    indicator.set_status(appindicator.IndicatorStatus.ACTIVE)
    indicator.set_menu(build_menu())
    notify.init(APPINDICATOR_ID)
    gtk.main()

def build_menu():
   global menu_items
   menu = gtk.Menu()
   group = []
   menu_arr = [
      'Autorotate', 'Laptop-Mode', 'Stand-Mode', 
      'Tablet-Mode', 'Tablet-Left-Mode', 'Tablet-Right-Mode'
   ]
   for i in range(len(menu_arr)):
      menu_item = gtk.RadioMenuItem.new_with_label(group, menu_arr[i])
      group = menu_item.get_group()
      menu_items[menu_arr[i]] = menu_item      
      menu.append(menu_item)
      menu_item.connect("activate", on_menu_select, menu_arr[i])
   
   # quit
   item_quit = gtk.MenuItem('Quit')
   item_quit.connect('activate', quit)
   menu.append(item_quit)
   menu.show_all()
   return menu


def on_menu_select(obj, label):
   global menu_items
   if menu_items[label].get_active():
      notify.Notification.new(label, None).show()
      os.system('echo "'+label+'" > /tmp/screen_management/screen_orientation')

# quit function
def quit(_):
	os.system('echo "Laptop-Mode" > /tmp/screen_management/screen_orientation')
	notify.uninit() 
	gtk.main_quit()

if __name__ == "__main__":
    signal.signal(signal.SIGINT, signal.SIG_DFL)
    main()
