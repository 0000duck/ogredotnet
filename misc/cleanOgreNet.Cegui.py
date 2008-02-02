#!/usr/bin/python
#clean ogredotnet
# 2005/11/11 
# By Rastaman aka Eric Sanford

import sys, os, string

#	cleanSwigGenFiles
#	will remove all the files that swig generated for the current directory.
#	we can do this be cause all custome .cs files are in a custom directory
#
def cleanSwigGenFiles():
	vpwd = os.getcwd()
	vdirlist = os.listdir(vpwd)
	x =0
	while x < len(vdirlist):
		if vdirlist[x][-3:].lower() != ".cs":
			if vdirlist[x][-4:].lower() == ".cxx":
				x=x+1
			else:
				del vdirlist[x]
		elif vdirlist[x].lower() == "assemblyinfo.cs":
			del vdirlist[x]
		else:
			x=x+1
	
	for x in vdirlist:	
		os.remove(x)
#


#	DELTree remove the directory and everything under it
def DELTree( vapath ):
	if os.path.isdir(vapath):
		for root, dirs, files in os.walk(vapath, topdown=False):
			for name in files:
				os.remove(os.path.join(root, name))
			for name in dirs:
				os.rmdir(os.path.join(root, name))
		os.rmdir(vapath)
#

#
def DELFile( vapath ):
	if os.path.isfile(vapath):
		os.remove(vapath)
#



#--- main line ---
os.chdir("..")

os.chdir("OgreNet.Cegui")
cleanSwigGenFiles()
os.chdir("..")


os.chdir("Bin")

for i in [1,2]:
	if i==1:
		os.chdir("Debug")
	else:
		os.chdir("Release")
	
	DELFile("OgreBindings_Cegui.dll")
	DELFile("OgreDotNet.Cegui.dll")
	os.chdir("..")
	

os.chdir("..")


