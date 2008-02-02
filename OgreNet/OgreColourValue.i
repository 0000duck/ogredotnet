%{
	#include "OgreColourValue.h"
%}

%typemap(cscode) Ogre::ColourValue
%{
    public float a   {
        get { return GetA(); }
        set { SetA(value); }
    }
    public float r   {
        get { return GetR(); }
        set { SetR(value); }
    }
    public float g   {
        get { return GetG(); }
        set { SetG(value); }
    }
    public float b   {
        get { return GetB(); }
        set { SetB(value); }
    }
%}


%typemap(cstype) const Ogre::ColourValue & "System.Drawing.Color"
%typemap(csin) const Ogre::ColourValue & "ColourValue.getCPtr(Converter.ToColourValue($csinput))"
%typemap(csout, excode=SWIGEXCODE) const Ogre::ColourValue &
{
	return Converter.ToColor(new ColourValue($imcall, false));
}

%include "OgreColourValue.h"


%extend Ogre::ColourValue
{
	float GetA()
	{
		return self->a;
	}
	
	float GetR()
	{
		return self->r;
	}
	
	float GetG()
	{
		return self->g;
	}
	
	float GetB()
	{
		return self->b;
	}
	
	void SetA( float val)
	{
		self->a = val;
	}
	void SetR( float val)
	{
		self->r = val;
	}
	void SetG( float val)
	{
		self->g = val;
	}
	void SetB( float val)
	{
		self->b = val;
	}

};

