#!/bin/sh

if [ -d "/usr/src/app/app" ]
then
  rm /usr/src/app/app/tmp/pids/server.pid
else
  echo app dir does not exist so not removing server.pid
fi

if [ -f "/usr/src/app/app/bin/rails" ]
then
  echo Starting rails dev server
  exec /usr/src/app/app/bin/rails server -b 0.0.0.0 --port 80
else
  echo Not starting rails because ./bin/rails not found
fi
