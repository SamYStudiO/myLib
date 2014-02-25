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
	import myLib.controls.skins.IListSkin;
	import myLib.controls.skins.ISkin;
	import myLib.controls.skins.my_skinset;
	import myLib.core.AFieldComponent;
	import myLib.core.IScroll;
	import myLib.core.InvalidationType;
	import myLib.data.CollectionEvent;
	import myLib.data.DataProvider;
	import myLib.data.DataProviderItem;
	import myLib.data.ICollection;
	import myLib.data.Iterator;
	import myLib.displayUtils.AlignmentPoint;
	import myLib.events.ListEvent;
	import myLib.form.IField;
	import myLib.styles.Padding;
	import myLib.styles.StyleManager;
	import myLib.utils.ObjectUtils;

	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.ui.Keyboard;
	import flash.utils.Dictionary;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	
	/**
	 * Defines the value of the type property of a change selectionChange object.
	 * 
	 * @eventType selectionChange
	 */
    [Event(name="selectionChange", type="myLib.events.ListEvent")]
    
	/**
	 * Defines the value of the type property of a cellAdded event object.
	 * 
	 * @eventType cellAdded
	 */
    [Event(name="cellAdded", type="myLib.events.ListEvent")]
    
    /**
	 * Defines the value of the type property of a cellOver event object.
	 * 
	 * @eventType cellOver
	 */
    [Event(name="cellOver", type="myLib.events.ListEvent")]
    
    /**
	 * Defines the value of the type property of a cellOut event object.
	 * 
	 * @eventType cellOut
	 */
    [Event(name="cellOut", type="myLib.events.ListEvent")]
    
    /**
	 * Defines the value of the type property of a cellClick event object.
	 * 
	 * @eventType cellClick
	 */
    [Event(name="cellClick", type="myLib.events.ListEvent")]
    
	/**
	 * List Display a list of cell build from a data provider.
	 * 
	 * @author SamYStudiO ( contact@samystudio.net )
	 */
	public class List extends AFieldComponent implements IList, IField
	{
		/**
		 * @private
		 * never used but useful when creating componentShim to have DataProviderItem compiled.
		 */
		DataProviderItem;

		/**
		 * @private
		 */
		protected var _listSkin : IListSkin;
		
		/**
		 * @private
		 */
		protected var _cells : Array = new Array();
		
		/**
		 * @private
		 */
		protected var _variableCellHeight : Boolean;
		
		/**
		 * @private
		 */
		protected var _handler : Sprite = new Sprite();
		
		/**
		 * @private
		 */
		protected var _cellsHandler : Sprite = new Sprite();
		
		/**
		 * @private
		 */
		protected var _contentMask : Shape = new Shape();
		
		/**
		 * @private
		 */
		protected var _displayIndex : int;
		
		/**
         * @private
         */
        protected var _displayScrollIndex : int;
		
		/**
		 * @private
		 */
		protected var _displayIndexPosition : int;
		
		/**
		 * @private
		 */
		protected var _displayIndexAlignment : String;
		
		/**
		 * @private
		 */
		protected var _displayIndexTween : Boolean;
		
		/**
		 * @private
		 */
		protected var _totalHeight : Number;

		/**
		 * @private
		 */
		protected var _cellIndexToPosition : Array = new Array( );
		
		/**
		 * @private
		 */
		protected var _itemToListCellData : Dictionary;

		/**
		 * @private
		 */
		protected var _filterDataProvider : Array;
		
		/**
		 * @private
		 */
		protected var _filterDataProviderCallback : Function;
		
		/**
		 * @private
		 */
		protected var _oldCells : Array = new Array();
		
		/**
		 * @private
		 */
		protected override function get _defaultHeight() : Number
		{
			return 100;	
		}
		
		/**
		 * @private
		 */
		protected var _keySelectionLoop : Boolean = true;
		
		[Inspectable(defaultValue=true)] 
		/**
		 * @inheritDoc
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
		 * @private
		 */
		protected var _borderThickness : Number = 1;
		
		[Inspectable(defaultValue=1)] 
		/**
		 * @inheritDoc
		 */
		public function get borderThickness() : Number
		{
			return _borderThickness;
		}
		
		public function set borderThickness( n : Number ) : void
		{
			if( _inspector && !_isLivePreview && _borderThickness != 1 ) return;
			
			_borderThickness = n;
			
			invalidate( );
		}
		
		/**
		 * @private
		 */
		protected var _dataProvider : ICollection;

		[Collection(collectionClass="myLib.data.DataProvider",collectionItem="myLib.data.DataProviderItem")]
		/**
		 * @inheritDoc
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
				_dataProvider.removeEventListener( CollectionEvent.ADD , _modelChange );					_dataProvider.removeEventListener( CollectionEvent.REMOVE , _modelChange );					_dataProvider.removeEventListener( CollectionEvent.REPLACE , _modelChange );					_dataProvider.removeEventListener( CollectionEvent.CLEAR , _modelChange );					_dataProvider.removeEventListener( CollectionEvent.SORT , _modelChange );	
			}
			
			clearSelection();
			
			_dataProvider = dataProvider || new DataProvider( null );
			
			_itemToListCellData = new Dictionary( true );
			
			var iterator : Iterator = _dataProvider.getIterator();
			
			while( iterator.hasNext() ) 
			{
				var o : * = iterator.next();
				
				_itemToListCellData[ o ] = new ListCellData( this , iterator.position - 1 , o );
			}
			
			_dataProvider.addEventListener( CollectionEvent.ADD , _modelChange , false , 0 , true );	
			_dataProvider.addEventListener( CollectionEvent.REMOVE , _modelChange , false , 0 , true );	
			_dataProvider.addEventListener( CollectionEvent.REPLACE , _modelChange , false , 0 , true );	
			_dataProvider.addEventListener( CollectionEvent.CLEAR , _modelChange , false , 0 , true );	
			_dataProvider.addEventListener( CollectionEvent.SORT , _modelChange , false , 0 , true );	
			
			_filterDataProvider = null;
			
			if( _scroll != null )
			{
				_scroll.removeEventListener( Event.SCROLL , _updateScrollPosition );
				_scroll.setScrollPosition( 0 );
				_scroll.addEventListener( Event.SCROLL , _updateScrollPosition , false , 0 , true );
				
				_displayIndex = 0;
				_displayIndexPosition = 0;
			}
			
			invalidate( InvalidationType.DATA );
		}
		
		/**
		 * @private
		 */
		protected var _labelField : String = "label";
		
		[Inspectable(defaultValue="label")] 
		/**
		 * @inheritDoc
		 */
		public function get labelField() : String
		{
			return _labelField;
		}
		
		public function set labelField( s : String ) : void
		{
			if( _inspector && !_isLivePreview && _labelField != "label" ) return;
			
			_labelField = s;
			
			invalidate( InvalidationType.DATA );
		}
		
		/**
		 * @private
		 */
		protected var _dataField : String = "data";
		
		[Inspectable(defaultValue="data")] 
		/**
		 * @inheritDoc
		 */
		public function get dataField() : String
		{
			return _dataField;
		}
		
		public function set dataField( s : String ) : void
		{
			if( _inspector && !_isLivePreview && _dataField != "data" ) return;
			
			_dataField = s;
		}
		
		/**
		 * @private
		 */
		protected var _iconField : String = "icon";

		[Inspectable(defaultValue="icon")] 
		/**
		 * @inheritDoc
		 */
		public function get iconField() : String
		{
			return _iconField;
		}
		
		public function set iconField( s : String ) : void
		{
			if( _inspector && !_isLivePreview && _iconField != "icon" ) return;
			
			_iconField = s;
			
			invalidate( InvalidationType.DATA );
		}
		
		/**
		 * @inheritDoc
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
		 * @inheritDoc
		 */
		public function get selectedIndices() : Array
		{
			return _selectedIndices.concat();
		}
		
		public function set selectedIndices( indices : Array ) : void
		{
			var oldSetected : Array = _selectedIndices;
			
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
			
			if( !ObjectUtils.arrayCompare( oldSetected , _selectedIndices ) ) dispatchEvent( new ListEvent( ListEvent.SELECTION_CHANGE ) );
		}
		
		/**
		 * @inheritDoc
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
		 * @inheritDoc
		 */
		public function get selectedItems() : Array
		{
			return _selectedItems.concat();
		}
		
		public function set selectedItems( items : Array ) : void
		{
			var oldSetected : Array = _selectedIndices;
			
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
			
			if( !ObjectUtils.arrayCompare( oldSetected , _selectedIndices ) ) dispatchEvent( new ListEvent( ListEvent.SELECTION_CHANGE ) );
		}
		
		/**
		 * @inheritDoc
		 */
		public function get selectedData() : *
		{
			var o : * = _selectedItems[ _selectedItems.length - 1 ];
			
			return o == null ? null : o[ _dataField ];
		}
		
		public function set selectedData( data : * ) : void
		{
			var o : * = _dataProvider.getItemFrom( _dataField , data );
			
			selectedItems = o != null ? [ o ] : null;
		}
		
		/**
		 * @inheritDoc
		 */
		public function get selectedDatas() : Array
		{
			var a : Array = new Array();
			var l : uint = _selectedItems.length;
			
			for( var i : uint = 0; i < l; i++ ) 
			{
				a.push( _selectedItems[ i ][ _dataField ] );
			}
			
			return a;
		}
		
		public function set selectedDatas( datas : Array ) : void
		{
			var oldSetected : Array = _selectedIndices;
			
			if( !_multipleSelection )
			{
				datas = datas != null && datas.length > 0 ? [ datas.pop() ] : new Array();
			}
			
			datas = datas || new Array();
			
			_selectedItems = _dataProvider.getItemsFrom.apply( _dataProvider , [ _dataField ].concat( datas ) );
			
			var indices : Array = _dataProvider.getItemsIndex.apply( _dataProvider , [ true ].concat( _selectedItems ) );
			indices.sort();
			
			_selectedIndices = indices;
			
			// retrieve items from selected indices to make sure all items are valid
			_selectedItems = _dataProvider.getItemsAt.apply( _dataProvider , _selectedIndices );
			
			if( _selectedItems.length == 0 ) clearSelection();
			else _refreshCellsSelection();
			
			if( !ObjectUtils.arrayCompare( oldSetected , _selectedIndices ) ) dispatchEvent( new ListEvent( ListEvent.SELECTION_CHANGE ) );
		}
		
		/**
		 * @private
		 */
		protected var _cellCount : uint;

		[Inspectable] 
		/**
		 * @inheritDoc
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
		 * @inheritDoc
		 */
		public function get cellHeight() : Number
		{
			return _cellHeight;
		}
		
		public function set cellHeight( n : Number ) : void
		{
			if( _cellHeight == n || ( _inspector && !_isLivePreview && _cellHeight != 20 ) ) return;
			
			_cellHeight = n;
			
			if( _scroll != null ) _scroll.scrollSnap = n + _cellSpacing;
			
			invalidate( InvalidationType.DATA );
		}
		
		/**
		 * @private
		 */
		protected var _cellSpacing : Number = 0;
		
		[Inspectable(defaultValue=0)] 
		/**
		 * @inheritDoc
		 */
		public function get cellSpacing() : Number
		{
			return _cellSpacing;
		}
		
		public function set cellSpacing( n : Number ) : void
		{
			if( _cellSpacing == n || ( _inspector && !_isLivePreview && _cellSpacing != 0 ) ) return;
			
			_cellSpacing = n;
			
			if( _scroll != null ) _scroll.scrollSnap = _cellHeight + n;
			
			invalidate( InvalidationType.DATA );
		}
		
		/**
		 * @private
		 */
		protected var _cellRenderer : * = "myLib.controls.ListCell";
		
		[Inspectable(defaultValue="myLib.controls.ListCell")] 
		/**
		 * @inheritDoc
		 */
		public function get cellRenderer() : *
		{
			return _cellRenderer;
		}
		
		public function set cellRenderer( definition : * ) : void
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
		 * @inheritDoc
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
		 * @inheritDoc
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
		 * @inheritDoc
		 */
		public function get selectable () : Boolean
		{
			return _selectable;
		}
		
		public function set selectable( b : Boolean ) : void
		{
			if( _selectable == b ) return;
			
			_selectable = b;
			
			var l : uint = _cells.length;
			
			for( var i : uint = 0; i < l; i++ ) 
			{
				( _cells[ i ] as ICellRenderer ).selectable = b;
			}
		}
		
		/**
		 * @private
		 */
		protected var _multipleSelection : Boolean;
		
		[Inspectable] 
		/**
		 * @inheritDoc
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
		}
        
        /**
         * @private
         */
        protected var _useKeyboard : Boolean = true;
		
		/**
		 * @inheritDoc
		 */
		public function get useKeyboard() : Boolean
		{
			return _useKeyboard;
		}
		
		public function set useKeyboard( b : Boolean ) : void
		{
			_useKeyboard = b;
			
			if( _useKeyboard ) addEventListener( KeyboardEvent.KEY_DOWN , keyDown , false , 0 , true );
			else removeEventListener( KeyboardEvent.KEY_DOWN , keyDown );
		}
		
		/**
		 * @private
		 */
		protected var _scrollRenderer : * = ScrollBar;
		
		[Inspectable(defaultValue="myLib.controls.ScrollBar",enumeration="myLib.controls.ScrollBar,myLib.controls.MouseScroll,myLib.controls.PanoramaScroll,off")] 
		/**
		 * @inheritDoc
		 */
		public function get scrollRenderer() : *
		{
			return _scrollRenderer;
		}
		
		public function set scrollRenderer( definition : * ) : void
		{
			if( _isLivePreview ) return;
			
			if( _scrollRenderer == definition || ( _inspector && !_isLivePreview && _scrollRenderer != ScrollBar ) ) return;
			
			_scrollRenderer = definition;
			
			if( _scroll != null )
			{
				_scroll.scrollTarget = null;
				_handler.removeChild( _scroll as DisplayObject );
			}
			
			_scroll = _listSkin.getScrollAsset( _scrollRenderer );
			
			if( _scroll != null )
			{
				_initScroll( _scroll );
				_handler.addChild( _scroll as DisplayObject );
			}
			
			invalidate( InvalidationType.SIZE );
		}
		
		/**
		 * @private
		 */
		protected var _scrollStyle : Object;
				
		/**
		 * @inheritDoc
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
		protected var _scrollBarPosition : String = ListScrollBarPosition.RIGHT;

		[Inspectable(defaultValue="right",enumeration="left,right")]
		/**
		 * @inheritDoc
		 */
		public function get scrollBarPosition() : String
		{
			return _scrollBarPosition;
		}
		
		public function set scrollBarPosition( position : String ) : void
		{
			if( _scrollBarPosition == position || ( _inspector && !_isLivePreview && _scrollBarPosition != ListScrollBarPosition.RIGHT ) ) return;
			
			_scrollBarPosition = position;
			
			invalidate( InvalidationType.SIZE );
		}
		
		/**
		 * @private
		 */
		protected var _scrollBarOverlapCells : Boolean;
		
		[Inspectable] 
		/**
		 * @inheritDoc
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
        protected var _scrollLayoutUseBorderThickness : Boolean = true;
		
		[Inspectable(defaultValue=true)]
        /**
         * @inheritDoc
         */
        public function get scrollLayoutUseBorderThickness() : Boolean
        {
            return _scrollLayoutUseBorderThickness;
        }
        
        public function set scrollLayoutUseBorderThickness( b : Boolean ) : void
        {
            if( _scrollLayoutUseBorderThickness == b || ( _inspector && !_isLivePreview && !_scrollLayoutUseBorderThickness ) ) return;
            
            _scrollLayoutUseBorderThickness = b;
            
            invalidate( InvalidationType.SIZE );
        }
		
		/**
		 * @private
		 */
		protected var _autoSize : Boolean;
		
		[Inspectable] 
		/**
		 * @inheritDoc
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
		 * @inheritDoc
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
		
		[Inspectable(defaultValue=0)]
		/**
		 * @inheritDoc
		 */
		public function get contentMaskCornerRadius() : Number
		{
			return _contentMaskCornerRadiusTopLeft;
		}
		
		public function set contentMaskCornerRadius( radius : Number ) : void
		{
			if( _contentMaskCornerRadiusTopLeft == radius || ( _inspector && !_isLivePreview && _contentMaskCornerRadiusTopLeft != 0 ) ) return;
			
			_contentMaskCornerRadiusTopLeft = radius;
			_contentMaskCornerRadiusTopRight = radius;
			_contentMaskCornerRadiusBottomRight = radius;
			_contentMaskCornerRadiusBottomLeft = radius;
			
			// no invalidation, this is not really expansive and definitely less expansive than a complete layout, so draw now
			_layoutMask();
		}
		
		/**
		 * @private
		 */
		protected var _contentMaskCornerRadiusTopLeft : Number = 0;
		
		[Inspectable(defaultValue=0)]
		/**
		 * @inheritDoc
		 */
		public function get contentMaskCornerRadiusTopLeft() : Number
		{
			return _contentMaskCornerRadiusTopLeft;
		}
		
		public function set contentMaskCornerRadiusTopLeft( radius : Number ) : void
		{
			if( _contentMaskCornerRadiusTopLeft == radius || ( _inspector && !_isLivePreview && _contentMaskCornerRadiusTopLeft != 0 ) ) return;
			
			_contentMaskCornerRadiusTopLeft = radius;
			
			// no invalidation, this is not really expansive and certainly less expansive than a complete layout, so draw now
			_layoutMask();
		}
		
		/**
		 * @private
		 */
		protected var _contentMaskCornerRadiusTopRight : Number = 0;
		
		[Inspectable(defaultValue=0)]
		/**
		 * @inheritDoc
		 */
		public function get contentMaskCornerRadiusTopRight() : Number
		{
			return _contentMaskCornerRadiusTopRight;
		}
		
		public function set contentMaskCornerRadiusTopRight( radius : Number ) : void
		{
			if( _contentMaskCornerRadiusTopRight == radius || ( _inspector && !_isLivePreview && _contentMaskCornerRadiusTopRight != 0 ) ) return;
			
			_contentMaskCornerRadiusTopRight = radius;
			
			// no invalidation, this is not really expansive and certainly less expansive than a complete layout, so draw now
			_layoutMask();
		}
		
		/**
		 * @private
		 */
		protected var _contentMaskCornerRadiusBottomRight : Number = 0;
		
		[Inspectable(defaultValue=0)]
		/**
		 * @inheritDoc
		 */
		public function get contentMaskCornerRadiusBottomRight() : Number
		{
			return _contentMaskCornerRadiusBottomRight;
		}
		
		public function set contentMaskCornerRadiusBottomRight( radius : Number ) : void
		{
			if( _contentMaskCornerRadiusBottomRight == radius || ( _inspector && !_isLivePreview && _contentMaskCornerRadiusBottomRight != 0 ) ) return;
			
			_contentMaskCornerRadiusBottomRight = radius;
			
			// no invalidation, this is not really expansive and certainly less expansive than a complete layout, so draw now
			_layoutMask();
		}
		
		/**
		 * @private
		 */
		protected var _contentMaskCornerRadiusBottomLeft : Number = 0;
		
		[Inspectable(defaultValue=0)]
		/**
		 * @inheritDoc
		 */
		public function get contentMaskCornerRadiusBottomLeft() : Number
		{
			return _contentMaskCornerRadiusBottomLeft;
		}
		
		public function set contentMaskCornerRadiusBottomLeft( radius : Number ) : void
		{
			if( _contentMaskCornerRadiusBottomLeft == radius || ( _inspector && !_isLivePreview && _contentMaskCornerRadiusBottomLeft != 0 ) ) return;
			
			_contentMaskCornerRadiusBottomLeft = radius;
			
			// no invalidation, this is not really expansive and certainly less expansive than a complete layout, so draw now
			_layoutMask();
		}
		
		/**
		 * @private
		 */
		protected var _backgroundAsset : IAsset;
		
		/**
		 * @inheritDoc
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
		 * @inheritDoc
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
		 * @inheritDoc
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
			
			var l : uint = _cells.length;
			
			for( var i : uint = 0; i < l; i++ ) 
			{
				( _cells[ i ] as ICellRenderer ).enabled = b;
			}
			
			var background : IAsset = b ? _listSkin.getBackgroundAsset() : _listSkin.getBackgroundDisabledAsset();
			
			if( _backgroundAsset != null && background != null ) removeChild( _backgroundAsset as DisplayObject );
			
			if( background != null )
			{
				_backgroundAsset = background;
				background.setSize( _width, _height );	
				addChildAt( background as DisplayObject , 0 );
			}
			
			var border : IAsset = b ? _listSkin.getBorderAsset() : _listSkin.getBorderDisabledAsset();
			
			if( _borderAsset != null && border != null ) removeChild( _borderAsset as DisplayObject );
			
			if( border != null )
			{
				var padding : Padding = contentPadding;
				var paddingTopBottom : Number = padding.top + padding.bottom;
				var paddingLeftRight : Number = padding.left + padding.right;
			
				_borderAsset = border;
				border.x = padding.left;
				border.y = padding.top;
				border.setSize( _width - paddingLeftRight , _height - paddingTopBottom );
				addChild( border as DisplayObject );
			}
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
			
			var l : uint = _cells.length;
			
			for( var i : uint = 0; i < l; i++ ) 
			{
				( _cells[ i ] as ICellRenderer ).useHandCursor = b;
			}
		}
		
		/**
		 * Build a new List instance. Default size is 15*100.
		 * @param parentContainer The parent DisplayObjectContainer where add this List.
		 * @param initStyle The initial style object for List initialization.
		 * @param skin The IListSkin to use instead of default skin.
		 * 
		 * @see myLib.styles.StyleManager
		 */
		public function List ( parentContainer : DisplayObjectContainer = null , initStyle : Object = null , skin : IListSkin = null )
		{
			_listSkin = skin == null ? my_skinset.getListSkin() : skin;
			
			super( parentContainer , initStyle , _listSkin );
		}
		
		/**
		 * @inheritDoc
		 */
		public function getCellAt( index : uint ) : ICellRenderer
		{
			return _getListCellDataAt( index ).cell;
		}
		
		/**
		 * @inheritDoc
		 */
		public function getVisibleCells(  ) : Array
		{
			return _cells.concat();
		}
		
		/**
		 * @inheritDoc
		 */
		public function setCellRendererAt( index : uint , definition : String ) : void
		{
			var listCellData : ListCellData = _getListCellDataAt( index );
			
			if( listCellData.cellRenderer == definition ) return;
			
			listCellData.cellRenderer = definition;
			
			invalidate( InvalidationType.DATA );
		}
		
		/**
		 * @inheritDoc
		 */
		public function getCellStyleAt( index : uint ) : Object
		{
			if( index < 0 || index > _dataProvider.length - 1 || _dataProvider.isEmpty() ) return null;
			
			return _getListCellDataAt( index ).style;
		}
		
		/**
		 * @inheritDoc
		 */
		public function setCellStyleAt( index : uint , style : Object ) : void
		{
			var listCellData : ListCellData = _getListCellDataAt( index );
			
			if( ObjectUtils.compare( listCellData.style , style ) ) return;
			
			listCellData.style = ObjectUtils.merge( _cellStyle , style , false );
			
			invalidate( );
		}
	
		/**
		 * @inheritDoc
		 */
		public function isItemSelected ( item : * ) : Boolean
		{
			return _selectedItems.indexOf( item ) >= 0;
		}

		/**
		 * @inheritDoc
		 */
		public function isItemVisible ( item : * ) : Boolean
		{
			return ( _itemToListCellData[ item ] as ListCellData ).cell != null;
		}
	
		/**
		 * @inheritDoc
		 */
		public function isIndexSelected ( index : uint ) : Boolean
		{
			return _selectedIndices.indexOf( index ) >= 0;
		}

		/**
		 * @inheritDoc
		 */
		public function isIndexVisible ( index : uint ) : Boolean
		{
			return _getListCellDataAt( index ).cell != null;
		}
		
		/**
		 * @inheritDoc
		 */
		public function scrollToIndex( index : uint , alignmentPoint : String = null ) : void
		{
			if( _scroll == null || _dataProvider.length == 0 ) return;
			
			if( !isInvalidate() )
			{
				var scrollPos : Number;
				
				if( _variableCellHeight ) scrollPos = _cellIndexToPosition[ index ];
				else scrollPos = index * ( _cellHeight + _cellSpacing );
				
				var indexSize : Number = _getListCellDataAt( index ).height;
				var padding : Padding = contentPadding;
				var pageSize : Number = _height - padding.top - padding.bottom - _borderThickness * 2;
				
				switch( true )
				{
					case alignmentPoint == AlignmentPoint.TOP :	
					case alignmentPoint == AlignmentPoint.TOP_LEFT :	
					case alignmentPoint == AlignmentPoint.TOP_RIGHT :	
					case alignmentPoint == AlignmentPoint.LEFT : _scroll.setScrollPosition( Math.min( Math.max( 0 , scrollPos ) , _scroll.maxScroll ) ); break;	
					
					case alignmentPoint == AlignmentPoint.BOTTOM :	
					case alignmentPoint == AlignmentPoint.BOTTOM_LEFT:	
					case alignmentPoint == AlignmentPoint.BOTTOM_RIGHT :	
					case alignmentPoint == AlignmentPoint.RIGHT : _scroll.setScrollPosition( Math.min( Math.max( 0 , scrollPos - ( pageSize - indexSize ) ) , _scroll.maxScroll ) ); break;	
					
					default : _scroll.setScrollPosition( Math.min( Math.max( 0 , scrollPos - ( pageSize - indexSize ) / 2 ) , _scroll.maxScroll ) ); break;	
				}
			}
			else
			{
				_displayScrollIndex = index;
				_displayIndexAlignment = alignmentPoint || AlignmentPoint.CENTER;	
			}
		}
		
		/**
		 * @inheritDoc
		 */
		public function tweenToIndex( index : uint , alignmentPoint : String = null , ease : Function = null , duration : Number = 500 , durationAsMilliseconds : Boolean = true ) : void
		{
			if( _scroll == null || _dataProvider.length == 0 ) return;
			
			if( !isInvalidate() )
			{
				var scrollPos : Number;
				
				if( _variableCellHeight ) scrollPos = _cellIndexToPosition[ index ];
				else scrollPos = index * ( _cellHeight + _cellSpacing );
				
				var indexSize : Number = _getListCellDataAt( index ).height;
				var padding : Padding = contentPadding;
				var pageSize : Number = _height - padding.top - padding.bottom - _borderThickness * 2;
				
				switch( true )
				{
					case alignmentPoint == AlignmentPoint.TOP :	
					case alignmentPoint == AlignmentPoint.TOP_LEFT :	
					case alignmentPoint == AlignmentPoint.TOP_RIGHT :	
					case alignmentPoint == AlignmentPoint.LEFT : _scroll.tweenToPosition( Math.min( Math.max( 0 , scrollPos ) , _scroll.maxScroll ) , ease, duration , durationAsMilliseconds ); break;	
					
					case alignmentPoint == AlignmentPoint.BOTTOM :	
					case alignmentPoint == AlignmentPoint.BOTTOM_LEFT:	
					case alignmentPoint == AlignmentPoint.BOTTOM_RIGHT :	
					case alignmentPoint == AlignmentPoint.RIGHT : _scroll.tweenToPosition( Math.min( Math.max( 0 , scrollPos - ( pageSize - indexSize ) ) , _scroll.maxScroll ) , ease, duration , durationAsMilliseconds ); break;	
					
					default : _scroll.tweenToPosition( Math.min( Math.max( 0 , scrollPos - ( pageSize - indexSize ) / 2 ) , _scroll.maxScroll ) , ease, duration , durationAsMilliseconds ); break;	
				}
			}
			else
			{
				_displayScrollIndex = index;
				_displayIndexAlignment = alignmentPoint || AlignmentPoint.CENTER;
				_displayIndexTween = true;
			}
		}
		
		/**
		 * @inheritDoc
		 */
		public function clearSelection(  ) : void
		{
			var wasSelected : Boolean = _selectedIndices.length > 0;
			
			_selectedIndices = new Array( );
			_selectedItems = new Array( );
			
			_refreshCellsSelection();
			
			if( wasSelected ) dispatchEvent( new ListEvent( ListEvent.SELECTION_CHANGE ) );
		}
		
		/**
		 * @inheritDoc
		 */
		public function filter( callback : Function ) : Array
		{
			if( callback == null ) throw new Error( this + " filter callback cannot be null" );
			
			var a : Array = _dataProvider.data.filter( callback );
			
			/*if( a.length == _dataProvider.length )
			{
				_filterDataProvider = null;
				
				return _filterDataProvider;	
			}*/
			
			if( ObjectUtils.compare( a , _filterDataProvider ) ) return _filterDataProvider;
			
			var iterator : Iterator = _dataProvider.getIterator();
			var cpt : uint = 0;
			
			while( iterator.hasNext() ) 
			{
				var o : * = iterator.next();
				
				( _itemToListCellData[ o ] as ListCellData ).filterIndex = a.indexOf( o ) >= 0 ? cpt++ : -1;
			}
			
			_filterDataProvider = a;
			_filterDataProviderCallback = callback;
			
			_scroll.setScrollPosition( 0 );
			
			invalidate( InvalidationType.DATA );
			
			return _filterDataProvider;
		}
		
		/**
		 * @inheritDoc
		 */
		public function clearFilter(  ) : void
		{
			if( _filterDataProvider == null ) return;
			
			var iterator : Iterator = _dataProvider.getIterator();
			
			while( iterator.hasNext() ) 
			{
				_getListCellDataAt( iterator.position ).filterIndex = -1;
				
				iterator.next();
			}
			
			_filterDataProvider = null;
			
			invalidate( InvalidationType.DATA );
		}
		
		/**
		 * @inheritDoc
		 */
		public function next(  ) : void
		{
			if( _dataProvider.isEmpty() ) return;
			
			var index : int = selectedIndex;
			
			var dp : ICollection = _filterDataProvider != null ? new DataProvider( _filterDataProvider ) : _dataProvider;
			var dpIndex : int = _filterDataProvider != null ? dp.getItemIndex( _dataProvider.getItemAt( index ) ) : index;
			
			if( dpIndex == -1 ) dpIndex = dp.length;
			if( --dpIndex < 0 && !_keySelectionLoop ) dpIndex = 0;
			else if( dpIndex < 0 ) dpIndex = dp.length - 1;
			
			index = _filterDataProvider != null ? _dataProvider.getItemIndex( dp.getItemAt( dpIndex ) ) : dpIndex;
			
			if( index == -1 ) return;
			
			_setSelectedCell( _getListCellDataAt( index ) );
			
			var cell : ICellRenderer = getCellAt( index );
			
			if( cell != null ) cell.selected = true;
		}
		
		/**
		 * @inheritDoc
		 */
		public function previous(  ) : void
		{
			if( _dataProvider.isEmpty() ) return;
			
			var index : int = selectedIndex;
			
			var dp : ICollection = _filterDataProvider != null ? new DataProvider( _filterDataProvider ) : _dataProvider;
			var dpIndex : int = _filterDataProvider != null ? dp.getItemIndex( _dataProvider.getItemAt( index ) ) : index;
				
			if( ++dpIndex >= dp.length && !_keySelectionLoop ) dpIndex = dpIndex;
			else if( dpIndex >= dp.length ) dpIndex = 0;
			
			index = _filterDataProvider != null ? _dataProvider.getItemIndex( dp.getItemAt( dpIndex ) ) : dpIndex;
			
			if( index == -1 ) return;
			
			_setSelectedCell( _getListCellDataAt( index ) );
			
			var cell : ICellRenderer = getCellAt( index );
			
			if( cell != null ) cell.selected = true;
		}

		/**
		 * @inheritDoc
		 */
		public override function getValue () : *
		{
			var a : Array = selectedDatas;
			
			return a.length > 1 ? a : a[ 0 ];
		}
		
		/**
		 * @inheritDoc
		 */
		public override function setValue ( value : * ) : void
		{
			switch( true )
			{
				case value is Array : selectedDatas = value as Array; break;
				case value is Number : selectedIndex = value as Number; break;
			}
		}

		/**
		 * @private
		 */
		protected override function _createChildren () : void
		{
			_backgroundAsset = _listSkin.getBackgroundAsset( );			_borderAsset = _listSkin.getBorderAsset();
			_scroll = _listSkin.getScrollAsset( _scrollRenderer );
			
			if( _backgroundAsset != null )
			{
				_backgroundAsset.owner = this;
				addChild( _backgroundAsset as DisplayObject );
			}
			addChild( _handler );			_handler.addChild( _cellsHandler );
			addChild( _contentMask );
						if( _scroll != null ) 
			{
				_initScroll( _scroll );
				_handler.addChild( _scroll as DisplayObject );
			}
						if( _borderAsset != null )
			{
				_borderAsset.owner = this;
				_borderAsset.mouseEnabled = false;
				_borderAsset.mouseChildren = false;
				addChild( _borderAsset as DisplayObject );
			}
		}

		/**
		 * @private
		 */
		protected override function _init () : void
		{
			_handler.mask = _contentMask;
			
			_dataProvider = _dataProvider == null ? new DataProvider( null ) : _dataProvider;
			
			if( _useKeyboard ) addEventListener( KeyboardEvent.KEY_DOWN , keyDown , false , 0 , true );
		}
		
		/**
		 * @private
		 */
		protected function _initScroll ( scroll : IScroll ) : void
		{
			scroll.owner = this;
			scroll.setStyle( _scrollStyle );
			scroll.scrollTarget = _cellsHandler;
			scroll.scrollSnap = _cellHeight + _cellSpacing;	
			scroll.enabled = _enabled;
			scroll.useHandCursor = useHandCursor;
			scroll.focusEnabled = false;
			scroll.addEventListener( Event.SCROLL , _updateScrollPosition , false , 0 , true );
		}

		/**
		 * @private
		 */
		protected override function _draw () : void
		{
			_variableCellHeight = _getVariableCellHeight( );
			
			_getSize();
			 
			if( _scroll != null )
			{
				var padding : Padding = contentPadding;
					
				_scroll.update( true , _width - padding.left - padding.right  - _borderThickness * 2 , _totalHeight );
				_scroll.draw( );
			}
			 
			if( isInvalidate( InvalidationType.DATA ) ) _drawCells();
			
			if( isInvalidate( InvalidationType.SIZE ) ) _layout();
			
			_invalidation.removeAllTypes();
			
			// needed when scrollToIndex is called before first draw is done
			if( _displayIndexAlignment != null )
			{
				if( _displayIndexTween ) tweenToIndex( _displayScrollIndex , _displayIndexAlignment );
				else scrollToIndex( _displayScrollIndex , _displayIndexAlignment );
				
				_displayIndexAlignment = null;
				_displayIndexTween = false;
			}
		}
		
		/**
		 * @private
		 */
		protected function _getVariableCellHeight(  ) : Boolean
		{
			var iterator : Iterator = _dataProvider.getIterator();
			var h : Number = _cellHeight;
			
			while( iterator.hasNext() ) 
			{
				var listCellData : ListCellData = _getListCellDataAt( iterator.position );
				var height : Number = listCellData.height;
				
				if( h != height || ( listCellData.style != null && listCellData.style.autoSize ) ) return true;
				
				iterator.next();
			}
			
			return false;
		}
		
		/**
		 * @private
		 */
		protected function _getSize(  ) : void
		{
			var w : Number = _width;
			var oldWidth : Number = w;			var oldHeight : Number = _height;
			var cell : ICellRenderer;
			var cellWidth : Number;
			var cellHeight : Number;
			var count : int = -1;			var padding : Padding = contentPadding;
			
			_totalHeight = 0;
			
			if( _variableCellHeight || _filterDataProvider != null || _autoSize )
			{
				_cellIndexToPosition = new Array( );
				
				count = 0;
				
				var iterator : Iterator = _dataProvider.getIterator();
				var index : uint;
				var listCellData : ListCellData;
				var cellRenderer : Class;
				var newCellRenderer : Class;
				var redraw : Boolean;
				
				while( iterator.hasNext() ) 
				{
					index = iterator.position;
					listCellData = _getListCellDataAt( index );
					
					if( _filterDataProvider == null || ( _filterDataProvider != null && listCellData.filterIndex != -1 ) ) count++;
					
					if( _filterDataProvider != null && listCellData.filterIndex != -1 )
						_cellIndexToPosition[ listCellData.filterIndex ] = _totalHeight;
					else 
						_cellIndexToPosition[ index ] = _totalHeight;
					
					if( _autoSize || ( listCellData.style != null && listCellData.style.autoSize ) )
					{
						if( listCellData.style != null && listCellData.style.autoSize )
							listCellData.style.multiline = true;
						
						
						cellRenderer = cell == null ? null : getDefinitionByName( getQualifiedClassName( cell ) ) as Class;
						newCellRenderer = listCellData.cellRenderer is Class ? listCellData.cellRenderer : getDefinitionByName( listCellData.cellRenderer ) as Class;
						redraw = cell == null || ( _alternateCellSkin != null && _alternateCellSkin.length > 1 ) || cellRenderer != newCellRenderer;
							
						if( redraw ) cell = _buildCell( listCellData );

						StyleManager.setInstanceStyle( cell , listCellData.style );
						
						cell.data = listCellData.data;
						
						cell.autoSize = true;
						
						if( !_autoSize ) cell.width = w;
						
						cellWidth = isNaN( cellWidth ) ? cell.width : cell.width > cellWidth ? cell.width : cellWidth;
						cellHeight = listCellData.style != null && listCellData.style.autoSize ? cell.height : listCellData.height;
						
						_totalHeight += listCellData.filterIndex == -1 && _filterDataProvider != null ? 0 : cellHeight + _cellSpacing;
					}
					else _totalHeight += listCellData.filterIndex == -1 && _filterDataProvider != null ? 0 : listCellData.height + _cellSpacing;
					
					iterator.next();
				}
			}
			
			count = count == -1 ? _dataProvider.length : count;
			
			if( _totalHeight == 0 ) _totalHeight = count * ( _cellHeight  + _cellSpacing ) - _cellSpacing;
			else _totalHeight -= _cellSpacing;			
			if( _autoSize )
			{
				cell = null;
				
				var h : Number = _height - padding.top - padding.bottom - _borderThickness * 2;
				// we need to get height before resize to know if scroll will be visible or not
				if( _scrollRenderer == ScrollRenderer.OFF ) h = _totalHeight;
				else if( _cellCount ) h = Math.min( _totalHeight , _cellCount * ( _cellHeight + _cellSpacing ) - _cellSpacing );
				
				var scrollWillVisible : Boolean = h < _totalHeight;
				var scrollWidth : Number = 0;
				
				if( _scroll == null && scrollWillVisible  && !_scroll.wrapTarget ) _scroll = _buildScroll( );
				
				if( _scroll != null && !_scroll.wrapTarget ) scrollWidth = _scroll.width;
				
				w = cellWidth + ( scrollWillVisible ? scrollWidth : 0 ) + padding.left + padding.right + _borderThickness * 2;
				w = Math.max( Math.min( _maxWidth , w ) , _minWidth );
			}
			
			
			if( _scrollRenderer == ScrollRenderer.OFF ) _height = _totalHeight + padding.top + padding.bottom + _borderThickness * 2;
			else if( _cellCount > 0 )
			{
				count = Math.min( count , _cellCount );
				_height = count * ( _cellHeight + _cellSpacing ) - _cellSpacing + padding.top + padding.bottom + _borderThickness * 2;
			}
			
			if( oldWidth != w || oldHeight != _height )
			{
				invalidate( InvalidationType.SIZE );
			}
			
			_width = isNaN( w ) ? _width : w;
		}
		
		/**
		 * @private
		 */
		protected function _updateScrollPosition( e : Event = null ) : void
		{
			var scrollPos : Number = _scroll.getScrollPosition( );
			
			if( _variableCellHeight )
			{
				var i : int = -1;
				var l : uint = _cellIndexToPosition.length;
				
				while( ++i < l ) 
				{
					if( _cellIndexToPosition[ i ] > scrollPos )
					{
						_displayIndex = i - 1;
						break;	
					}
				}
				
				_displayIndexPosition = _cellIndexToPosition[ _displayIndex ];
			}
			else
			{
				_displayIndex = Math.floor( scrollPos / ( _cellHeight + _cellSpacing ) );
				_displayIndexPosition = Math.max( 0 , ( _cellHeight + _cellSpacing ) * _displayIndex );
			}
			
			_drawCells( true );
		}
		
		/**
		 * @private
		 */
		protected function _drawCells( fromScroll : Boolean = false ) : void
		{
			var padding : Padding = contentPadding;
			var i : int = _displayIndex;
			var filterIndex : int = Math.max( 0 , _displayIndex );
			var scrollIsVisible : Boolean = _height - padding.top - padding.bottom - _borderThickness * 2 < _totalHeight;
			var scrollWidth : Number = _scroll == null || _scroll.wrapTarget || _scrollBarOverlapCells || !scrollIsVisible ? 0 : _scroll.width;
			var w : Number = _width - padding.left - padding.right - _borderThickness * 2 - scrollWidth;
			var h : Number = _height - padding.top - padding.bottom - _borderThickness * 2;
			var y : Number = _displayIndexPosition;
			var cpt : uint = 0;
			var scrollPosition : Number = _scroll != null ? _scroll.getScrollPosition( ) : 0;
			var a : Array = new Array();
			var l : int = _dataProvider.length;
			var listCellData : ListCellData;
			var cell : ICellRenderer;
			var oldCell : ICellRenderer;
			var oCell : DisplayObject;
			//var cellRenderer : Class;
			//var newCellRenderer : Class;
			//var redraw : Boolean;
			
			while( y - scrollPosition < h && i < l )
			{
				listCellData = _getListCellDataAt( i );
				
				// display only valid cells > useful when a dataProvider filter is defined
				if( listCellData == null || _filterDataProvider != null && ( listCellData.filterIndex == -1 || listCellData.filterIndex != filterIndex ) )
				{
					i++;
					continue;
				}
				
				cell = listCellData.cell;
				
				if( !fromScroll || cell == null )
				{					//cellRenderer = cell == null ? null : getDefinitionByName( getQualifiedClassName( cell ) ) as Class;
					//newCellRenderer = listCellData.cellRenderer is Class ? listCellData.cellRenderer : getDefinitionByName( listCellData.cellRenderer ) as Class;
					//redraw = cell == null || ( _alternateCellSkin != null && _alternateCellSkin.length > 1 ) || cellRenderer != newCellRenderer;
											
					//if( redraw ) cell = 
					cell = _buildCell( listCellData );
					
					cell.owner = this;
					
					StyleManager.setInstanceStyle( cell , listCellData.style );
					
					if( _scrollBarPosition == ListScrollBarPosition.LEFT && _scrollBarOverlapCells && _scroll != null && !_scroll.wrapTarget )
					{
						var p : Padding = cell.padding;
						
						p.left = p.left < _scroll.width ? p.left + _scroll.width : p.left;
						
						cell.padding = p;
					}
					
					cell.index = listCellData.index;
					
					listCellData.cell = cell;
					
					if( cell.width != w || cell.height != listCellData.height )
						cell.setSize( w , listCellData.height );
					
					cell.enabled = _enabled;					cell.useHandCursor = useHandCursor;
					cell.selectable = _selectable;					cell.selected = _selectedIndices.indexOf( i ) >= 0;
					cell.visible = true;					cell.y = y;
					
					if( cell.data != listCellData.data ) cell.data = listCellData.data;
										if( !isInvalidate( InvalidationType.SIZE ) ) cell.draw( );
					
					oCell = cell as DisplayObject;
				
					if( !_cellsHandler.contains( oCell ) )
						_cellsHandler.addChildAt( oCell , 0 );
					
					dispatchEvent( new ListEvent( ListEvent.CELL_ADDED , cell ) );
				}
				else cell.y = y;
				
				a[ cpt ] = cell;
				
				y += cell.height + _cellSpacing;
				cpt++;
				i++;
				filterIndex++;
			}
			
			// clear useless cells
			for each( oldCell in _cells ) 
			{
				if( a.indexOf( oldCell ) == -1 ) 
				{
					oldCell.owner = null;
					oldCell.visible = false;
					//oCell = oldCell as DisplayObject;
					
					//if( _cellsHandler.contains( oCell ) ) 
					//{
						//_cellsHandler.removeChild( oCell );
						if( _itemToListCellData[ oldCell.data ] != null && _itemToListCellData[ oldCell.data ].cell == oldCell ) _itemToListCellData[ oldCell.data ].cell = null;
						
						_oldCells.push( oldCell );
						
						if( _oldCells.length > 10 )
						{
							oCell = _oldCells.shift();
							if( _cellsHandler.contains( oCell ) ) _cellsHandler.removeChild( oCell );
						}
						
						dispatchEvent( new ListEvent( ListEvent.CELL_REMOVED , oldCell ) );
					//} 
				}
			}
			
			_cells = a;
		}
		
		/**
		 * @private
		 */
		protected function _buildCell ( listCellData : ListCellData ) : ICellRenderer
		{
			var skinLength : uint = _alternateCellSkin != null ? _alternateCellSkin.length : 0;
			
			if( skinLength == 0 )
			{
				var oldCell : ICellRenderer = _getFromOldCells( listCellData );
				if( oldCell != null ) return oldCell;
			}
			
			var skin : ISkin = skinLength > 0 ? _alternateCellSkin[ listCellData.index % skinLength ] as ISkin : null;
			var cell : ICellRenderer = _listSkin.getCellAsset( listCellData.cellRenderer , skin );
			
			cell.addEventListener( MouseEvent.ROLL_OVER , _cellOver , false , 0 , true );
			cell.addEventListener( MouseEvent.ROLL_OUT , _cellOut , false , 0 , true );
			cell.addEventListener( MouseEvent.CLICK , _cellClick , false , 0 , true );
			
			return cell;
		}
		
		/**
		 * @private
		 */
		protected function _getFromOldCells( listCellData : ListCellData ) : ICellRenderer
		{
			var cell : ICellRenderer;
			var cellRenderer : Class;
			var newCellRenderer : Class;
			var a : Array = listCellData.cell != null ? [ listCellData.cell ].concat( _oldCells ) : _oldCells;
			var l : uint = a.length;
			
			for( var i : uint = 0; i < l; i++ ) 
			{
				cell = a[ i ];
				cellRenderer = getDefinitionByName( getQualifiedClassName( cell ) ) as Class;
				newCellRenderer = listCellData.cellRenderer is Class ? listCellData.cellRenderer : getDefinitionByName( listCellData.cellRenderer ) as Class;
				
				if( cellRenderer == newCellRenderer )
				{
					var index : uint = _oldCells.indexOf( cell );
					
					if( index >= 0 ) _oldCells.splice( index , 1 );
					
					return cell;
				}
			}
			
			return null;
		}
		
		/**
		 * @private
		 */
		protected function _buildScroll( ) : IScroll
		{
			var scroll : IScroll = _listSkin.getScrollAsset( _scrollRenderer );
			
			if( scroll != null ) _initScroll( scroll );
			
			return scroll;
		}
		
		/**
		 * @private
		 */
		protected function _layout(  ) : void
		{
			var padding : Padding = contentPadding;
			var paddingTopBottom : Number = padding.top + padding.bottom;			var paddingLeftRight : Number = padding.left + padding.right;
			
			if( _backgroundAsset != null )
			{
				_backgroundAsset.setSize( _width , _height );
				_backgroundAsset.draw();
			}
			
			if( _borderAsset != null )
			{
				_borderAsset.x = padding.left;
				_borderAsset.y = padding.top;
				_borderAsset.setSize( _width - paddingLeftRight , _height - paddingTopBottom );
				_borderAsset.draw();
			}
			
			_layoutMask();
			
			var scrollIsVisible : Boolean = _height - padding.top - padding.bottom - _borderThickness * 2 < _totalHeight;
			var scrollWidth : Number = _scroll == null || _scroll.wrapTarget || _scrollBarOverlapCells || !scrollIsVisible ? 0 : _scroll.width;
			var w : Number = _width - paddingLeftRight - _borderThickness * 2 - scrollWidth;
			if( scrollWidth != 0 && !_scrollLayoutUseBorderThickness ) w += _borderThickness;
			var scrollBorderLayout : Number = _scrollLayoutUseBorderThickness ? _borderThickness : 0;
			
			if( _scroll != null )
			{
				_scroll.height = _height - paddingTopBottom - scrollBorderLayout * 2;
				
				if( _scroll.wrapTarget )
				{
					_scroll.x = padding.left + scrollBorderLayout;
					_scroll.width = _width - paddingLeftRight - scrollBorderLayout * 2;
				}
				else if( _scrollBarPosition == ListScrollBarPosition.LEFT )
					_scroll.x = padding.left + scrollBorderLayout;
				else					_scroll.x = _width - padding.right - scrollBorderLayout - _scroll.width;
				
				
				_scroll.y = padding.top + scrollBorderLayout;
				_scroll.draw();
			}
			
			_cellsHandler.x = padding.left + _borderThickness + ( _scrollBarPosition == ListScrollBarPosition.LEFT && !_scrollBarOverlapCells ? scrollWidth : 0 );
			_cellsHandler.y = padding.top + _borderThickness;
			
			var i : int = -1;
			var l : uint = _cells.length;
			
			while( ++i < l ) 
			{
				var cell : ICellRenderer = _cells[ i ] as ICellRenderer;
				
				cell.width = w;
				cell.draw();
			}
		}
		
		/**
		 * @private
		 */
		protected function _layoutMask(  ) : void
		{
			var padding : Padding = contentPadding;
			var g : Graphics = _contentMask.graphics;
			
			g.clear();
			g.beginFill( 0x000000 , .5 );
			
			if( _contentMaskCornerRadiusTopLeft != 0 || _contentMaskCornerRadiusTopRight != 0 || _contentMaskCornerRadiusBottomRight != 0 || _contentMaskCornerRadiusBottomLeft != 0)
			
				g.drawRoundRectComplex( padding.left + _borderThickness ,
										padding.top + _borderThickness ,
										_width - padding.left - padding.right - _borderThickness * 2 ,
										_height - padding.top - padding.bottom - _borderThickness * 2 ,
										_contentMaskCornerRadiusTopLeft , _contentMaskCornerRadiusTopRight , _contentMaskCornerRadiusBottomLeft ,  _contentMaskCornerRadiusBottomLeft );
			else
				
				g.drawRect( padding.left + _borderThickness ,
							padding.top + _borderThickness ,
							_width - padding.left - padding.right - _borderThickness * 2 ,
							_height - padding.top - padding.bottom - _borderThickness * 2 );
				
			
			g.endFill();
		}

		/**
		 * @private
		 */
		protected function _cellOver( e : MouseEvent ) : void
		{
			dispatchEvent( new ListEvent( ListEvent.CELL_OVER , e.currentTarget as ICellRenderer ) );
		}
		
		/**
		 * @private
		 */
		protected function _cellOut( e : MouseEvent ) : void
		{
			dispatchEvent( new ListEvent( ListEvent.CELL_OUT , e.currentTarget as ICellRenderer ) );
		}
		
		/**
		 * @private
		 */
		protected function _cellClick( e : MouseEvent ) : void
		{
			var cell : ICellRenderer = e.currentTarget as ICellRenderer;	
			
			_setSelectedCell( _getListCellDataAt( cell.index ) , e.ctrlKey , e.shiftKey );
			
			dispatchEvent( new ListEvent( ListEvent.CELL_CLICK , cell ) );
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
					
					_itemToListCellData[ e.item ] = new ListCellData( this , e.fromIndex , e.item );
					
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
					
					var newItem : * = _dataProvider.getItemAt( e.fromIndex );
					
					_itemToListCellData[ newItem ] = new ListCellData( this , e.fromIndex , newItem );
					
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
			
			if( _filterDataProvider != null ) filter( _filterDataProviderCallback );
			
			invalidate( InvalidationType.DATA );
		}
		
		/**
		 * @private
		 */
		protected function _refreshCellsSelection(  ) : void
		{
			var l : uint = _cells.length;
			
			for( var i : uint = 0; i < l; i++ ) 
			{
				var cell : ICellRenderer = _cells [ i ] as ICellRenderer;
				
				cell.selected = _selectedIndices.indexOf( cell.index  ) >= 0;
			}
		}
		
		/**
		 * @private
		 */
		protected function _setSelectedCell ( listCellData : ListCellData , ctrlKey : Boolean = false , shiftKey : Boolean = false ) : void
		{
			if( listCellData == null ) return;
			
			var cell : ICellRenderer = listCellData.cell;
			var i : int = -1;
			var l : uint = _selectedIndices.length;
			
			if( ( _multipleSelection && ctrlKey && !shiftKey ) )
			{
				if( cell.selected )
				{
					_selectedIndices.push( listCellData.index );					_selectedItems.push( listCellData.data );
				}
				else
				{
					while( ++i < l )
					{
						if( _getListCellDataAt( _selectedIndices[ i ] ).cell == cell )
						{
							_selectedIndices.splice( i , 1 );
							_selectedItems.splice( i , 1 );
							break;
						}
					}
				}
			}
			else if( _multipleSelection && !ctrlKey && shiftKey )
			{ 
				var selectedListCell : ListCellData;
				var selectedCell : ICellRenderer;
				
				while( ++i < l )
				{
					selectedListCell = _getListCellDataAt( _selectedIndices[ i ] );
					selectedCell = selectedListCell.cell;
					selectedCell.selected = selectedCell != cell;
				}
	
				var selectedIndex : int = this.selectedIndex;
				var clickIndex : uint = listCellData.index;
				var min : int = Math.min( selectedIndex , clickIndex );
				var max : int = Math.max( selectedIndex , clickIndex );
				
				_selectedIndices = new Array( );
				_selectedItems = new Array( );
				
				if( selectedIndex != -1 && min != max )
				{
					i = min - 1;
					
					while( ++i <= max )
					{
						var currentListCellData : ListCellData = _getListCellDataAt( i );
						var currentCell : ICellRenderer = currentListCellData.cell;
					
						if( currentCell != null )
							currentCell.selected = true;
						
						_selectedIndices.push( currentListCellData.index );						_selectedItems.push( currentListCellData.data );
					}
				}
			}
			else
			{
				while( ++i < l )
				{
					selectedListCell = _getListCellDataAt( _selectedIndices[ i ] );
					selectedCell = selectedListCell.cell;
	
					if( selectedCell != cell && selectedCell != null )
					{
						selectedCell.selected = false;
					}
				}
				
				_selectedIndices = cell.selected ? [ listCellData.index ] : [];
				_selectedItems = cell.selected ? [ listCellData.data ] : [];
			}
			
			dispatchEvent( new ListEvent( ListEvent.SELECTION_CHANGE ) );
			
			// make sure new selected cell is visible
			var a : Array = getVisibleCells();
			
			if( a.length )
			{				var index : uint = listCellData.filterIndex != -1 ? listCellData.filterIndex : listCellData.index;
				var topCell : ICellRenderer = a[ 0 ] as ICellRenderer;				var bottomCell : ICellRenderer = a[ a.length - 1 ] as ICellRenderer;
				var topIndex : uint = listCellData.filterIndex != -1 ? _getListCellDataAt( topCell.index ).filterIndex : topCell.index;
				var bottomIndex : uint = listCellData.filterIndex != -1 ? _getListCellDataAt( bottomCell.index ).filterIndex : bottomCell.index;				
				if( index <= topIndex ) scrollToIndex( index , AlignmentPoint.TOP );
				else if( index >= bottomIndex ) scrollToIndex( index , AlignmentPoint.BOTTOM );
			}
		}
		
		/**
		 * @private
		 */
		protected function _getListCellDataAt( index : uint ) : ListCellData
		{
			return _itemToListCellData[ _dataProvider.getItemAt( index ) ] as ListCellData;
		}
		
		/**
		 * @private
		 */
		protected function _nextItemLabelStartWith ( char : String , fromIndex : uint = 0 ) : *
		{
			var i : int = 0;
			var l : uint = _dataProvider.length;
			
			while( ++i <= l )
			{
				var index : uint = fromIndex + i > l ? fromIndex + i - ( l + 1 ) : fromIndex + i;
				var item : * = _dataProvider.getItemAt( index );
				
				if( item == null ) continue;
				
				var s : String = String( item[ _labelField ] );
				
				if( s == null ) continue;
				
				var match : Boolean = s.substr( 0 , 1 ).toLowerCase( ) == char.toLowerCase( );
				var listCellData : ListCellData = _getListCellDataAt( index );
				
				if( ( match && _filterDataProvider == null ) ||
					( match && _filterDataProvider != null && listCellData.filterIndex != -1 ) ) return item;
			}
			
			return null;
		}
		
		/**
		 * @private
		 */
		// TODO try to change public namespace to protected ( comboBox )
		public function keyDown ( e : KeyboardEvent ) : void
		{
			if( _dataProvider.isEmpty() ) return;
			
			var index : int = selectedIndex;
			var keyCode : uint = e.keyCode;			var charCode : uint = e.charCode;
			var padding : Padding = contentPadding;
			
			if ( charCode >= 33 && charCode <= 126 ) index = _dataProvider.getItemIndex( _nextItemLabelStartWith( String.fromCharCode( charCode ) ) );
			else
			{
				var dp : ICollection = _filterDataProvider != null ? new DataProvider( _filterDataProvider ) : _dataProvider;
				var dpIndex : int = _filterDataProvider != null ? dp.getItemIndex( _dataProvider.getItemAt( index ) ) : index;
				
				switch( keyCode )
				{
					case Keyboard.DOWN :
						
						if( ++dpIndex >= dp.length && !_keySelectionLoop ) dpIndex = dpIndex;
						else if( dpIndex >= dp.length ) dpIndex = 0;
						
						break;
	
					case Keyboard.UP :
					
						if( dpIndex == -1 ) dpIndex = dp.length;
						if( --dpIndex < 0 && !_keySelectionLoop ) dpIndex = 0;
						else if( dpIndex < 0 ) dpIndex = dp.length - 1;
						
						break;
					
					case Keyboard.PAGE_DOWN :
					
						dpIndex += Math.round( ( _height - padding.top - padding.bottom - _borderThickness * 2 ) / ( _cellHeight + _cellSpacing ) );
						
						if( dpIndex > dp.length - 1 ) dpIndex = dp.length - 1;
						
						break;
					
					case Keyboard.PAGE_UP :
					
						dpIndex -= Math.round( ( _height - padding.top - padding.bottom - _borderThickness * 2 ) / ( _cellHeight + _cellSpacing ) );
						
						if( dpIndex < 0 ) dpIndex = 0;
						
						break;	
					
					case Keyboard.HOME :
						
						dpIndex = 0;
						break;
	
					case Keyboard.END :
						
						dpIndex = dp.length - 1;
						
						break;
				}
			}
			
			index = _filterDataProvider != null ? _dataProvider.getItemIndex( dp.getItemAt( dpIndex ) ) : dpIndex;
			
			if( index == -1 ) return;
			
			_setSelectedCell( _getListCellDataAt( index ) );
			
			var cell : ICellRenderer = getCellAt( index );
			
			if( cell != null ) cell.selected = true;
		}
	}
}