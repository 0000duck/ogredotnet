using System;

namespace OgreDotNet
{
	public delegate void KeyEventDelegate( KeyEvent e );

	/// <summary>
	/// Summary description for KeyEvent.
	/// </summary>
	public struct KeyEvent
	{
		public KeyCode KeyCode;
		public char KeyChar;
		public bool Shift;
		public bool Alt;
		public bool Ctrl;
		public bool Meta;

		public KeyEvent( KeyCode keycode, char keychar, bool shift, bool alt, bool ctrl, bool meta )
		{
			this.KeyCode = keycode;
			this.KeyChar = keychar;
			this.Shift = shift;
			this.Alt = alt;
			this.Ctrl = ctrl;
			this.Meta = meta;
		}
	}
}
