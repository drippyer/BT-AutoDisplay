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

MAC="ENTER BLUETOOTH MAC ADDRESS HERE"
output="$(python bluetooth-proximity/examples/test_address.py $MAC)"
status=""

display_on()
{
	vcgencmd display_power 1
	echo "on" >| /tmp/display_status.dat
	status="on"
}

display_off()
{
	vcgencmd display_power 0
	echo "off" >| /tmp/display_status.dat
	status="off"
}

# if /tmp/display_status.dat does not exist, set status to "on" then create .dat
if [ ! -f "/tmp/display_status.dat" ]; then
	echo "status file does not exist, creating one and turning display on..."
	display_on
# otherwise set status to the value in /tmp/display_status.dat ("on"/"off")
else
	status=`cat /tmp/display_status.dat`
	echo "status file found, status: $status"
fi

# if bluetooth is NOT connected...
if [ $output = "None" ]; then
	# ... and display was on before, then turn display off
	if [ $status = "on" ]; then
		echo "bluetooth has disconnected, turning display off..."
		display_off
	# ... and display was off before, then do nothing
	else
		echo "bluetooth not connected but display already off, not doing anything"
	fi
# BUT if bluetooth IS connected...	
else
	# ... and display was off before, then turn the display on
	if [ $status = "off" ]; then
		echo "bluetooth reconnected, turning display on..."
		display_on
	else
		echo "bluetooth connected but display already on, not doing anything"
	fi
fi

echo "display status: $status"