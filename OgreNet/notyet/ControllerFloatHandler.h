#ifndef _ControllerFloatHandler_H_
#define _ControllerFloatHandler_H_

namespace Ogre
{
    //rastaman 11/13/2005
    // ControllerValueFloat Event Director
    // need some way to callback into C# for getValue and setValue 
    typedef float (SWIGSTDCALL *CVFH_GetValue_FunctionPointer)(void);
    typedef void (SWIGSTDCALL *CVFH_SetValue_FunctionPointer)(float);

    class ControllerValueFloatDirector : public ControllerValue<float>
    {
    public:
        CVFH_GetValue_FunctionPointer mGetValueFP;
        CVFH_SetValue_FunctionPointer mSetValueFP;

    public:
        ControllerValueFloatDirector()
        {
            mGetValueFP =0;
            mSetValueFP =0;
        }

        virtual float  getValue (void) const
        {
            if(mGetValueFP)
                return mGetValueFP();
            else
                return 0;
        }

        virtual void  setValue (float value)
        {
            if(mSetValueFP)
                mSetValueFP(value);
        }
    };


    //rastaman 11/14/2005
    // ControllerFunctionFloat Event Director
    // need some way to callback into C# for calculate 
    typedef float (SWIGSTDCALL *CFFH_Calculate_FunctionPointer)(float);
    typedef float (SWIGSTDCALL *CFFH_GetAdjustedInput_FunctionPointer)(float);

    class ControllerFunctionFloatDirector  : public ControllerFunction<float>
    {
    protected:
        float getAdjustedInput(float input)
        {
            if(mGetAdjustedInputFP)
                return mGetAdjustedInputFP(input);
            else
                return ControllerFunction<Real>::getAdjustedInput(input);
        }

    public:
        CFFH_Calculate_FunctionPointer mCalculateFP;
        CFFH_GetAdjustedInput_FunctionPointer mGetAdjustedInputFP;

        ControllerFunctionFloatDirector(bool deltaInput) : ControllerFunction<float>(deltaInput)
        {
            mCalculateFP = 0;
            mGetAdjustedInputFP = 0;
        }

        float  calculate (float sourceValue)
        {
            if(mCalculateFP)
                return mCalculateFP(sourceValue);
            else
                return 0;
        }

        bool GetDeltaInput()          { return mDeltaInput; }
        void SetDeltaInput(bool vv)   { mDeltaInput = vv; }
        float GetDeltaCount()         { return mDeltaCount; }
        void SetDeltaCount(float vv)  { mDeltaCount = vv; }
    };
}


extern "C" SWIGEXPORT void CVFH_GetValue_Function(void* cv, void* fn)
{
    ((Ogre::ControllerValueFloatDirector*)cv)->mGetValueFP = (CVFH_GetValue_FunctionPointer)fn;
}

extern "C" SWIGEXPORT void CVFH_SetValue_Function(ControllerValueFloatDirector* cv, void* fn)
{
    ((Ogre::ControllerValueFloatDirector*)cv)->mSetValueFP = (CVFH_SetValue_FunctionPointer)fn;
}


extern "C" SWIGEXPORT void CFFH_Calculate_Function(void* cf, void* fn)
{
    ((Ogre::ControllerFunctionFloatDirector*)cf)->mCalculateFP = (CFFH_Calculate_FunctionPointer)fn;
}

extern "C" SWIGEXPORT void CFFH_GetAdjustedInput_Function(void* cf, void* fn)
{
    ((Ogre::ControllerFunctionFloatDirector*)cf)->mGetAdjustedInputFP = (CFFH_GetAdjustedInput_FunctionPointer)fn;
}

#endif //_ControllerFloatHandler_H_
