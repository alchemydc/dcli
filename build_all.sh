#!/bin/bash
set -x

# read .env for DESTINY_API_KEY
[ -f .env ] && . .env

PROJECT_DIR=${PWD}

for i in `ls $PROJECT_DIR/src/`;
  do
  echo "Building $i"
  cd $PROJECT_DIR/src/$i
  cargo build --release
  # maybe check status of $0 before creating these symlinks
  echo "Symlinking binary to $PROJECT_DIR/bin"
  ln -sf $PROJECT_DIR/src/$i/target/release/$i $PROJECT_DIR/bin/$i 
  done