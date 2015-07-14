#!/bin/sh
echo -n "enter the path"
set dir = $<
echo -n "enter the file name"
set name = $< 
echo "result"
echo ""
find $dir -name "$name" -print
