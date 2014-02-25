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
package myLib.core 
{
	import myLib.assets.IAsset;
	import myLib.controls.ITextInput;
	import myLib.controls.LabelAlignment;
	import myLib.controls.LabelPlacement;
	import myLib.controls.StepperNextPreviousPosition;
	import myLib.controls.skins.IStepperSkin;
	import myLib.controls.skins.my_skinset;
	import myLib.events.ButtonEvent;
	import myLib.styles.Padding;
	import myLib.styles.TextStyle;

	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.InteractiveObject;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.ui.Keyboard;
			/**
	 * @author SamYStudiO
	 */
	public class AStepper extends AFieldComponent implements IAStepper
	{
		/**
		 * @private
		 */
		protected var _stepperSkin : IStepperSkin;
		
		/**
		 * @private
		 */
		protected var _defaultNextButtonWidth : Number;
		
		/**
		 * @private
		 */
		protected var _defaultNextButtonHeight : Number;
		
		/**
		 * @private
		 */
		protected var _defaultPreviousButtonWidth : Number;
		
		/**
		 * @private
		 */
		protected var _defaultPreviousButtonHeight : Number;
		
		/**
		 * @private
		 */
		protected var _invertNextPrevious : Boolean;
		
		[Inspectable]
		/**
		 * @inheritDoc
		 */
		public function get invertNextPrevious() : Boolean
		{
			return _invertNextPrevious;
		}
		
		public function set invertNextPrevious( b : Boolean ) : void
		{
			if( _inspector && !_isLivePreview && _invertNextPrevious ) return;
			
			_invertNextPrevious = b;
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
			if( _editable == b || ( _inspector && !_isLivePreview && _editable ) ) return;
			
			_editable = b;
			_textInput.textField.type = b ? TextFieldType.INPUT : TextFieldType.DYNAMIC;
			_textInput.textField.selectable =
			_textInput.mouseEnabled = _textInput.mouseChildren = _enabled ? b : false;
			
			_focusTarget = _editable ? _textInput as InteractiveObject : null;
		}
		
		/**
		 * @private
		 */
		protected var _resizeButton : Boolean = true;
		
		[Inspectable(defaultValue=true)]
		/**
		 * @inheritDoc
		 */
		public function get resizeButton() : Boolean
		{
			return _resizeButton;
		}
		
		public function set resizeButton( b : Boolean ) : void
		{
			if( _resizeButton == b || ( _inspector && !_isLivePreview && !_resizeButton ) ) return;
			
			_resizeButton = b;
			
			invalidate( InvalidationType.SIZE ); 
		}
		
		/**
		 * @private
		 */
		protected var _nextPreviousPosition : String = StepperNextPreviousPosition.RIGHT;

		[Inspectable(defaultValue="right",enumeration="left,right,top,bottom,leftRight,topBottom")]
		/**
		 * @inheritDoc
		 */
		public function get nextPreviousPosition() : String
		{
			return _nextPreviousPosition;
		}
		
		public function set nextPreviousPosition( s : String ) : void
		{
			if( _nextPreviousPosition == s || ( _inspector && !_isLivePreview && _nextPreviousPosition != StepperNextPreviousPosition.RIGHT ) ) return;
			
			_nextPreviousPosition = s;
			
			invalidate( InvalidationType.SIZE ); 
		}
		
		/**
		 * @private
		 */
		protected var _textButtonSpacing : Number = 0;

		[Inspectable(defaultValue=0)]
		/**
		 * @inheritDoc
		 */
		public function get textButtonSpacing() : Number
		{
			return _textButtonSpacing;
		}
		
		public function set textButtonSpacing( n : Number ) : void
		{
			if( _textButtonSpacing == n || ( _inspector && !_isLivePreview && _textButtonSpacing != 0 ) ) return;
			
			_textButtonSpacing = n;
			
			invalidate( InvalidationType.SIZE ); 
		}
		
		[Inspectable]
		/**
		 * @inheritDoc
		 */
		public function get icon() : *
		{
			return _textInput.icon;
		}
		
		public function set icon( icon : * ) : void
		{
			_textInput.icon = icon;
		}
		
		[Inspectable(defaultValue="left",enumeration="left,center,right")]
		/**
		 * @inheritDoc
		 */
		public function get horizontalAlignment() : String
		{
			return _textInput.horizontalAlignment;
		}
		
		public function set horizontalAlignment( s : String ) : void
		{
			if( _inspector && !_isLivePreview && _textInput.horizontalAlignment != LabelAlignment.LEFT ) return;
			
			_textInput.horizontalAlignment = s;
		}
		
		[Inspectable(defaultValue="center",enumeration="top,center,bottom")]
		/**
		 * @inheritDoc
		 */
		public function get verticalAlignment() : String
		{
			return _textInput.verticalAlignment;
		}
		
		public function set verticalAlignment( s : String ) : void
		{
			if( _inspector && !_isLivePreview && _textInput.verticalAlignment != LabelAlignment.CENTER ) return;
			
			_textInput.verticalAlignment = s;
		}
		
		[Inspectable]
		/**
		 * @inheritDoc
		 */
		public function get embedFonts() : Boolean
		{
			return _textInput.embedFonts;
		}
		
		public function set embedFonts( b : Boolean ) : void
		{
			if( _inspector && !_isLivePreview && _textInput.embedFonts ) return;
			
			_textInput.embedFonts = b;
		}
		
		[Inspectable(defaultValue="right",enumeration="left,top,right,bottom")]
		/**
		 * @inheritDoc
		 */
		public function get labelPlacement() : String
		{
			return _textInput.labelPlacement;
		}
		
		public function set labelPlacement( s : String ) : void
		{
			if( _inspector && !_isLivePreview && _textInput.labelPlacement != LabelPlacement.RIGHT ) return;
			
			_textInput.labelPlacement = s;
		}
		
		/**
		 * @inheritDoc
		 */
		public function get labelIconSpacing() : Number
		{
			return _textInput.labelIconSpacing;
		}
		
		public function set labelIconSpacing( n : Number ) : void
		{
			_textInput.labelIconSpacing = n;
		}
		
		/**
		 * @inheritDoc
		 */
		public function get padding() : Padding
		{
			return _textInput.padding;
		}
		
		public function set padding( padding : Padding ) : void
		{
			_textInput.padding = padding;
		}
		
		[Inspectable(name="textPadding",type="Object",defaultValue="left:2,top:2,right:2,bottom:2")]
		/**
		 * @private
		 */
		public function set inspectableTextPadding( padding : Object ) : void
		{
			if( !_inspector && !_isLivePreview ) throw new Error( this + " inspectableTextPadding property is internal and used by Flash component inspector panel , use padding property instead" );
			
			if( _inspector && !_isLivePreview && ( _textInput.padding.left != 2 || _textInput.padding.top != 2 || _textInput.padding.right != 2 || _textInput.padding.bottom != 2 ) ) return;
			
			_textInput.padding = new Padding( padding.left , padding.top , padding.right , padding.bottom );
		}
		
		/**
		 * @inheritDoc
		 */
		public function get textStyle () : TextStyle
		{
			return _textInput.textStyle;
		}
		
		public function set textStyle ( style : TextStyle ) : void
		{
			_textInput.textStyle  = style;
		}
		
		[Inspectable]
		/**
		 * @inheritDoc
		 */
		public function get html() : Boolean
		{
			return _textInput.html;
		}
		
		public function set html( b : Boolean ) : void
		{
			if( _inspector && !_isLivePreview && _textInput.html ) return;
			
			_textInput.html = b;
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
			
			_textInput.text = s;
		}
		
		/**
		 * @inheritDoc
		 */
		public function get htmlText () : String
		{
			return _textInput.htmlText;
		}
		
		public function set htmlText ( s : String ) : void
		{
			_textInput.htmlText = s;
		}
		
		[Inspectable(type="Color",defaultValue="#CCCCCC")]
		/**
		 * @inheritDoc
		 */
		public function get disabledTextColor() : uint
		{
			return _textInput.disabledTextColor;
		}
		
		public function set disabledTextColor( n : uint ) : void
		{
			if( _inspector && !_isLivePreview && _textInput.disabledTextColor != 0xCCCCCC ) return;
			
			_textInput.disabledTextColor = n;
		}
		
		/**
		 * @private
		 */
		protected var _textField : TextField;
		
		/**
		 * @inheritDoc
		 */
		public function get textField () : TextField
		{
			return _textField;
		}
		 
		/**
		 * @private
		 */
		protected var _nextAsset : IAsset;
		
		/**
		 * @inheritDoc
		 */
		public function get nextAsset() : IAsset
		{
			return _nextAsset;
		}
		
		/**
		 * @private
		 */
		protected var _previousAsset : IAsset;
		
		/**
		 * @inheritDoc
		 */
		public function get previousAsset() : IAsset
		{
			return _previousAsset;
		}
		
		/**
		 * @private
		 */
		protected var _textInput : ITextInput;

		/**
		 * @inheritDoc
		 */
		public function get textInput () : ITextInput
		{
			return _textInput;
		}

		/**
		 * @private
		 */
		public function AStepper( parentContainer : DisplayObjectContainer = null , initStyle : Object = null , skin : IStepperSkin = null )
		{
			_stepperSkin = skin == null ? my_skinset.getStepperSkin() : skin;
			
			super( parentContainer , initStyle , _stepperSkin );
			
			_skin = _stepperSkin;
		}
		
		/**
		 * @inheritDoc
		 */
		public function next(  ) : void
		{
			_next();
		}
		
		/**
		 * @inheritDoc
		 */
		public function previous(  ) : void
		{
			_previous();
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
		public override function setValue( value : * ) : void
		{
			
		}
		
		/**
		 * @private
		 */
		protected override function _createChildren(  ) : void
		{
			_nextAsset = _stepperSkin.getNextAsset( );
			_previousAsset = _stepperSkin.getPreviousAsset( );
			_textInput = _stepperSkin.getTextInputAsset( );
			_textField = _textInput.textField;
			
			_nextAsset.owner = this;
			_previousAsset.owner = this;
			_textInput.owner = this;
			
			_defaultNextButtonWidth = _nextAsset.width;
			_defaultNextButtonHeight = _nextAsset.height;
			
			_defaultPreviousButtonWidth = _previousAsset.width;
			_defaultPreviousButtonHeight = _previousAsset.height;
			
			addChild( _textInput as DisplayObject );
			addChild( _nextAsset as DisplayObject );
			addChild( _previousAsset as DisplayObject );
		}
		
		/**
		 * @private
		 */
		protected override function _init(  ) : void
		{
			_textInput.textField.addEventListener( Event.CHANGE , _labelChanged , false , 0 , true );
			
			_textInput.textField.type = TextFieldType.DYNAMIC;
			_textInput.textField.selectable =
			_textInput.mouseEnabled = _textInput.mouseChildren = false;
			_textInput.focusEnabled = false;
			
			_nextAsset.addEventListener( MouseEvent.CLICK , _next , false , 0 , true );			_nextAsset.addEventListener( ButtonEvent.REPEAT_MOUSE_DOWN , _next , false , 0 , true );
			_previousAsset.addEventListener( MouseEvent.CLICK , _previous , false , 0 , true );			_previousAsset.addEventListener( ButtonEvent.REPEAT_MOUSE_DOWN , _previous , false , 0 , true );
			
			_nextAsset.focusEnabled = _previousAsset.focusEnabled = false;
			
			addEventListener( KeyboardEvent.KEY_DOWN , _keyDown , false , 0 , true );
		}
		
		/**
		 * @private
		 */
		protected override function _draw(  ) : void
		{
			if( isInvalidate( InvalidationType.SIZE ) )
			{
				switch( true ) 
				{
					case _nextPreviousPosition == StepperNextPreviousPosition.LEFT_RIGHT : 
					
						if( _resizeButton ) _nextAsset.height = _previousAsset.height = _height;
						else 
						{
							_nextAsset.height = _defaultNextButtonHeight;
							_previousAsset.height = _defaultPreviousButtonHeight;
						}
						
						_nextAsset.width = _defaultNextButtonWidth;
						_previousAsset.width = _defaultPreviousButtonWidth;
						
						_textInput.x = _previousAsset.width + _textButtonSpacing;
						_textInput.y = 0;
						_textInput.setSize( _width - _nextAsset.width - _previousAsset.width - 2 * _textButtonSpacing , _height );
						
						_previousAsset.x = 0;
						_previousAsset.y = ( _height - _previousAsset.height ) / 2;	
						_nextAsset.x = _width - _nextAsset.width;
						_nextAsset.y = ( _height - _nextAsset.height ) / 2;	
						
						break;
						
					case _nextPreviousPosition == StepperNextPreviousPosition.TOP_BOTTOM : 
					
						if( _resizeButton ) _nextAsset.width = _previousAsset.width = _width;
						else 
						{
							_nextAsset.width = _defaultNextButtonWidth;
							_previousAsset.width = _defaultPreviousButtonWidth;
						}
						
						_nextAsset.height = _defaultNextButtonHeight;
						_previousAsset.height = _defaultPreviousButtonHeight;
						
						_textInput.x = 0;
						_textInput.y = _nextAsset.height + _textButtonSpacing;
						_textInput.setSize( _width , _height - _nextAsset.height - _previousAsset.height - 2 * _textButtonSpacing );
						
						_nextAsset.x = ( _width - _nextAsset.width ) / 2;
						_nextAsset.y = 0;	
						_previousAsset.x = ( _width - _previousAsset.width ) / 2;
						_previousAsset.y = _height - _previousAsset.height;	
						
						break;
						
					case _nextPreviousPosition == StepperNextPreviousPosition.LEFT : 
					
						if( _resizeButton ) _nextAsset.height = _previousAsset.height = _height / 2;
						else 
						{
							_nextAsset.height = _defaultNextButtonHeight;
							_previousAsset.height = _defaultPreviousButtonHeight;
						}
						
						_nextAsset.width = _defaultNextButtonWidth;
						_previousAsset.width = _defaultPreviousButtonWidth;
						
						_textInput.x = _nextAsset.width + _textButtonSpacing;
						_textInput.y = 0;
						_textInput.setSize( _width - _nextAsset.width - _textButtonSpacing , _height );
						
						_nextAsset.x = _previousAsset.x = 0;
						_nextAsset.y = ( _height / 2 ) - _nextAsset.height;
						_previousAsset.y = ( _height / 2 );
						
						break;
						
					case _nextPreviousPosition == StepperNextPreviousPosition.TOP : 
					
						if( _resizeButton ) _nextAsset.width = _previousAsset.width = _width / 2;
						else 
						{
							_nextAsset.width = _defaultNextButtonWidth;
							_previousAsset.width = _defaultPreviousButtonWidth;
						}
						
						_nextAsset.height = _defaultNextButtonHeight;
						_previousAsset.height = _defaultPreviousButtonHeight;
						
						_textInput.x = 0;
						_textInput.y = _nextAsset.height + _textButtonSpacing;
						_textInput.setSize( _width , _height - _nextAsset.height - _textButtonSpacing );
						
						_nextAsset.x = ( _width / 2 );
						_nextAsset.y = 0;
						_previousAsset.x = ( _width / 2 ) - _previousAsset.width;
						_previousAsset.y = 0;
						
						break;
						
					case _nextPreviousPosition == StepperNextPreviousPosition.BOTTOM : 
					
						if( _resizeButton ) _nextAsset.width = _previousAsset.width = _width / 2;
						else 
						{
							_nextAsset.width = _defaultNextButtonWidth;
							_previousAsset.width = _defaultPreviousButtonWidth;
						}
						
						_nextAsset.height = _defaultNextButtonHeight;
						_previousAsset.height = _defaultPreviousButtonHeight;
						
						_textInput.x = 0;
						_textInput.y = 0;
						_textInput.setSize( _width , _height - _nextAsset.height - _textButtonSpacing );
						
						_nextAsset.x = ( _width / 2 );
						_nextAsset.y = _height - _nextAsset.height;
						_previousAsset.x = ( _width / 2 ) - _previousAsset.width;
						_previousAsset.y = _height - _nextAsset.height;
						
						break;
						
					default :
						
						if( _resizeButton ) _nextAsset.height = _previousAsset.height = _height / 2;
						else 
						{
							_nextAsset.height = _defaultNextButtonHeight;
							_previousAsset.height = _defaultPreviousButtonHeight;
						}
						
						_nextAsset.width = _defaultNextButtonWidth;
						_previousAsset.width = _defaultPreviousButtonWidth;
						
						_textInput.x = 0;
						_textInput.y = 0;
						_textInput.setSize( _width - _nextAsset.width - _textButtonSpacing , _height );
						
						_nextAsset.x = _previousAsset.x = _width - _nextAsset.width;
						_nextAsset.y = ( _height / 2 ) - _nextAsset.height;
						_previousAsset.y = ( _height / 2 );
						
						_nextPreviousPosition = StepperNextPreviousPosition.RIGHT;
				}	
				
				_nextAsset.draw();		
				_previousAsset.draw();
				_textInput.draw();		
			}
		}
		
		/**
		 * @private
		 */
		protected function _next( e : Event = null ) : void
		{
			if( e is ButtonEvent ) _nextAsset.removeEventListener( MouseEvent.CLICK , _next );
		}

		/**
		 * @private
		 */
		protected function _previous( e : Event = null ) : void
		{
			if( e is ButtonEvent ) _previousAsset.removeEventListener( MouseEvent.CLICK , _previous );
		}
		
		/**
		 * @private
		 */
		protected function _labelChanged ( e : Event = null ) : void
		{
			
		}
		
		/**
		 * @private
		 */
		protected function _keyDown( e : KeyboardEvent ) : void
		{
			switch( true ) 
			{
				case e.keyCode == Keyboard.LEFT || e.keyCode == Keyboard.DOWN || e.keyCode == Keyboard.NUMPAD_SUBTRACT : 
					_previous(); break;				case e.keyCode == Keyboard.RIGHT || e.keyCode == Keyboard.UP || e.keyCode == Keyboard.NUMPAD_ADD : 
					_next(); break;
			}
		}
	}
}
