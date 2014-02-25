/*
 * The contents of this file are subject to the Mozilla Public License Version
 * 1.1 (the "License"); you may not use this file except in compliance with
 * the License. You may obtain a copy of the License at 
 *
 *        http://www.mozilla.org/MPL/ 
 *
 * Software distributed under the License is distributed on an "AS IS" basis,
 * WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
 * for the specific language governing rights and limitations under the License. 
 *
 * The Original Code is myLib.
 *
 * The Initial Developer of the Original Code is
 * Samuel EMINET (aka SamYStudiO) contact@samystudio.net.
 * Portions created by the Initial Developer are Copyright (C) 2008-2011
 * the Initial Developer. All Rights Reserved.
 *
 */
package myLib.controls 
{
	import myLib.assets.IAsset;
	import myLib.controls.skins.IDataGridSkin;
	import myLib.controls.skins.my_skinset;
	import myLib.core.AFieldComponent;
	import myLib.core.IScroll;
	import myLib.core.InvalidationType;
	import myLib.data.CollectionEvent;
	import myLib.data.DataProvider;
	import myLib.data.ICollection;
	import myLib.data.Iterator;
	import myLib.form.IField;
	import myLib.styles.Padding;
	import myLib.utils.ObjectUtils;

	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import flash.utils.Dictionary;
	/**
	 * @private
	 * 
	 * @author SamYStudiO
	 */
	public class DataGrid extends AFieldComponent implements IDataGrid, IField
	{
		/**
		 * @private
		 */
		protected var _dateGridSkin : IDataGridSkin;
		
		/**
		 * @private
		 */
		protected var _itemToListCellData : Dictionary = new Dictionary( true );

		/**
		 * @private
		 */
		protected var _filterDataProvider : Array;
		
		/**
		 * @private
		 */
		protected var _keySelectionLoop : Boolean = true;
		
		[Inspectable(defaultValue=true)] 
		/**
		 * Get or set a Boolean that indicates if a key selection using up or down loop from last item to first item.
		 * 
		 * @default true
		 */
		public function get keySelectionLoop() : Boolean
		{
			return _keySelectionLoop;
		}
		
		public function set keySelectionLoop( b : Boolean ) : void
		{
			if( _inspector && !_isLivePreview && !_keySelectionLoop ) return;
			
			_keySelectionLoop = b;
		}
				
		/**
		 *
		 */
		protected var _borderThickness : Number = 1;
		
		[Inspectable(defaultValue=1)] 
		/**
		 * Get or set the border thickness for layout.
		 */
		public function get borderThickness() : Number
		{
			return _borderThickness;
		}
		
		public function set borderThickness( n : Number ) : void
		{
			if( _inspector && !_isLivePreview && _borderThickness != 1 ) return;
			
			_borderThickness = n;
		}
		
		/**
		 * @private
		 */
		protected var _dataProvider : ICollection;

		[Collection(collectionClass="myLib.data.DataProvider",collectionItem="myLib.data.DataProviderItem")]
		/**
		 * Get or set the collection object used to build List cells. In most case DataProvider collection is what you need here.
		 * 
		 * @see myLib.data.DataProvider
		 */
		public function get dataProvider () : ICollection
		{
			return _dataProvider;
		}
		
		public function set dataProvider ( dataProvider : ICollection ) : void
		{
			if( dataProvider == _dataProvider || ( _inspector && !_isLivePreview && !_dataProvider.isEmpty() ) ) return;	
			
			if( _dataProvider != null ) 
			{
				_dataProvider.removeEventListener( CollectionEvent.ADD , _modelChange );	
				_dataProvider.removeEventListener( CollectionEvent.REMOVE , _modelChange );	
				_dataProvider.removeEventListener( CollectionEvent.REPLACE , _modelChange );	
				_dataProvider.removeEventListener( CollectionEvent.CLEAR , _modelChange );	
				_dataProvider.removeEventListener( CollectionEvent.SORT , _modelChange );	
			}
			
			clearSelection();
			
			_dataProvider = dataProvider || new DataProvider( null );
			
			var iterator : Iterator = _dataProvider.getIterator();
			
			while( iterator.hasNext() ) 
			{
				//var o : * = iterator.next();
				
				//_itemToListCellData[ o ] = new ListCellData( this , iterator.position - 1 , o );
			}
			
			_dataProvider.addEventListener( CollectionEvent.ADD , _modelChange , false , 0 , true );	
			_dataProvider.addEventListener( CollectionEvent.REMOVE , _modelChange , false , 0 , true );	
			_dataProvider.addEventListener( CollectionEvent.REPLACE , _modelChange , false , 0 , true );	
			_dataProvider.addEventListener( CollectionEvent.CLEAR , _modelChange , false , 0 , true );	
			_dataProvider.addEventListener( CollectionEvent.SORT , _modelChange , false , 0 , true );	
			
			_filterDataProvider = null;
			
			invalidate( InvalidationType.DATA );
		}
		
		/**
		 * Get or set the List selected index.
		 */
		public function get selectedIndex() : int
		{
			return _selectedIndices.length ? _selectedIndices[ _selectedIndices.length - 1 ] : -1;
		}
		
		public function set selectedIndex( index : int ) : void
		{
			selectedIndices = index >= 0 && index < _dataProvider.length ? [ index ] : null;
		}
		
		/**
		 * @private
		 */
		protected var _selectedIndices : Array = new Array();
		
		/**
		 * Get or set the List selected indices for multiple selection List.
		 */
		public function get selectedIndices() : Array
		{
			return _selectedIndices.concat();
		}
		
		public function set selectedIndices( indices : Array ) : void
		{
			if( !_multipleSelection )
			{
				indices = indices != null && indices.length > 0 ? [ indices.pop() ] : new Array();
			}
			
			indices = indices || new Array();
			
			_selectedItems = _dataProvider.getItemsAt.apply( _dataProvider , indices );
			
			// retrieve indices from selected items to make sure all indices are valid
			indices = _dataProvider.getItemsIndex.apply( _dataProvider , [ true ].concat( _selectedItems ) );
			indices.sort();
			
			if( ObjectUtils.compare( _selectedIndices , indices ) ) return;
			
			_selectedIndices = indices;
			
			if( _selectedIndices.length == 0 ) clearSelection();
			else _refreshCellsSelection();
		}
		
		/**
		 * Get or set the List selected item from data provider (this is an alternative to selectedIndex to select a cell).
		 */
		public function get selectedItem() : *
		{
			return _selectedItems[ _selectedItems.length - 1 ];
		}
		
		public function set selectedItem( item : * ) : void
		{
			selectedItems = item == null ? null : [ item ];
		}
		
		/**
		 * @private
		 */
		protected var _selectedItems : Array = new Array();
		
		/**
		 * Get or set the List selected items from data provider (this is an alternative to selectedIndices to select cells in multiple selection List).
		 */
		public function get selectedItems() : Array
		{
			return _selectedItems.concat();
		}
		
		public function set selectedItems( items : Array ) : void
		{
			if( !_multipleSelection )
			{
				items = items != null && items.length > 0 ? [ items.pop() ] : new Array();
			}
			
			_selectedItems = items || new Array();
			
			var indices : Array = _dataProvider.getItemsIndex.apply( _dataProvider , [ true ].concat( _selectedItems ) );
			indices.sort();
			
			if( ObjectUtils.compare( _selectedIndices , indices ) ) return;
			
			_selectedIndices = indices;
			
			// retrieve items from selected indices to make sure all items are valid
			_selectedItems = _dataProvider.getItemsAt.apply( _dataProvider , _selectedIndices );
			
			if( _selectedIndices.length == 0 ) clearSelection();
			else _refreshCellsSelection();
		}
		
		/**
		 * @private
		 */
		protected var _cellCount : uint;

		[Inspectable] 
		/**
		 * Get or set the number of cells display before scroll is used. This modify layout, using height property when cellCount is used have no effect.
		 * 
		 * @default 0 (use height property for layout)
		 */
		public function get cellCount() : uint
		{
			return _cellCount;
		}
		
		public function set cellCount( n : uint ) : void
		{
			if( _cellCount == n || ( _inspector && !_isLivePreview && _cellCount != 0 ) ) return;
			
			_cellCount = n;
			
			invalidate( InvalidationType.SIZE );
		}
		
		/**
		 * @private
		 */
		protected var _cellHeight : Number = 20;
		
		[Inspectable(defaultValue=20)] 
		/**
		 * get or set the default height size for List cells.
		 * 
		 * @default 20
		 */
		public function get cellHeight() : Number
		{
			return _cellHeight;
		}
		
		public function set cellHeight( n : Number ) : void
		{
			if( _cellHeight == n || ( _inspector && !_isLivePreview && _cellHeight != 20 ) ) return;
			
			_cellHeight = n;
			
			if( _scroll != null ) _scroll.scrollSnap = n;
			
			invalidate( InvalidationType.DATA );
		}
		
		/**
		 * @private
		 */
		protected var _cellSpacing : Number = 0;
		
		[Inspectable(defaultValue=0)] 
		/**
		 * get or set the default height size for List cells.
		 * 
		 * @default 20
		 */
		public function get cellSpacing() : Number
		{
			return _cellSpacing;
		}
		
		public function set cellSpacing( n : Number ) : void
		{
			if( _cellSpacing == n || ( _inspector && !_isLivePreview && _cellSpacing != 0 ) ) return;
			
			_cellSpacing = n;
			
			invalidate( InvalidationType.DATA );
		}
		
		/**
		 * @private
		 */
		protected var _cellRenderer : String = "myLib.controls.ListCell";
		
		[Inspectable(defaultValue="myLib.controls.ListCell")] 
		/**
		 * Get or set the string definition used to build cells.
		 * 
		 * @default myLib.controls.ListCell
		 */
		public function get cellRenderer() : String
		{
			return _cellRenderer;
		}
		
		public function set cellRenderer( definition : String ) : void
		{
			if( _cellRenderer == definition || ( _inspector && !_isLivePreview && _cellRenderer != "myLib.controls.ListCell" ) ) return;
			
			_cellRenderer = definition;
			
			invalidate( InvalidationType.DATA );
		}
		
		/**
		 * @private
		 */
		protected var _cellStyle : Object;

		/**
		 * Get or set the style object merge with each cell build with this List.
		 * 
		 * @see myLib.styles.StyleManager
		 */
		public function get cellStyle() : Object
		{
			return _cellStyle;
		}
		
		public function set cellStyle( style : Object ) : void
		{
			if( ObjectUtils.compare( style , _style ) ) return;
			
			_cellStyle = style;
			
			invalidate( InvalidationType.DATA );
		}
		
		/**
		 * @private
		 */
		protected var _alternateCellSkin : Array;
		
		/**
		 * Get or set an Array of skin object to alternate cell skins.
		 */
		public function get alternateCellSkin() : Array
		{
			return _alternateCellSkin.concat();
		}
		
		public function set alternateCellSkin( a : Array ) : void
		{
			if( ObjectUtils.compare( a , _alternateCellSkin ) ) return;
			
			_alternateCellSkin = a;
			
			invalidate( InvalidationType.DATA );
		}
		
		/**
		 * @private
		 */
		protected var _selectable : Boolean = true;
		
		/**
		 * Get or set a Bollean that indicates if cells can be selected.
		 * 
		 * @default true
		 */
		public function get selectable () : Boolean
		{
			return _selectable;
		}
		
		public function set selectable( b : Boolean ) : void
		{
			if( _selectable == b ) return;
			
			_selectable = b;
			
			//var l : uint = _cells.length;
			
			//for( var i : uint = 0; i < l; i++ ) 
			//{
			//	( _cells[ i ] as ICellRenderer ).selectable = b;
			//}
		}
		
		/**
		 * @private
		 */
		protected var _multipleSelection : Boolean;
		
		[Inspectable] 
		/**
		 * get or set a Boolean that indicates if multiple selection is alow.
		 * 
		 * @default false
		 */
		public function get multipleSelection() : Boolean
		{
			return _multipleSelection;
		}
		
		public function set multipleSelection( b : Boolean ) : void
		{
			if( _multipleSelection == b || ( _inspector && !_isLivePreview && _multipleSelection ) ) return;
			
			_multipleSelection = b;
			
			if( !b && _selectedIndices.length > 1 ) _selectedIndices = [ _selectedIndices.pop() ];
			
			//var l : uint = _cells.length;
			//
			//for( var i : uint = 0; i < l; i++ ) 
			//{
			//	( _cells[ i ] as ICellRenderer ).groupOwner = b ? name + "Cell" : "";
			//}
		}
		
		/**
		 * @private
		 */
		protected var _scrollRenderer : String = ScrollRenderer.SCROLLBAR;
		
		[Inspectable(defaultValue="myLib.controls.ScrollBar",enumeration="myLib.controls.ScrollBar,myLib.controls.MouseScroll,myLib.controls.PanoramaScroll,off")] 
		/**
		 * Get or set the scroll string defintion used to render scroll as defined in ScrollRenderer.
		 * 
		 * @default ScrollRenderer.SCROLLBAR
		 * @see ScrollRenderer
		 */
		public function get scrollRenderer() : String
		{
			return _scrollRenderer;
		}
		
		public function set scrollRenderer( definition : String ) : void
		{
			if( _scrollRenderer == definition || ( _inspector && !_isLivePreview && _scrollRenderer != ScrollRenderer.SCROLLBAR ) ) return;
			
			_scrollRenderer = definition;
			
			if( _scroll != null )
			{
				_scroll.scrollTarget = null;
				//_handler.removeChild( _scroll );
			}
			
			//_scroll = _listSkin.getScrollAsset( _scrollRenderer );
			
			//if( _scroll != null )
			//{
			//	_initScroll( _scroll );
			//	_handler.addChild( _scroll );
			//}
			
			invalidate( InvalidationType.SIZE );
		}
		
		/**
		 * @private
		 */
		protected var _scrollStyle : Object;
				
		/**
		 * Get or set the style object that will be merged with scroll instance.
		 * 
		 * @see myLib.styles.StyleManager
		 */
		public function get scrollStyle() : Object
		{
			return _scrollStyle;
		}
		
		public function set scrollStyle( style : Object ) : void
		{
			_scrollStyle = style;
			
			if( _scroll != null )
				_scroll.setStyle( style );
		}
		
		/**
		 * @private
		 */
		protected var _scrollBarOverlapCells : Boolean;
		
		[Inspectable] 
		/**
		 * Get or set a Boolean that indicates if ScrollBar overlap cells or cells are resized when ScrollBar is display.
		 * 
		 * @default false
		 */
		public function get scrollBarOverlapCells() : Boolean
		{
			return _scrollBarOverlapCells;
		}
		
		public function set scrollBarOverlapCells( b : Boolean ) : void
		{
			if( _scrollBarOverlapCells == b || ( _inspector && !_isLivePreview && _scrollBarOverlapCells ) ) return;
			
			_scrollBarOverlapCells = b;
			
			invalidate( InvalidationType.SIZE );
		}
		
		/**
		 * @private
		 */
		protected var _autoSize : Boolean;
		
		[Inspectable] 
		/**
		 * Get or set a Boolean that indicates if List is sized automatically to make all cells content visible.
		 * 
		 * @default false
		 */
		public function get autoSize() : Boolean
		{
			return _autoSize;
		}
		
		public function set autoSize( b : Boolean ) : void
		{
			if( _autoSize == b || ( _inspector && !_isLivePreview && _autoSize ) ) return;
			
			_autoSize = b;
			
			invalidate( InvalidationType.DATA );
		}
		
		/**
		 * @private
		 */
		protected var _contentPadding : Padding = new Padding();
		
		/**
		 * Get or set the Padding object used with cells handler.
		 */
		public function get contentPadding() : Padding
		{
			_contentPadding = _contentPadding == null ? new Padding() : _contentPadding;
			
			return _contentPadding;
		}
		
		public function set contentPadding( padding : Padding ) : void
		{
			if( padding == _contentPadding ) return;
			
			_contentPadding = padding;
			
			invalidate( InvalidationType.SIZE );
		}
		
		[Inspectable(name="contentPadding",type="Object",defaultValue="left:0,top:0,right:0,bottom:0")]
		/**
		 * @private
		 */
		public function set inspectableContentPadding( padding : Object ) : void
		{
			if( !_inspector && !_isLivePreview ) throw new Error( this + " inspectableContentPadding property is internal and used by Flash component inspector panel , use contentPadding property instead" );
			
			if( _inspector && !_isLivePreview && ( _contentPadding.left != 0 || _contentPadding.top != 0 || _contentPadding.right != 0 || _contentPadding.bottom != 0 ) ) return;
			
			contentPadding = new Padding( padding.left , padding.top , padding.right , padding.bottom );
		}
		
		/**
		 * @private
		 */
		protected var _contentMaskCornerRadius : Number = 2;
		
		[Inspectable(defaultValue=2)]
		/**
		 * Get or set cells mask corner radius.
		 * 
		 * @default 2
		 */
		public function get contentMaskCornerRadius() : Number
		{
			return _contentMaskCornerRadius;
		}
		
		public function set contentMaskCornerRadius( radius : Number ) : void
		{
			if( _contentMaskCornerRadius == radius || ( _inspector && !_isLivePreview && _contentMaskCornerRadius != 2 ) ) return;
			
			_contentMaskCornerRadius = radius;
			
			// no invalidation, this is not really expansive and certainly less expansive than a complete layout, so draw now
			//_layoutMask();
		}
		
		/**
		 * @private
		 */
		protected var _backgroundAsset : IAsset;
		
		/**
		 * Get IAsset used to render background.
		 */
		public function get backgroundAsset() : IAsset
		{
			return _backgroundAsset;
		}
		
		/**
		 * @private
		 */
		protected var _borderAsset : IAsset;
		
		/**
		 * Get IAsset used to render border.
		 */
		public function get borderAsset() : IAsset
		{
			return _borderAsset;
		}
		
		/**
		 * @private
		 */
		protected var _scroll : IScroll;
				
		/**
		 * Get AScroll used to render scroll.
		 */
		public function get scroll() : IScroll
		{
			return _scroll;
		}
		
		[Inspectable(defaultValue=true)]
		/**
		 * @inheritDoc
		 */
		public override function get enabled() : Boolean
		{
			return super.enabled;
		}
		
		public override function set enabled( b : Boolean ) : void
		{
			if( _inspector && !_isLivePreview && !_enabled ) return;
			
			super.enabled = b;
			
			_scroll.enabled = b;
			
			//var l : uint = _cells.length;
			//
			//for( var i : uint = 0; i < l; i++ ) 
			//{
			//	( _cells[ i ] as ICellRenderer ).enabled = b;
			//}
			
			//var background : IAsset = b ? _listSkin.getBackgroundAsset() : _listSkin.getBackgroundDisabledAsset();
			
			//if( _backgroundAsset != null && background != null ) removeChild( _backgroundAsset as DisplayObject );
			//
			//if( background != null )
			//{
			//	_backgroundAsset = background;
			//	background.setSize( _width, _height );	
			//	addChildAt( background as DisplayObject , 0 );
			//}
			
			//var border : IAsset = b ? _listSkin.getBorderAsset() : _listSkin.getBorderDisabledAsset();
			
			//if( _borderAsset != null && border != null ) removeChild( _borderAsset as DisplayObject );
			
			//if( border != null )
			//{
			//	var padding : Padding = contentPadding;
			//	var paddingTopBottom : Number = padding.top + padding.bottom;
			//	var paddingLeftRight : Number = padding.left + padding.right;
			//
			//	_borderAsset = border;
			//	border.x = padding.left;
			//	border.y = padding.top;
			//	border.setSize( _width - paddingLeftRight , _height - paddingTopBottom );
			//	addChild( border as DisplayObject );
			//}
		}
		
		[Inspectable(defaultValue=true)]
		/**
		 * @inheritDoc
		 */
		public override function get useHandCursor() : Boolean
		{
			return super.useHandCursor;
		}
		
		public override function set useHandCursor( b : Boolean ) : void
		{
			if( _inspector && !_isLivePreview && !super.useHandCursor ) return;
			
			super.useHandCursor = b;
			
			//var l : uint = _cells.length;
			//
			//for( var i : uint = 0; i < l; i++ ) 
			//{
			//	( _cells[ i ] as ICellRenderer ).useHandCursor = b;
			//}
		}
		
		/**
		 * 
		 */
		public function DataGrid( parentContainer : DisplayObjectContainer = null , initStyle : Object = null , skin : IDataGridSkin = null )
		{
			_dateGridSkin = skin == null ? my_skinset[ "DataGrid" ] : skin;
			
			super( parentContainer , initStyle , _dateGridSkin );
		}
		
		/**
		 * @inheritDoc
		 */
		public override function getValue(  ) : *
		{
			return null;
		}
		
		/**
		 * @inheritDoc
		 */
		public override function setValue( value : *  ) : void
		{
			
		}
		
		/**
		 * Unselect all currently selected cells.
		 */
		public function clearSelection(  ) : void
		{
			var change : Boolean = _selectedIndices.length > 0;
			
			_selectedIndices = new Array( );
			_selectedItems = new Array( );
			
			if( change ) _refreshCellsSelection();
		}
		
		/**
		 * @private
		 */
		protected function _modelChange ( e : CollectionEvent ) : void
		{	
			var l : uint = _selectedIndices.length;
			var i : int = -1;
			var type : String  = e.type;
			
			switch( true )
			{
				case type == CollectionEvent.CLEAR :
					
					_selectedIndices = new Array( );
					_selectedItems = new Array( );
					_itemToListCellData = new Dictionary( true );
				
					break;
					
				case type == CollectionEvent.ADD :
					
					//_itemToListCellData[ e.item ] = new ListCellData( this , e.fromIndex , e.item );
					
					while( ++i < l )
					{
						if( _selectedIndices[ i ] >= e.fromIndex )
							_selectedIndices[ i ]++;	
					}
	
					break;
					
				case type == CollectionEvent.REMOVE :
					
					delete _itemToListCellData[ e.item ];
					
					var indexToSplice : int = -1;
					
					while( ++i < l )
					{
						if( _selectedIndices[ i ] > e.fromIndex )
							_selectedIndices[ i ]--;
						else if( _selectedIndices[ i ] == e.fromIndex ) indexToSplice = e.fromIndex;
					}
					
					if( indexToSplice >= 0 )
					{
						_selectedIndices.splice( indexToSplice , 1 );
						_selectedItems.splice( indexToSplice , 1 );	
					}
					
					break;
				
				case type == CollectionEvent.REPLACE :
					
					//var newItem : * = _dataProvider.getItemAt( e.fromIndex );
					
					//_itemToListCellData[ newItem ] = new ListCellData( this , e.fromIndex , newItem );
					
					delete _itemToListCellData[ e.item ];
					
					var index : uint = _selectedItems.indexOf( e.item );
					
					if( index >= 0 ) _selectedItems.splice( i , 1 );
					
					break;
				
				case type == CollectionEvent.SORT :
					
					// update new index
					var length : uint = _dataProvider.length;
					var j : int = -1;
					
					while( ++j < length )
					{
						var listCellData : ListCellData = _itemToListCellData[ _dataProvider.getItemAt( j ) ] as ListCellData;
						
						listCellData.index = j;
					}
					
					// force current selection to refresh selected indices
					selectedItems = _selectedItems;
					
					break;
			}
			
			//if( _filterDataProvider != null ) filter( _filterDataProviderCallback );
			
			invalidate( InvalidationType.DATA );
		}
		
		/**
		 * @private
		 */
		protected function _refreshCellsSelection(  ) : void
		{
			//var l : uint = _cells.length;
			//
			//for( var i : uint = 0; i < l; i++ ) 
			//{
			//	var cell : ICellRenderer = _cells [ i ] as ICellRenderer;
			//	
			//	cell.selected = _selectedIndices.indexOf( cell.index  ) >= 0;
			//}
			
			dispatchEvent( new Event( Event.CHANGE ) );
		}
	}
}
