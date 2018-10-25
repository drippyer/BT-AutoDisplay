# BT-AutoDisplay

These are some pretty simple scripts that utilize [bluetooth-proximity](https://github.com/ewenchou/bluetooth-proximity) by ewenchou in order to automatically turn display output on or off based upon Bluetooth detection.

[BT-AutoDisplay.sh](BT-AutoDisplay.sh) was the first version of this code. However, it simply checked for proximity, and turned display on if it found it. This meant that if the display was already on, it would try to turn it on again. Same thing goes for trying to turn off if it's already off.

So, I made [BT-AutoDisplay2.sh](BT-AutoDisplay2.sh) to try to address this issue. It differs in that it creates a file which stores the status of the display, that is, whether the display is on or off, as a string. From there it only turns the monitor on if it is off to start with (or only turn it off if it is already on), by reading the status from the file first.

I am honestly not sure if the second is any more effective or efficient than the first so I have included both just in case.

Enjoy!