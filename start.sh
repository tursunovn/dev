#!/bin/bash

HOSTNAME=$(hostname)
BOT_TOKEN=7812271535:AAG2RY02yVNBuf5YVVs2mTIlSvyPjeJQUSA
CHAT_ID=240659658

INTERVAL=5
CPU_LIMIT=5
LOGGING_LEVEL=error
number_cpu_cores=$(nproc)

while (true) ; do
	datetime=$(date)
cpu_overall_load=$(uptime | awk '{ print $(NF-2)  }' | tr -d ',' | tr -d '.')

cpu_load_percentage=$( echo " $cpu_overall_load/$number_cpu_cores" | bc)

if [[ $cpu_load_percentage -gt $CPU_LIMIT ]]; then
	if [[ LOGGING_LEVEL == error  ]]; then
		echo "$datetime | CPU load: $cpu_load_percentage" >> /home/nodir/Desktop/monitoring/cpu.log
	fi
	message="🔥🔥 Alert 🔥🔥 %0A%0AHostname: $HOSTNAME%0A%0ACPU is in fire: ${cpu_load_percentage}"
	curl -s -X POST https://api.telegram.org/bot${BOT_TOKEN}/sendMessage -d chat_id=${CHAT_ID} -d text="${message}" > /dev/null 2>&1
fi
if [[ $LOGGING_LEVEL == debug  ]]; then
	echo "$datetime | CPU load: $cpu_load_percentage" >> /home/nodir/Desktop/monitoring/cpu.log
fi
sleep $INTERVAL
done
