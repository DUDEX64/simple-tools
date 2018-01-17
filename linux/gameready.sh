#!/bin/bash
# !! NVIDIA GPU MACHINES ONLY !!
# Please change your min/max parameters as required
# Copyright 2017 Michael Miranda
if [ $UID != 0 ]; then
	printf "Root Required!\n"
	exit 13
fi
if [ "$1" == "" ]; then
	printf "Usage: $0 <desktop/laptop mode>\n"
	exit 1
fi
if [ "$1" == "laptop" ]; then
	# This is the summer/laptop config
	printf "Selecting Laptop Mode...\n"
	nvidia-smi -acp RESTRICTED &> /dev/null
	nvidia-smi -pm DISABLED &> /dev/null
	cpupower frequency-set -g conservative --min 775MHz --max 1.7GHz &> /dev/null
	cpupower set -b 15
	cpupower frequency-info
	exit 0
fi
if [ "$1" == "desktop" ]; then
	# This is the winter/desktop config
	printf "Selecting Desktop Mode...\n"
	nvidia-smi -acp UNRESTRICTED &> /dev/null
	nvidia-smi -pm ENABLED &> /dev/null
	cpupower frequency-set -g ondemand --min 1.7GHz --max 2GHz &> /dev/null
	cpupower set -b 0
	cpupower frequency-info
	exit 0
fi
if [ "$1" == "normal" ]; then
	# This is the normal config
	printf "Selecting Normal Mode...\n"
	nvidia-smi -acp UNRESTRICTED &> /dev/null
	nvidia-smi -pm ENABLED &> /dev/null
	cpupower frequency-set -g ondemand --min 775MHz --max 2GHz &> /dev/null
	cpupower set -b 8
	cpupower frequency-info
	exit 0
fi
printf "Invalid selection mode: $1\n"
exit 1

