#!/usr/bin/python3

import os
import signal
from gi.repository import Gtk as gtk
from gi.repository import AppIndicator3 as appindicator
from gi.repository import Notify as notify

APPINDICATOR_ID = 'screenrotationindicator'

def main():
    indicator = appindicator.Indicator.new(APPINDICATOR_ID, '/usr/share/pixmaps/screenrotation.svg', appindicator.IndicatorCategory.SYSTEM_SERVICES)
    indicator.set_status(appindicator.IndicatorStatus.ACTIVE)
    indicator.set_menu(build_menu())
    notify.init(APPINDICATOR_ID)
    gtk.main()

def build_menu():
	menu = gtk.Menu()	
	#laptop-mode
	item_laptop_mode = gtk.MenuItem('Laptop-Mode')
	item_laptop_mode.connect('activate', laptopmode)
	menu.append(item_laptop_mode)
	#stand-mode
	item_stand_mode = gtk.MenuItem('Stand-Mode')
	item_stand_mode.connect('activate', standmode)
	menu.append(item_stand_mode)
	#tablet-mode
	item_tablet_mode = gtk.MenuItem('Tablet-Mode')
	item_tablet_mode.connect('activate', tabletmode)
	menu.append(item_tablet_mode)
	#tablet-left-mode
	item_tablet_left_mode = gtk.MenuItem('Tablet-Left-Mode')
	item_tablet_left_mode.connect('activate', tabletleftmode)
	menu.append(item_tablet_left_mode)
	#tablet-right-mode
	item_tablet_right_mode = gtk.MenuItem('Tablet-Right-Mode')
	item_tablet_right_mode.connect('activate', tabletrightmode)
	menu.append(item_tablet_right_mode)
	# quit
	item_quit = gtk.MenuItem('Quit')
	item_quit.connect('activate', quit)
	menu.append(item_quit)
	menu.show_all()
	return menu

# laptopmode funktion
def laptopmode(_):
    notify.Notification.new("Laptop-Mode", None).show()
    os.system('screenrotation.sh -l')

# standmode funktion
def standmode(_):
    notify.Notification.new("Stand-Mode", None).show()
    os.system('screenrotation.sh -s')    

# ltabletmode funktion
def tabletmode(_):
    notify.Notification.new("Tablet-Mode", None).show()
    os.system('screenrotation.sh -t')

# tabletleftmode funktion
def tabletleftmode(_):
    notify.Notification.new("Tablet-Left-Mode", None).show()
    os.system('screenrotation.sh -tl')

# tabletrightmode funktion
def tabletrightmode(_):
    notify.Notification.new("Tablet-Right-Mode", None).show()
    os.system('screenrotation.sh -tr')

# quit funktion
def quit(_):
	notify.uninit() 
	gtk.main_quit()

if __name__ == "__main__":
    signal.signal(signal.SIGINT, signal.SIG_DFL)
    main()