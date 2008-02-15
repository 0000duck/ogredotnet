%{
#include "OgreController.h"
%}


//rastaman 11/13/2005
// ControllerValueFloat Event Director
// need some way to callback into C# for getValue and setValue 
%typemap(cscode) Ogre::ControllerValueFloatDirector %{
    protected delegate float _CVFH_GetValue_Delegate();
    protected delegate void _CVFH_SetValue_Delegate(float newvalue);

    public void SubscribeEvents()
    {
        mGetValueDelegate = new _CVFH_GetValue_Delegate(GetValueHandler);
        SetGetValueFunction(swigCPtr, mGetValueDelegate);
        
        mSetValueDelegate = new _CVFH_SetValue_Delegate(SetValueHandler);
        SetSetValueFunction(swigCPtr, mSetValueDelegate);
    }

    //
    // CVFH_GetValue handling
    //
    public event CVFHGetValueDelegate GetValueFunction = null;
    [DllImport("OgreBindings", EntryPoint="CVFH_GetValue_Function")]
    protected static extern void SetGetValueFunction(HandleRef CVFloatDirector, _CVFH_GetValue_Delegate fn);
    protected _CVFH_GetValue_Delegate mGetValueDelegate = null;
    protected float GetValueHandler()
    {
        if(GetValueFunction != null)
            return GetValueFunction();
        return 0;
    }
    
    //
    // CVFH_SetValue handling
    //
    public event CVFHSetValueDelegate SetValueFunction = null;
    [DllImport("OgreBindings", EntryPoint="CVFH_SetValue_Function")]
    protected static extern void SetSetValueFunction(HandleRef CVFloatDirector, _CVFH_SetValue_Delegate fn);
    protected _CVFH_SetValue_Delegate mSetValueDelegate = null;
    protected void SetValueHandler(float newvalue)
    {
        if(SetValueFunction != null)
            SetValueFunction(newvalue);
    }
%}


//rastaman 11/14/2005
// ControllerFunctionFloat Event Director
// need some way to callback into C# for calculate
//CFFH_Calculate_FunctionPointer
%typemap(cscode) Ogre::ControllerFunctionFloatDirector %{
    protected delegate float _CFFH_Calculate_Delegate(float sourceValue);
    protected delegate float _CFFH_GetAdjustedInput_Delegate(float inputValue);

    public void SubscribeEvents()
    {
        mCalculateDelegate = new _CFFH_Calculate_Delegate(CalculateHandler);
        SetCalculateFunction(swigCPtr, mCalculateDelegate);
    }

    //
    // CFFH_Calculate handling
    //
    public event CFFHCalculateDelegate CalculateFunction = null;
    [DllImport("OgreBindings", EntryPoint="CFFH_Calculate_Function")]
    protected static extern void SetCalculateFunction(HandleRef CFuncFloatDirector, _CFFH_Calculate_Delegate fn);
    protected _CFFH_Calculate_Delegate mCalculateDelegate = null;
    protected float CalculateHandler(float sourceValue)
    {
        if(CalculateFunction != null)
            return CalculateFunction(sourceValue);
        return 0;
    }
    
    //
    // CFFH_GetAdjustedInput handling
    //
    public event CFFHGetAdjustedInputDelegate GetAdjustedInputFunction = null;
    [DllImport("OgreBindings", EntryPoint="CFFH_GetAdjustedInput_Function")]
    protected static extern void SetGetAdjustedInputFunction(HandleRef CFuncFloatDirector, _CFFH_GetAdjustedInput_Delegate fn);
    protected _CFFH_GetAdjustedInput_Delegate mGetAdjustedInputDelegate = null;
    protected float GetAdjustedInputHandler(float inputValue)
    {
        if(GetAdjustedInputFunction != null)
            return GetAdjustedInputFunction(inputValue);
        return 0;
    }

    public bool DeltaInput {
        get { return this.GetDeltaInput(); }
        set { this.SetDeltaInput(value); }
    }
    public float DeltaCount {
        get { return this.GetDeltaCount(); }
        set { this.SetDeltaCount(value); }
    }
%}


namespace Ogre
{
    class ControllerValueFloatDirector : public ControllerValue<float>
    {
    public:
        ControllerValueFloatDirector();
        virtual float  getValue (void) const;
        virtual void  setValue (float value);
    };


    class ControllerFunctionFloatDirector  : public ControllerFunction<float>
    {
    public:
        ControllerFunctionFloatDirector(bool deltaInput);
        float  calculate (float sourceValue);
        
        bool GetDeltaInput();
        void SetDeltaInput(bool vv);
        float GetDeltaCount();
        void SetDeltaCount(float vv);
    };
}
