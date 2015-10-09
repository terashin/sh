##!/bin/sh

# input extention 
echo -n "extention before?"
read before
echo -n "extention after?"
read after

ext=$(find -name "*.$before")

# replace ext
for filename in ${ext[@]}; do 
	mv $filename ${filename%.${before}}.$after
done
