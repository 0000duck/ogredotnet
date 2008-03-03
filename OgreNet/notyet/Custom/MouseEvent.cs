using System;

namespace OgreDotNet
{
    public delegate void MouseEventDelegate(MouseEvent e);

    /// <summary>
    /// Summary description for MouseEvent.
    /// </summary>
    public struct MouseEvent
    {
        public float X;
        public float Y;
        public float Z;

        public int ButtonID;

        public MouseEvent(float x, float y, float z, int buttonid)
        {
            this.X = x;
            this.Y = y;
            this.Z = z;
            this.ButtonID = buttonid;
        }
    }
}
