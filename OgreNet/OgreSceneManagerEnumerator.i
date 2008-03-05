%{
#include "OgreSceneManagerEnumerator.h"
%}


%typemap(cscode) Ogre::SceneManagerEnumerator
%{
    public static SceneManagerEnumerator Instance    {
        get    {
            return new SceneManagerEnumerator(OgreBindingsPINVOKE.SceneManagerEnumerator_getSingletonPtr(), false);
        }
    }
%}


%include "OgreSceneManagerEnumerator.h"

//typedef std::map<String, SceneManager*> Instances;
PTR_REF_TYPEMAPS(SceneManager, Ogre::SceneManager*)
%template(SceneManagerInstances) std::map<Ogre::String, Ogre::SceneManager*>;

//typedef MapIterator<Instances> SceneManagerIterator;
MapIteratorWRAP(SceneManagerIteratorWrap, std::map, Ogre::String, Ogre::SceneManager*);


//typedef std::vector<const SceneManagerMetaData*> MetaDataList;
SWIG_STD_VECTOR_SPECIALIZE_MINIMUM(SceneManagerMetaData, const Ogre::SceneManagerMetaData*)
%template(MetaDataList) std::vector<const Ogre::SceneManagerMetaData*>;

//typedef ConstVectorIterator<MetaDataList> MetaDataIterator;
ConstVectorIteratorWRAP(MetaDataIteratorWrap, std::vector, const Ogre::SceneManagerMetaData*);



