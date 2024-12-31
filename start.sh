#!/bin/bash

HOSTNAME=$(hostname)
BOT_TOKEN=7812271535:AAG2RY02yVNBuf5YVVs2mTIlSvyPjeJQUSA
CHAT_ID=240659658

INTERVAL=5
CPU_LIMIT=40
LOGGING_LEVEL=error
LIMIT_PEAK_COUNT=3


source functions/cpu.sh

init(){
	if [[ ! -d states  ]]; then
		mkdir states
	fi
	touch /home/nodir/Desktop/monitoring/states/running
}

init


while [[ -f states/running  ]]; do
	cpu_check
	sleep $INTERVAL
done
