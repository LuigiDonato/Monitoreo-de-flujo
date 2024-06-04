#!/bin/bash
# This script will run the webserver.py as a background task
# You will then be able close the terminal session.  To auto start
# Add the following command to the /etc/rc.local
# /home/pi/speed-camera/webserver.sh start
# To implement webserver3.py copy it to webserver.py.  Use Buster or later 

progpath="/home/pi/speed-camera"
progname="webserver.py"

echo "$0 ver 6.02 "
echo "-----------------------------------------------"
cd $progpath

# Check if progname exists
if [ ! -e $progname ] ; then
  echo "ERROR   - Could Not Find $progname"
  exit 1
fi

if [ -z "$( pgrep -f $progname )" ]; then
  if [ "$1" = "start" ]; then
     echo "START   - Start $progname in Background ..."
     ./$progname >/dev/null 2>&1 &
  fi
else
  if [ "$1" = "stop" ]; then
    echo "STATUS  - Stopping $progname ...."
    progPID=$( pgrep -f $progname )
    sudo kill $progPID
  fi
fi

if [ -z "$( pgrep -f $progname )" ]; then
    echo "STATUS  - $progname is Not Running ..."
    echo "INFO    - To Start $progname execute command below"
    echo "INFO    - $0 start"
  else
    progPID=$(pgrep -f $progname)
    echo "STATUS  - $progname is Running ..."
    echo "STATUS  - PID is $progPID"
    echo "INFO    - To Stop $progname execute command below"
    echo "INFO    - $0 stop"
fi
echo "Done"
