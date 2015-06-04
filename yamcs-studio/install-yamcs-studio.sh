#!/bin/bash -e
SCRIPTPATH=$(dirname ${BASH_SOURCE[0]})
pushd $SCRIPTPATH > /dev/null
. common

function main {  
  
  local YAMCS_STUDIO_INSTALLER="https://github.com/yamcs/yamcs-studio/releases/download/v1.0.0-beta.11/yamcs-studio-1.0.0-SNAPSHOT-linux.gtk.x86_64.tar.gz"
  local YAMCS_STUDIO_DIR_NAME="yamcs-studio-1.0.0-SNAPSHOT"
  local OUTPUT_DIR="/root/"
  local INSTALL_DIR="/root/yamcs-studio"
 
  info "Downloading Yamcs-Studio"
  cd $OUTPUT_DIR
  wget $YAMCS_STUDIO_INSTALLER  

 
  info "Installing Yamcs-Studio"
  tar -xzf $YAMCS_STUDIO_DIR_NAME*.tar.gz
  mv $YAMCS_STUDIO_DIR_NAME $INSTALL_DIR
 
  info "Configuring Yamcs-Studio"
  cd $OUTPUT_DIR
  mkdir workspace
  cd workspace
  # TODO: copy here specific config and displays

  info "Exiting"

}

main $@
popd > /dev/null
