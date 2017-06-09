#!/bin/bash
#
# Save the current xmls to the git location

# Check to see the differences
 #  for f in $(ls etc/hadoop/conf/*-site.xml ) ; do ls -alt $f ; done
 #  for f in $(ls hadoop/conf/*-site.xml ) ; do ls -alt $f ; done

cp hadoop/conf/*-site*.xml etc/hadoop/conf/.
