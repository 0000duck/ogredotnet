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
            return GetName();
        }
    }

    public virtual UInt32 Width {
        get
        {
            return GetWidth();
        }
    }

    public virtual UInt32 Height {
        get
        {
            return GetHeight();
        }
    } 

    public virtual UInt32 ColourDepth {
        get
        {
            return GetColourDepth();
        }
    }

    public virtual int NumViewports {
        get
        {
            return GetNumViewports();
        }
    }

    public virtual float LastFPS {
        get
        {
            return GetLastFPS();
        }
    }

    public virtual float AverageFPS {
        get
        {
            return GetAverageFPS();
        }
    }

    public virtual float BestFPS {
        get
        {
            return GetBestFPS();
        }
    }

    public virtual float WorstFPS {
        get
        {
            return GetWorstFPS();
        }
    }

    public virtual float BestFrameTime {
        get
        {
            return GetBestFrameTime();
        }
    }

    public virtual float WorstFrameTime {
        get
        {
            return GetWorstFrameTime();
        }
    }

    public string DebugText {
        get
        {
            return GetDebugText();
        }
        set
        {
            SetDebugText((string)value);
        }
    }

    public virtual byte Priority {
        get
        {
            return GetPriority();
        }
        set
        {
            SetPriority((byte)value);
        }
    }

//     public virtual bool IsActive {
//         get
//         {
//             return IsActive();
//         }
//     }

//     public virtual void Active {
//         set
//         {
//             SetActive((bool)value);
//         }
//     }

//     public virtual void AutoUpdated {
//         set
//         {
//             SetAutoUpdated((bool)value);
//         }
//     }

//     public virtual bool IsAutoUpdated {
//         get
//         {
//             return IsAutoUpdated();
//         }
//     }

    public virtual UInt32 TriangleCount {
        get
        {
            return GetTriangleCount();
        }
    }

//     public virtual bool IsPrimary {
//         get
//         {
//             return IsPrimary();
//         }
//     }
%}

%include "OgreRenderTarget.h"
