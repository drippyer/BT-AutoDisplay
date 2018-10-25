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
status=""

# if display_status.dat does not exist, set status to "on" then create .dat
if [ ! -f "display_status.dat" ]; then
	echo "status file NOT found"
	vcgencmd display_power 1
	status="on" 
	echo $status >| display_status.dat
# otherwise set status to the value in display_status.dat ("on"/"off")
else
	status=`cat display_status.dat`
	echo "status file found, status: $status"
fi

# if bluetooth is NOT connected...
if [ $output = "None" ]; then
	# ... and display was on before, then turn display off
	if [ $status = "on" ]; then
		echo "bluetooth has disconnected, turning display off..."
		vcgencmd display_power 0
		status="off" 
		echo $status >| display_status.dat
	# ... and display was off before, then do nothing
	else
		echo "bluetooth not connected but display already off, not doing anything"
	fi
# BUT if bluetooth IS connected...	
else
	# ... and display was off before, then turn the display on
	if [ $status = "off" ]; then
		echo "bluetooth reconnected, turning display on..."
		vcgencmd display_power 1
		status="on" 
		echo $status >| display_status.dat
	else
		echo "bluetooth connected but display already on, not doing anything"
	fi
fi

echo "display status: $status"
