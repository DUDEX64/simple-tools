#!/bin/bash
# Instead of running git add, git commit, git push, this file
# does this for you. Change the file as you see fit.
# Copyright 2017 Michael Miranda
if [ ! -d ./.git ]; then
	printf "This directory is not a github repo.\n"
	exit 1
fi
if [ "$1" == "" ]; then
	printf "Usage: $0 <commit-message>\n";
	exit 1
fi
git add *
git commit -m "$1"
git push
exit $?
