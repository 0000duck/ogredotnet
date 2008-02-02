#!/bin/sh

swig -c++ -E -xml -csharp -namespace OgreDotNet -I/usr/local/include/OGRE -I../OgreNet OgreBindings.i >OgreBindings.xml

swig -c++ -E -xml -csharp -namespace OgreDotNet -I/usr/local/include/OGRE -I../OgreNet OgreBindings_Compositor.i >OgreBindings_Compositor.xml


