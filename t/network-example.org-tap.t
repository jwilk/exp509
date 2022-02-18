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

exec "$prog" --TAP -t 7 www.example.org

# vim:ts=4 sts=4 sw=4 et ft=sh
