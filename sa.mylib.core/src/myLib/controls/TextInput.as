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
	import myLib.controls.skins.IFieldSkin;
	import myLib.controls.skins.ITextInputSkin;
	import myLib.controls.skins.my_skinset;
	import myLib.core.AComponent;
	import myLib.events.ComponentEvent;
	import myLib.form.IField;
	import myLib.styles.Padding;
	import myLib.styles.TextStyle;
	import myLib.utils.NumberUtils;

	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import flash.events.FocusEvent;
	import flash.events.KeyboardEvent;
	import flash.events.TextEvent;
	import flash.text.TextFieldType;
	import flash.ui.Keyboard;

	/**
	 * Defines the value of the type property of a enter event object.
	 * 
	 * @eventType enter
	 */
    [Event(name="enter", type="myLib.events.ComponentEvent")]
    
    /**
	 * Defines the value of the type property of a change event object.
	 * 
	 * @eventType change
	 */
    [Event(name="change", type="flash.events.Event")]
    
    /**
	 * Defines the value of the type property of a textInput event object.
	 * 
	 * @eventType textInput
	 */
    [Event(name="textInput", type="flash.events.TextEvent")]
    	
	[InspectableList("defaultText","disabledTextColor","displayAsPassword","enabled","embedFonts","horizontalAlignment","icon","inspectablePadding","labelIconSpacing","labelPlacement","maxChars","restrict","text","verticalAlignment")]
	/**
	 * TextInput consist of an input textfield that can be layout like a Label component and display an icon asset.
	 * 
	 * @author SamYStudiO ( contact@samystudio.net )
	 */
	public class TextInput extends Label implements ITextInput, IField
	{
		/**
		 * @private
		 */
		protected var _enabledTextColor : uint;
		
		/**
		 * @private
		 */
		protected var _isErrorDrawn : Boolean;
		
		/**
		 * @private
		 */
		protected var _displayAsPassword : Boolean;
		
		[Inspectable]
		/**
		 * @inheritDoc
		 */
		public function get displayAsPassword() : Boolean
		{
			return _displayAsPassword;
		}
		
		public function set displayAsPassword( b : Boolean ) : void
		{
			if( _inspector && !_isLivePreview && _displayAsPassword ) return;
			
			_displayAsPassword = b;
			_textField.displayAsPassword = b;
		}
		
		[Inspectable]
		/**
		 * @inheritDoc
		 */
		public function get restrict() : String
		{
			return _textField.restrict;
		}
		
		public function set restrict( s : String ) : void
		{
			if( _inspector && !_isLivePreview && _textField.restrict != null ) return;
			
			_textField.restrict = _inspector && s == "" ? null : s;
		}
		
		[Inspectable]
		/**
		 * @inheritDoc
		 */
		public function get maxChars() : int
		{
			return _textField.maxChars;
		}
		
		public function set maxChars( n : int ) : void
		{
			if( _inspector && !_isLivePreview && _textField.maxChars != 0 ) return;
			
			_textField.maxChars = n;
		}
		
		/**
		 * @private
		 */
		protected var _disabledTextColor : uint = 0xCCCCCC;
		
		[Inspectable(type="Color",defaultValue="#CCCCCC")]
		/**
		 * @inheritDoc
		 */
		public function get disabledTextColor() : uint
		{
			return _disabledTextColor;
		}
		
		public function set disabledTextColor( n : uint ) : void
		{
			if( _inspector && !_isLivePreview && _disabledTextColor != 0xCCCCCC ) return;
			
			_disabledTextColor = n;
			
			if( !_enabled )
				_textField.textColor = _disabledTextColor;
		}
		
		/**
		 * @private
		 */
		protected var _defaultText : String = "";
		
		[Inspectable(defaultValue="")]
		/**
		 * @inheritDoc
		 */
		public function get defaultText() : String
		{
			return _defaultText;
		}
		
		public function set defaultText( s : String ) : void
		{
			if( _inspector && !_isLivePreview && _defaultText != "" ) return;
			
			_defaultText = s;
			
			if( text == "" ) text = _defaultText;
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
		protected var _errorRectDepth : int = 1;
		
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
		protected var _errorRectAsset : IAsset;
		
		/**
		 * @inheritDoc
		 */
		public function get errorRectAsset() : IAsset
		{
			return _errorRectAsset;
		}
		
		
		[Inspectable(defaultValue="")]
		/**
		 * @inheritDoc
		 */
		public override function get text() : String
		{
			return super.text;
		}
		
		public override function set text( s : String ) : void
		{
			if( _textField == null || ( _inspector && !_isLivePreview && super.text != "" ) ) return;
			
			s = s == null ? "" : s;
			s = s == "" && _defaultText != null && ( stage == null || stage.focus != _textField )? _defaultText : s;
			
			if( !_html )
			{
				_textField.text = s;
				_text = s;
				_htmlText = "";
			
				_invalidateSize( );
			}
			else htmlText = s;
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
			if( _enabled == b || ( _inspector && !_isLivePreview && !super.enabled ) ) return;
			
			super.enabled = b;
			
			var skin : ITextInputSkin = _labelSkin as ITextInputSkin;
			
			var asset : IAsset = b ? skin.getUpAsset() : skin.getDisabledAsset();
			
			if( _backgroundAsset != null && asset != null ) removeChild( _backgroundAsset as DisplayObject );
			
			if( asset != null )
			{
				_backgroundAsset = asset;
				asset.setSize( _width, _height );	
				asset.draw();
				addChildAt( asset as DisplayObject , 0 );
			}
			
			var icon : IAsset = b ? skin.getIconUpAsset() : skin.getIconDisabledAsset();
			
			if( _iconAsset != null && icon != null ) removeChild( _iconAsset as DisplayObject );
			
			if( icon != null )
			{
				icon.x = _iconAsset.x;
				icon.y = _iconAsset.y;
				icon.setSize( iconWidth , iconHeight );
                icon.draw();
				_iconAsset = icon;
				addChildAt( icon as DisplayObject , 1 );
			}
			
			_textField.selectable = b;
			_textField.textColor = b ? _enabledTextColor : _disabledTextColor;
		}
		
		/**
		 * @inheritDoc
		 */
		public override function set textStyle ( style : TextStyle ) : void
		{
			super.textStyle = style;
			
			_enabledTextColor = uint( _textField.defaultTextFormat.color );
		}
		
		/**
		 * @inheritDoc
		 */
		public override function set multiline( b : Boolean ) : void
		{
			if( b ) throw new Error( this + " multiline is not allow" );
		}
		
		/**
		 * @inheritDoc
		 */
		public override function set autoFit( b : Boolean ) : void
		{
			if( b ) throw new Error( this + " autoFit is not allow" );
		}

		/**
		 * Build a new TextInput instance. Default size is 100*20.
		 * @param parentContainer The parent DisplayObjectContainer where add this TextInput.
		 * @param initStyle The initial style object for TextInput initialization.
		 * @param skin The ITextInputSkin to use instead of default skin.
		 * 
		 * @see myLib.styles.StyleManager
		 */
		public function TextInput ( parentContainer : DisplayObjectContainer = null , initStyle : Object = null , skin : ITextInputSkin = null )
		{
			super( parentContainer , initStyle , skin == null ? my_skinset.getTextInputSkin() : skin );
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
			return _textField.text;
		}
		
		/**
		 * @inheritDoc
		 */
		public function setValue( value : * ) : void
		{
			text = value == null ? "" : String( value );
		}
		
		/**
		 * @private
		 */
		protected override function _createChildren(  ) : void
		{
			super._createChildren();
			
			if( _textField == null ) throw new Error( this + " textField asset is missing" );
		}

		/**
		 * @private
		 */
		protected override function _init(  ) : void
		{
			_text = "";
			_textField.multiline = false;
			_textField.selectable = true;
			_textField.type = TextFieldType.INPUT;
			_textField.addEventListener( Event.CHANGE , _passEvent , false , 0 , true );			_textField.addEventListener( TextEvent.TEXT_INPUT , _passEvent , false , 0 , true );			_textField.addEventListener( KeyboardEvent.KEY_DOWN , _keyDown , false , 0 , true );
			
			_enabledTextColor = uint( _textField.defaultTextFormat.color );
			
			_focusTarget = _textField;
			
			addEventListener( FocusEvent.FOCUS_IN , _focusIn , false , 0 , true );			addEventListener( FocusEvent.FOCUS_OUT , _focusOut , false , 0 , true );
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
		protected function _focusIn ( e : FocusEvent ) : void
		{
			if( text == _defaultText ) text = "";
		}
		
		/**
		 * @private
		 */
		protected function _focusOut ( e : FocusEvent ) : void
		{
			if( text == "" && _defaultText != null ) text = _defaultText;
		}
		
		/**
		 * @private
		 */
		protected function _passEvent( e : Event ) : void
		{
			_text = _textField.text;
			
			dispatchEvent( e );
		}
		
		/**
		 * 
		 */
		private function _keyDown ( e : KeyboardEvent ) : void
		{
			if ( e.keyCode == Keyboard.ENTER )
				dispatchEvent( new ComponentEvent( ComponentEvent.ENTER ) );
		}
	}
}
