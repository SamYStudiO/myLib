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
	import myLib.controls.skins.IComboBoxSkin;
	import myLib.controls.skins.my_skinset;
	import myLib.core.AFieldComponent;
	import myLib.core.IScroll;
	import myLib.core.InvalidationType;
	import myLib.data.ICollection;
	import myLib.displayUtils.AlignmentPoint;
	import myLib.events.ComboBoxEvent;
	import myLib.events.ComponentEvent;
	import myLib.events.ListEvent;
	import myLib.form.IField;
	import myLib.styles.Padding;
	import myLib.styles.TextStyle;
	import myLib.transitions.Tween;
	import myLib.transitions.TweenEvent;
	import myLib.transitions.easing.Regular;

	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Graphics;
	import flash.display.InteractiveObject;
	import flash.display.Shape;
	import flash.events.Event;
	import flash.events.FocusEvent;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.ui.Keyboard;
	
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
	 * Defines the value of the type property of a open event object.
	 * 
	 * @eventType open
	 */
    [Event(name="open", type="myLib.events.ComboBoxEvent")]
    
    /**
	 * Defines the value of the type property of a close event object.
	 * 
	 * @eventType close
	 */
    [Event(name="close", type="myLib.events.ComboBoxEvent")]
    
    /**
	 * Defines the value of the type property of a boxListRollOut event object.
	 * 
	 * @eventType boxListRollOut
	 */
    [Event(name="boxListRollOut", type="myLib.events.ComboBoxEvent")]
	/**
	 * ComboBox consist of a List component that can be display or hide.
	 * 
	 * @author SamYStudiO ( contact@samystudio.net )
	 */
	public class ComboBox extends AFieldComponent implements IComboBox, IField
	{
		/**
		 * @private
		 */
		protected var _comboBoxSkin : IComboBoxSkin;
		
		/**
		 * @private
		 */
		protected var _alphaTween : Tween;
		
		/**
		 * @private
		 */
		protected var _tween : Tween;
		
		/**
		 * @private
		 */
		protected var _keyBackDelete : Boolean;

		/**
		 * @private
		 */
		protected var _defaultText : String = "";
		
		/**
		 * @inheritDoc
		 */
		public function get defaultText() : String
		{
			return _defaultText;
		}
		
		public function set defaultText( s : String ) : void
		{
			_defaultText = s;
		}
		
		/**
		 * @private
		 */
		protected var _openFunction : Function;
		
		/**
		 * @inheritDoc
		 */
		public function get openFunction() : Function
		{
			return _openFunction;
		}
		
		public function set openFunction( f : Function ) : void
		{
			_openFunction = f;
		}
		
		/**
		 * @private
		 */
		protected var _closeFunction : Function;
		
		/**
		 * @inheritDoc
		 */
		public function get closeFunction() : Function
		{
			return _closeFunction;
		}
		
		public function set closeFunction( f : Function ) : void
		{
			_closeFunction = f;
		}
	
		/**
		 * @private
		 */
		protected var _transitionEasing : Function = Regular.easeOut;
		
		/**
		 * @inheritDoc
		 */
		public function get transitionEasing() : Function
		{
			return _transitionEasing;
		}
		
		public function set transitionEasing( f : Function ) : void
		{
			_transitionEasing = f;
		}
		
		/**
		 * @private
		 */
		protected var _transitionType : String = ComboBoxTransitionType.TRANSLATE;
		
		[Inspectable(enumeration="none,translate,roll,custom",defaultValue="translate")]
		/**
		 * @inheritDoc
		 */
		public function get transitionType() : String
		{
			return _transitionType;
		}
		
		public function set transitionType( s : String ) : void
		{
			if( _inspector && !_isLivePreview && _transitionType != ComboBoxTransitionType.TRANSLATE ) return;
			
			_transitionType = s;
		}
		
		/**
		 * @private
		 */
		protected var _transitionAlpha : Boolean;
		
		[Inspectable]
		/**
		 * @inheritDoc
		 */
		public function get transitionAlpha() : Boolean
		{
			return _transitionAlpha;
		}
		
		public function set transitionAlpha( b : Boolean ) : void
		{
			if( _inspector && !_isLivePreview && _transitionAlpha ) return;
			
			_transitionAlpha = b;
		}
	
		/**
		 * @private
		 */
		protected var _transitionDuration : Number = 10;
		
		[Inspectable(defaultValue=10)]
		/**
		 * @inheritDoc
		 */
		public function get transitionDuration() : Number
		{
			return _transitionDuration;
		}
		
		public function set transitionDuration( n : Number ) : void
		{
			if( _inspector && !_isLivePreview && _transitionDuration != 10 ) return;
			
			_transitionDuration = n;
		}
		
		/**
		 * @private
		 */
		protected var _allowCustomEditableText : Boolean = true;
		
		[Inspectable(defaultValue=true)]
		/**
		 * @inheritDoc
		 */
		public function get allowCustomEditableText() : Boolean
		{
			return _allowCustomEditableText;
		}
		
		public function set allowCustomEditableText( b : Boolean ) : void
		{
			if( _inspector && !_isLivePreview && !_allowCustomEditableText ) return;
			
			_allowCustomEditableText = b;
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
			
			if( !b )
			{
				close();
				setFocus();
			}
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
			
			invalidate( InvalidationType.SIZE );
		}
		
		/**
		 * @private
		 */
		protected var _autoCompletion : Boolean;
		
		[Inspectable] 
		/**
		 * @inheritDoc
		 */
		public function get autoCompletion() : Boolean
		{
			return _autoCompletion;
		}
		
		public function set autoCompletion( b : Boolean ) : void
		{
			if( _inspector && !_isLivePreview && _autoCompletion ) return;
			
			_autoCompletion = b;
			
			if( b && !_editable ) editable = true;
			
			if( b ) _hideSelectedCell = false;
		}
			
		/**
		 * @private
		 */
		protected var _editable : Boolean;
		
		[Inspectable] 
		/**
		 * @inheritDoc
		 */
		public function get editable() : Boolean
		{
			return _editable;
		}
		
		public function set editable( b : Boolean ) : void
		{
			if( _inspector && !_isLivePreview && _editable ) return;
			
			_editable = b || _autoCompletion;
			_textInput.textField.type = b ? TextFieldType.INPUT : TextFieldType.DYNAMIC;
			_textInput.textField.selectable =
			_textInput.mouseEnabled = _textInput.mouseChildren = _enabled ? b || _autoCompletion : false;
			_boxAsset.mouseEnabled = !_editable;
			
			_focusTarget = _editable ? _textInput as InteractiveObject : null;
			
			_dropdownList.focusTarget = _focusTarget;
		}
		
		/**
		 * @private
		 */
		protected var _hideSelectedCell : Boolean;
		
		[Inspectable] 
		/**
		 * @inheritDoc
		 */
		public function get hideSelectedCell() : Boolean
		{
			return _hideSelectedCell;
		}
		
		public function set hideSelectedCell( b : Boolean ) : void
		{
			if( _inspector && !_isLivePreview && _hideSelectedCell ) return;
			
			_hideSelectedCell = b;
		}
		
		/**
		 * @private
		 */
		protected var _arrowButtonPosition : String = ComboBoxArrowButtonPosition.RIGHT;
		
		[Inspectable(defaultValue="right",enumeration="left,right")]
		/**
		 * @inheritDoc
		 */
		public function get arrowButtonPosition() : String
		{
			return _arrowButtonPosition;
		}
		
		public function set arrowButtonPosition( position : String ) : void
		{
			if( _inspector && !_isLivePreview && _arrowButtonPosition != ComboBoxArrowButtonPosition.RIGHT ) return;
			
			_arrowButtonPosition = position;
			
			invalidate( InvalidationType.SIZE );
		}
		
		/**
		 * @private
		 */
		protected var _arrowButtonWidth : Number;
		
		// TODO apply button width?
		/**
		 * @inheritDoc
		 */
		public function get arrowButtonWidth() : Number
		{
			return _arrowButtonWidth;
		}
		
		public function set arrowButtonWidth( n : Number ) : void
		{
			_arrowButtonWidth = n;
		}
		
		/**
		 * @private
		 */
		protected var _sens : int = 1;
		
		[Inspectable(defaultValue="down",enumeration="up,down")]
		/**
		 * @inheritDoc
		 */
		public function get openDirection() : String
		{
			return _sens == -1 ? ComboBoxOpenDirection.UP : ComboBoxOpenDirection.DOWN;
		}
		
		public function set openDirection( direction : String ) : void
		{
			if( _inspector && !_isLivePreview && _sens != 1 ) return;
			
			var sens : int = _sens;
			
			_sens = direction == ComboBoxOpenDirection.UP ? -1 : 1;
			
			if( sens != _sens ) dispatchEvent( new ComboBoxEvent( ComboBoxEvent.OPEN_DIRECTION_CHANGE ) );
		}
		
		/**
		 * @private
		 */
		protected var _openMouseAction : String = ComboBoxOpenMouseAction.CLICK;

		[Inspectable(defaultValue="click",enumeration="click,roll")]
		/**
		 * @inheritDoc
		 */
		public function get openMouseAction() : String
		{
			return _openMouseAction;
		}
		
		public function set openMouseAction( action : String ) : void
		{
			if( _inspector && !_isLivePreview && _openMouseAction != ComboBoxOpenMouseAction.CLICK ) return;
			
			_openMouseAction = action;
			
			if( action != ComboBoxOpenMouseAction.ROLL )
			{
				_boxAsset.addEventListener( MouseEvent.CLICK , _toggleOpen , false , 0 , true );
				_arrowButtonAsset.addEventListener( MouseEvent.CLICK , _toggleOpen , false , 0 , true );				_boxAsset.removeEventListener( MouseEvent.ROLL_OVER , _rollOpen );				_arrowButtonAsset.removeEventListener( MouseEvent.ROLL_OVER , _rollOpen );
			}
			else
			{
				_boxAsset.addEventListener( MouseEvent.ROLL_OVER , _rollOpen , false , 0 , true );				_arrowButtonAsset.addEventListener( MouseEvent.ROLL_OVER , _rollOpen , false , 0 , true );
				_boxAsset.removeEventListener( MouseEvent.CLICK , _toggleOpen );				_arrowButtonAsset.removeEventListener( MouseEvent.CLICK , _toggleOpen );
			}
		}
		
		/**
		 * @private
		 */
		protected var _dropdownWidth : Number;
		
		[Inspectable]
		/**
		 * @inheritDoc
		 */
		public function get dropdownWidth() : Number
		{
			return _dropdownWidth;
		}
		
		public function set dropdownWidth( n : Number ) : void
		{
			if( _inspector && !_isLivePreview && !isNaN( _dropdownWidth ) ) return;
			
			if( n <= 0 ) n = NaN;
			
			_dropdownWidth = n;
			
			if( _dropdownWidthType == ComboBoxDropdownWidthType.NONE || _dropdownWidthType == ComboBoxDropdownWidthType.PERCENTAGE )
				_updateDropdownListSize();
		}
		
		/**
		 * @private
		 */
		protected var _dropdownWidthType : String = ComboBoxDropdownWidthType.NONE;

		[Inspectable(enumeration="none,percentage,arrowButton,autoSize",defaultValue="none")] 
		/**
		 * @inheritDoc
		 */
		public function get dropdownWidthType() : String
		{
			return _dropdownWidthType;
		}
		
		public function set dropdownWidthType( s : String ) : void
		{
			if( _inspector && !_isLivePreview && _dropdownWidthType != ComboBoxDropdownWidthType.NONE ) return;
			
			_dropdownWidthType = s;
			
			_updateDropdownListSize();
		}
		
		/**
		 * @private
		 */
		protected var _isOpen : Boolean;
		
		/**
		 * @inheritDoc
		 */
		public function get isOpen() : Boolean
		{
			return _isOpen;
		}
		
		/**
		 * @private
		 */
		protected var _boxAsset : IAsset;
		
		/**
		 * @inheritDoc
		 */
		public function get boxAsset() : IAsset
		{
			return _boxAsset;
		}
		
		/**
		 * @private
		 */
		protected var _arrowButtonAsset : IAsset;
		
		/**
		 * @inheritDoc
		 */
		public function get arrowButtonAsset() : IAsset
		{
			return _arrowButtonAsset;
		}
		
		/**
		 * @private
		 */
		protected var _textInput : ITextInput;
		
		/**
		 * @inheritDoc
		 */
		public function get textInput() : ITextInput
		{
			return _textInput;
		}
		
		/**
		 * @private
		 */
		protected var _textStyle : TextStyle;
		
		/**
		 * @inheritDoc
		 */
		public function get textStyle () : TextStyle
		{
			return _textInput.textStyle;
		}
		
		public function set textStyle ( style : TextStyle ) : void
		{
			_textInput.textStyle = style;
			
			invalidate( InvalidationType.SIZE );
		}
				
		/**
		 * @inheritDoc
		 */
		public function get textField() : TextField
		{
			return _textInput.textField;
		}
		
		[Inspectable]
		/**
		 * @inheritDoc
		 */
		public function get text() : String
		{
			return _textInput.text;
		}
		
		public function set text( s : String ) : void
		{
			if( _inspector && !_isLivePreview && _textInput.text != "" ) return;
			
			_dropdownList.clearSelection();
			
			_textInput.text = _defaultText = s;
		}
		
		/**
		 * @private
		 */
		protected var _dropdownList : IList;
		
		/**
		 * @inheritDoc
		 */
		public function get dropdownList() : IList
		{
			return _dropdownList;
		}
		
		/**
		 * @private
		 */
		protected var _dropdownListMask : Shape = new Shape();
		
		/**
		 * Get the mask used to open and close dropdown list.
		 */
		public function get dropdownListMask() : Shape
		{
			return _dropdownListMask;
		}
		
		[Inspectable(defaultValue=true)]
		/**
		 * @inheritDoc
		 */
		public function get keySelectionLoop() : Boolean
		{
			return _dropdownList.keySelectionLoop;
		}
		
		public function set keySelectionLoop( b : Boolean ) : void
		{
			if( _inspector && !_isLivePreview && !_dropdownList.keySelectionLoop ) return;
			
			_dropdownList.keySelectionLoop = b;
		}
		
		[Inspectable(defaultValue=1)]
		/**
		 * @inheritDoc
		 */
		public function get borderThickness() : Number
		{
			return _dropdownList.borderThickness;
		}
		
		public function set borderThickness( n : Number ) : void
		{
			if( _inspector && !_isLivePreview && _dropdownList.borderThickness != 1 ) return;
			
			_dropdownList.borderThickness = n;
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
			
			_dropdownList.useHandCursor = b;
		}

		[Collection(collectionClass="myLib.data.DataProvider",collectionItem="myLib.data.DataProviderItem")]
		/**
		 * @inheritDoc
		 */
		public function get dataProvider () : ICollection
		{
			return _dropdownList.dataProvider;
		}
		
		public function set dataProvider ( dataProvider : ICollection ) : void
		{
			if( _inspector && !_isLivePreview && !_dropdownList.dataProvider.isEmpty() ) return;	
			
			_dropdownList.dataProvider = dataProvider;
		}

		[Inspectable(defaultValue="label")] 
		/**
		 * @inheritDoc
		 */
		public function get labelField() : String
		{
			return _dropdownList.labelField;
		}
		
		public function set labelField( s : String ) : void
		{
			if( _inspector && !_isLivePreview && _dropdownList.labelField != "label" ) return;
			
			_dropdownList.labelField = s;
		}
		
		[Inspectable(defaultValue="data")] 
		/**
		 * @inheritDoc
		 */
		public function get dataField() : String
		{
			return _dropdownList.dataField;
		}
		
		public function set dataField( s : String ) : void
		{
			if( _inspector && !_isLivePreview && _dropdownList.dataField != "data" ) return;
			
			_dropdownList.dataField = s;
		}

		[Inspectable(defaultValue="icon")]
		/**
		 * @inheritDoc
		 */
		public function get iconField() : String
		{
			return _dropdownList.iconField;
		}
		
		public function set iconField( s : String ) : void
		{
			if( _inspector && !_isLivePreview && _dropdownList.iconField != "icon" ) return;
			
			_dropdownList.iconField = s;
		}
		
		/**
		 * @inheritDoc
		 */
		public function get selectedIndex() : int
		{
			return _dropdownList.selectedIndex;
		}
		
		public function set selectedIndex( index : int ) : void
		{
			_dropdownList.selectedIndex = index;
		}
		
		/**
		 * @inheritDoc
		 */
		public function get selectedItem() : *
		{
			return _dropdownList.selectedItem;
		}
		
		public function set selectedItem( item : * ) : void
		{
			_dropdownList.selectedItem = item;
		}
		
		/**
		 * @inheritDoc
		 */
		public function get selectedData() : *
		{
			return _dropdownList.selectedData;
		}
		
		public function set selectedData( data : * ) : void
		{
			_dropdownList.selectedData = data;
		}
		
		[Inspectable(defaultValue=5)] 
		/**
		 * @inheritDoc
		 */
		public function get cellCount() : uint
		{
			return _dropdownList.cellCount;
		}
		
		public function set cellCount( n : uint ) : void
		{
			if( _inspector && !_isLivePreview && _dropdownList.cellCount != 5 ) return;
			
			_dropdownList.cellCount = n;
		}
		
		[Inspectable(defaultValue=20)] 
		/**
		 * @inheritDoc
		 */
		public function get cellHeight() : Number
		{
			return _dropdownList.cellHeight;
		}
		
		public function set cellHeight( n : Number ) : void
		{
			if( _inspector && !_isLivePreview && _dropdownList.cellHeight != 20 ) return;
			
			_dropdownList.cellHeight = n;
		}
		
		[Inspectable(defaultValue=0)] 
		/**
		 * @inheritDoc
		 */
		public function get cellSpacing() : Number
		{
			return _dropdownList.cellSpacing;
		}
		
		public function set cellSpacing( n : Number ) : void
		{
			if( _inspector && !_isLivePreview && _dropdownList.cellSpacing != 0 ) return;
			
			_dropdownList.cellSpacing = n;
		}

		/**
		 * @inheritDoc
		 */
		public function get cellStyle() : Object
		{
			return _dropdownList.cellStyle;
		}
		
		public function set cellStyle( style : Object ) : void
		{
			_dropdownList.cellStyle = style;
		}
		
		[Inspectable(defaultValue="myLib.controls.ListCell")]
		/**
		 * @inheritDoc
		 */
		public function get cellRenderer() : String
		{
			return _dropdownList.cellRenderer;
		}
		
		public function set cellRenderer( definition : String ) : void
		{
			if( _inspector && !_isLivePreview && _dropdownList.cellRenderer != "myLib.controls.ListCell" ) return;
			
			_dropdownList.cellRenderer = definition;
		}
		
		[Inspectable(defaultValue="right",enumeration="left,right")]
		/**
		 * Get or set a Boolean that indicates if ScrollBar overlap cells or cells are resized when ScrollBar is display.
		 * 
		 * @default false
		 */
		public function get scrollBarPosition() : String
		{
			return _dropdownList.scrollBarPosition;
		}
		
		public function set scrollBarPosition( position : String ) : void
		{
			if( _inspector && !_isLivePreview && _dropdownList.scrollBarPosition != ListScrollBarPosition.RIGHT ) return;
			
			_dropdownList.scrollBarPosition = position;
		}
		
		[Inspectable] 
		/**
		 * @inheritDoc
		 */
		public function get scrollBarOverlapCells() : Boolean
		{
			return _dropdownList.scrollBarOverlapCells;
		}
		
		public function set scrollBarOverlapCells( b : Boolean ) : void
		{
			if( _inspector && !_isLivePreview && _dropdownList.scrollBarOverlapCells ) return;
			
			_dropdownList.scrollBarOverlapCells = b;
		}
		
		/**
		 * @private
		 */
		protected var _keepScrollPositionOnClose : Boolean = true;
		
		[Inspectable(defaultValue=true)] 
		/**
		 * @inheritDoc
		 */
		public function get keepScrollPositionOnClose() : Boolean
		{
			return _keepScrollPositionOnClose;
		}
		
		public function set keepScrollPositionOnClose( b : Boolean ) : void
		{
			if( _inspector && !_isLivePreview && !_keepScrollPositionOnClose ) return;
			
			_keepScrollPositionOnClose = b;
		}
		
		/**
		 * @inheritDoc
		 */
		public function get alternateCellSkin() : Array
		{
			return _dropdownList.alternateCellSkin;
		}
		
		public function set alternateCellSkin( a : Array ) : void
		{
			_dropdownList.alternateCellSkin = a;
		}
		
		/**
		 * @inheritDoc
		 */
		public function get contentPadding() : Padding
		{
			return _dropdownList.contentPadding;
		}

		public function set contentPadding( padding : Padding ) : void
		{
			_dropdownList.contentPadding = padding;
		}
		
		[Inspectable(name="contentPadding",type="Object",defaultValue="left:0,top:0,right:0,bottom:0")]
		/**
		 * @private
		 */
		public function set inspectableContentPadding( padding : Object ) : void
		{
			if( !_inspector && !_isLivePreview ) throw new Error( this + " inspectableContentPadding property is internal and used by Flash component inspector panel , use contentPadding property instead" );
			
			if( _inspector && !_isLivePreview && ( _dropdownList.contentPadding.left != 0 || _dropdownList.contentPadding.top != 0 || _dropdownList.contentPadding.right != 0 || _dropdownList.contentPadding.bottom != 0 ) ) return;
			
			_dropdownList.contentPadding = new Padding( padding.left , padding.top , padding.right , padding.bottom );
		}
		
		[Inspectable(defaultValue=2)]
		/**
		 * @inheritDoc
		 */
		public function get contentMaskCornerRadius() : Number
		{
			return _dropdownList.contentMaskCornerRadius;
		}
		
		public function set contentMaskCornerRadius( radius : Number ) : void
		{
			if( _inspector && !_isLivePreview && _dropdownList.contentMaskCornerRadius != 2 ) return;
			
			_dropdownList.contentMaskCornerRadius = radius;
		}
		
		[Inspectable(defaultValue=2)]
		/**
		 * @inheritDoc
		 */
		public function get contentMaskCornerRadiusTopLeft() : Number
		{
			return _dropdownList.contentMaskCornerRadiusTopLeft;
		}
		
		public function set contentMaskCornerRadiusTopLeft( radius : Number ) : void
		{
			if( _inspector && !_isLivePreview && _dropdownList.contentMaskCornerRadiusTopLeft != 2 ) return;
			
			_dropdownList.contentMaskCornerRadiusTopLeft = radius;
		}
		
		[Inspectable(defaultValue=2)]
		/**
		 * @inheritDoc
		 */
		public function get contentMaskCornerRadiusTopRight() : Number
		{
			return _dropdownList.contentMaskCornerRadiusTopRight;
		}
		
		public function set contentMaskCornerRadiusTopRight( radius : Number ) : void
		{
			if( _inspector && !_isLivePreview && _dropdownList.contentMaskCornerRadiusTopRight != 2 ) return;
			
			_dropdownList.contentMaskCornerRadiusTopRight = radius;
		}
		
		[Inspectable(defaultValue=2)]
		/**
		 * @inheritDoc
		 */
		public function get contentMaskCornerRadiusBottomRight() : Number
		{
			return _dropdownList.contentMaskCornerRadiusBottomRight;
		}
		
		public function set contentMaskCornerRadiusBottomRight( radius : Number ) : void
		{
			if( _inspector && !_isLivePreview && _dropdownList.contentMaskCornerRadiusBottomRight != 2 ) return;
			
			_dropdownList.contentMaskCornerRadiusBottomRight = radius;
		}
		
		[Inspectable(defaultValue=2)]
		/**
		 * @inheritDoc
		 */
		public function get contentMaskCornerRadiusBottomLeft() : Number
		{
			return _dropdownList.contentMaskCornerRadiusBottomLeft;
		}
		
		public function set contentMaskCornerRadiusBottomLeft( radius : Number ) : void
		{
			if( _inspector && !_isLivePreview && _dropdownList.contentMaskCornerRadiusBottomLeft != 2 ) return;
			
			_dropdownList.contentMaskCornerRadiusBottomLeft = radius;
		}
		
		/**
		 * @inheritDoc
		 */
		public function get scrollStyle() : Object
		{
			return _dropdownList.scrollStyle;
		}
		
		public function set scrollStyle( style : Object ) : void
		{
			_dropdownList.scrollStyle = style;
		}
		
		/**
		 * @inheritDoc
		 */
		public function get scroll() : IScroll
		{
			return _dropdownList.scroll;
		}
		
		[Inspectable(defaultValue="myLib.controls.ScrollBar",enumeration="myLib.controls.ScrollBar,myLib.controls.MouseScroll,myLib.controls.PanoramaScroll,off")] 
		/**
		 * @inheritDoc
		 */
		public function get scrollRenderer() : *
		{
			return _dropdownList.scrollRenderer;
		}
		
		public function set scrollRenderer( definition : * ) : void
		{
			if( _inspector && !_isLivePreview && _dropdownList.scrollRenderer != ScrollRenderer.SCROLLBAR ) return;
			
			_dropdownList.scrollRenderer = definition;
		}
		
		/**
		 * Build a new ComboBox instance. Default size is 100*20.
		 * @param parentContainer The parent DisplayObjectContainer where add this ComboBox.
		 * @param initStyle The initial style object for ComboBox initialization.
		 * @param skin The IComboBoxSkin to use instead of default skin.
		 * 
		 * @see myLib.styles.StyleManager
		 */
		public function ComboBox ( parentContainer : DisplayObjectContainer = null , initStyle : Object = null , skin : IComboBoxSkin = null )
		{
			_comboBoxSkin = skin == null ? my_skinset.getComboBoxSkin() : skin;
			
			super( parentContainer , initStyle , _comboBoxSkin );
		}
		
		/**
		 * @inheritDoc
		 */
		public function getCellAt( index : uint ) : ICellRenderer
		{
			return _dropdownList.getCellAt( index );
		}
		
		/**
		 * @inheritDoc
		 */
		public function getVisibleCells(  ) : Array
		{
			return _dropdownList.getVisibleCells();
		}
		
		/**
		 * @inheritDoc
		 */
		public function setCellRendererAt( index : uint , definition : String ) : void
		{
			_dropdownList.setCellRendererAt( index , definition );
		}
		
		/**
		 * @inheritDoc
		 */
		public function getCellStyleAt( index : uint ) : Object
		{
			return _dropdownList.getCellStyleAt( index );
		}
		
		/**
		 * @inheritDoc
		 */
		public function setCellStyleAt( index : uint , style : Object ) : void
		{
			_dropdownList.setCellStyleAt( index , style );
		}
	
		/**
		 * @inheritDoc
		 */
		public function isItemSelected ( item : * ) : Boolean
		{
			return _dropdownList.isItemSelected( item );
		}

		/**
		 * @inheritDoc
		 */
		public function isItemVisible ( item : * ) : Boolean
		{
			return _dropdownList.isItemVisible( item );
		}
	
		/**
		 * @inheritDoc
		 */
		public function isIndexSelected ( index : uint ) : Boolean
		{
			return _dropdownList.isIndexSelected( index );
		}

		/**
		 * @inheritDoc
		 */
		public function isIndexVisible ( index : uint ) : Boolean
		{
			return _dropdownList.isIndexVisible( index );
		}
		
		/**
		 * @inheritDoc
		 */
		public function scrollToIndex( index : uint , alignmentPoint : String = null ) : void
		{
			_dropdownList.scrollToIndex( index , alignmentPoint );
		}
		
		/**
		 * @inheritDoc
		 */
		public function clearSelection(  ) : void
		{
			_dropdownList.clearSelection();
			
			_textInput.text = _defaultText;
		}

		/**
		 * @inheritDoc
		 */
		public function filter( callback : Function ) : Array
		{
			return _dropdownList.filter( callback );
		}
		
		/**
		 * @inheritDoc
		 */
		public function clearFilter(  ) : void
		{
			_dropdownList.clearFilter();
		}

		/**
		 * @inheritDoc
		 */
		public function open(  ) : void
		{
			if( _isOpen || !_enabled || _dropdownList.dataProvider.isEmpty() || stage == null ) return;
			
			_dropdownList.draw(); // make sure our component is validate (to get correct size).
			
			if( _dropdownList.getVisibleCells().length == 0 ) return;
			
			if( !_keepScrollPositionOnClose ) _dropdownList.scrollToIndex( 0 , AlignmentPoint.TOP );	
			
			_isOpen = true;
			
			var p : Point = _boxAsset.localToGlobal( new Point( 0 ,  0 ) );
			
			// make sure open direction is valid and dropdown list will visible in stage area, if not change direction
			if( _sens == 1 && p.y + _height + _dropdownList.height > stage.stageHeight && p.y - _dropdownList.height >= 0 )
			{
				_sens = -1;
				dispatchEvent( new ComboBoxEvent( ComboBoxEvent.OPEN_DIRECTION_CHANGE ) );			}
			if( _sens == -1 && p.y - _dropdownList.height < 0 && p.y + _height + _dropdownList.height <= stage.stageHeight )
			{
				_sens = 1;
				dispatchEvent( new ComboBoxEvent( ComboBoxEvent.OPEN_DIRECTION_CHANGE ) );
			}
			
			if( _tween != null ) _tween.stop();
			
			if( _transitionType != ComboBoxTransitionType.NONE && _transitionDuration > 0 )
			{
				_tween = _openFunction != null && _transitionType == ComboBoxTransitionType.CUSTOM ? _openFunction() : _initDropdownListForOpening();
				_tween.addEventListener( TweenEvent.TWEEN_COMPLETE, _dropdownTweenOpenComplete , false , 0 , true );
				_tween.start( );
			}
			else
			{
				_dropdownList.x = p.x;					_dropdownList.y = _sens == 1 ? p.y + _boxAsset.height : p.y - _dropdownList.height;	
				
				_dropdownList.mask = null;
			}
			
			if( _transitionAlpha && _transitionDuration > 0 )
			{
				if( _alphaTween != null  ) _alphaTween.stop();
				
				_alphaTween = new Tween( _dropdownList , "alpha" , _transitionEasing , 0 , 1 , _transitionDuration );
				_alphaTween.start();
				
				if( _transitionType == ComboBoxTransitionType.NONE ) _alphaTween.addEventListener( TweenEvent.TWEEN_COMPLETE, _dropdownTweenOpenComplete , false , 0 , true );
			}
			
			stage.addChild( _dropdownListMask );
			stage.addChild( _dropdownList as DisplayObject );
			
			_dropdownList.setFocus();
			
			dispatchEvent( new ComboBoxEvent( ComboBoxEvent.OPEN ) );
			
			if( _transitionType == ComboBoxTransitionType.NONE && !_transitionAlpha ) dispatchEvent( new ComboBoxEvent( ComboBoxEvent.OPEN_COMPLETE ) );
		}
		
		/**
		 * @inheritDoc
		 */
		public function close(  ) : void
		{
			if( !_isOpen ) return;
			
			_isOpen = false;
			
			if( _transitionType != ComboBoxTransitionType.NONE && _transitionDuration > 0 )
			{
				if( _tween != null ) _tween.stop();
				
				_tween = _closeFunction != null && _transitionType == ComboBoxTransitionType.CUSTOM ? _closeFunction() : _initDropdownListForClosing();
				_tween.addEventListener( TweenEvent.TWEEN_COMPLETE, _dropdownTweenCloseComplete , false , 0 , true );
				_tween.start( );
			}
			else if( !_transitionAlpha ) _dropdownTweenCloseComplete();
			
			if( _transitionAlpha && _transitionDuration > 0 )
			{
				if( _alphaTween != null  ) _alphaTween.stop();
				
 				_alphaTween = new Tween( _dropdownList , "alpha" , _transitionEasing , null , 0 , _transitionDuration );
 				_alphaTween.start();
 				
 				if( _transitionType == ComboBoxTransitionType.NONE ) _alphaTween.addEventListener( TweenEvent.TWEEN_COMPLETE, _dropdownTweenCloseComplete , false , 0 , true );
			}
			
			dispatchEvent( new ComboBoxEvent( ComboBoxEvent.CLOSE ) );
		}
		
		/**
		 * @inheritDoc
		 */
		public function next(  ) : void
		{
			_dropdownList.next();
		}
		
		/**
		 * @inheritDoc
		 */
		public function previous(  ) : void
		{
			_dropdownList.previous();
		}
		/**
		 * @inheritDoc
		 */
		public override function getValue(  ) : *
		{
			var a : Array = _dropdownList.selectedDatas;
			
			return a.length == 0 || a[ 0 ] == null ? _textInput.text : a[ 0 ];
		}
		
		/**
		 * @inheritDoc
		 */
		public override function setValue( value : * ) : void
		{
			switch( true )
			{
				case value is Array : _dropdownList.selectedDatas = value as Array; break;				case value is Number : _dropdownList.selectedIndex = uint( value ); break;				case value is String : _textInput.text = value as String; break;
				case value == null : clearSelection(); break;
			}
		}
		
		/**
		 * @private
		 */
		protected override function _createChildren(  ) : void
		{
			_boxAsset = _comboBoxSkin.getBoxAsset( );			_arrowButtonAsset = _comboBoxSkin.getArrowButtonAsset( );			_textInput = _comboBoxSkin.getTextInputAsset( );			_dropdownList = _comboBoxSkin.getListAsset( );

			_boxAsset.owner = this;
			_textInput.owner = this;
			_dropdownList.owner = this;
			
			addChild( _boxAsset as DisplayObject );
			
			if( _arrowButtonAsset != null )			{
				_arrowButtonAsset.owner = this;
				addChild( _arrowButtonAsset as DisplayObject );			}
			
			addChild( _textInput as DisplayObject );
		}

		/**
		 * @private
		 */
		protected override function _init(  ) : void
		{
			_textInput.textField.addEventListener( Event.CHANGE , _labelChanged , false , 0 , true );			_textInput.textField.addEventListener( KeyboardEvent.KEY_DOWN , _textFieldKeyDown , false , 0 , true );			_textInput.textField.addEventListener( KeyboardEvent.KEY_UP , _textFieldKeyUp , false , 0 , true );
			_textInput.focusEnabled = false;
			
			_textInput.textField.type = TextFieldType.DYNAMIC;
			_textInput.mouseEnabled = _textInput.mouseChildren = _textInput.textField.selectable = false;
			
			_dropdownList.cellCount = 5;
			_dropdownList.addEventListener( MouseEvent.ROLL_OUT , _rollOut, false , 0 , true );
			_dropdownList.addEventListener( ListEvent.SELECTION_CHANGE , _change , false , 0 , true );			_dropdownList.addEventListener( ListEvent.CELL_ADDED , _propagateEvent , false , 0 , true );			_dropdownList.addEventListener( ListEvent.CELL_OVER , _propagateEvent , false , 0 , true );			_dropdownList.addEventListener( ListEvent.CELL_OUT , _propagateEvent , false , 0 , true );			_dropdownList.addEventListener( ListEvent.CELL_CLICK , _closeAndPropagateEvent , false , 0 , true );
			_dropdownList.addEventListener( KeyboardEvent.KEY_DOWN , _keyDown , false , 0 , true );			_dropdownList.addEventListener( FocusEvent.FOCUS_OUT , _focusOut , false , 0 , true );
			_dropdownList.focusTarget = this;			_dropdownList.focusDrawTarget = this;			_dropdownList.tabEnabled = false;
			
			_boxAsset.addEventListener( MouseEvent.CLICK , _toggleOpen , false , 0 , true );
			_boxAsset.focusEnabled = false;
						if( _arrowButtonAsset != null )
			{
				_arrowButtonAsset.addEventListener( MouseEvent.CLICK , _toggleOpen , false , 0 , true );
				_arrowButtonAsset.focusEnabled = false;
			}
			
			addEventListener( FocusEvent.FOCUS_OUT , _focusOut , false , 0 , true );			addEventListener( MouseEvent.ROLL_OUT , _rollOut , false , 0 , true );			addEventListener( KeyboardEvent.KEY_DOWN , _keyDown , false , 0 , true );
			addEventListener( Event.ADDED_TO_STAGE , _added , false , 0 , true );
			addEventListener( Event.REMOVED_FROM_STAGE , _removed , false , 0 , true );
			
			if( stage != null ) _added();
		}
		
		/**
		 * @private
		 */
		protected override function _draw(  ) : void
		{
			if( isInvalidate( InvalidationType.SIZE ) )
			{
				if( _autoSize )
				{
					_width = _getMaxSize();
					_dropdownList.autoSize = true;
					_dropdownList.draw();
					
					_width = Math.max( _width , _dropdownList.width );
				}
				
				if( _boxAsset != null )
				{
					_boxAsset.setSize( _width , _height );
					_boxAsset.draw();
				}
				
				if( _arrowButtonAsset != null )
				{
					_arrowButtonAsset.height = _height;
					_arrowButtonAsset.x = _arrowButtonPosition == ComboBoxArrowButtonPosition.LEFT ? 0 : _width - _arrowButtonAsset.width;
					_arrowButtonAsset.draw();
				}
				
				_textInput.setSize( _width - ( !isNaN( _arrowButtonWidth ) ? _arrowButtonWidth : _arrowButtonAsset != null ? _arrowButtonAsset.width : 0 ) , _height );
				_textInput.x = _arrowButtonPosition == ComboBoxArrowButtonPosition.LEFT ? !isNaN( _arrowButtonWidth ) ? _arrowButtonWidth : _arrowButtonAsset != null ? _arrowButtonAsset.width : 0 : 0;
				_textInput.draw();
				
				 _updateDropdownListSize();
			}
		}
		
		/**
		 * @private
		 */
		protected function _getMaxSize(  ) : Number
		{
			var l : uint = _dropdownList.dataProvider.length;
			var i : int = -1;
			var w : Number = 0;
			
			_textInput.autoSize = true;
			
			var oldText : String = _textInput.text;			var oldIcon : String = _textInput.icon;
			
			while( ++i < l )
			{
				var item : * = _dropdownList.dataProvider.getItemAt( i );
				
				_textInput.text = String( item[ _dropdownList.labelField ] );
				_textInput.icon = item[ _dropdownList.iconField ];
				
				w = Math.max( w , _textInput.width );
			}
			
			_textInput.autoSize = false;
			_textInput.text = oldText;
			_textInput.icon = oldIcon;
			
			return w + ( _arrowButtonAsset != null ? _arrowButtonAsset.width : 0 );
		}
		
		/**
		 * @private
		 */
		protected function _added( e : Event = null ) : void
		{
			stage.addEventListener( MouseEvent.MOUSE_DOWN , _mouseDown , false , 0 , true );
		}
		
		/**
		 * @private
		 */
		protected function _removed( e : Event ) : void
		{
			if( e.target == this )
				stage.removeEventListener( MouseEvent.MOUSE_DOWN , _mouseDown );
		}
		
		/**
		 * @private
		 */
		protected function _rollOut ( e : MouseEvent ) : void
		{
			if( e.relatedObject == null || ( e.relatedObject != _boxAsset && e.relatedObject != _dropdownList && !_dropdownList.contains( e.relatedObject ) ) )
			{
				if( _openMouseAction == ComboBoxOpenMouseAction.ROLL )
				{
					close();
					setFocus();
				}
				
				dispatchEvent( new ComboBoxEvent( ComboBoxEvent.BOX_LIST_ROLL_OUT ) );
			}
		}
		
		/**
		 * @private
		 */
		protected function _change( e : ListEvent ) : void
		{
			if( _dropdownList.selectedIndex != -1 )
			{
				var style : Object = _dropdownList.getCellStyleAt( _dropdownList.selectedIndex );
				
				if( style != null && style.html ) _textInput.htmlText = String( _dropdownList.selectedItem[ _dropdownList.labelField ] );
				else _textInput.text = String( _dropdownList.selectedItem[ _dropdownList.labelField ] );
				
				_textInput.icon = _dropdownList.selectedItem[ _dropdownList.iconField ];
			}
			else
			{
				if( !_autoCompletion || ( _autoCompletion && text == "" ) )
				{
					_textInput.text = _defaultText != null ? _defaultText : "";
				}
				
				_textInput.icon = null;	
			}
			
			_textInput.draw();
			
			_propagateEvent( e );
		}
		
		/**
		 * @private
		 */
		protected function _focusOut( e : FocusEvent ) : void
		{
			if( e.relatedObject == null || ( !contains( e.relatedObject ) && !_dropdownList.contains( e.relatedObject ) && _openMouseAction != ComboBoxOpenMouseAction.ROLL ) )
				close();
		}
		
		/**
		 * @private
		 */
		protected function _mouseDown( e : MouseEvent ) : void
		{
			if( !contains( e.target as DisplayObject ) && !dropdownList.contains( e.target as DisplayObject ) && _openMouseAction != ComboBoxOpenMouseAction.ROLL )
				close();
		}
		
		/**
		 * @private
		 */
		protected function _toggleOpen( e : MouseEvent = null ) : void
		{
			if( _isOpen )
			{
				close();
				setFocus();
			}
			else
			{
				open();
			}
		}
		
		/**
		 * @private
		 */
		protected function _rollOpen( e : MouseEvent ) : void
		{
			open();
		}
		
		/**
		 * @private
		 */
		protected function _propagateEvent( e : Event ) : void
		{
			dispatchEvent( e );
		}
		
		/**
		 * @private
		 */
		protected function _closeAndPropagateEvent( e : ListEvent ) : void
		{
			close();
			setFocus();
			_propagateEvent( e );
		}
		
		/**
		 * @private
		 */
		protected function _drawMask(  ) : void
		{
			var g : Graphics = _dropdownListMask.graphics;
			g.clear();
			g.beginFill( 0x000000 , 1.0 );
			g.drawRect( -50 , 0 , _dropdownList.width + 100 , _dropdownList.height + 50 );
			g.endFill();
		}
		
		/**
		 * @private
		 */
		protected function _initDropdownListForOpening( fromCurrentPosition : Boolean = false ) : Tween
		{
			var p : Point = _boxAsset.localToGlobal( new Point( 0 ,  0 ) );
			
			_dropdownList.x = _dropdownListMask.x = p.x;
			
			_drawMask();
						var finish : Number;
			
			if( _transitionType == ComboBoxTransitionType.ROLL )
			{
				if( !fromCurrentPosition )
					_dropdownList.y = _sens == 1 ? p.y + _height : p.y - _dropdownList.height;
				
				_dropdownListMask.y = _sens == 1 ? p.y + _height - _dropdownListMask.height : p.y;
								
				finish = _sens == 1 ? p.y + _height : p.y - _dropdownListMask.height;
			}
			else
			{
				_transitionType = ComboBoxTransitionType.TRANSLATE;
				
				if( !fromCurrentPosition )
					_dropdownList.y = _sens == 1 ? p.y + _height - _dropdownList.height : p.y;
					
				_dropdownListMask.y = _sens == 1 ? p.y + _height : p.y - _dropdownListMask.height;
				
				finish = _sens == 1 ? p.y + _height : p.y - _dropdownList.height;	
			}
			
			
			var t : Tween = new Tween( 	_transitionType == ComboBoxTransitionType.ROLL ? _dropdownListMask : _dropdownList ,
										"y" , _transitionEasing , null , finish , _transitionDuration );
										
			_dropdownList.mask = _dropdownListMask;
			
			return t;
		}
		
		/**
		 * @private
		 */
		protected function _initDropdownListForClosing(  ) : Tween
		{
			var finish : Number;
			var p : Point = _boxAsset.localToGlobal( new Point( 0 , 0 ) );
			
			if( _transitionType == ComboBoxTransitionType.ROLL ) finish = _sens == 1 ? p.y + _height - _dropdownListMask.height : p.y;
			else finish = _sens == 1 ? p.y + _height - _dropdownList.height : p.y + _height;	
			
			var t : Tween = new Tween( 	_transitionType == ComboBoxTransitionType.ROLL ? _dropdownListMask : _dropdownList ,
										"y" , _transitionEasing , null , finish , _transitionDuration );
										
			return t;
		}

		/**
		 * @private
		 */
		protected function _updateDropdownListSize(  ) : void
		{
			var p : Point = _boxAsset.localToGlobal( new Point( 0 ,  0 ) );
			
			switch( _dropdownWidthType )
			{
				case ComboBoxDropdownWidthType.NONE : 
					_dropdownList.autoSize = false;	
					_dropdownList.width = isNaN( _dropdownWidth ) ? _width : _dropdownWidth;
					_dropdownList.x = _dropdownListMask.x = p.x;
					break;	
					
				case ComboBoxDropdownWidthType.PERCENTAGE : 
					_dropdownList.autoSize = false;	
					_dropdownList.width = isNaN( _dropdownWidth ) ? _width : _width * _dropdownWidth / 100;
					_dropdownList.x = _dropdownListMask.x = p.x;
					break;	
					
				case ComboBoxDropdownWidthType.ARROW_BUTTON : 
					_dropdownList.autoSize = false;	
					_dropdownList.width = _width - ( !isNaN( _arrowButtonWidth ) ? _arrowButtonWidth : _arrowButtonAsset != null ? _arrowButtonAsset.width : 0 );
					_dropdownList.x = _arrowButtonPosition == ComboBoxArrowButtonPosition.LEFT ? ( !isNaN( _arrowButtonWidth ) ? p.x + _arrowButtonWidth : _arrowButtonAsset != null ? p.x + _arrowButtonAsset.width : p.x ) : p.x;
					break;	
					
				case ComboBoxDropdownWidthType.AUTOSIZE : 
					_dropdownList.autoSize = true;
					_dropdownList.x = _dropdownListMask.x = p.x;
					break;	
			}
			
			_dropdownList.draw();
		}
		
		/**
		 * @private
		 */
		protected function _dropdownTweenOpenComplete( e : TweenEvent = null ) : void
		{
			dispatchEvent( new ComboBoxEvent( ComboBoxEvent.OPEN_COMPLETE ) );
		}
		
		/**
		 * @private
		 */
		protected function _dropdownTweenCloseComplete( e : TweenEvent = null ) : void
		{
			_dropdownListMask.stage.removeChild( _dropdownListMask );
			_dropdownList.stage.removeChild( _dropdownList as DisplayObject );
			
			_dropdownList.alpha = 1;
			_dropdownList.mask = null;
			
			dispatchEvent( new ComboBoxEvent( ComboBoxEvent.CLOSE_COMPLETE ) );
		}
		
		/**
		 * @private
		 */
		protected function _textFieldKeyDown ( e : KeyboardEvent ) : void
		{
			_keyBackDelete = e.keyCode == Keyboard.DELETE || e.keyCode == Keyboard.BACKSPACE;
		}

		/**
		 * @private
		 */
		protected function _textFieldKeyUp ( e : KeyboardEvent ) : void
		{
			_keyBackDelete = false;
		}
		
		/**
		 * @private
		 */
		protected function _labelChanged ( e : Event = null ) : void
		{
			if( !_autoCompletion )
			{
				_dropdownList.clearSelection( );
				return;
			}
			
			var textLength : uint = _textInput.text.length;
			
			if( textLength == 0 )
			{
				_dropdownList.clearFilter();
				_dropdownList.draw();
				_updatePosition( );
				return;	
			}
			
			var a : Array = _dropdownList.filter( _filter );
			var itemsLength : uint = a == null ? 0 : a.length;
			
			if( itemsLength == 0 && !_allowCustomEditableText )
			{
				_textInput.text = _textInput.text.substr( 0 , textLength - 1 );
				
				_labelChanged();
				return;
			}
			
			var h : Number = _dropdownList.height;
			_dropdownList.draw();
			
			a = getVisibleCells( );
			
			if( a.length )
			{
				if( !_keyBackDelete )
				{
					var startIndex : uint = _textInput.textField.length;
					
					_dropdownList.selectedItem = ( a[ 0 ] as ICellRenderer ).data;
					_textInput.textField.setSelection( startIndex , _textInput.textField.length );
				}
				else _dropdownList.clearSelection();
			}
			else _dropdownList.clearSelection();
					
			_drawMask();
			
			if( !_isOpen && itemsLength > 1 ) open( );
			else if( itemsLength <= 1 )
			{
				close();
				setFocus();
			}
			else if( h != _dropdownList.height ) _updatePosition( );
		}
		
		/**
		 * @private
		 */
		protected function _updatePosition(  ) : void
		{
			var p : Point = _boxAsset.localToGlobal( new Point( 0 ,  0 ) );
			
			// make sure open direction is valid and dropdown list will visible in stage area, if not change direction
			if( _sens == 1 && p.y + _height + _dropdownList.height > stage.stageHeight && p.y - _dropdownList.height >= 0 )
			{
				_sens = -1;
				dispatchEvent( new ComboBoxEvent( ComboBoxEvent.OPEN_DIRECTION_CHANGE ) );
			}
			if( _sens == -1 && p.y - _dropdownList.height < 0 && p.y + _height + _dropdownList.height <= stage.stageHeight )
			{
				_sens = 1;
				dispatchEvent( new ComboBoxEvent( ComboBoxEvent.OPEN_DIRECTION_CHANGE ) );
			}
			
			if( _tween != null ) _tween.stop();
			
			if( _transitionType != ComboBoxTransitionType.NONE && _transitionDuration > 0 )
			{
				_tween = _openFunction != null && _transitionType == ComboBoxTransitionType.CUSTOM ? _openFunction() : _initDropdownListForOpening( true );
				_tween.start( );
			}
			else
			{
				_dropdownList.x = p.x;	
				_dropdownList.y = _sens == 1 ? p.y + _height : p.y - _dropdownList.height;	
				
				_dropdownList.mask = null;
			}
		}
		
		/**
		 * @private
		 */
		protected function _filter( item : * , ...arguments : Array ) : Boolean
		{
			var b1 : Boolean = !_hideSelectedCell || _dropdownList.selectedItem != item;
			var b2 : Boolean = !_autoCompletion || String( item[ _dropdownList.labelField ] ).toLowerCase( ).indexOf( _textInput.text.toLowerCase( ) ) == 0;
			
			return b1 && b2;
		}

		/**
		 * @private
		 */
		protected function _keyDown ( e : KeyboardEvent ) : void
		{			if ( _editable && ( e.keyCode != Keyboard.UP && e.keyCode != Keyboard.DOWN &&
								e.keyCode != Keyboard.PAGE_UP && e.keyCode != Keyboard.PAGE_DOWN &&
								e.keyCode != Keyboard.HOME && e.keyCode != Keyboard.END && e.keyCode != Keyboard.ENTER ) ) return;
			
			switch ( e.keyCode )
			{
				case Keyboard.SPACE : _toggleOpen(); break;
				case Keyboard.ENTER : dispatchEvent( new ComponentEvent( ComponentEvent.ENTER ) );
				case Keyboard.ESCAPE : close(); setFocus(); break;
				default : if( e.currentTarget != _dropdownList ) _dropdownList.keyDown( e ); break;
			}
		}
	}
}
