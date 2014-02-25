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
	import myLib.assets.Asset;
	import myLib.assets.IAsset;
	import myLib.colors.Colorize;
	import myLib.colors.colorSpaces.RGBColor;
	import myLib.controls.skins.IColorPickerSkin;
	import myLib.controls.skins.my_skinset;
	import myLib.core.AFieldComponent;
	import myLib.core.InvalidationType;
	import myLib.displayUtils.AlignmentManager;
	import myLib.displayUtils.AlignmentPoint;
	import myLib.displayUtils.DepthManager;
	import myLib.displayUtils.FocusGroup;
	import myLib.events.ColorPickerEvent;
	import myLib.form.IField;
	import myLib.styles.Padding;

	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Graphics;
	import flash.display.InteractiveObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.FocusEvent;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.events.TextEvent;
	import flash.text.TextField;
	import flash.ui.Keyboard;
	import flash.utils.Dictionary;

    /**
     * Defines the value of the type property of a colorChange event object.
     * 
     * @eventType colorChange
     */
    [Event(name="colorChange", type="myLib.events.ColorPickerEvent")]
	
	/**
	 * Defines the value of the type property of a open event object.
	 * 
	 * @eventType open
	 */
    [Event(name="open", type="myLib.events.ColorPickerEvent")]
    
    /**
	 * Defines the value of the type property of a close event object.
	 * 
	 * @eventType close
	 */
    [Event(name="close", type="myLib.events.ColorPickerEvent")]
    
	/**
	 * @author SamYStudiO
	 */
	public class ColorPicker extends AFieldComponent implements IColorPicker, IField 
	{
		/**
		 * @private
		 */
		protected static var __DEFAULT_COLOR_MAP : Array;
		
		/**
		 * @private
		 */
		protected var _colorPickerSkin : IColorPickerSkin;
		
		/**
		 * @private
		 */
		protected var _swatches : Sprite;
		
		/**
		 * @private
		 */
		protected var _swatchToColor : Dictionary = new Dictionary( true );
		
		/**
		 * @private
		 */
		protected var _swatchToRow : Dictionary = new Dictionary( true );
		
		/**
		 * @private
		 */
		protected var _swatchToColumn : Dictionary = new Dictionary( true );
		
		/**
		 * @private
		 */
		protected var _coordinateToSwatch : Dictionary = new Dictionary( true );
		
		/**
		 * @private
		 */
		protected var _colorToSwatch : Dictionary = new Dictionary( true );
		
		/**
		 * @private
		 */
		protected var _background : BitmapData;
		
		/**
		 * @private
		 */
		protected var _selectedSwatch : Sprite;
		
		/**
		 * @private
		 */
		protected var _currentSwatchOver : Sprite;
		
		/**
		 * @private
		 */
		protected override function get _defaultWidth() : Number
		{
			return 20;	
		}
		
		/**
		 * @private
		 */
		protected var _selectedColor : uint;
		
		[Inspectable(type="Color",defaultValue="#000000")]
		/**
		 * @inheritDoc
		 */
		public function get selectedColor() : uint
		{
			return _selectedColor;
		}
		
		public function set selectedColor( n : uint ) : void
		{
			if( _selectedColor == n || ( _inspector && !_isLivePreview && _selectedColor != 0x000000 ) ) return;
			
			_selectedColor = Math.min( n , 0xFFFFFF );
			
			if( _selectedSwatch == null || _swatchToColor[ _selectedSwatch ] != _selectedColor )
				_selectedSwatch = _colorToSwatch[ _selectedColor ];
				
			Colorize.tint( _colorWell as DisplayObject , _selectedColor );
			
			if( _selectedSwatch != null )
				_displaySwatch( _selectedSwatch );
			else
				_displayColor( _selectedColor );
			
			dispatchEvent( new ColorPickerEvent( ColorPickerEvent.COLOR_CHANGE ) );
		}

		/**
		 * @private
		 */
		protected var _colorMap : Array;
		
		/**
		 * @inheritDoc
		 */
		public function get colorMap() : Array
		{
			return _colorMap == null ? __DEFAULT_COLOR_MAP : _colorMap;
		}
		
		public function set colorMap( map : Array ) : void
		{
			if( _colorMap == map ) return;
			
			_colorMap = map;
			
			invalidate( InvalidationType.DATA );
		}
		
		/**
		 * @private
		 */
		protected var _swatchWidth : Number = 10;
		
		[Inspectable(defaultValue=10)]
		/**
		 * @inheritDoc
		 */
		public function get swatchWidth() : Number
		{
			return _swatchWidth;
		}
		
		public function set swatchWidth( n : Number ) : void
		{
			if( _swatchWidth == n || ( _inspector && !_isLivePreview && _swatchWidth != 10 ) ) return;
			
			_swatchWidth = Math.abs( n );
			
			invalidate( InvalidationType.DATA );
		}
		
		/**
		 * @private
		 */
		protected var _swatchHeight : Number = 10;
		
		[Inspectable(defaultValue=10)]
		/**
		 * @inheritDoc
		 */
		public function get swatchHeight() : Number
		{
			return _swatchHeight;
		}
		
		public function set swatchHeight( n : Number ) : void
		{
			if( _swatchHeight == n || ( _inspector && !_isLivePreview && _swatchHeight != 10 ) ) return;
			
			_swatchHeight = Math.abs( n );
			
			invalidate( InvalidationType.DATA );
		}
		
		/**
		 * @private
		 */
		protected var _swatchBorderColor : uint = 0x000000;
		
		[Inspectable(type="Color",defaultValue="#000000")]
		/**
		 * @inheritDoc
		 */
		public function get swatchBorderColor() : uint
		{
			return _swatchBorderColor;
		}
		
		public function set swatchBorderColor( n : uint ) : void
		{
			if( _swatchBorderColor == n || ( _inspector && !_isLivePreview && _swatchBorderColor != 0x000000 ) ) return;
			
			_swatchBorderColor = n;
			
			invalidate( InvalidationType.DATA );
		}
		
		/**
		 * @private
		 */
		protected var _swatchBorderSelectedColor : uint = 0xFFFFFF;
		
		[Inspectable(type="Color",defaultValue="#FFFFFF")]
		/**
		 * @inheritDoc
		 */
		public function get swatchBorderSelectedColor() : uint
		{
			return _swatchBorderSelectedColor;
		}
		
		public function set swatchBorderSelectedColor( n : uint ) : void
		{
			if( _swatchBorderSelectedColor == n || ( _inspector && !_isLivePreview && _swatchBorderSelectedColor != 0xFFFFFF ) ) return;
			
			_swatchBorderSelectedColor = n;
			
			invalidate( InvalidationType.DATA );
		}
		
		/**
		 * @private
		 */
		protected var _swatchBorderThickness : Number = 1;
		
		[Inspectable(defaultValue=1)]
		/**
		 * @inheritDoc
		 */
		public function get swatchBorderThickness() : Number
		{
			return _swatchBorderThickness;
		}
		
		public function set swatchBorderThickness( n : Number ) : void
		{
			if( _swatchBorderThickness == n || ( _inspector && !_isLivePreview && _swatchBorderThickness != 1 ) ) return;
			
			_swatchBorderThickness = n;
			
			invalidate( InvalidationType.DATA );
		}
		
		/**
		 * @private
		 */
		protected var _paletteContentPadding : Padding = new Padding( 5 , 5 , 5 , 5 );
		
		/**
		 * @inheritDoc
		 */
		public function get paletteContentPadding() : Padding
		{
			return _paletteContentPadding == null ? new Padding( 5 , 5 , 5 , 5 ) : _paletteContentPadding;
		}
		
		public function set paletteContentPadding( padding : Padding ) : void
		{
			if( padding == _paletteContentPadding ) return;
			
			_paletteContentPadding = padding;
			
			invalidate( InvalidationType.DATA );
		}
		
		[Inspectable(name="paletteContentPadding",type="Object",defaultValue="left:5,top:5,right:5,bottom:5")]
		/**
		 * @private
		 */
		public function set inspectablePaletteContentPadding( padding : Object ) : void
		{
			if( !_inspector && !_isLivePreview ) throw new Error( this + " inspectablePaletteContentPadding property is internal and used by Flash component inspector panel , use paletteContentPadding property instead" );
			
			if( _inspector && !_isLivePreview && ( _paletteContentPadding.left != 5 || _paletteContentPadding.top != 5 || _paletteContentPadding.right != 5 || _paletteContentPadding.bottom != 5 ) ) return;
			
			paletteContentPadding = new Padding( padding.left , padding.top , padding.right , padding.bottom );
		}
		
		/**
		 * @private
		 */
		protected var _openDirection : String = ColorPickerOpenDirection.RIGHT;
		
		[Inspectable(defaultValue="right",enumeration="left,up,right,bottom")]
		/**
		 * @inheritDoc
		 */
		public function get openDirection() : String
		{
			return _openDirection;
		}
		
		public function set openDirection( direction : String ) : void
		{
			if( _inspector && !_isLivePreview && _openDirection != ColorPickerOpenDirection.RIGHT ) return;
			
			_openDirection = direction;
		}
		
		/**
		 * @private
		 */
		protected var _openPoint : String = AlignmentPoint.TOP_LEFT;

		[Inspectable(defaultValue="TL",enumeration="TL,T,TR,R,BR,B,BL,L,C")]
		/**
		 * @inheritDoc
		 */
		public function get openPoint() : String
		{
			return _openPoint;
		}
		
		public function set openPoint( point : String ) : void
		{
			if( _inspector && !_isLivePreview && _openPoint != AlignmentPoint.TOP_LEFT ) return;
			
			_openPoint = point;
		}
		
		/**
		 * @private
		 */
		protected var _openPadding : Padding = new Padding( 5 , 5 , 5 , 5 );
		
		/**
		 * @inheritDoc
		 */
		public function get openPadding() : Padding
		{
			return _openPadding == null ? new Padding( 5 , 5 , 5 , 5 ) : _openPadding;
		}
		
		public function set openPadding( padding : Padding ) : void
		{
			_openPadding = padding;
		}
		
		[Inspectable(name="openPadding",type="Object",defaultValue="left:5,top:5,right:5,bottom:5")]
		/**
		 * @private
		 */
		public function set inspectableOpenPadding( padding : Object ) : void
		{
			if( !_inspector && !_isLivePreview ) throw new Error( this + " inspectableOpenPadding property is internal and used by Flash component inspector panel , use openPadding property instead" );
			
			if( _inspector && !_isLivePreview && ( _openPadding.left != 5 || _openPadding.top != 5 || _openPadding.right != 5 || _openPadding.bottom != 5 ) ) return;
			
			openPadding = new Padding( padding.left , padding.top , padding.right , padding.bottom );
		}
		
		/**
		 * @private
		 */
		protected var _showPaletteColorWell : Boolean = true;
		
		[Inspectable(defaultValue=true)]
		/**
		 * @inheritDoc
		 */
		public function get showPaletteColorWell() : Boolean
		{
			return _showPaletteColorWell;
		}
		
		public function set showPaletteColorWell( b : Boolean ) : void
		{
			if( _showPaletteColorWell == b || ( _inspector && !_isLivePreview && !_showPaletteColorWell ) ) return;
			
			_showPaletteColorWell = b;
			
			invalidate( InvalidationType.DATA );
		}
		
		/**
		 * @private
		 */
		protected var _showPaletteTextField : Boolean = true;
		
		[Inspectable(defaultValue=true)]
		/**
		 * @inheritDoc
		 */
		public function get showPaletteTextField() : Boolean
		{
			return _showPaletteTextField;
		}
		
		public function set showPaletteTextField( b : Boolean ) : void
		{
			if( _showPaletteTextField == b || ( _inspector && !_isLivePreview && !_showPaletteTextField ) ) return;
			
			_showPaletteTextField = b;
			
			invalidate( InvalidationType.DATA );
		}
		
		/**
		 * @private
		 */
		protected var _paletteTextFieldEditable : Boolean = true;
		
		[Inspectable(defaultValue=true)]
		/**
		 * @inheritDoc
		 */
		public function get paletteTextFieldEditable() : Boolean
		{
			return _paletteTextFieldEditable;
		}
		
		public function set paletteTextFieldEditable( b : Boolean ) : void
		{
			if( _inspector && !_isLivePreview && !_paletteTextFieldEditable ) return;
			
			_paletteTextFieldEditable = b;
			
			_paletteTextInput.textField.selectable = b;
		}
		
		/**
		 * @private
		 */
		protected var _captureBackgroundColor : Boolean;
		
		[Inspectable]
		/**
		 * @inheritDoc
		 */
		public function get captureBackgroundColor() : Boolean
		{
			return _captureBackgroundColor;
		}
		
		public function set captureBackgroundColor( b : Boolean ) : void
		{
			if( _inspector && !_isLivePreview && _captureBackgroundColor ) return;
			
			_captureBackgroundColor = b;
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
		protected var _colorWellButton : IAsset;
		
		/**
		 * @inheritDoc
		 */
		public function get colorWellButton() : IAsset
		{
			return _colorWellButton;
		}
		
		/**
		 * @private
		 */
		protected var _colorWell : IAsset;
		
		/**
		 * @inheritDoc
		 */
		public function get colorWell() : IAsset
		{
			return _colorWell;
		}
				
		/**
		 * @private
		 */
		protected var _palette : IAsset;
		
		/**
		 * @inheritDoc
		 */
		public function get palette() : IAsset
		{
			return _palette;
		}
		
		/**
		 * @private
		 */
		protected var _paletteTextInput : ITextInput;
		
		/**
		 * @inheritDoc
		 */
		public function get paletteTextInput () : ITextInput
		{
			return _paletteTextInput;
		}
		
		/**
		 * @private
		 */
		protected var _paletteColorWell : IAsset;
		
		/**
		 * @inheritDoc
		 */
		public function get paletteColorWell() : IAsset
		{
			return _paletteColorWell;
		}
		
		/**
		 * @private
		 */
		protected var _paletteBackground : IAsset;
		
		/**
		 * @inheritDoc
		 */
		public function get paletteBackground() : IAsset
		{
			return _paletteBackground;
		}
		
		/**
		 * @private
		 */
		protected var _paletteColorWellBorder : IAsset;
		
		/**
		 * @inheritDoc
		 */
		public function get paletteColorWellBorder() : IAsset
		{
			return _paletteColorWellBorder;
		}
		
		/**
		 * Build a new ColorPicker instance. Default size is 20*20.
		 * @param parentContainer The parent DisplayObjectContainer where add this ColorPicker.
		 * @param initStyle The initial style object for ColorPicker initialization.
		 * @param skin The IColorPickerSkin to use instead of default skin.
		 * 
		 * @see myLib.styles.StyleManager
		 */
		public function ColorPicker( parentContainer : DisplayObjectContainer = null , initStyle : Object = null , skin : IColorPickerSkin = null )
		{
			_colorPickerSkin = skin == null ? my_skinset.getColorPickerSkin() : skin;
			
			super( parentContainer , initStyle , _colorPickerSkin );
		}
		
		/**
		 * @inheritDoc
		 */
		public function open(  ) : void
		{
			if( _isOpen ) return;
			
			if( _selectedSwatch != null )
				_displaySwatch( _selectedSwatch );
			else
				_displayColor( _selectedColor );
			
			var padding : Padding = openPadding;
			var offset : Number;
			var redrawFocus : Boolean = false;
			
			if( _isFocused )
			{
				redrawFocus = true;
				drawFocus( false );
			}
			
			switch( true ) 
			{
				case _openDirection == ColorPickerOpenDirection.LEFT :
				
					offset = _openPoint == AlignmentPoint.CENTER ? _height / 2 : _openPoint.indexOf( AlignmentPoint.TOP ) == 0 ? 0 : _openPoint.indexOf( AlignmentPoint.BOTTOM ) >= 0 ? _height : _height / 2;
					
					AlignmentManager.move( _palette as DisplayObject , _openPoint , _openPoint == AlignmentPoint.CENTER ? stageX + _width / 2 : stageX - padding.left , stageY + offset , stage );
					
					break;
					
				case _openDirection == ColorPickerOpenDirection.TOP :
				
					offset = _openPoint == AlignmentPoint.CENTER ? _width / 2 : _openPoint.indexOf( AlignmentPoint.LEFT ) >= 0 ? 0 : _openPoint.indexOf( AlignmentPoint.RIGHT ) >=0 ? _width : _width / 2;
				
					AlignmentManager.move( _palette as DisplayObject , _openPoint , stageX + offset , _openPoint == AlignmentPoint.CENTER ? stageY + _height / 2 : stageY - _palette.height - padding.top , stage );
					break;
					
				case _openDirection == ColorPickerOpenDirection.BOTTOM :
				
					offset = _openPoint == AlignmentPoint.CENTER ? _width / 2 : _openPoint.indexOf( AlignmentPoint.LEFT ) >= 0 ? 0 : _openPoint.indexOf( AlignmentPoint.RIGHT ) >=0 ? _width : _width / 2;
				
					AlignmentManager.move( _palette as DisplayObject , _openPoint , stageX + offset , _openPoint == AlignmentPoint.CENTER ? stageY + _height / 2 : stageY + padding.bottom , stage );
					break;
					
				default :
				
					_openDirection = ColorPickerOpenDirection.RIGHT;
					
					offset = _openPoint == AlignmentPoint.CENTER ? _height / 2 : _openPoint.indexOf( AlignmentPoint.TOP ) == 0 ? 0 : _openPoint.indexOf( AlignmentPoint.BOTTOM ) >=0 ? _height : _height / 2;
					
					AlignmentManager.move( _palette as DisplayObject , _openPoint , _openPoint == AlignmentPoint.CENTER ? stageX + _width / 2 : stageX + _width + padding.right , stageY + offset , stage );
					break;
			}
			
			if( redrawFocus ) drawFocus( true );
			
			_palette.x = Math.max( 0 , Math.min( stage.stageWidth - _palette.width , _palette.x ) );			_palette.y = Math.max( 0 , Math.min( stage.stageHeight - _palette.height , _palette.y ) );
			
			stage.addChild( _palette as DisplayObject );
						stage.addEventListener( MouseEvent.MOUSE_MOVE , _stageMove , false , 0 , true );			
			_isOpen = true;
			
			_focusTarget = _paletteTextInput as InteractiveObject;
			_paletteTextInput.setFocus();
			
			dispatchEvent( new ColorPickerEvent( ColorPickerEvent.OPEN ) );
			
			if( _captureBackgroundColor )
			{
				_background = new BitmapData( stage.stageWidth , stage.stageHeight , true , 0x000000 );
				_background.draw( stage );
				stage.addEventListener( MouseEvent.MOUSE_DOWN , _stageClick , true , 0 , true );
			}
			else
			{
				_background = null;
				stage.removeEventListener( MouseEvent.MOUSE_DOWN , _stageClick );
			}
		}
		
		/**
		 * @inheritDoc
		 */
		public function close(  ) : void
		{
			if( !_isOpen ) return;
			
			_focusTarget = null;
			_palette.stage.removeChild( _palette as DisplayObject );
			_isOpen = false;
			
			dispatchEvent( new ColorPickerEvent( ColorPickerEvent.CLOSE ) );
		}
		
		/**
		 * @inheritDoc
		 */
		public override function getValue() : *
		{
			return _selectedColor;
		}
		
		/**
		 * @inheritDoc
		 */
		public override function setValue( value : * ) : void
		{
			selectedColor = uint( value );
		}
		
		/**
		 * @private
		 */
		protected override function _createChildren(  ) : void
		{
			_colorWellButton = _colorPickerSkin.getButtonAsset( );
			_colorWell = _colorPickerSkin.getColorWellAsset();
			
			_colorWellButton.owner = this;
			_colorWell.owner = this;
			
			addChild( _colorWell as DisplayObject );			addChild( _colorWellButton as DisplayObject );
			
			_paletteBackground = _colorPickerSkin.getPaletteBackgroundAsset( );
			_paletteColorWell = _colorPickerSkin.getPaletteColorWellAsset( );
			_paletteColorWellBorder = _colorPickerSkin.getPaletteColorWellBorderAsset( );
			_paletteTextInput = _colorPickerSkin.getTextInputAsset( );
			
			_paletteBackground.owner = this;
			_paletteColorWell.owner = this;
			if( _paletteColorWellBorder!= null ) _paletteColorWellBorder.owner = this;
			_paletteTextInput.owner = this;
			
			_palette = new Asset();
			_palette.owner = this;
			
			_palette.addChild( _paletteBackground as DisplayObject );
			_palette.addChild( _paletteColorWell as DisplayObject );
			if( _paletteColorWellBorder!= null ) _palette.addChild( _paletteColorWellBorder as DisplayObject );
			_palette.addChild( _paletteTextInput as DisplayObject );
		}

		/**
		 * @private
		 */
		protected override function _init(  ) : void
		{
			if( __DEFAULT_COLOR_MAP == null )
			{
				__DEFAULT_COLOR_MAP = new Array(  );
				
				var a : Array;
				var b : Array = new Array( 0x000000 , 0x333333 , 0x666666 , 0x999999 , 0xCCCCCC , 0xFFFFFF , 0xFF0000 , 0x00FF00 , 0x0000FF , 0xFFFF00 , 0x00FFFF , 0xFF00FF );
				
				for( var i : uint = 0; i < 216; i++ )
				{
					if( i % 18 == 0 )
					{
						a = new Array( 0x000000 , b [ __DEFAULT_COLOR_MAP.length ] , 0x000000 );
						
						__DEFAULT_COLOR_MAP.push( a );
					}
					
					a.push( ( ( i / 6 % 3 << 0 ) + ( ( i / 108 ) << 0 ) * 3 ) * 0x33 << 16 | i % 6 * 0x33 << 8 | ( i / 18 << 0 ) % 6 * 0x33 );
				}
			}
			
			_colorWell.focusEnabled = false;
						_colorWellButton.focusEnabled = false;
			_colorWellButton.addEventListener( MouseEvent.CLICK , _toggleOpen , false , 0 , true );
	
			_palette.tabChildren = false;			_palette.focusEnabled = false;			
			if( FocusGroup.DEFAULT_FOCUS_GROUP != null ) _added();
			else addEventListener( Event.ADDED_TO_STAGE , _added , false , 0 , true );
			
			_paletteColorWell.visible = _showPaletteColorWell;
			if( _paletteColorWellBorder != null ) _paletteColorWellBorder.visible = _showPaletteColorWell;
			
			_paletteBackground.focusEnabled = true;
			
			_paletteTextInput.focusDrawTarget = this;
			_paletteTextInput.visible = _showPaletteTextField;
			_paletteTextInput.addEventListener( Event.CHANGE , _colorChanged , false , 0 , true );
			_paletteTextInput.addEventListener( TextEvent.TEXT_INPUT , _inputChanged , false , 0 , true );
			_paletteTextInput.addEventListener( FocusEvent.FOCUS_OUT , _focusOut , false , 0 , true );
			_paletteTextInput.textField.addEventListener( KeyboardEvent.KEY_DOWN , _keyDown , false , 0 , true );
			_paletteTextInput.restrict = "#A-Fa-f0-9";
			_paletteTextInput.autoSize = true;
			_paletteTextInput.text = "#CCCCCC ";
			_paletteTextInput.autoSize = false;
			_paletteTextInput.height = _paletteColorWellBorder != null ? _paletteColorWellBorder.height || _paletteColorWell.height : _paletteColorWell.height;
		
			addEventListener( FocusEvent.FOCUS_OUT , _focusOut , false , 0 , true );
			addEventListener( KeyboardEvent.KEY_DOWN , _keyDown , false , 0 , true );
			
			_displayColor( _selectedColor );
		}
		
		/**
		 * @private
		 */
		protected function _added( e : Event = null ) : void
		{
			var g : FocusGroup = FocusGroup.getGroupFromFocusable( _palette as InteractiveObject );
			
			if( g == null || g == FocusGroup.DEFAULT_FOCUS_GROUP ) FocusGroup.DEFAULT_FOCUS_GROUP.addItem( _palette );
		}

		/**
		 * @private
		 */
		protected override function _draw(  ) : void
		{
			if( isInvalidate( InvalidationType.SIZE ) )
			{
				_colorWellButton.setSize( _width , _height );
				_colorWellButton.draw();				_colorWell.setSize( _width , _height );
				_colorWell.draw();
			}
			
			if( isInvalidate( InvalidationType.DATA ) || !_isInitialized )
			{
				if( stage != null && _palette != null && stage.contains( _palette as DisplayObject ) ) stage.removeChild( _palette as DisplayObject );
				
				if( _swatches != null && _palette.contains( _swatches ) ) _palette.removeChild( _swatches );
			
				_drawSwatches();
				
				_paletteColorWell.visible = _showPaletteColorWell;
				if( _paletteColorWellBorder != null ) _paletteColorWellBorder.visible = _showPaletteColorWell;
				
				var padding : Padding = paletteContentPadding;
				
				_paletteColorWell.x = padding.left;
				_paletteColorWell.y = _paletteTextInput.y = padding.top;
				
				if (_paletteColorWellBorder != null )
				{
					_paletteColorWellBorder.x = padding.left;
					_paletteColorWellBorder.y = _paletteTextInput.y = padding.top;
				}
				
				_paletteTextInput.visible = _showPaletteTextField;
				_paletteTextInput.x = _showPaletteColorWell ? _paletteColorWell.x + _paletteColorWell.width + padding.left : padding.left;
				
				_swatches.x = padding.left;
				_swatches.y = _showPaletteColorWell || _showPaletteTextField ? _paletteColorWell.height + padding.top * 2 : padding.top;				
				var headerWidth : Number = ( _showPaletteColorWell ? _paletteColorWell.width : 0 ) + ( _showPaletteTextField ? _paletteTextInput.width : 0 ) + ( _showPaletteColorWell && _showPaletteTextField ? padding.left : 0 );
								_paletteBackground.setSize( padding.left + padding.right + Math.max( _swatches.width , headerWidth ) , 
											padding.top + padding.bottom + _swatches.height + ( _showPaletteColorWell || _showPaletteTextField ? _paletteColorWell.height + padding.top : 0 ) );
				_paletteBackground.draw();
				
				_palette.setSize( _paletteBackground.width , _paletteBackground.height );
				_palette.addChild( _swatches );
			}
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
			else open();
		}
		
		/**
		 * @private
		 */
		protected function _drawSwatches(  ) : void
		{
			_swatches = new Sprite();
			
			var l : uint = colorMap.length;
			
			for( var i : uint = 0; i < l; i++ ) 
			{
				var row : Array = colorMap[ i ] as Array;
				
				if( row == null ) continue;
				
				var rowLength : uint = row.length;
				
				for( var j : uint = 0; j < rowLength; j++ ) 
				{
					var s : Sprite = new Sprite();
					var color : uint = uint( row[ j ] );
					
					if( _selectedSwatch == null && color == _selectedColor ) _selectedSwatch = s;
					
					_swatchToColor[ s ] = color;
					_swatchToRow[ s ] = i;					_swatchToColumn[ s ] = j;
					_coordinateToSwatch[ String( i ) + "_" + String( j ) ] = s;
					
					if( _colorToSwatch[ color ] == undefined ) _colorToSwatch[ color ] = s;
					
					_drawSwatchGraphics( s );
										s.addEventListener( MouseEvent.ROLL_OVER , _swatchOver , false , 0 , true );					s.addEventListener( MouseEvent.ROLL_OUT , _swatchOut , false , 0 , true );
					s.addEventListener( MouseEvent.CLICK , _swatchClick , false , 0 , true );
										s.x = j * ( _swatchWidth - _swatchBorderThickness );
					s.y = i * ( _swatchHeight - _swatchBorderThickness );
					
					_swatches.addChild( s );
				}
			}
		}
		
		/**
		 * @private
		 */
		protected function _drawSwatchGraphics( swatch : Sprite , selected : Boolean = false ) : void
		{
			if( _currentSwatchOver != null && selected ) _drawSwatchGraphics( _currentSwatchOver );
			
			var g : Graphics = swatch.graphics;
			
			g.clear();	
			g.beginFill( selected ? _swatchBorderSelectedColor : _swatchBorderColor , 1 );
			g.drawRect( 0 , 0 , _swatchWidth , _swatchHeight );
			g.beginFill( uint( _swatchToColor[ swatch ] ) , 1 );
			g.drawRect( _swatchBorderThickness , _swatchBorderThickness , _swatchWidth - _swatchBorderThickness * 2 , _swatchHeight - _swatchBorderThickness * 2 );
			g.endFill();
			
			if( selected ) DepthManager.bringFront( swatch );
			
			_currentSwatchOver = selected ? swatch : null;
		}
		
		/**
		 * @private
		 */
		protected function _displaySwatch( swatch : Sprite ) : void
		{
			if( swatch == null ) return;
			
			var color : uint = _swatchToColor[ swatch ];
			
			_drawSwatchGraphics( swatch , true );
			
			_updateWellAndTextField( color );
		}
		
		/**
		 * @private
		 */
		protected function _displayColor( color : uint , noTextUpdate : Boolean = false ) : void
		{
			var swatch : Sprite = _colorToSwatch[ color ];
		
			if( swatch != null )
			{
				_drawSwatchGraphics( swatch , true );
			}
			else if( _currentSwatchOver != null )
			{
				_drawSwatchGraphics( _currentSwatchOver );
			}
			
			_updateWellAndTextField( color , noTextUpdate);
		}
		
		/**
		 * @private
		 */
		protected function _updateWellAndTextField( color : uint , noTextUpdate : Boolean = false ) : void
		{
			if( !_showPaletteColorWell || !_isOpen )
				Colorize.tint( _colorWell as DisplayObject , color );
				
			Colorize.tint( _paletteColorWell as DisplayObject , color );
			
			if( !noTextUpdate )
				_paletteTextInput.text = new RGBColor( color ).toHex( "#" ).toUpperCase();
		}
		
		/**
		 * @private
		 */
		protected function _swatchOver( e : MouseEvent ) : void
		{
			_displaySwatch( e.currentTarget as Sprite );
		}
		
		/**
		 * @private
		 */
		protected function _swatchOut( e : MouseEvent ) : void
		{
			if( _captureBackgroundColor )
			{
				_drawSwatchGraphics( e.currentTarget as Sprite );
			}
		}
		
		/**
		 * @private
		 */
		protected function _swatchClick( e : MouseEvent ) : void
		{
			_selectSwatchAndClose( e.currentTarget as Sprite );
		}
		
		/**
		 * @private
		 */
		protected function _selectSwatchAndClose( swatch : Sprite , color : uint = 0 ) : void
		{
			_selectedSwatch = swatch;
			selectedColor = uint( swatch != null ? _swatchToColor[ swatch ] : color );
			
			close();
			setFocus();
		}
		
		/**
		 * @private
		 */
		protected function _stageMove( e : MouseEvent ) : void
		{
			if( stage && !_palette.hitTestPoint( stage.mouseX , stage.mouseY ) && _captureBackgroundColor && _isOpen )
			{
				_displayColor( uint( "0x" + _background.getPixel( stage.mouseX , stage.mouseY ).toString( 16 ) ) );
			}
		}
		
		/**
		 * @private
		 */
		protected function _stageClick( e : MouseEvent ) : void
		{
			if( !_captureBackgroundColor || _background == null || stage == null ) return;
			
			if( !_palette.hitTestPoint( stage.mouseX , stage.mouseY ) && _isOpen )
			{
				selectedColor = uint( "0x" + _background.getPixel( stage.mouseX , stage.mouseY ).toString( 16 ) );
			}
		}
		
		/**
		 * @private
		 */
		protected function _focusOut( e : FocusEvent ) : void
		{
			if( e.relatedObject == null || ( !contains( e.relatedObject ) && !_palette.contains( e.relatedObject ) ) )
			{
				Colorize.tint( _colorWell as DisplayObject , _selectedColor );
				
				close();
			}
		}
		
		/**
		 * @private
		 */
		protected function _colorChanged( e : Event ) : void
		{
			var color : uint = uint( "0x" + _paletteTextInput.text.replace( "#" , "" ) );
			
			_displayColor( color , true );
			
			_paletteTextInput.maxChars = _paletteTextInput.text.charAt( 0 ) == "#" ? 7 : 6;
		}
		
		/**
		 * @private
		 */
		protected function _inputChanged( e : TextEvent ) : void
		{
			if( ( e.text == "#" && ( e.currentTarget as TextField ).selectionBeginIndex > 0 ) || e.text.indexOf( "#" ) > 0 ) e.preventDefault();
		}
		
		/**
		 * @private
		 */
		protected function _keyDown ( e : KeyboardEvent ) : void
		{
			var row : uint = _currentSwatchOver == null ? 0 : _swatchToRow[ _currentSwatchOver ];
			var column : uint = _currentSwatchOver == null ? 0 : _swatchToColumn[ _currentSwatchOver ];
			
			switch ( e.keyCode )
			{
				case Keyboard.SPACE : _toggleOpen(); break;
				
				case Keyboard.ENTER : 
					
					_selectSwatchAndClose( _currentSwatchOver , uint( "0x" + _paletteTextInput.text.replace( "#" , "" ) ) );
					
					break;
				
				case Keyboard.ESCAPE : 
				
					Colorize.tint( _colorWell as DisplayObject , _selectedColor );
					
					close();
					setFocus();
					break;
					
				case Keyboard.DOWN : 
				case Keyboard.UP : 
				case Keyboard.RIGHT : 				case Keyboard.LEFT : 
				
					row += ( e.keyCode == Keyboard.DOWN ? 1 : e.keyCode == Keyboard.UP ? -1 : 0 );
					column += ( e.keyCode == Keyboard.RIGHT ? 1 : e.keyCode == Keyboard.LEFT ? -1 : 0 );
					
					_displaySwatch( _coordinateToSwatch[ String( row ) + "_" + String( column ) ] );
					
					break;
				
				case Keyboard.HOME :
					
					_displaySwatch( _coordinateToSwatch[ "0_0" ] );
					break;
					
				case Keyboard.END :
					
					_displaySwatch( _coordinateToSwatch[ ( colorMap.length - 1 ) + "_" + ( colorMap[ 0 ].length - 1 ) ] );
					break;
					
				case Keyboard.PAGE_DOWN :
					
					_displaySwatch( _coordinateToSwatch[ ( colorMap.length - 1 ) + "_" + column ] );
					break;
					
				case Keyboard.PAGE_UP :
					
					_displaySwatch( _coordinateToSwatch[ "0_" + column ] );
					break;
				
			}
		}
	}
}
