#!/bin/sh

sp=$(find -name "*.sp")
i=0
for e in ${sp[@]}; do
    echo "sp[$i] = ${e}"
    let i++
done
