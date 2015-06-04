#!/bin/bash -e
SCRIPTPATH=$(dirname ${BASH_SOURCE[0]})
pushd $SCRIPTPATH > /dev/null
. common

function main {  

  USAGE="
Usage: $0 sources-dir output-dir

Builds deb packages for yamcs, yamcs-cdmcs, yamcs-busoc.
NOTE: environment variable $HOME must be set, and the directory must be writable.

Mandatory arguments:
       sources-dir   the directory with sources for yamcs, yamcs-cdmcs, yamcs-busoc
       output-dir    the output directory to put deb packages in
  "
  
  
  local YAMCS_REPO="https://github.com/yamcs/yamcs.git"
  local YAMCS_SRC=$SRC_DIR"/yamcs"
  local OUTPUT_DIR="/root/"
  git clone $YAMCS_REPO $YAMCS_SRC 
  
  info "Building yamcs"
  build_yamcs $YAMCS_SRC $OUTPUT_DIR
  
 find /root/ -name "*deb" | xargs dpkg -i


  # configure yamcs
  # install the default dev config
  cd $YAMCS_SRC
  ./make-live-devel.sh
  cp -r $YAMCS_SRC/live/etc/* /opt/yamcs/etc/
  cp -r $YAMCS_SRC/live/mdb/* /opt/yamcs/mdb/
  cp -r $YAMCS_SRC/live/test_data /opt/yamcs/test_data
  
  #ensure permissions on directories used by yamcs
  chown -R yamcs /storage/
  mkdir -p /opt/yamcs/.yamcs/log
  mkdir -p /opt/yamcs/data/journal  
  chown -R yamcs /opt/yamcs/.yamcs
  chown -R yamcs /opt/yamcs/data

  info "Exiting"
}


function build_yamcs {
  local SRC=$1
  local OUT=$2
  local RPMS_DIR=$HOME"/rpmbuild"

  cd $SRC
  ./make-rpm.sh
  cd $OUT
  find $RPMS_DIR -name yamcs*noarch.rpm | xargs alien -c
}


main $@
popd > /dev/null
