#!/bin/bash

#######################################################
#                                                     #
#   THIS REQUIRES                                     #
#   bluetooth-proximity                               #
#   BY                                                #
#   ewenchou                                          #
#   FROM GitHub                                       #
#   https://github.com/ewenchou/bluetooth-proximity   #
#                                                     #
#######################################################

MAC="ENTER MAC ADDRESS HERE"
output="$(python bluetooth-proximity/examples/test_address.py $MAC)"
echo $output
if [ $output = "None" ]; then
	vcgencmd display_power 0
else
	vcgencmd display_power 1
fi
