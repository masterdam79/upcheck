upcheck
=======

A simple bash script to be ran by cron every minute on a remote machine to determine whether another server responds to ping

Usage:

/etc/crontab

*/1	*	*	*	*	root	~/upcheck.sh 11.11.11.11 alert@domain.tld > /dev/null

*/1	*	*	*	*	root	~/upcheck.sh 11.11.11.22 alert@domain.tld > /dev/null

*/1	*	*	*	*	root	~/upcheck.sh 11.11.22.33 alert@domain.tld > /dev/null

*/1	*	*	*	*	root	~/upcheck.sh 11.22.33.44 alert@domain.tld > /dev/null
