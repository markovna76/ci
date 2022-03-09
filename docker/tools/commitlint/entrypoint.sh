#!/bin/bash

if [ "$1" == "bash" ]; then
  bash
else
  cp /commitlint.config.js /app/
  commitlint -e
  EXIT_CODE=$?
  rm -f /app/commitlint.config.js
  exit $EXIT_CODE
fi