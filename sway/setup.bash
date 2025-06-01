#!/bin/bash

mkdir -p ~/Pictures

mkdir -p ~/Desktop

mkdir -p ~/Documents

mkdir -p ~/Downloads

cd "$(dirname "$0")" || {
  exit 1
}

shopt -s dotglob
mv -v -- * ~/
shopt -u dotglob

source ~/.bashrc
