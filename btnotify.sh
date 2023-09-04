#!/bin/bash

# The phone's bluetooth MAC address
MACADDR=0C:DF:A4:E9:02:54

# a dirty hack for the notes stuff - we remember the time and put the note file with its date before sending it
MOMENT=$(date +%s%N)
# if there is an argument passed to the script, that's what gets sent to the phone
if [ $# \> 0 ]; then
	cat ./OwnNote.vnt | sed "s/\%MESSAGE\%/$*/" > /tmp/OwnNote$MOMENT.vnt
else
# if there is NO argument to the script, try to send stdin
	while read spo; do echo -n "$spo\n" >> /tmp/notif$MOMENT.vntc; done
	MESS=$(cat /tmp/notif$MOMENT.vntc | sed 's/~\\n//')
	#note the usage of \t as sed control char, its the least common one in common short messages
	cat ./OwnNote.vnt | sed "s	\%MESSAGE\%	$MESS	" > /tmp/OwnNote$MOMENT.vnt
fi
# send the note in question with bt-obex (actually, try to send it until it gets sent, because Bluetooth is not a reliable protocol and sometimes my phone did not receive messages)
bt-obex -p $MACADDR /tmp/OwnNote$MOMENT.vnt  >/dev/null 2>/dev/null || while [ $? != 0 ]; do bt-obex -p $MACADDR /tmp/OwnNote$MOMENT.vnt  >/dev/null 2>/dev/null; done
