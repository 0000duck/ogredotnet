%{
#include "OgreRenderable.h"
%}

//ignore because RenderOperation is private
%ignore Ogre::Renderable::getRenderOperation;

//override is a key word in C#
%ignore Ogre::Renderable::setPolygonModeOverrideable;

//TODO wrap AutoConstantEntry
%ignore Ogre::Renderable::_updateCustomGpuParameter;

%typemap(cscode) Ogre::Renderable
%{
    static public Renderable GetRenderableFrom(BillboardSet c)
    {
        Renderable ret = new Renderable(BillboardSet.getCPtr(c).Handle, false);
        return ret;
    }

/*    static public Renderable GetRenderableFrom(BorderRenderable c)
    {
        Renderable ret = new Renderable(BorderRenderable.getCPtr(c).Handle, false);
        return ret;
    }
*/
    static public Renderable GetRenderableFrom(Frustum c)
    {
        Renderable ret = new Renderable(Frustum.getCPtr(c).Handle, false);
        return ret;
    }

    static public Renderable GetRenderableFrom(Node c)
    {
        Renderable ret = new Renderable(Node.getCPtr(c).Handle, false);
        return ret;
    }

    static public Renderable GetRenderableFrom(OverlayElement c)
    {
        Renderable ret = new Renderable(OverlayElement.getCPtr(c).Handle, false);
        return ret;
    }

    static public Renderable GetRenderableFrom(ShadowRenderable c)
    {
        Renderable ret = new Renderable(ShadowRenderable.getCPtr(c).Handle, false);
        return ret;
    }

    static public Renderable GetRenderableFrom(SimpleRenderable c)
    {
        Renderable ret = new Renderable(SimpleRenderable.getCPtr(c).Handle, false);
        return ret;
    }

//     static public Renderable GetRenderableFrom(GeometryBucket c)
//     {
//         Renderable ret = new Renderable(GeometryBucket.getCPtr(c).Handle, false);
//         return ret;
//     }

    static public Renderable GetRenderableFrom(SubEntity c)
    {
        Renderable ret = new Renderable(SubEntity.getCPtr(c).Handle, false);
        return ret;
    }
%}

%include OgreRenderable.h

%extend Ogre::Renderable
{
    void SetPolygonModeOverrideable(bool oo)
    {
        self->setPolygonModeOverrideable(oo);
    }
};
