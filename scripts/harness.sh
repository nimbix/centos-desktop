#!/usr/bin/env bash
set -x

echo "all args: $*"

sleep 20

echo "in harness.sh"
echo "$1"
echo $1
echo "after echo of first arg"
echo "$2"
echo $2
echo "after echo of second arg"
