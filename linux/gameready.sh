#!/bin/bash
# Please change your min/max parameters as required
# Copyright 2017 Michael Miranda
if [ $UID != 0 ]; then
	printf "Root Required!\n"
	exit 13
fi
if [ "$1" == "" ]; then
	printf "Usage: $0 <winter/summer mode>\n"
	exit 1
fi
if [ "$1" == "summer" ]; then
	# This is the summer/laptop config
	printf "Selecting Summer Mode...\n"
	cpupower frequency-set -g powersave --min 775MHz --max 2GHz &> /dev/null
	cpupower set -b 15
	cpupower frequency-info
	exit 0
fi
if [ "$1" == "winter" ]; then
	# This is the winter/desktop config
	printf "Selecting Winter Mode...\n"
	cpupower frequency-set -g performance --min 775MHz --max 2GHz &> /dev/null
	cpupower set -b 0
	cpupower frequency-info
	exit 0
fi
printf "Invalid selection mode: $1\n"
exit 1

