#!/bin/bash
# when a user logs in, accessibility service run as root must be killed
# otherwise onboard does not work
killall at-spi-bus-launcher
killall at-spi2-registry
exit 0
