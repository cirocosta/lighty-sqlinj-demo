#!/bin/bash

read -p "Are you sure to build lighttpd? [Yy/n] " -n 1 -r
echo    # (optional) move to a new line
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
  echo "Nothing will be done!"
  exit 1
else
  echo "Building lighttpd '$(basename $(pwd))'"
  ./autogen.sh && ./configure --with-mysql && make && make install
fi

