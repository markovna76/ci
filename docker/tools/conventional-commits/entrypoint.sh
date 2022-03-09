#!/bin/bash

if [ "$1" == "bash" ]; then
  bash
else

  cp /.cz-config.js /app/
  echo '{"path": "/usr/lib/node_modules/cz-customizable"}' >/app/.czrc

  # add already existed scopes
  replace=`git log --all --format=%s | grep -E "^[a-z]+\(([^)]+)\):.*" | awk -F '(' '{ print $2 }' | sed -E 's/[ "]+/-/g' | awk -F ')' '{ if(length($1)<40) { a[$1]++} } END { for (b in a) { printf ("\"%s\",\n", b) } }' | sort`
  replace=`echo $replace`
  sed -i "s/\\[\\]/\\[$replace\\]/" .cz-config.js

  cz $@

  rm -f /app/.czrc
  rm -f /app/.cz-config.js
fi