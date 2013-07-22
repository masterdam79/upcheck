#!/bin/sh
#
# This script will check on specified intervals if the returned pings are sufficient and if not mail
#

# Apple compatibility: If this script is ran under the crontab user, the crontab user isn't able to find ping, so find it first.
pingLocation=`whereis ping`

# Get ping results
pingCheck=`${pingLocation} -c 20 $1 | grep $1: | wc -l`

# Check if ping returns enough results
if [ "${pingCheck}" -lt "2" ]
then
	# Ping DOES NOT return enough results

	# Check if ping's previous returned result is stored in upcheck-${1}-.msg
	pingCheckMsg=`cat ~/upcheck-${1}-.msg`
	if [ "${pingCheckMsg}" != "Host unreachable" ]
	then
		# Then make alert and store alert in upcheck-${1}-.msg
		echo "Host unreachable" > ~/upcheck-${1}-.msg
		mail -s "[PROBLEM] Host $1 ping returned < 10%" $2 < /dev/null
	fi
else
	# Ping DOES return enough results

	# Check if ping didn't previously returned result stored in upcheck-${1}-.msg
	pingCheckMsg=`cat ~/upcheck-${1}-.msg`
	if [ "${pingCheckMsg}" != "Host reachable" ]
	then
		# Then make alert and store alert in upcheck-${1}-.msg
		echo "Host reachable" > ~/upcheck-${1}-.msg
		mail -s "[SOLVED] Host $1 ping returned > 10%" $2 < /dev/null
	fi
fi
