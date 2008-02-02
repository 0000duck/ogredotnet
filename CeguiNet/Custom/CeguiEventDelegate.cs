using System;

namespace CeguiDotNet
{
	public delegate bool CeguiEventDelegate();

	public delegate bool MouseEventDelegate( MouseEventArgs e );
	public delegate bool WindowEventDelegate( WindowEventArgs e );
	public delegate bool ActivationEventDelegate( ActivationEventArgs e );
	public delegate bool DragDropEventDelegate( DragDropEventArgs e );
	public delegate bool KeyEventDelegate( KeyEventArgs e );
}
