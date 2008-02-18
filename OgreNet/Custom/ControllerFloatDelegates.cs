using System;

namespace OgreDotNet
{
    public delegate float CVFHGetValueDelegate();
    public delegate void CVFHSetValueDelegate(float newvalue);

    public delegate float CFFHCalculateDelegate(float sourceValue);
    public delegate float CFFHGetAdjustedInputDelegate(float inputvalue);
}
