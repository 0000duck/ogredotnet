#!/usr/bin/python
#clean ogredotnet
# 2005/11/11 
# By Rastaman aka Eric Sanford

import sys, os, string



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

os.chdir("OgreNet")
DELTree("Bin")
DELTree("Debug")
DELTree("Release")
DELTree("Obj")
os.chdir("..")


os.chdir("CeguiNet")
DELTree("Bin")
DELTree("Debug")
DELTree("Release")
DELTree("Obj")
os.chdir("..")


os.chdir("OgreNet.Cegui")
DELTree("Bin")
DELTree("Debug")
DELTree("Release")
DELTree("Obj")
os.chdir("..")


os.chdir("GangstaNet")
DELTree("Bin")
DELTree("Debug")
DELTree("Release")
DELTree("Obj")
os.chdir("..")


os.chdir("DemoCEGUI")
DELTree("Bin")
DELTree("Obj")
os.chdir("..")


os.chdir("DemoCeguiMenus")
DELTree("Bin")
DELTree("Obj")
os.chdir("..")


os.chdir("DemoParticleFX")
DELTree("Bin")
DELTree("Obj")
os.chdir("..")


os.chdir("DemoSkeletalAnimation")
DELTree("Bin")
DELTree("Obj")
os.chdir("..")


os.chdir("DemoSkyBox")
DELTree("Bin")
DELTree("Obj")
os.chdir("..")


os.chdir("DemoWinForms")
DELTree("Bin")
DELTree("Obj")
os.chdir("..")


os.chdir("Math3D")
DELTree("Bin")
DELTree("Obj")
os.chdir("..")


os.chdir("Samples")


os.chdir("DemoFireworks")
DELTree("Bin")
DELTree("Obj")
os.chdir("..")


os.chdir("DemoGrass")
DELTree("Bin")
DELTree("Obj")
os.chdir("..")


os.chdir("DemoRSQ")
DELTree("Bin")
DELTree("Obj")
os.chdir("..")


os.chdir("DemoCustomObjects")
DELTree("Bin")
DELTree("Obj")
os.chdir("..")


os.chdir("DemoCelShading")
DELTree("Bin")
DELTree("Obj")
os.chdir("..")


os.chdir("DemoGAPyramid")
DELTree("Bin")
DELTree("Obj")
os.chdir("..")


os.chdir("DemoRenderToTexture")
DELTree("Bin")
DELTree("Obj")
os.chdir("..")


os.chdir("DemoCompositor")
DELTree("Bin")
DELTree("Obj")
os.chdir("..")


os.chdir("..")


os.chdir("Bin")

for i in [1,2]:
	if i==1:
		os.chdir("Debug")
	else:
		os.chdir("Release")
	
	DELFile("DemoCEGUI.exe")
	DELFile("DemoCeguiMenus.exe")
	DELFile("DemoFireworks.exe")
	DELFile("DemoGrass.exe")
	DELFile("DemoParticleFX.exe")
	DELFile("DemoRSQ.exe")
	DELFile("DemoSkeletalAnimation.exe")
	DELFile("SkeletalAnimation.exe")
	DELFile("DemoSkyBox.exe")
	DELFile("DemoWinForms.exe")
	DELFile("DemoCustomObjects.exe")
	DELFile("DemoGAPyramid.exe")
	DELFile("DemoRenderToTexture.exe")
	DELFile("DemoCelShading.exe")
	DELFile("DemoCompositor.exe")
	
	DELFile("DemoCEGUI.pdb")
	DELFile("DemoCeguiMenus.pdb")
	DELFile("DemoFireworks.pdb")
	DELFile("DemoGrass.pdb")
	DELFile("DemoParticleFX.pdb")
	DELFile("DemoRSQ.pdb")
	DELFile("DemoSkeletalAnimation.pdb")
	DELFile("SkeletalAnimation.pdb")
	DELFile("DemoSkyBox.pdb")
	DELFile("DemoWinForms.pdb")
	DELFile("DemoCustomObjects.pdb")
	DELFile("DemoGAPyramid.pdb")
	DELFile("DemoRenderToTexture.pdb")
	DELFile("DemoCelShading.pdb")
	DELFile("DemoCompositor.pdb")
	
	DELFile("Math3D.dll")
	DELFile("OgreBindings.dll")
	DELFile("OgreDotNet.dll")
	DELFile("CeguiBindings.dll")
	DELFile("CeguiDotNet.dll")
	DELFile("OgreBindings_Cegui.dll")
	DELFile("OgreDotNet.Cegui.dll")
	DELFile("GangstaBindings.dll")
	DELFile("GangstaDotNet.dll")
	
	DELFile("Math3D.pdb")
	DELFile("OgreBindings.pdb")
	DELFile("OgreDotNet.pdb")
	DELFile("CeguiBindings.pdb")
	DELFile("CeguiDotNet.pdb")
	DELFile("OgreBindings_Cegui.pdb")
	DELFile("OgreDotNet.Cegui.pdb")
	DELFile("GangstaBindings.pdb")
	DELFile("GangstaDotNet.pdb")

	os.chdir("..")
	

os.chdir("..")


