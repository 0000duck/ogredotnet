using System;
using System.Collections;
using System.Drawing;

using Math3D;
using OgreDotNet;
using CeguiDotNet;
using OgreDotNet.Cegui;


namespace DemoCompositor
{
	public delegate void ISVMItemStateChanged(int index, bool state); 
	public class ItemSelectorViewManager
	{
		public event ISVMItemStateChanged EventItemStateChanged=null;

		protected const float WIDGET_XPOS =0.0f;
		protected const float WIDGET_YSTART =0.1f;
		protected const float WIDGET_YOFFSET =0.13f;
		protected const float ITEM_YSIZE =15.0f;
		protected const float ITEM_YSPACING =2.0f;
		protected class ItemSelector
		{
			// make use of widget text member to store Compositor name
			// widget toggle state is used for enable/disable compositor
			// widget ID used for selector index
			public CeguiDotNet.Checkbox CheckBoxWidget;
		}
		protected float mVerticalScrollPosition;
		protected CeguiDotNet.Window           mParentWindow = null;
		protected CeguiDotNet.ScrollablePane   mScrollablePane = null;
		protected System.Collections.ArrayList   mItemSelectorContainer = null;


		public ItemSelectorViewManager(string parentWindowName)
		{
			mItemSelectorContainer = new ArrayList();

			mParentWindow = WindowManager.Instance.getWindow( parentWindowName);
			// add a scrollable pane as a child to the parent
			mScrollablePane = new CeguiDotNet.ScrollablePane( CeguiDotNet.Window.getCPtr(
				WindowManager.Instance.CreateWindow("TaharezLook/ScrollablePane", "MainScrollPane")).Handle , false);
			mScrollablePane.setHorizontalAlignment( CeguiDotNet.HorizontalAlignment.HA_CENTRE);
			mScrollablePane.SetSize( 0.9f, 0.75f );
			mParentWindow.AddChildWindow(mScrollablePane);
			mScrollablePane.SetPosition( WIDGET_XPOS, WIDGET_YSTART );
			// setup scrollable pane to resize to inside of parent window when parent resizes
			// scrollbars should only become visible when required
			// automatically handled by scrollable pane
		}


		~ItemSelectorViewManager()
		{
			mItemSelectorContainer.Clear();
			mItemSelectorContainer = null;
		}


		public int getSelectorCount()
		{
			return this.mItemSelectorContainer.Count;
		}


		public void addItemSelector(string displayText)
		{
			// add a new item selector
			// determine new index for item
			int idx = mItemSelectorContainer.Count;
			ItemSelector item = new ItemSelector();
			mItemSelectorContainer.Add( item);
			
			// create new checkbox
			Checkbox checkbox = item.CheckBoxWidget = new Checkbox( Window.getCPtr( 
				WindowManager.Instance.CreateWindow("TaharezLook/Checkbox",
					"ItemCheckbox" + idx.ToString()) ).Handle , false);
			
			// set checkbox ID to selector ID
			checkbox.setID( (uint)idx);
			checkbox.setMetricsMode( CeguiDotNet.MetricsMode.Absolute);
			checkbox.SetSize( 100, ITEM_YSIZE );
			checkbox.setText( displayText );
			checkbox.setHoverTextColour( new CeguiDotNet.colour(1.0f, 1.0f, 0.0f) );
			
			// add event handler for when checkbox state changes
			checkbox.SubscribeEvents();
			checkbox.CheckStateChanged += new WindowEventDelegate( handleCheckStateChanged );
			checkbox.SetPosition( 0.0f, 12.0f + (ITEM_YSIZE + ITEM_YSPACING)* (float)idx );
			// add checkbox to the scroll pane
			mScrollablePane.AddChildWindow(checkbox);
		}

		public string getItemSelectorText(int index)
		{
			ItemSelector item = (ItemSelector)this.mItemSelectorContainer[index];
			if (item !=null)	
				return item.CheckBoxWidget.getText();
			return "";
		}


		protected bool handleCheckStateChanged( CeguiDotNet.WindowEventArgs args)
		{
			// activate controller if set
			if (EventItemStateChanged!=null )
			{
				Checkbox checkbox = new Checkbox( CeguiDotNet.Window.getCPtr(args.window).Handle , false );
				
				EventItemStateChanged( (int)checkbox.getID(), checkbox.isSelected() );

				float selectColour = checkbox.isSelected() ? 0.0f : 1.0f;
				checkbox.setNormalTextColour( new CeguiDotNet.colour(selectColour, 1.0f, selectColour) );
			}
			return true;
		}
	}

}
