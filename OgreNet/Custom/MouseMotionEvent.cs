using System;

namespace OgreDotNet
{
    public delegate void MouseMotionEventDelegate(MouseMotionEvent e);

    /// <summary>
    /// Summary description for MouseMotionEvent.
    /// </summary>
    public struct MouseMotionEvent
    {
        public float DeltaX;
        public float DeltaY;
        public float DeltaZ;

        public MouseMotionEvent(float deltax, float deltay, float deltaz)
        {
            this.DeltaX = deltax;
            this.DeltaY = deltay;
            this.DeltaZ = deltaz;
        }
    }
}
