#!/bin/bash
# Rotates screen

isEnabled=$(xinput --list-props 'SynPS/2 Synaptics TouchPad' | awk '/Device Enabled/{print $NF}')

if [ $isEnabled == 1 ] 
then
    xrandr -o inverted
    xinput set-prop 'ELAN Touchscreen' 'Coordinate Transformation Matrix' -1 0 1 0 -1 1 0 0 1
    xinput disable 'SynPS/2 Synaptics TouchPad'
else
    xrandr -o normal
    xinput set-prop 'ELAN Touchscreen' 'Coordinate Transformation Matrix' 1 0 0 0 1 0 0 0 1
    xinput enable 'SynPS/2 Synaptics TouchPad'
fi
