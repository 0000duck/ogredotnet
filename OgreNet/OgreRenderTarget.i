%{
#include "OgreRenderTarget.h"
%}

//TODO subclass Impl, do we need that?
%ignore Ogre::RenderTarget::_getImpl;

//subclass FrameStats, don't think we need it was there before v1.2
%ignore getStatistics;

//  virtual void getMetrics(unsigned int& width, unsigned int& height, unsigned int& colourDepth);
%apply unsigned int &OUTPUT { unsigned int& width, unsigned int& height, unsigned int& colourDepth };

//        virtual void getCustomAttribute(const String& name, void* pData);
%typemap(ctype)        void* pData     "void*"
%typemap(imtype)    void* pData     "ref IntPtr"
%typemap(cstype)    void* pData     "ref IntPtr"
%typemap(in)        void* pData     %{ $1 = (void*)$input; %}
%typemap(csin)        void* pData     "ref $csinput"

%typemap(cscode) Ogre::RenderTarget
%{
    public virtual string Name {
        get
        {
            return getName();
        }
    }

    public virtual UInt32 Width {
        get
        {
            return getWidth();
        }
    }

    public virtual UInt32 Height {
        get
        {
            return getHeight();
        }
    } 

    public virtual UInt32 ColourDepth {
        get
        {
            return getColourDepth();
        }
    }

    public virtual int NumViewports {
        get
        {
            return getNumViewports();
        }
    }

    public virtual float LastFPS {
        get
        {
            return getLastFPS();
        }
    }

    public virtual float AverageFPS {
        get
        {
            return getAverageFPS();
        }
    }

    public virtual float BestFPS {
        get
        {
            return getBestFPS();
        }
    }

    public virtual float WorstFPS {
        get
        {
            return getWorstFPS();
        }
    }

    public virtual float BestFrameTime {
        get
        {
            return getBestFrameTime();
        }
    }

    public virtual float WorstFrameTime {
        get
        {
            return getWorstFrameTime();
        }
    }

    public virtual byte Priority {
        get
        {
            return getPriority();
        }
        set
        {
            setPriority((byte)value);
        }
    }

//     public virtual bool IsActive {
//         get
//         {
//             return isActive();
//         }
//     }

//     public virtual void Active {
//         set
//         {
//             setActive((bool)value);
//         }
//     }

//     public virtual void AutoUpdated {
//         set
//         {
//             setAutoUpdated((bool)value);
//         }
//     }

//     public virtual bool IsAutoUpdated {
//         get
//         {
//             return isAutoUpdated();
//         }
//     }

    public virtual UInt32 TriangleCount {
        get
        {
            return getTriangleCount();
        }
    }

//     public virtual bool IsPrimary {
//         get
//         {
//             return isPrimary();
//         }
//     }
%}

%include "OgreRenderTarget.h"
