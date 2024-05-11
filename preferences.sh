#!/bin/bash

CONFIG_DIR=~/.config/FreeCAD
LOCAL_SHARE_DIR=~/.local/share/FreeCAD
SUFIX=.BKP

clean(){
  echo "- Removing files..."
  rm -rf $CONFIG_DIR
  rm -rf $LOCAL_SHARE_DIR
}

backup_preferences(){
  echo "- Backing up preferences..."
  [ -d  $CONFIG_DIR ] && [ ! -d $CONFIG_DIR$SUFIX ] && mv $CONFIG_DIR $CONFIG_DIR$SUFIX
  [ -d  $LOCAL_SHARE_DIR ] && [ ! -d $LOCAL_SHARE_DIR$SUFIX ] && mv $LOCAL_SHARE_DIR $LOCAL_SHARE_DIR$SUFIX
}

restore_preferences(){
  echo "- Restoring preferences..."
  [ -d  $CONFIG_DIR$SUFIX ] && mv $CONFIG_DIR$SUFIX $CONFIG_DIR
  [ -d  $LOCAL_SHARE_DIR$SUFIX ] && mv $LOCAL_SHARE_DIR$SUFIX $LOCAL_SHARE_DIR
}

install(){
  backup_preferences
  clean
  echo "- Installing files..."
  cp -r ./preferences/.config ~/
  cp -r ./preferences/.local ~/
  cp -r ./overrides/.local ~/
}

uninstall(){
  clean
  restore_preferences
}

case $1 in
  install)
    install
    ;;
  uninstall)
    uninstall
    ;;
  clean)
    clean
    ;;
  *)
    echo "Usage: $0 {install|uninstall|clean}"
    exit 1
    ;;
esac