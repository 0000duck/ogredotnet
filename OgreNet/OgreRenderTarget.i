%{
    #include "OgreRenderTarget.h"
%}

%rename Ogre::RenderTarget::getName                        GetName;
%rename Ogre::RenderTarget::getMetrics                     GetMetrics;
%rename Ogre::RenderTarget::getWidth                       GetWidth;
%rename Ogre::RenderTarget::getHeight                      GetHeight;
%rename Ogre::RenderTarget::getColourDepth                 GetColourDepth;
%rename Ogre::RenderTarget::update                         Update;
%rename Ogre::RenderTarget::addViewport                    AddViewport;
%rename Ogre::RenderTarget::getNumViewports                GetNumViewports;
%rename Ogre::RenderTarget::getViewport                    GetViewport;
%rename Ogre::RenderTarget::removeViewport                 RemoveViewport;
%rename Ogre::RenderTarget::removeAllViewports             RemoveAllViewports;
%rename Ogre::RenderTarget::getLastFPS                     GetLastFPS;
%rename Ogre::RenderTarget::getAverageFPS                  GetAverageFPS;
%rename Ogre::RenderTarget::getBestFPS                     GetBestFPS;
%rename Ogre::RenderTarget::getWorstFPS                    GetWorstFPS;
%rename Ogre::RenderTarget::getBestFrameTime               GetBestFrameTime;
%rename Ogre::RenderTarget::getWorstFrameTime              GetWorstFrameTime;
%rename Ogre::RenderTarget::resetStatistics                ResetStatistics;
%rename Ogre::RenderTarget::getCustomAttribute             GetCustomAttribute;
%rename Ogre::RenderTarget::setDebugText                   SetDebugText;
%rename Ogre::RenderTarget::getDebugText                   GetDebugText;
%rename Ogre::RenderTarget::addListener                    AddListener;
%rename Ogre::RenderTarget::removeListener                 RemoveListener;
%rename Ogre::RenderTarget::removeAllListeners             RemoveAllListeners;
%rename Ogre::RenderTarget::setPriority                    SetPriority;
%rename Ogre::RenderTarget::getPriority                    GetPriority;
%rename Ogre::RenderTarget::isActive                       IsActive;
%rename Ogre::RenderTarget::setActive                      SetActive;
%rename Ogre::RenderTarget::setAutoUpdated                 SetAutoUpdated;
%rename Ogre::RenderTarget::isAutoUpdated                  IsAutoUpdated;
%rename Ogre::RenderTarget::writeContentsToFile            WriteContentsToFile;
%rename Ogre::RenderTarget::writeContentsToTimestampedFile WriteContentsToTimestampedFile;
%rename Ogre::RenderTarget::requiresTextureFlipping        RequiresTextureFlipping;
%rename Ogre::RenderTarget::getTriangleCount               GetTriangleCount;
%rename Ogre::RenderTarget::isPrimary                      IsPrimary;

//TODO subclass Impl, do we need that?
%ignore Ogre::RenderTarget::_getImpl;

//subclass FrameStats, dont think we need it was there befor v1.2
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

//  public virtual bool IsActive {
//    get
//    {
//        return IsActive();
//    }
//  }

//  public virtual void Active {
//    set
//    {
//        SetActive((bool)value);
//    }
//  }

//  public virtual void AutoUpdated {
//    set
//    {
//        SetAutoUpdated((bool)value);
//    }
//  }

//  public virtual bool IsAutoUpdated {
//    get
//    {
//        return IsAutoUpdated();
//    }
//  }


  public virtual UInt32 TriangleCount {
    get
    {
        return GetTriangleCount();
    }
  }

//  public virtual bool IsPrimary {
//    get
//    {
//        return IsPrimary();
//    }
//  }

%}


%include "OgreRenderTarget.h"

