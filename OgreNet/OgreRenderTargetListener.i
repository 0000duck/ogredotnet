%{
#include "OgreRenderTargetListener.h"
#include "RenderTargetListenerDirector.h"
%}

%include "OgreRenderTargetListener.h"

%typemap(cscode) Ogre::RenderTargetListenerDirector %{
    
    public delegate  void    RTLD_Delegate_RenderTargetUpdate    (RenderTargetEvent evt);
    public delegate  void    RTLD_Delegate_ViewportUpdate        (RenderTargetViewportEvent evt);
    
    protected delegate  void    _RTLD_Delegate_Both    (IntPtr evt);
    
    public void SubscribeEvents()
    {
        m_Delegate_preRenderTargetUpdate =        new _RTLD_Delegate_Both    (Handle_preRenderTargetUpdate);
        set_RTLD_FP_preRenderTargetUpdate        (swigCPtr, m_Delegate_preRenderTargetUpdate);
        
        m_Delegate_postRenderTargetUpdate =        new _RTLD_Delegate_Both    (Handle_postRenderTargetUpdate);
        set_RTLD_FP_postRenderTargetUpdate        (swigCPtr, m_Delegate_postRenderTargetUpdate);
        
        m_Delegate_preViewportUpdate =            new _RTLD_Delegate_Both    (Handle_preViewportUpdate);
        set_RTLD_FP_preViewportUpdate            (swigCPtr, m_Delegate_preViewportUpdate);
        
        m_Delegate_postViewportUpdate =            new _RTLD_Delegate_Both    (Handle_postViewportUpdate);
        set_RTLD_FP_postViewportUpdate            (swigCPtr, m_Delegate_postViewportUpdate);
        
    }
    
    
    
    public event    RTLD_Delegate_RenderTargetUpdate        evtPreRenderTargetUpdate = null;
    public event    RTLD_Delegate_RenderTargetUpdate        evtPostRenderTargetUpdate = null;
    public event    RTLD_Delegate_ViewportUpdate            evtPreViewportUpdate = null;
    public event    RTLD_Delegate_ViewportUpdate            evtPostViewportUpdate = null;
    
    protected    _RTLD_Delegate_Both            m_Delegate_preRenderTargetUpdate = null;
    protected    _RTLD_Delegate_Both            m_Delegate_postRenderTargetUpdate = null;
    protected    _RTLD_Delegate_Both            m_Delegate_preViewportUpdate = null;
    protected    _RTLD_Delegate_Both            m_Delegate_postViewportUpdate = null;
    
    
    [DllImport("OgreBindings", EntryPoint="set_RTLD_FP_preRenderTargetUpdate")]
    protected static extern void set_RTLD_FP_preRenderTargetUpdate(HandleRef RenderTargetListenerDirector, _RTLD_Delegate_Both fn);
    
    [DllImport("OgreBindings", EntryPoint="set_RTLD_FP_postRenderTargetUpdate")]
    protected static extern void set_RTLD_FP_postRenderTargetUpdate(HandleRef RenderTargetListenerDirector, _RTLD_Delegate_Both fn);
    
    [DllImport("OgreBindings", EntryPoint="set_RTLD_FP_preViewportUpdate")]
    protected static extern void set_RTLD_FP_preViewportUpdate(HandleRef RenderTargetListenerDirector, _RTLD_Delegate_Both fn);
    
    [DllImport("OgreBindings", EntryPoint="set_RTLD_FP_postViewportUpdate")]
    protected static extern void set_RTLD_FP_postViewportUpdate(HandleRef RenderTargetListenerDirector, _RTLD_Delegate_Both fn);
    
    
    
    
    protected void Handle_preRenderTargetUpdate (IntPtr evt)
    {
        RenderTargetEvent e = new RenderTargetEvent(evt, false);
        if(evtPreRenderTargetUpdate != null)
            evtPreRenderTargetUpdate(e);
    }
    
    protected void Handle_postRenderTargetUpdate (IntPtr evt)
    {
        RenderTargetEvent e = new RenderTargetEvent(evt, false);
        if(evtPostRenderTargetUpdate != null)
            evtPostRenderTargetUpdate(e);
    }
    
    protected void Handle_preViewportUpdate (IntPtr evt)
    {
        RenderTargetViewportEvent e = new RenderTargetViewportEvent(evt, false);
        if(evtPreViewportUpdate != null)
            evtPreViewportUpdate(e);
    }
    
    protected void Handle_postViewportUpdate (IntPtr evt)
    {
        RenderTargetViewportEvent e = new RenderTargetViewportEvent(evt, false);
        if(evtPostViewportUpdate != null)
            evtPostViewportUpdate(e);
    }
    
%}


namespace Ogre
{
    class RenderTargetListenerDirector : public Ogre::RenderTargetListener
    {
    public:
        RenderTargetListenerDirector();
    };
}
