//Deprecated
%{
#include "OgreConfigFile.h"
%}

// TODO: figure out how to wrap SectionIterator
// %template(SettingsMultiMap) std::multimap<Ogre::String, Ogre::String>;
// 
// %typemap(ctype)   std::multimap<Ogre::String, Ogre::String> &       "void *"
// %typemap(imtype)  std::multimap<Ogre::String, Ogre::String> &       "IntPtr"
// %typemap(cstype)  std::multimap<Ogre::String, Ogre::String> &       "SettingsMultiMap"
// %typemap(csin)    std::multimap<Ogre::String, Ogre::String> &       "SettingsMultiMap.getCPtr($csinput).Handle"
// %typemap(out)     std::multimap<Ogre::String, Ogre::String> &       %{ $result = (void *)&$1; %}
// %typemap(csout)   std::multimap<Ogre::String, Ogre::String> &
// {
//     IntPtr cPtr = $imcall;
//     return (cPtr == IntPtr.Zero) ? null : new SettingsMultiMap(cPtr, $owner);
// }
// %typemap(in)      std::multimap<Ogre::String, Ogre::String> & 
// %{
//     $1 = (std::multimap<Ogre::String, Ogre::String> *)$input;
// %}
// 
// MapIteratorWRAP(SectionIteratorWrap, std::map, Ogre::String, OgreDotNet.SettingsMultiMap*)

// overloaded function is ambiguous, so we choose one
// TODO: fix this in Ogre
%ignore Ogre::ConfigFile::load(const String& filename, const String& resourceGroup, const String& separators = "\t:=", bool trimWhitespace = true);

%include OgreConfigFile.h
