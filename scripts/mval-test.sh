#!/usr/bin/env bash
#set -x

[[ -r /etc/JARVICE/jobenv.sh ]] && . /etc/JARVICE/jobenv.sh

SUBSCRIPT=
OPTIONS="extra"
while [[ -n "$1" ]]; do
    case "$1" in
        # Required parameters
        -subscript)
            shift
            SUBSCRIPT="$1"
            ;;
        -options)
            shift
            OPTIONS="$1"
            ;;
        *)
            ;;
    esac
    shift
done

echo "subscript passed: |$SUBSCRIPT|"
echo "options passed: |$OPTIONS|"

sudo chmod a+x /usr/local/scripts/harness.sh
exec $SUBSCRIPT "$OPTIONS"
