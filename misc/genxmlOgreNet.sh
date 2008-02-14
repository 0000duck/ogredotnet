#!/bin/sh

FLAGS="-c++ -E -xml -csharp -namespace OgreDotNet -I/usr/local/include/OGRE -I../OgreNet"

swig ${FLAGS} OgreBindings.i >OgreBindings.xml
swig ${FLAGS} OgreBindings_Compositor.i >OgreBindings_Compositor.xml
