%{
#include "OgreColourValue.h"
%}

%typemap(cstype) const Ogre::ColourValue & "System.Drawing.Color"
%typemap(csin) const Ogre::ColourValue & "ColourValue.getCPtr(Converter.ToColourValue($csinput))"
%typemap(csout, excode=SWIGEXCODE) const Ogre::ColourValue &
{
    return Converter.ToColor(new ColourValue($imcall, false));
}

%include "OgreColourValue.h"
