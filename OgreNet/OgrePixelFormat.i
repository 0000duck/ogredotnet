%{
   #include "OgrePixelFormat.h"
%}

%apply float *OUTPUT { float *r, float *g, float *b, float *a };

%apply int *OUTPUT { int *r, int *g, int *b, int *a };

%apply unsigned int *OUTPUT { Ogre::uint32 *r, Ogre::uint32 *g, Ogre::uint32 *b, Ogre::uint32 *a };

%apply unsigned char *OUTPUT { uint8 *r, uint8 *g, uint8 *b, uint8 *a };



%ignore Ogre::PixelUtil::getBitDepths;
%ignore Ogre::PixelUtil::getBitMasks;

//static void getBitDepths(PixelFormat format, int rgba[4]);
//static void getBitMasks(PixelFormat format, uint32 rgba[4]);

%extend Ogre::PixelUtil {
    static void GetBitDepths(PixelFormat format, int *r, int *g, int *b, int *a)
    {
        int _rgba[4]= {0,0,0,0};
        if (r != 0)  _rgba[0] = *r;
        if (g != 0)  _rgba[1] = *g;
        if (b != 0)  _rgba[2] = *b;
        if (a != 0)  _rgba[3] = *a;
        PixelUtil::getBitDepths(format, _rgba);
        if (r != 0)  *r = _rgba[0];
        if (g != 0)  *g = _rgba[1];
        if (b != 0)  *b = _rgba[2];
        if (a != 0)  *a = _rgba[3];
    }
    static void GetBitMasks(PixelFormat format, uint32 *r, uint32 *g, uint32 *b, uint32 *a)
    {
        uint32 _rgba[4]= {0,0,0,0};
        if (r != 0)  _rgba[0] = *r;
        if (g != 0)  _rgba[1] = *g;
        if (b != 0)  _rgba[2] = *b;
        if (a != 0)  _rgba[3] = *a;
        PixelUtil::getBitMasks(format, _rgba);
        if (r != 0)  *r = _rgba[0];
        if (g != 0)  *g = _rgba[1];
        if (b != 0)  *b = _rgba[2];
        if (a != 0)  *a = _rgba[3];
    }
};




%include "OgrePixelFormat.h"


