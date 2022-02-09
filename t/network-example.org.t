#!/bin/sh

# Copyright © 2022 Jakub Wilk <jwilk@jwilk.net>
# SPDX-License-Identifier: MIT

set -e -u

if [ -z "${EXP509_NETWORK_TESTING-}" ]
then
    echo '1..0 # SKIP set EXP509_NETWORK_TESTING=1 to enable tests that exercise network'
    exit 0
fi

pdir="${0%/*}/.."
prog="$pdir/exp509"

i=0
t()
{
    i=$((i + 1))
    xstatus="$1"
    shift
    [ "$1" = 'exp509' ]
    shift
    set +e
    "$prog" "$@"
    status=$?
    set -e
    if [ "$status" -eq "$xstatus" ]
    then
        printf 'ok %d "%s" exit status %d\n' "$i" "$*" "$status"
    else
        printf 'not ok %d "%s" exit status %d (expected %d)\n' "$i" "$*" "$status" "$xstatus"
    fi
}

echo 1..2
t 0 exp509 -t 7 www.example.org
t 1 exp509 -t 1100 www.example.org

# vim:ts=4 sts=4 sw=4 et ft=sh
