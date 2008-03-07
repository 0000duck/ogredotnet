%{
#include "OgreRoot.h"
%}

%ignore Ogre::Root::addFrameListener;
%ignore Ogre::Root::removeFrameListener;
%ignore Ogre::Root::_fireFrameStarted;
%ignore Ogre::Root::_fireFrameEnded;
%ignore Ogre::Root::_allocateNextMovableObjectTypeFlag;

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
    
    static public Root Instance
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
