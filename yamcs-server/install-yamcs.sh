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
  
  local GIT_REVISION=$1 
 
  local YAMCS_REPO="https://github.com/yamcs/yamcs.git"
  local YAMCS_SRC="/root/yamcs"
  local OUTPUT_DIR="/root/"
  git clone $YAMCS_REPO $YAMCS_SRC 
  echo "Checking out yamcs revision " $GIT_REVISION
  cd $YAMCS_SRC
  git checkout $GIT_REVISION
  
  info "Building yamcs"
  cd $YAMCS_SRC
  mvn clean install -DskipTests

  # configure yamcs
  # install the default dev config
  ./make-live-devel.sh

  #ensure permissions on directories used by yamcs
  if [ ! -d "/storage" ]; then
  mkdir /storage/
  fi

  info "Exiting"
}



main $@
popd > /dev/null
