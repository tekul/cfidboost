#! /bin/sh
export PWD=`pwd`
mkdir -p logs/nginx

echo "Starting nginx (enter system password if asked)"

sudo nginx -p $PWD -c $PWD/config/nginx.conf
