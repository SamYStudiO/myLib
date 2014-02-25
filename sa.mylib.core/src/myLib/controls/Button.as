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
	import myLib.assets.getAsset;
	import myLib.controls.skins.IButtonSkin;
	import myLib.controls.skins.IFieldSkin;
	import myLib.controls.skins.my_skinset;
	import myLib.core.AComponent;
	import myLib.core.InvalidationType;
	import myLib.displayUtils.FrameLabelUtils;
	import myLib.events.ButtonEvent;
	import myLib.events.ComponentEvent;
	import myLib.form.IField;
	import myLib.styles.Padding;
	import myLib.styles.TextStyle;
	import myLib.utils.NumberUtils;
	import myLib.utils.Timer;

	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.FrameLabel;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.FocusEvent;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.ui.Keyboard;
	import flash.utils.clearTimeout;
	import flash.utils.setTimeout;

	/**
	 * Defines the value of the type property of a toggle event object.
	 * 
	 * @eventType toggle
	 */
    [Event(name="toggle", type="myLib.events.ButtonEvent")]
    
    /**
	 * Defines the value of the type property of a stateChanged event object.
	 * 
	 * @eventType stateChanged
	 */
    [Event(name="stateChanged", type="myLib.events.ButtonEvent")]
    
    /**
	 * Defines the value of the type property of a mouseUpOutside event object.
	 * 
	 * @eventType mouseUpOutside
	 */
    [Event(name="mouseUpOutside", type="myLib.events.ButtonEvent")]
    
     /**
	  * Defines the value of the type property of a repeatMouseDown event object.
	  * 
	  * @eventType repeatMouseDown
	  */
    [Event(name="repeatMouseDown", type="myLib.events.ButtonEvent")]
    
	[InspectableList("autoFit","autoFitMinSize","autoRepeat","autoRepeatDelay","autoRepeatInterval","autoSize","data","disabledTextColor","embedFonts","enabled","groupOwner","horizontalAlignment","icon","iconDisabled","iconDisabledSelected","iconDown","iconDownSelected","iconOver","iconOverSelected","iconUp","iconUpSelected","inspectablePadding","labelIconSpacing","labelPlacement","maximizeTextWidth","multiline","selectable","selected","text","useHandCursor","verticalAlignment")]
	/**
	 * Button is a label component with mouse states (up, up selected, over, over selected, down, down selected, disabled, disabled selected).
	 * Button class is also the base class for toggle button and list cell renderer.
	 * 
	 * @author SamYStudiO ( contact@samystudio.net )
	 */
	public class Button extends Label implements IButton , IField
	{	 
		/**
		 *
		 */
		private var _defaultSizeFound : Boolean;
		
		/**
		 *
		 */
		private var _autoRepeatTimeoutID : uint;
		
		/**
		 *
		 */
		private var _autoRepeatTimer : Timer;
		
		/**
		 * @private
		 */
		protected var _buttonSkin : IButtonSkin;
		
		/**
		 * @private
		 */
		protected var _enabledTextColor : uint;
		
		/**
		 * @private
		 */
		protected var _isOver : Boolean;
		
		/**
		 * @private
		 */
		protected var _wasDown : Boolean;
		
		/**
		 * @private
		 */
		protected var _isErrorDrawn : Boolean;
		
		/**
		 * @private
		 */
		protected var _downTimeout : uint;

		/**
		 * @private
		 */
		protected var _disabledDragOutState : Boolean;
		
		/**
		 * @inheritDoc
		 */
		public function get disabledDragOutState() : Boolean
		{
			return _disabledDragOutState;
		}
		
		public function set disabledDragOutState( b : Boolean ) : void
		{
			_disabledDragOutState = b;
		}
		
		/**
		 * @private
		 */
		protected var _disabledDragOverState : Boolean = true;
		
		/**
		 * @inheritDoc
		 */
		public function get disabledDragOverState() : Boolean
		{
			return _disabledDragOverState;
		}
		
		public function set disabledDragOverState( b : Boolean ) : void
		{
			_disabledDragOverState = b;
		}
		
		/**
		 * @private
		 */
		protected var _selectable : Boolean;
		
		[Inspectable]
		/**
		 * @inheritDoc
		 */
		public function get selectable() : Boolean
		{
			return _selectable;
		}
		
		public function set selectable( b : Boolean ) : void
		{
			if( _inspector && !_isLivePreview && _selectable ) return;	
			
			_selectable = b;
		}
		
		/**
		 * @private
		 */
		protected var _data : *;
		
		[Inspectable]
		/**
		 * @inheritDoc
		 */
		public function get data() : *
		{
			return _data;
		}
		
		public function set data( data : * ) : void
		{
			if( _inspector && !_isLivePreview && ( data == "" || _data != null ) ) return;
			
			_data = data;
		}
		
		/**
		 * @private
		 */
		protected var _groupOwner : String;
		
		[Inspectable]
		/**
		 * @inheritDoc
		 */
		public function get groupOwner() : String
		{
			return _groupOwner;
		}
		
		public function set groupOwner( groupName : String ) : void
		{
			if( groupName == _groupOwner || ( _inspector && !_isLivePreview && _groupOwner != null ) ) return;
			
			if( _groupOwner != null && ( groupName == "" || groupName == null ) )
			{
				var g : ButtonGroup = ButtonGroup.getGroup( _groupOwner );
			
				if( g != null )
					g.removeItem( this );
			}
			
			if( groupName != "" && groupName != null && parent != null )
				ButtonGroup.getGroup( groupName , true ).addItem( this );
			
			mouseEnabled = ( groupName == ""  || groupName == null || !_selected ) && _enabled;

			_groupOwner = groupName;
		}
		
		/**
		 * @private
		 */
		protected var _selected : Boolean;
		
		[Inspectable]
		/**
		 * @inheritDoc
		 */
		public function get selected() : Boolean
		{
			return _selected;
		}
		
		public function set selected( b : Boolean ) : void
		{
			if( _selected == b || !_selectable || ( _inspector && !_isLivePreview && _selected ) ) return;
			
			_selected = b;
			
			mouseEnabled = ( groupOwner == ""  || groupOwner == null || !_selected ) && _enabled;
						if( _enabled && !b && _isOver ) _setStateLastFrame( ButtonStates.OVER ); // if mouse is over display over state
			else if( _enabled && !b ) _setStateLastFrame( ButtonStates.UP );
			else if( _enabled && b && _isOver ) _setStateLastFrame( ButtonStates.OVER_SELECTED );
			else if( _enabled && b ) _setStateLastFrame( ButtonStates.UP_SELECTED );
			else _setState( !_enabled && b ? ButtonStates.DISABLED_SELECTED : ButtonStates.DISABLED );
			
			dispatchEvent( new ButtonEvent( ButtonEvent.TOGGLE ) );
		}
		
		/**
		 * @inheritDoc
		 */
		public override function get textColor ( ) : uint
		{
			return super.textColor;
		}
		
		public override function set textColor ( color : uint ) : void
		{
			_enabledTextColor = color;
			
			_updateTextColor();
		}
		
		/**
		 * @private
		 */
		protected var _overTextColor : int = -1;
		
		/**
		 * @inheritDoc
		 */
		public function get overTextColor() : int
		{
			return _overTextColor;
		}
		
		public function set overTextColor( n : int ) : void
		{
			_overTextColor = n;
		}
		
		/**
		 * @private
		 */
		protected var _downTextColor : int = -1;
		
		/**
		 * @inheritDoc
		 */
		public function get downTextColor() : int
		{
			return _downTextColor;
		}
		
		public function set downTextColor( n : int ) : void
		{
			_downTextColor = n;
		}
		
		/**
		 * @private
		 */
		protected var _disabledTextColor : int = 0xCCCCCC;
		
		/**
		 * @inheritDoc
		 */
		public function get disabledTextColor() : int
		{
			return _disabledTextColor;
		}
		
		public function set disabledTextColor( n : int ) : void
		{
			_disabledTextColor = n;
			
			_updateTextColor();
		}
		
		/**
		 * @private
		 */
		protected var _selectedTextColor : int = -1;
		
		/**
		 * @inheritDoc
		 */
		public function get selectedTextColor() : int
		{
			return _selectedTextColor;
		}
		
		public function set selectedTextColor( n : int ) : void
		{
			_selectedTextColor = n;
			
			_updateTextColor();
		}
		
		/**
		 * @private
		 */
		protected var _overSelectedTextColor : int = -1;
		
		/**
		 * @inheritDoc
		 */
		public function get overSelectedTextColor() : int
		{
			return _overSelectedTextColor;
		}
		
		public function set overSelectedTextColor( n : int ) : void
		{
			_overSelectedTextColor = n;
		}
		
		/**
		 * @private
		 */
		protected var _downSelectedTextColor : int = -1;
		
		/**
		 * @inheritDoc
		 */
		public function get downSelectedTextColor() : int
		{
			return _downSelectedTextColor;
		}
		
		public function set downSelectedTextColor( n : int ) : void
		{
			_downSelectedTextColor = n;
		}
		
		/**
		 * @private
		 */
		protected var _disabledSelectedTextColor : int = -1;
		
		/**
		 * @inheritDoc
		 */
		public function get disabledSelectedTextColor() : int
		{
			return _disabledSelectedTextColor;
		}
		
		public function set disabledSelectedTextColor( n : int ) : void
		{
			_disabledSelectedTextColor = n;
			
			_updateTextColor();
		}
		
		/**
		 * @private
		 */
		protected var _iconUp : *;
		
		[Inspectable]
		/**
		 * @inheritDoc
		 */
		public function get iconUp() : *
		{
			return _iconUp;
		}
		
		public function set iconUp( icon : * ) : void
		{
			if( icon == "" ) icon = null;
			if( _iconUp == icon || ( _inspector && !_isLivePreview && _iconUp != null ) ) return;
			
			_iconUp = icon;
			
			if( _currentState == ButtonStates.UP )
			{	
				_setState( _currentState );
				_invalidateSize( );
			}
		}

		/**
		 * @private
		 */
		protected var _iconUpSelected : *;
		
		[Inspectable]
		/**
		 * @inheritDoc
		 */
		public function get iconUpSelected() : *
		{
			return _iconUpSelected;
		}
		
		public function set iconUpSelected( icon : * ) : void
		{
			if( icon == "" ) icon = null;
			if( _iconUpSelected == icon || ( _inspector && !_isLivePreview && _iconUpSelected != null ) ) return;
			
			_iconUpSelected = icon;
			
			if( _currentState == ButtonStates.UP_SELECTED )
			{
				_setIconState( _currentState );
				_invalidateSize( );
			}
		}
		
		/**
		 * @private
		 */
		protected var _iconOver : *;
		
		[Inspectable]
		/**
		 * @inheritDoc
		 */
		public function get iconOver() : *
		{
			return _iconOver;
		}
		
		public function set iconOver( icon : * ) : void
		{
			if( icon == "" ) icon = null;
			if( _iconOver == icon || ( _inspector && !_isLivePreview && _iconOver != null ) ) return;
			
			_iconOver = icon;
			
			if( _currentState == ButtonStates.OVER )
			{
				_setIconState( _currentState );
				_invalidateSize( );
			}
		}
		
		/**
		 * @private
		 */
		protected var _iconOverSelected : *;
		
		[Inspectable]
		/**
		 * @inheritDoc
		 */
		public function get iconOverSelected() : *
		{
			return _iconOverSelected;
		}
		
		public function set iconOverSelected( icon : * ) : void
		{
			if( icon == "" ) icon = null;
			if( _iconOverSelected == icon || ( _inspector && !_isLivePreview && _iconOverSelected != null ) ) return;
			
			_iconOverSelected = icon;
			
			if( _currentState == ButtonStates.OVER_SELECTED )
			{
				_setIconState( _currentState );
				_invalidateSize( );
			}
		}
		
		/**
		 * @private
		 */
		protected var _iconDown : *;
		
		[Inspectable]
		/**
		 * @inheritDoc
		 */
		public function get iconDown() : *
		{
			return _iconDown;
		}
		
		public function set iconDown( icon : * ) : void
		{
			if( icon == "" ) icon = null;
			if( _iconDown == icon || ( _inspector && !_isLivePreview && _iconDown != null ) ) return;
			
			_iconDown = icon;
			
			if( _currentState == ButtonStates.DOWN )
			{
				_setIconState( _currentState );
				_invalidateSize( );
			}
		}
		
		/**
		 * @private
		 */
		protected var _iconDownSelected : *;
		
		[Inspectable]
		/**
		 * @inheritDoc
		 */
		public function get iconDownSelected() : *
		{
			return _iconDownSelected;
		}
		
		public function set iconDownSelected( icon : * ) : void
		{
			if( icon == "" ) icon = null;
			if( _iconDownSelected == icon || ( _inspector && !_isLivePreview && _iconDownSelected != null ) ) return;
			
			_iconDownSelected = icon;
			
			if( _currentState == ButtonStates.DOWN_SELECTED )
			{
				_setIconState( _currentState );
				_invalidateSize( );
			}
		}
		
		/**
		 * @private
		 */
		protected var _iconDisabled : *;
		
		[Inspectable]
		/**
		 * @inheritDoc
		 */
		public function get iconDisabled() : *
		{
			return _iconDisabled;
		}
		
		public function set iconDisabled( icon : * ) : void
		{
			if( icon == "" ) icon = null;
			if( _iconDisabled == icon || ( _inspector && !_isLivePreview && _iconDisabled != null ) ) return;
			
			_iconDisabled = icon;
			
			if( _currentState == ButtonStates.DISABLED )
			{
				_setIconState( _currentState );
				_invalidateSize( );
			}
		}
		
		/**
		 * @private
		 */
		protected var _iconDisabledSelected : *;
		
		[Inspectable]
		/**
		 * @inheritDoc
		 */
		public function get iconDisabledSelected() : *
		{
			return _iconDisabledSelected;
		}
		
		public function set iconDisabledSelected( icon : * ) : void
		{
			if( icon == "" ) icon = null;
			if( _iconDisabledSelected == icon || ( _inspector && !_isLivePreview && _iconDisabledSelected != null ) ) return;
			
			_iconDisabledSelected = icon;
			
			if( _currentState == ButtonStates.DISABLED_SELECTED )
			{
				_setIconState( _currentState );
				_invalidateSize( );
			}
		}
		
		/**
		 * @private
		 */
		protected var _autoRepeat : Boolean;
		
		[Inspectable]
		/**
		 * @inheritDoc
		 */
		public function get autoRepeat() : Boolean
		{
			return _autoRepeat;
		}
		
		public function set autoRepeat( b : Boolean ) : void
		{
			if( _inspector && !_isLivePreview && _autoRepeat ) return;
			
			_autoRepeat = b;
		}
		
		[Inspectable(defaultValue=0)]
		/**
		 * @private
		 */
		protected var _autoRepeatDelay : uint = 0;
		
		/**
		 * @inheritDoc
		 */
		public function get autoRepeatDelay() : uint
		{
			return _autoRepeatDelay;
		}
		
		public function set autoRepeatDelay( n : uint ) : void
		{
			if( _inspector && !_isLivePreview && _autoRepeatDelay != 0 ) return;
			
			_autoRepeatDelay = n;
		}
		
		/**
		 * @private
		 */
		protected var _autoRepeatInterval : uint = 0;
		
		[Inspectable(defaultValue=0)]
		/**
		 * @inheritDoc
		 */
		public function get autoRepeatInterval() : uint
		{
			return _autoRepeatInterval;
		}
		
		public function set autoRepeatInterval( n : uint ) : void
		{
			if( _inspector && !_isLivePreview && _autoRepeatInterval != 0 ) return;
			
			_autoRepeatInterval = n;
		}
		
		/**
		 * @private
		 */
		protected var _currentState : String = ButtonStates.UP;
		
		/**
		 * @inheritDoc
		 */
		public function get currentState() : String
		{
			return _currentState;
		}
		
		public function set currentState( state : String ) : void
		{
			_setState( state );
		}
		
		[Inspectable(defaultValue="Button")]
		/**
		 * @inheritDoc
		 */
		public override function get text() : String
		{
			return super.text;
		}
		
		public override function set text( s : String ) : void
		{
			if( _textField == null || ( _inspector && !_isLivePreview && text != "Button" ) ) return;
			
			if( !_html )
			{
				_textField.text = _text = s;
				_htmlText = "";
			
				_invalidateSize( );
			}
			else htmlText = s;
		}
		
		[Inspectable(defaultValue="center",enumeration="left,center,right")]
		/**
		 * @inheritDoc
		 */
		public override function get horizontalAlignment() : String
		{
			return _horizontalAlignment;
		}
		
		public override function set horizontalAlignment( s : String ) : void
		{
			if( _horizontalAlignment == s || ( _inspector && !_isLivePreview && _horizontalAlignment != LabelAlignment.CENTER ) ) return;
			
			_horizontalAlignment = s;
			
			_invalidateSize( );
		}
		
		[Inspectable]
		/**
		 * @inheritDoc
		 */
		public override function get icon() : *
		{
			return super.icon;
		}
		
		public override function set icon( icon : * ) : void
		{
			if( icon == "" ) icon = null;
			
			if( _icon == icon || ( _inspector && !_isLivePreview && _icon != null ) ) return;
			
			_icon = icon;
			
			_setIconState( _currentState );
			
			_invalidateSize( );
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
			if( _enabled == b || ( _inspector && !_isLivePreview && !_enabled ) ) return;
			
			super.enabled  = b;
			
			if( b && !_selected ) _setStateLastFrame( ButtonStates.UP );
			else _setState( b && _selected ? ButtonStates.UP_SELECTED :
							!b && _selected ? ButtonStates.DISABLED_SELECTED : ButtonStates.DISABLED );
		}
		
		/**
		 * @inheritDoc
		 */
		public override function get textStyle() : TextStyle
		{
			return super.textStyle;
		}
		
		public override function set textStyle ( style : TextStyle ) : void
		{
			super.textStyle = style;
			
			_enabledTextColor = uint( _textField.defaultTextFormat.color );
			_updateTextColor();
		}
		
		/**
		 * @private
		 */
		protected var _variableName : String;
		
		/**
		 * @inheritDoc
		 */
		public function get variableName() : String
		{
			return _variableName;
		}
		
		public function set variableName( name : String ) : void
		{
			_variableName = name;
		}
		
		/**
		 * @private
		 */
		protected var _required : *;
		
		/**
		 * @inheritDoc
		 */
		public function get required() : *
		{
			return _required;
		}
		
		public function set required( b : * ) : void
		{
			_required = b != null ? Boolean( b ) : null;
		}
		
		/**
		 * @private
		 */
		protected var _validators : *;
		
		/**
		 * @inheritDoc
		 */
		public function get validators() : *
		{
			return _validators;
		}
		
		public function set validators( validators : * ) : void
		{
			_validators = validators;
		}
		
		/**
		 * @private
		 */
		protected var _errorRectPadding : Padding = new Padding( 0 , 0 , 0 , 0 );
		
		/**
		 * @inheritDoc
		 */	
		public function get errorRectPadding() : Padding
		{
			_errorRectPadding = _errorRectPadding == null ? new Padding( 0 , 0 , 0 , 0 ) : _errorRectPadding;
			
			return _errorRectPadding;
		}
		
		public function set errorRectPadding( padding : Padding ) : void
		{
			_errorRectPadding = padding;
			
			if( _isErrorDrawn ) 
			{
				_isErrorDrawn = false;
				drawFocus( true );
			}
		}
		
		/**
		 * @private
		 */
		protected var _errorRectTarget : IAsset;
		
		/**
		 * @inheritDoc
		 */	
		public function get errorRectTarget() : IAsset
		{
			_errorRectTarget = _errorRectTarget == null ? this : _errorRectTarget;
			
			return _errorRectTarget;
		}
		
		public function set errorRectTarget( asset : IAsset ) : void
		{
			_errorRectTarget = asset;
			
			if( _isErrorDrawn ) 
			{
				_isErrorDrawn = false;
				drawError( true );
			}
		}
		
		/**
		 * @private
		 */
		protected var _errorRectDepth : int = -1;
		
		/**
		 * @inheritDoc
		 */
		public function get errorRectDepth() : int
		{
			return _errorRectDepth;
		}
		
		public function set errorRectDepth( n : int ) : void
		{
			_errorRectDepth = NumberUtils.clamp( n , -1 );
			
			if( _isErrorDrawn ) 
			{
				_isErrorDrawn = false;
				drawError( true );
			}
		}
		
		/**
		 * @private
		 */
		protected var _backgroundAssetContainer : Sprite = new Sprite();
		
		/**
		 *
		 */
		public function get backgroundAssetContainer() : Sprite
		{
			return _backgroundAssetContainer;
		}
		
		/**
         * @private
         */
        protected var _iconAssetContainer : Sprite = new Sprite();
        
        /**
         *
         */
        public function get iconAssetContainer() : Sprite
        {
            return _iconAssetContainer;
        }
		
		/**
		 * @private
		 */
		protected var _errorRectAsset : IAsset;
		
		/**
		 * @inheritDoc
		 */
		public function get errorRectAsset() : IAsset
		{
			return _errorRectAsset;
		}

		/**
		 * Build a new Button instance. Default size is 100*20.
		 * @param parentContainer The parent DisplayObjectContainer where add this Button.
		 * @param initStyle The initial style object for Button initialization.
		 * @param skin The IButtonSkin to use instead of default skin.
		 * 
		 * @see myLib.styles.StyleManager
		 */
		public function Button ( parentContainer : DisplayObjectContainer = null , initStyle : Object = null , skin : IButtonSkin = null )
		{
			_buttonSkin = skin == null ? my_skinset.getButtonSkin() : skin;
						super( parentContainer , initStyle , _buttonSkin );
		}

		/**
		 * @inheritDoc
		 */
		public function getGroup (  ) : ButtonGroup
		{
			return ButtonGroup.getGroup( _groupOwner );
		}
		
		/**
		 * @inheritDoc
		 */
		public function drawError( b : Boolean ) : void
		{
			if( _isErrorDrawn == b || parent is AComponent ) return;
			
			_isErrorDrawn = b;
			
			if( _errorRectAsset != null && contains( _errorRectAsset as DisplayObject ) )
				removeChild( _errorRectAsset as DisplayObject );
			
			_errorRectAsset = null;
			
			if( b && _skin != null )
			{
				_errorRectAsset = ( _skin as IFieldSkin ).getErrorRectAsset();
				
				if( _errorRectAsset != null )
				{
					var errorPadding : Padding = errorRectPadding;
					var errorTarget : IAsset = errorRectTarget;
					
					_errorRectAsset.x = ( errorTarget == this ? 0 : errorTarget.x ) - errorPadding.left;
					_errorRectAsset.y = ( errorTarget == this ? 0 : errorTarget.y ) - errorPadding.top;
					
					_errorRectAsset.setSize( 	errorTarget.width + errorPadding.left + errorPadding.right ,
												errorTarget.height + errorPadding.top + errorPadding.bottom );
					_errorRectAsset.draw();
					
					if( _errorRectDepth >= 0 ) addChildAt( _errorRectAsset  as DisplayObject , _errorRectDepth );
					else addChild( _errorRectAsset  as DisplayObject );
				}
			}
		}

		/**
		 * @inheritDoc
		 */
		public function getValue(  ) : *
		{
			return _selected ? data != null ? data : true : false;
		}
		
		/**
		 * @inheritDoc
		 */
		public function setValue( value : * ) : void
		{
			if( selectable && value != _data && ( Number( value ) == 0 || Number( value ) == 1 ) )
				selected = Boolean( Number( value ) );
			else selected = value is Boolean ? value as Boolean : value == _data && _data != null;
		}
		
		/**
		 * @private
		 */
		protected override function _createChildren(  ) : void
		{
			_textFieldAsset = _buttonSkin.getTextFieldAsset();
			
			if( _textFieldAsset != null ) _textFieldAsset.owner = this;
			
			_textField = _textFieldAsset != null ? _textFieldAsset.textField : null;
			_enabledTextColor = _textField != null ? uint( _textField.defaultTextFormat.color ) : 0;
			
			_setStateLastFrame( ButtonStates.UP );
			
			addChild( _backgroundAssetContainer);
			if( _textFieldAsset != null ) addChild( _textFieldAsset as DisplayObject );
			addChild( _iconAssetContainer);
		}
				
		/**
		 * @private
		 */
		protected override function _init(  ) : void
		{
			if( _textField != null && _textField.text == "" )
				_textField.text = "Button";
			
			_horizontalAlignment = LabelAlignment.CENTER;
			
			buttonMode = true;
			mouseChildren = false;
			
			_focusEnabled = true;
			
			addEventListener( MouseEvent.ROLL_OVER , _over , false , 0 , true );
			addEventListener( MouseEvent.ROLL_OUT , _out , false , 0 , true );
			addEventListener( KeyboardEvent.KEY_DOWN , _keyDown , false , 0 , true );	
			
			addEventListener( MouseEvent.MOUSE_DOWN , _down , false , 0 , true );
			addEventListener( MouseEvent.MOUSE_UP , _up , false , 0 , true );			addEventListener( MouseEvent.CLICK , _click , false , 0 , true );
			
			addEventListener( Event.ADDED_TO_STAGE , _added , false , 0 , true );
			addEventListener( Event.REMOVED_FROM_STAGE , _removed , false , 0 , true );	
		}
		
		/**
		 *
		 */
		protected override function _render( e : Event = null ) : void
		{
			if( !_invalidation.isActive() ) return;
			
			// TODO cannot remove listener at the moment > stage invalidate issue!
			//removeEventListener( Event.RENDER , _render );
			
			_draw();
			
			if( _isFocused )
			{
				_isFocused = false;
				drawFocus( true );
			}
			
			if( _isErrorDrawn )
			{
				_isErrorDrawn = false;
				drawError( true );
			}
			
			_invalidation.removeAllTypes();
			_isInitialized = true;
			
			dispatchEvent( new ComponentEvent( ComponentEvent.DRAW ) );
		}
		
		/**
		 * @private
		 */
		protected function _added( e : Event ) : void
		{
			if ( _groupOwner != null && _groupOwner != "" )
				ButtonGroup.getGroup( _groupOwner , true ).addItem( this );
		}
		
		/**
		 * @private
		 */
		protected function _removed( e : Event ) : void
		{
			var g : ButtonGroup = ButtonGroup.getGroup( _groupOwner );
			
			if( g != null ) g.removeItem( this );
		}
		
		/**
		 * @private
		 */
		protected function _keyDown( e : KeyboardEvent ) : void
		{
			if( ( e.keyCode == Keyboard.SPACE || e.keyCode == Keyboard.ENTER ) && _enabled && mouseEnabled )
			{
				dispatchEvent( new MouseEvent( MouseEvent.CLICK ) );
			}	
		}

		/**
		 * @private
		 */
		protected function _setState( s : String , buttonDown : Boolean = false ) : void
		{
			if( buttonDown && _disabledDragOutState ) return;
			
			_currentState = s;
			
			// BACKGROUND ------------------
			var asset : IAsset = _getBackgroundAssetFromState( s );

			// if button is component asset and instantiated by code try to use background asset default size insteadof Button default size ( 100 * 22 ).
			// In most case this is what you want and what ScrollBar needs with default skin for example.
			if( parent == null && asset != null && asset.width != 0 && asset.height != 0 && !_isLivePreview && !_defaultSizeFound )
			{
				_width = _originWidth = asset.width;
				_height = _originHeight = asset.height;	
				
				// to check min/max width/height
				setSize( _width , _height );
			}
			
			_defaultSizeFound = true;
			
			if( asset != null )
			{
				asset.owner = this;
				_addBackground( asset );
			}
			else if( _backgroundAsset != null  )
			{
				removeChild( _backgroundAsset as DisplayObject );
				_backgroundAsset = null;	
			}
			
			// ICON ------------------
			_setIconState( s );
			
			// TODO remove these lines?
			/*if ( _iconAsset == null ) _setIconState( s );
			else
			{
				switch( s )
				{
					case ButtonStates.UP 				: if ( _iconUp != null || ( _currentState != s && this[ "_icon" + StringUtils.capitalize( _currentState ) ] != null ) ) _setIconState( s ); break;
					case ButtonStates.UP_SELECTED 		: if( _iconUpSelected != null || ( _currentState != s && this[ "_icon" + StringUtils.capitalize( _currentState ) ] != null ) )_setIconState( s ); break;
					case ButtonStates.OVER 				: if( _iconOver != null || ( _currentState != s && this[ "_icon" + StringUtils.capitalize( _currentState ) ] != null ) )_setIconState( s ); break;
					case ButtonStates.OVER_SELECTED 	: if( _iconOverSelected != null || ( _currentState != s && this[ "_icon" + StringUtils.capitalize( _currentState ) ] != null ) )_setIconState( s ); break;
					case ButtonStates.DOWN 				: if( _iconDown != null || ( _currentState != s && this[ "_icon" + StringUtils.capitalize( _currentState ) ] != null ) )_setIconState( s ); break;
					case ButtonStates.DOWN_SELECTED 	: if( _iconDownSelected != null || ( _currentState != s && this[ "_icon" + StringUtils.capitalize( _currentState ) ] != null ) )_setIconState( s ); break;
					case ButtonStates.DISABLED 			: if( _iconDisabled != null || ( _currentState != s && this[ "_icon" + StringUtils.capitalize( _currentState ) ] != null ) )_setIconState( s ); break;
					case ButtonStates.DISABLED_SELECTED : if( _iconDisabledSelected != null || ( _currentState != s && this[ "_icon" + StringUtils.capitalize( _currentState ) ] != null ) )_setIconState( s ); break;
				}
			}*/
			
			// TEXTFIELD ------------------
			if( _textField != null )
			{
				var frameLabel : FrameLabel;
				var isMovie : Boolean = _isMovie( _textFieldAsset );
				
				if( isMovie )
					frameLabel = FrameLabelUtils.getFrameLabelFromName( _textFieldAsset as MovieClip , s );
					
				if( isMovie && frameLabel != null )
				{
					var mcTextField : MovieClip = _textFieldAsset as MovieClip;
					
					mcTextField.gotoAndPlay( s );
				}
				
				_updateTextColor();
			}
			
			// TODO try to invalidate only when using state icons
			if( !isInvalidate( InvalidationType.SIZE ) )
			{
				if( isInvalidate( ) )
					invalidate( InvalidationType.SIZE );				else
					validate( InvalidationType.SIZE );
			}
			
			dispatchEvent( new ButtonEvent( ButtonEvent.STATE_CHANGED ) );
		}
		
		/**
		 * @private
		 */
		protected function _updateTextColor(  ) : void
		{
			if( _textField == null ) return;
			
			var color : int;
                
            switch( _currentState )
            {
                case ButtonStates.UP : color = _enabledTextColor; break;
                case ButtonStates.UP_SELECTED : color = _selectedTextColor; break;
                case ButtonStates.OVER : color = _overTextColor; break;
                case ButtonStates.OVER_SELECTED : color = _overSelectedTextColor; break;
                case ButtonStates.DOWN : color = _downTextColor; break;
                case ButtonStates.DOWN_SELECTED : color = _downSelectedTextColor; break;
                case ButtonStates.DISABLED : color = _disabledTextColor; break;
                case ButtonStates.DISABLED_SELECTED : color = _disabledSelectedTextColor; break;
            }
            
            color = color < 0 ? _enabledTextColor : color;
            
            if( _textField.textColor != color ) _textField.textColor = color;
		}
		
		/**
		 * @private
		 */
		protected function _setIconState( s : String ) : void
		{
			var icon : IAsset = _getIconAssetFromState( s );
			
			if( icon != null )
			{
				icon.owner = this;
				_addIcon( icon );
			}
			else if( _iconAsset != null )
			{
				removeChild( _iconAsset as DisplayObject );	
				_iconAsset = null;
			}
		}
		
		/**
		 * @private
		 */
		protected function _getBackgroundAssetFromState( s : String ) : IAsset
		{
			switch( s )
			{
				case ButtonStates.UP 				: return _buttonSkin.getUpAsset();	
				case ButtonStates.UP_SELECTED 		: return _buttonSkin.getUpSelectedAsset();					case ButtonStates.OVER 				: return _buttonSkin.getOverAsset();					case ButtonStates.OVER_SELECTED 	: return _buttonSkin.getOverSelectedAsset();				case ButtonStates.DOWN 				: return _buttonSkin.getDownAsset();					case ButtonStates.DOWN_SELECTED 	: return _buttonSkin.getDownSelectedAsset();
				case ButtonStates.DISABLED 			: return _buttonSkin.getDisabledAsset();	
				case ButtonStates.DISABLED_SELECTED : return _buttonSkin.getDisabledSelectedAsset();	
			}
			
			return null;
		}
		
		/**
		 * @private
		 */
		protected function _getIconAssetFromState( s : String ) : IAsset
		{
			switch( s )
			{
				case ButtonStates.UP 				: return _buttonSkin.getIconUpAsset( ) || getAsset( _iconUp != null ? _iconUp : _icon );				case ButtonStates.UP_SELECTED 		: return _buttonSkin.getIconUpSelectedAsset( ) || getAsset( _iconUpSelected != null ? _iconUpSelected : _icon );
				case ButtonStates.OVER 				: return _buttonSkin.getIconOverAsset( ) || getAsset( _iconOver != null ? _iconOver : _icon );
				case ButtonStates.OVER_SELECTED 	: return _buttonSkin.getIconOverSelectedAsset( ) || getAsset( _iconOverSelected != null ? _iconOverSelected : _icon );
				case ButtonStates.DOWN 				: return _buttonSkin.getIconDownAsset( ) || getAsset( _iconDown != null ? _iconDown : _icon );
				case ButtonStates.DOWN_SELECTED 	: return _buttonSkin.getIconDownSelectedAsset( ) || getAsset( _iconDownSelected != null ? _iconDownSelected : _icon );
				case ButtonStates.DISABLED 			: return _buttonSkin.getIconDisabledAsset( ) || getAsset( _iconDisabled != null ? _iconDisabled : _icon );
				case ButtonStates.DISABLED_SELECTED : return _buttonSkin.getIconDisabledSelectedAsset( ) || getAsset( _iconDisabledSelected != null ? _iconDisabledSelected : _icon );
			}
			
			return null;
		}
		
		/**
		 * @private
		 */
		protected function _addBackground( asset : IAsset ) : void
		{
			if( _backgroundAsset != null )
			{
				var o : DisplayObject = _backgroundAsset as DisplayObject;
                if( _backgroundAssetContainer.contains( o ) ) _backgroundAssetContainer.removeChild( o );
			}
				
			_backgroundAsset = asset;
			_backgroundAsset.setSize( _width , _height );
			
			_backgroundAssetContainer.addChild( _backgroundAsset as DisplayObject );
		}
		
		/**
		 * @private
		 */
		protected function _addIcon( asset : IAsset ) : void
		{
			if( _iconAsset != null )
			{
				var o : DisplayObject = _iconAsset as DisplayObject;
    			if( _iconAssetContainer.contains( o ) ) _iconAssetContainer.removeChild( o );
				asset.move( _iconAsset.x , _iconAsset.y );
				asset.setSize( iconWidth , iconHeight );
			}
			
			_iconAsset = asset;
			
			_iconAssetContainer.addChild( _iconAsset as DisplayObject );
		}
			
		/**
		 * @private
		 */
		protected function _up( e : MouseEvent ) : void
		{
			clearTimeout( _autoRepeatTimeoutID );
			clearTimeout( _downTimeout );
			
			if( _autoRepeatTimer != null )
				_autoRepeatTimer.stop();
			
			if( _wasDown )
			{
				if( !_selected ) _setState( ButtonStates.OVER );
				else if( _selectable ) _setState( ButtonStates.OVER_SELECTED );
			}
			else
			{
				if( !_selected ) _setStateLastFrame( ButtonStates.OVER );
				else if( _selectable ) _setStateLastFrame( ButtonStates.OVER_SELECTED );
			}
			
			_wasDown = false;
		}
		
		/**
		 * @private
		 */
		protected function _over( e : MouseEvent ) : void
		{
			var idDown : Boolean = _currentState == ButtonStates.DOWN || _currentState == ButtonStates.DOWN_SELECTED;
			
			if( _disabledDragOverState && e.buttonDown && !idDown )
			{
				e.stopImmediatePropagation();
				_wasDown = true;
				return;	
			}
			
			_isOver = true;
			
			if( !_selected ) _setState( ButtonStates.OVER , e.buttonDown );
			else if( _selectable ) _setState( ButtonStates.OVER_SELECTED , e.buttonDown );
		}
		
		/**
		 * @private
		 */
		protected function _out( e : MouseEvent ) : void
		{
			var idDown : Boolean = _currentState == ButtonStates.DOWN || _currentState == ButtonStates.DOWN_SELECTED;
			
			if( _disabledDragOverState && e.buttonDown && !idDown )
			{
				e.stopImmediatePropagation();
				return;	
			}
			
			_isOver = false;
			
			if( !_selected ) _setState( ButtonStates.UP , e.buttonDown );
			else if( _selectable ) _setState( ButtonStates.UP_SELECTED , e.buttonDown );
		}
		
		/**
		 * @private
		 */
		protected function _down( e : MouseEvent ) : void
		{
			_activateDownState();
		}
		
		/**
		 * @private
		 */
		protected function _activateDownState(  ) : void
		{
			if( !_selected ) _setState( ButtonStates.DOWN );
			else if( _selectable ) _setState( ButtonStates.DOWN_SELECTED );
			
			if( _autoRepeat )
			{
				clearTimeout( _autoRepeatTimeoutID );
				
				if( _autoRepeatTimer != null )
					_autoRepeatTimer.stop();
				
				if( _autoRepeatDelay > 0 ) _autoRepeatTimeoutID = setTimeout( _startAutoRepeat , _autoRepeatDelay );
				else _startAutoRepeat();
				
				dispatchEvent( new ButtonEvent( ButtonEvent.REPEAT_MOUSE_DOWN ) );
			}
			
			if( stage != null )
				stage.addEventListener( MouseEvent.MOUSE_UP , _releaseOutSide , false , 0 , true );	
		}
		
		/**
		 * @private
		 */
		protected function _focusOut( e : FocusEvent ) : void
		{
			_releaseOutSide();
		}
		
		/**
		 * @private
		 */
		protected function _startAutoRepeat(  ) : void
		{
			clearTimeout( _autoRepeatTimeoutID );
			
			_autoRepeatTimer = new Timer( _autoRepeatInterval , 0 , true );
			_autoRepeatTimer.addEventListener( TimerEvent.TIMER , _repeatDown , false , 0 , true );
		}

		/**
		 * @private
		 */
		protected function _repeatDown( e : TimerEvent ) : void
		{
			dispatchEvent( new ButtonEvent( ButtonEvent.REPEAT_MOUSE_DOWN ) );
		}
		
		/**
		 * @private
		 */
		protected function _click( e : MouseEvent ) : void
		{
			if( _selectable && ( groupOwner == ""  || groupOwner == null || !_selected ) ) selected = !selected;
		}
		
		/**
		 * @private
		 */
		protected function _releaseOutSide ( e : MouseEvent = null ) : void
		{
			// TODO why test e and _disabledDragOutState?
			/*if( e == null || _disabledDragOutState )
			{
				if( ( e == null || e.target != this ) && !_selected )_setStateLastFrame( ButtonStates.UP );
				else if( ( e == null || e.target != this ) && _selectable ) _setStateLastFrame( ButtonStates.UP_SELECTED );
			}*/
			
			if( !_selected ) _setStateLastFrame( ButtonStates.UP );
			else if( _selectable ) _setStateLastFrame( ButtonStates.UP_SELECTED );
			
			clearTimeout( _autoRepeatTimeoutID );
			clearTimeout( _downTimeout );
			
			if( _autoRepeatTimer != null )
				_autoRepeatTimer.stop();
			
			if( stage != null ) stage.removeEventListener( MouseEvent.MOUSE_UP , _releaseOutSide );
			
			dispatchEvent( new ButtonEvent( ButtonEvent.MOUSE_UP_OUTSIDE ) );	
		}
		
		/**
		 * @private
		 * 
		 * Display state and go immediatly to last frame for each animated assets.
		 */
		protected function _setStateLastFrame( s : String ) : void
		{
			_setState( s );
			
			if( _isMovie( _backgroundAsset ) ) _gotoAssetLastFrame( _backgroundAsset as MovieClip , s );
				
			if( _isMovie( _iconAsset ) ) _gotoAssetLastFrame( _iconAsset as MovieClip , s );
			
			if( _isMovie( _textFieldAsset ) ) _gotoAssetLastFrame( _textFieldAsset as MovieClip , s );
		}
		
		/**
		 * @private
		 * 
		 * Search a movie asset last frame and reach it.
		 */
		protected function _gotoAssetLastFrame( asset : MovieClip , state : String ) : void
		{
			var lastFrame : int = FrameLabelUtils.getLabelEndFrame( asset , state );
			asset.gotoAndStop( lastFrame == -1 ? asset.totalFrames : lastFrame );
		}
		
		/**
		 * 
		 */
		private function _isMovie( o : * ) : Boolean
		{
			return o is MovieClip && ( o as MovieClip ).totalFrames > 1;
		}
	}
}
