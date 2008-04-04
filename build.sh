#!/bin/sh

# This should build OgreDotNet under Linux and OS X

clean() {
    rm -rf CMakeCache.txt cmake_install.cmake CMakeFiles *.sln *.build Makefile
    rm -rf Math3D/*.csproj Math3D/*.build Math3D/*.user Math3D/bin
    rm -rf bin/*.dll bin/*.so bin/*.dylib
    rm -rf OgreNet/*_wrap.* OgreNet/*.build OgreNet/*.user OgreNet/*.csproj OgreNet/bin
    rm -rf OgreNet/build/*.cs
}

build_swig() {
    cmake -G "Unix Makefiles" || exit 1
    make || exit 1
}

build_csharp() {
    ./runprebuild.sh || exit 1
    nant || exit 1
}

clean
build_swig
build_csharp

if [ "`uname`" == "Darwin" ]; then
    mv bin/OgreBindings.so bin/libOgreBindings.dylib
else
    mv bin/OgreBindings.so bin/libOgreBindings.so
fi
