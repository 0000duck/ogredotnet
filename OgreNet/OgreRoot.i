%{
#include "OgreRoot.h"
%}

%rename Ogre::Root::termHandler            TermHandler;
%rename Ogre::Root::saveConfig             SaveConfig;
%rename Ogre::Root::restoreConfig          RestoreConfig;
%rename Ogre::Root::showConfigDialog       ShowConfigDialog;
%rename Ogre::Root::addRenderSystem        AddRenderSystem;
%rename Ogre::Root::getAvailableRenderers  GetAvailableRenderers;
%rename Ogre::Root::getRenderSystemByName  GetRenderSystemByName;
%rename Ogre::Root::setRenderSystem        SetRenderSystem;
%rename Ogre::Root::getRenderSystem        GetRenderSystem;
%rename Ogre::Root::initialise             Initialise;
%rename Ogre::Root::isInitialised                    IsInitialised;
%rename Ogre::Root::addSceneManagerFactory           AddSceneManagerFactory;
%rename Ogre::Root::removeSceneManagerFactory        RemoveSceneManagerFactory;
%rename Ogre::Root::getSceneManagerMetaData          GetSceneManagerMetaData;
%rename Ogre::Root::getSceneManagerMetaDataIterator  GetSceneManagerMetaDataIterator;
%rename Ogre::Root::createSceneManager               CreateSceneManager;
%rename Ogre::Root::destroySceneManager              DestroySceneManager;
%rename Ogre::Root::getSceneManager                  GetSceneManager;
%rename Ogre::Root::getSceneManagerIterator          GetSceneManagerIterator;
%rename Ogre::Root::getTextureManager      GetTextureManager;
%rename Ogre::Root::getMeshManager         GetMeshManager;
%rename Ogre::Root::getErrorDescription    GetErrorDescription;
%rename Ogre::Root::queueEndRendering      QueueEndRendering;
%rename Ogre::Root::startRendering         StartRendering;
%rename Ogre::Root::renderOneFrame         RenderOneFrame;
%rename Ogre::Root::shutdown               Shutdown;
%rename Ogre::Root::addResourceLocation    AddResourceLocation;
%rename Ogre::Root::removeResourceLocation RemoveResourceLocation;
%rename Ogre::Root::getAutoCreatedWindow   GetAutoCreatedWindow;
%rename Ogre::Root::createRenderWindow     CreateRenderWindow;
%rename Ogre::Root::detachRenderTarget     DetachRenderTarget;
%rename Ogre::Root::getRenderTarget        GetRenderTarget;
%rename Ogre::Root::loadPlugin             LoadPlugin;
%rename Ogre::Root::unloadPlugin           UnloadPlugin;
%rename Ogre::Root::getTimer               GetTimer;
%rename Ogre::Root::getCurrentFrameNumber  GetCurrentFrameNumber;
%rename Ogre::Root::getSingleton           GetSingleton;
%rename Ogre::Root::getSingletonPtr           GetSingletonPtr;
%rename Ogre::Root::clearEventTimes           ClearEventTimes;
%rename Ogre::Root::setFrameSmoothingPeriod   SetFrameSmoothingPeriod;
%rename Ogre::Root::getFrameSmoothingPeriod   GetFrameSmoothingPeriod;

%rename Ogre::Root::addMovableObjectFactory             AddMovableObjectFactory;
%rename Ogre::Root::removeMovableObjectFactory          RemoveMovableObjectFactory;
%rename Ogre::Root::_allocateNextMovableObjectTypeFlag  m_AllocateNextMovableObjectTypeFlag;
%rename Ogre::Root::hasMovableObjectFactory             HasMovableObjectFactory;
%rename Ogre::Root::getMovableObjectFactory             GetMovableObjectFactory;
%rename Ogre::Root::getMovableObjectFactoryIterator     GetMovableObjectFactoryIterator;

%rename Ogre::Root::createRenderQueueInvocationSequence         CreateRenderQueueInvocationSequence;
%rename Ogre::Root::getRenderQueueInvocationSequence            GetRenderQueueInvocationSequence;
%rename Ogre::Root::destroyRenderQueueInvocationSequence        DestroyRenderQueueInvocationSequence;
%rename Ogre::Root::destroyAllRenderQueueInvocationSequences    DestroyAllRenderQueueInvocationSequences;


%ignore Ogre::Root::addFrameListener;
%ignore Ogre::Root::removeFrameListener;
%ignore Ogre::Root::_fireFrameStarted;
%ignore Ogre::Root::_fireFrameEnded;


//these internal use functions should not be needed
%ignore Ogre::Root::_getCurrentSceneManager;
%ignore Ogre::Root::_updateAllRenderTargets;


// TODO this exspects a list of uint32
%ignore Ogre::Root::convertColourValue;



%typemap(cscode) Ogre::Root
%{
    public RenderWindow Initialise(System.Windows.Forms.Control control)
    {
        System.Drawing.Size s = control.ClientSize;
        return this.Initialise(control.Handle.ToInt32(), s.Width, s.Height, false);
    }
    
    static public Root Instance // njkogre-added
    {
        get    {
            if (_instance == null) _instance = GetSingleton();
            return _instance;
        }
    }
    static private Root _instance = null;
    
    public RenderSystemList AvailableRenderers {
        get    {    return GetAvailableRenderers();    }
    }
    
    public RenderSystem RenderSystem {
        get    {    return GetRenderSystem();    }
        set    {    SetRenderSystem((RenderSystem)value);    }
    }
    
    public TextureManager TextureManager {
        get    {    return GetTextureManager();    }
    }

    public MeshManager MeshManager {
        get    {    return GetMeshManager();    }
    }
    
    public RenderWindow AutoCreatedWindow {
        get    {    return GetAutoCreatedWindow();    }
    }
    
    public OgreDotNet.Timer Timer {
        get    {    return GetTimer();    }
    }
    
    public UInt32 CurrentFrameNumber {
        get    {    return GetCurrentFrameNumber();    }
    }
%}

%extend Ogre::Root
{
    RenderWindow * initialise(int existingwindowhandle, int width, int height, bool fullscreen)
    {
            NameValuePairList miscParams;
            miscParams["externalWindowHandle"] = StringConverter::toString((size_t)existingwindowhandle);
            
            self->initialise(false);
            
            return self->createRenderWindow("", width, height, fullscreen, &miscParams);
    }
};

%include "OgreRoot.h"


//typedef std::vector<RenderSystem*> RenderSystemList;
//swig.29     PTR_REF_TYPEMAPS(RenderSystem, Ogre::RenderSystem*)
SWIG_STD_VECTOR_SPECIALIZE_MINIMUM(RenderSystem, Ogre::RenderSystem*)
%template(RenderSystemList) std::vector<Ogre::RenderSystem*>;

//    typedef std::map<String, MovableObjectFactory*> MovableObjectFactoryMap;
//    typedef ConstMapIterator<MovableObjectFactoryMap> MovableObjectFactoryIterator;
ConstMapIteratorWRAP(MovableObjectFactoryIteratorWrap, std::map, Ogre::String, Ogre::MovableObjectFactory*);

