== Requirements ==

To build OgreDotNet, you need the following:
 - Ogre (http://www.ogre3d.org/)
 - CMake (http://www.cmake.org/)
 - swig (http://www.swig.org/) (swig 1.3.33 or later is known to work.  1.3.31 does not work.  1.3.32 is unknown.)

For Linux / OS X, you also need the following:
 - mono (http://www.mono-project.com/)
 - NAnt (http://nant.sourceforge.org/)

For Windows, you also need the following:
 - Visual C# (www.microsoft.com/express/vcsharp/)

== Building ==

This is basically a two-step build process.  First you must build the
SWIG wrapper, and then the C# interface to it.

=== SWIG wrapper ===

We use CMake for building the SWIG wrapper.  CMake is a build tool to
allow a single configuration file to generate project files and
makefiles for a number of platforms.  To see what generators are
available for your platform, run:

 cmake --help

Then, for example, to use Unix makefiles as your build method, run:

 cmake -G "Unix Makefiles"

Then build using your chosen generator the way you normally would.  In
the case of Unix makefiles, run:

 make

=== C# wrapper ===

To build the C# wrapper on Linux / OS X, run:

 ./runprebuild.sh && nant

On Windows:

 runprebuild.bat (or runprebuild2008.bat for VC# 2008)
 Then open OgreDotNet.sln in Visual C# and build its projects
