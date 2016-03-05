#!/bin/bash

if [[ $# -eq 0 ]]; then
  flyway migrate
else
  exit 0
fi
