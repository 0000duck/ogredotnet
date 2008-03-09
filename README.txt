To build OgreDotNet, you need the following:
 - Ogre (http://www.ogre3d.org/)
 - CMake (http://www.cmake.org/)

CMake is a build tool to allow a single configuration file to generate
project files and makefiles for a number of platforms.  To see what
generators are available for your platform, run:

  cmake --help

Then, for example, to use Unix makefiles as your build method, run:

  cmake -G "Unix Makefiles"

Then build using your chosen generator the way you normally would.  In
the case of Unix makefiles, run:

  make

To build the C# wrapper on Linux / OS X, run:

  ./runprebuild.sh && nant

On Windows:

  runprebuild.bat (or runprebuild2008.bat for VC# 2008)
  Then build the projects in OgreDotNet.sln
