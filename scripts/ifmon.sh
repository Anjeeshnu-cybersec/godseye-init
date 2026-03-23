#/usr/bin/env bash
#   ifmon - A small bash script to put wireless cards in monitor mode and back
#    Copyright (C) 2021 ANJEESHNU
#
#    
#
set -e
setMonitorMode () {
	set -x
	ip link set $1 down
	iw dev $1 set type monitor
	ip link set $1 up
	exit 0
}
setManagedMode () {
	set -x 
	ip link set $1 down
	iw dev $1 set type managed
	ip link set $1 up
	exit 0	
}
showDocumentation () {
	echo -e "ifmon Copyright (C) 2021 ANJEESHNU"
	echo "A  bash script to put interfaces in promiscous mode."
	echo "Usage: $0 [-m,--monitor,-n,--managed,--normal] <interface>"
	echo "Usage: $0 <interface> [-m,--monitor,-n,--managed,--normal]"
	echo "Example: $0 -m wlan1"
	echo "Example: $0 -n wlan1"
	echo "Options:"
	echo -e "  \e[4m-m,\e[0m \e[4m--monitor\e[0m \e[4m<interface>\e[0m"
	echo "	set the interface to monitor mode (promiscous mode)"
	echo -e "  \e[4m-n,\e[0m \e[4m--normal,\e[0m \e[4m--managed\e[0m \e[4m<interface>\e[0m"
	echo "	set the interface to managed mode (default or normal mode)"
	exit 1
}
checkForIp=$(hash ip 2>/dev/null;printf $?)
checkForIw=$(hash iw 2>/dev/null;printf $?)
checkForEcho=$(hash echo 2>/dev/null;printf $?)
if [ $# -lt 2 ]
then
	showDocumentation
fi
if [ $checkForIp -ne 0 ];
then
	printf "You don't seem to have the ip package installed.\n"
	printf "Please install the iproute2 package from your distro's package manager.\n"
	exit 1
fi
if [ $checkForIw -ne 0 ];
then
	printf "You don't seem to have the iw package installed.\n"
	printf "Please install the iw from your distro's package manager.\n"
	exit 1
fi
if [ $checkForEcho -ne 0 ];
then
	printf "What? You don't have echo installed? How is this possible?\n"
	printf "Please choose a linux distro that has basic functionality, or install echo.\n"
	exit 1
fi
retCode=1
checkArgs () {
	case "$1" in
		"--managed")
			retCode=0;;
		"-n")
			retCode=0;;
		"--normal")
			retCode=0;;
		"-m")
			retCode=0;;
		"--monitor")
			retCode=0;;
		*)
			retCode=1;;
	esac
}
runArgs () {
	case $1 in
		"--managed")
			setManagedMode $2;;
		"-n")
			setManagedMode $2;;
		"--normal")
			setManagedMode $2;;
		"-m")
			setMonitorMode $2;;
		"--monitor")
			setMonitorMode $2;;
	esac
}
checkArgs $1
variable1=$retCode
checkArgs $2 
variable2=$retCode
if [ $variable1 -eq 0 ] && [ $variable2 -eq 0 ];
then
	showDocumentation
	echo -e "\nInvalid arguments provided"
elif [ $variable1 -eq 0 ] && [ $variable2 -ne 0 ];
then
	runArgs $1 $2
elif [ $variable1 -ne 0 ] && [ $variable2 -eq 0 ];
then
	runArgs $2 $1
else
	showDocumentation
fi
#Insert witty WPA3 comment here.
exit 0
