#!/bin/sh
dir="ark/`date +%s%N`"
mkdir "$dir" || { echo failed; exit 1; }
find code -mindepth 1 -maxdepth 1 -type d -exec mv {} "$dir" \;
