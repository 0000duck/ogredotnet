#!/bin/sh

swig -c++ -E -xml -csharp -namespace CeguiDotNet -I/usr/local/include/CEGUI -I/usr/local/include/CEGUI/elements -I../CeguiNet CeguiBindings.i >CeguiBindings.xml

