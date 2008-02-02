%{
#include "OgreCommon.h"
%}

// enum CompareFunction
#define CMPF_ALWAYS_FAIL   AlwaysFail
#define CMPF_ALWAYS_PASS   AlwaysPass
#define CMPF_LESS          Less
#define CMPF_LESS_EQUAL    LessEqual
#define CMPF_EQUAL         Equal
#define CMPF_NOT_EQUAL     NotEqual
#define CMPF_GREATER_EQUAL GreaterEqual
#define CMPF_GREATER       Greater
// enum TextureFilterOptions
#define TFO_NONE        TfoNone
#define TFO_BILINEAR    TfoBilinear
#define TFO_TRILINEAR   TfoTrilinear
#define TFO_ANISOTROPIC TfoAnisotropic
// enum FilterType
#define FT_MIN Min
#define FT_MAG Mag
#define FT_MIP Mip
// enum FilterOptions
#define FO_NONE        FoNone
#define FO_POINT       FoPoint
#define FO_LINEAR      FoLinear
#define FO_ANISOTROPIC FoAnisotropic
// enum ShadeOptions
#define SO_FLAT    Flat
#define SO_GOURAUD Gouraud
#define SO_PHONG   Phong
// enum FogMode
#define FOG_NONE   FogNone
#define FOG_EXP    FogExp
#define FOG_EXP2   FogExp2
#define FOG_LINEAR FogLinear
// enum CullingMode
#define CULL_NONE          CullNone
#define CULL_CLOCKWISE     CullClockwise
#define CULL_ANTICLOCKWISE CullAntiClockwise
// enum ManualCullingMode
#define MANUAL_CULL_NONE  ManualCullNone
#define MANUAL_CULL_BACK  ManualCullBack
#define MANUAL_CULL_FRONT ManualCullFront
// enum WaveformType
#define WFT_SINE             Sine
#define WFT_TRIANGLE         Triangle
#define WFT_SQUARE           Square
#define WFT_SAWTOOTH         Sawtooth
#define WFT_INVERSE_SAWTOOTH InverseSawtooth
#define WFT_PWM              PulseWidthModulation
// enum PolygonMode
#define PM_POINTS    PMPoints
#define PM_WIREFRAME PMWireframe
#define PM_SOLID     PMSolid
// enum ShadowTechnique
#define SHADOWTYPE_NONE                  ShadowTypeNone
#define SHADOWDETAILTYPE_ADDITIVE        ShadowDetailTypeAdditive
#define SHADOWDETAILTYPE_MODULATIVE      ShadowDetailTypeModulative
#define SHADOWDETAILTYPE_STENCIL         ShadowDetailTypeStencil
#define SHADOWDETAILTYPE_TEXTURE         ShadowDetailTypeTexture
#define SHADOWTYPE_STENCIL_MODULATIVE    ShadowTypeStencilModulative
#define SHADOWTYPE_STENCIL_ADDITIVE      ShadowTypeStencilAdditive
#define SHADOWTYPE_TEXTURE_MODULATIVE    ShadowTypeTextureModulative
#define SHADOWTYPE_TEXTURE_ADDITIVE      ShadowTypeTextureAdditive
// enum TrackVertexColourEnum
#define TVC_NONE     TvcNone    
#define TVC_AMBIENT  TvcAmbient        
#define TVC_DIFFUSE  TvcDiffuse 
#define TVC_SPECULAR TvcSpecular
#define TVC_EMISSIVE TvcEmissive
// enum SortMode
#define SM_DIRECTION  SortModeDirection
#define SM_DISTANCE   SortModeDistance
// enum FrameBufferType
#define FBT_COLOUR  FBTypeColour
#define FBT_DEPTH   FBTypeDepth
#define FBT_STENCIL FBTypeStencil



//DotNet has native ways to do commandline parsing
%ignore Ogre::findCommandLineOpts;

%include OgreCommon.h

//typedef std::vector<Light*> LightList;
//swig.29     PTR_REF_TYPEMAPS(Light, Ogre::Light*)
SWIG_STD_VECTOR_SPECIALIZE_MINIMUM(Light, Ogre::Light*)
%template(LightList) std::vector<Ogre::Light*>;


//we can only have one all uses of std::map<string,string> will use the same named type
//  typedef std::map<String, String> BinaryOptionList;
//  typedef std::map<String, String> AliasTextureNamePairList;
//	typedef std::map<String, String> NameValuePairList;
%template(NameValuePairList) std::map<std::string, std::string>;

// typedef TRect<float> FloatRect;
%template(FloatRect) Ogre::TRect<float>;

// typedef TRect< long > Rect;
%template(Rect) Ogre::TRect<long>;


