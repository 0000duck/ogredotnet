#!/bin/sh

# This should build OgreDotNet under Linux and OS X

clean() {
    rm -rf CMakeCache.txt cmake_install.cmake CMakeFiles *.sln *.build Makefile
    rm -rf Math3D/*.csproj Math3D/*.build Math3D/*.user Math3D/bin
    rm -rf *.so bin/*.dll
    rm -rf OgreNet/*_wrap.* OgreNet/*.build OgreNet/*.user OgreNet/*.csproj OgreNet/bin

    # To avoid deleting OgreNet/AssemblyInfo.cs, rename it temporarily
    mv OgreNet/AssemblyInfo.cs OgreNet/AssemblyInfo.cs.cleaning_script.temp
    rm -rf OgreNet/*.cs
    mv OgreNet/AssemblyInfo.cs.cleaning_script.temp OgreNet/AssemblyInfo.cs
}

build_swig() {
    cmake -G "Unix Makefiles" && make
}

build_csharp() {
    ./runprebuild.sh && nant
}

clean
build_swig && build_csharp
