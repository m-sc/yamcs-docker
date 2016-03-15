#!/bin/bash -e

#/install-yamcs.sh

# Start the yamcs server
#/usr/sbin/service yamcs-server start
cd /root/yamcs/live/
bin/yamcs-server.sh &


# Start the simulator
bin/simulator.sh && tail -f /dev/null
