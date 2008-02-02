//The best opensource license is no license at all - The OgreDotNet team

%{
	#include "EventSet.h"
%}

%ignore WrappedEventSet::mOnClick;

%typemap(cscode) WrappedEventSet
%{
	public delegate bool ClickedDelegate();
	
	[DllImport("CeguiBindings", EntryPoint="EventSetSetOnClicked")]
	public static extern void EventSetSetOnClicked( HandleRef eventhandler, ClickedDelegate fn );
	protected ClickedDelegate mClickedDelegate = null;
	public ClickedDelegate OnClicked
	{
		set
		{
			mClickedDelegate = value;
			EventSetSetOnClicked(swigCPtr, mClickedDelegate);
		}
	}
%}

%include EventSet.h