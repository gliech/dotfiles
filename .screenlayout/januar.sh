#!/bin/sh
xrandr --newmode "3840x1440_120.00"  993.50  3840 4176 4600 5360  1440 1443 1453 1545 -hsync +vsync
xrandr --addmode DisplayPort-2 3840x1440_120.00
xrandr --output DisplayPort-0 --mode 2560x1440 --pos 0x0 --rotate left --output DisplayPort-1 --off --output DisplayPort-2 --primary --mode 5120x1440 --pos 1440x227 --rotate normal --output HDMI-A-0 --off
