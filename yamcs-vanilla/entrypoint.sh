#!/bin/bash -e

#/install-yamcs.sh

# Start the yamcs server
/usr/sbin/service yamcs-server start

# Start the simulator
/opt/yamcs/bin/simulator.sh && tail -f /dev/null
