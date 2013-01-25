#! /bin/sh

# Initialize postgres directory. Noop if already done.
mkdir ./uaadb
initdb ./uaadb

postgres -d 2 -D ./uaadb

if [ "$?" -ne 0 ]
  then
  echo "Non-zero postgres exit status"
  read
fi
