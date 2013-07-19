#!/bin/bash

pingCheck=`ping -c 20 $1 | grep $1: | wc -l`

# Check if ping returns enough results
if [ "${pingCheck}" -lt "2" ]
then
	# Ping does NOT return enough results

	# Check if ping's previous returned result is stored in upcheck-${1}-.msg
	pingCheckMsg=`cat ~/upcheck-${1}-.msg`
	if [ "${pingCheckMsg}" != "Host unreachable" ]
	then
		# Then make alert and store alert in upcheck-${1}-.msg
		echo "Host unreachable" > ~/upcheck-${1}-.msg
		echo "Host $1 unreachable"
		mail -s "[PROBLEM] Host $1 ping returned < 20%" $2 < /dev/null
	fi
else
	# Ping returns result
	# Check if ping didn't previously returned result stored in upcheck-${1}-.msg
	pingCheckMsg=`cat ~/upcheck-${1}-.msg`
	if [ "${pingCheckMsg}" != "Host reachable" ]
	then
		# Then make alert and store alert in upcheck-${1}-.msg
		echo "Host reachable" > ~/upcheck-${1}-.msg
		echo "Host $1 reachable"
		mail -s "[SOLVED] Host $1 ping returned > 20%" $2 < /dev/null
	fi
fi
