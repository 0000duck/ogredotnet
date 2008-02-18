using System;

namespace OgreDotNet
{
    public delegate bool FrameEventDelegate(FrameEvent e);

    /// <summary>
    /// Struct containing information about a frame event.
    /// </summary>
    public struct FrameEvent
    {
        /// <summary>
        /// Time in seconds since the last frame.
        /// </summary>
        public float TimeSinceLastFrame;

        /// <summary>
        /// Time in seconds since the last event.
        /// </summary>
        public float TimeSinceLastEvent;

        /// <summary>
        /// Initialises a new instance of the FrameEvent struct.
        /// </summary>
        /// <param name="timesincelastevent">Time in seconds since the last frame.</param>
        /// <param name="timesincelastframe">Time in seconds since the last event.</param>
        public FrameEvent(float timesincelastframe, float timesincelastevent)
        {
            this.TimeSinceLastFrame = timesincelastframe;
            this.TimeSinceLastEvent = timesincelastevent;
        }
    }
}
