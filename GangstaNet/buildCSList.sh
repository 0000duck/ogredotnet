#!/bin/bash
#
#this will list all the .cs file and build a Makefile.include
#

CHECKFILE1="AssemblyInfo.cs"
strout="GANGSTANET_SWIG_FILES ="
strSep1=' \\'
strSep2="\n\t"

u=""

for u in `ls --color=no *.cs`; do
	if ( [ -f "$u" ] ) && (!( [ -h "$u" ] )); then
		if [ "$u" != "$CHECKFILE1" ]; then
			strout=`echo -e "$strout$strSep1$strSep2$u"`
		fi
	fi
done

echo "$strout" >Makefile.include


