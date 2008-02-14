#!/bin/sh

FLAGS="-c++ -E -xml -csharp -namespace CeguiDotNet -I/usr/local/include/CEGUI -I/usr/local/include/CEGUI/elements -I../CeguiNet"

swig ${FLAGS} CeguiBindings.i >CeguiBindings.xml
