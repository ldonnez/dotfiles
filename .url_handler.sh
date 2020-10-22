#!/bin/bash
set -e
if grep -qEi "(Microsoft|WSL)" /proc/version &> /dev/null ; then
    wslview $1
else
    open $1
fi
