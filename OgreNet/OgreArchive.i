%{
   #include "OgreArchive.h"
%}


%include "OgreArchive.h"

//    typedef std::vector<FileInfo> FileInfoList;
SWIG_STD_VECTOR_SPECIALIZE_MINIMUM(FileInfo, Ogre::FileInfo)
%template(FileInfoList) std::vector<Ogre::FileInfo>;


// TODO custom wrap this
//    typedef SharedPtr<FileInfoList> FileInfoListPtr;
//DLLNonePtrType(FileInfoList, std::vector<FileInfo>)
//%template(FileInfoListPtr) Ogre::SharedPtr<std::vector<FileInfo> >;
