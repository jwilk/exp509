#!/usr/bin/env bash

# Copyright © 2021-2022 Jakub Wilk <jwilk@jwilk.net>
# SPDX-License-Identifier: MIT

set -e -u
pdir="${0%/*}/.."
prog="$pdir/exp509"
echo 1..1
xout=$(< "$pdir/README")
xout=${xout#*$'\n   $ exp509 --help\n   '}
xout=${xout%$'\n\n   $ '*}
xout=${xout//$'\n   '/$'\n'}
out=$("$prog" --help)
say() { printf "%s\n" "$@"; }
diff=$(diff -u <(say "$xout") <(say "$out")) || true
if [ -z "$diff" ]
then
    echo 'ok 1'
else
    sed -e 's/^/# /' <<< "$diff"
    echo 'not ok 1'
fi

# vim:ts=4 sts=4 sw=4 et ft=sh
