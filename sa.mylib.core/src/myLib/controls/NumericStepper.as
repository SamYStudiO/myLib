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
	import myLib.controls.skins.IStepperSkin;
	import myLib.core.AStepper;
	import myLib.events.ComponentEvent;

	import flash.display.DisplayObjectContainer;
	import flash.display.InteractiveObject;
	import flash.events.Event;
	import flash.events.FocusEvent;
	import flash.events.KeyboardEvent;
	import flash.events.TextEvent;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.ui.Keyboard;
	
	/**
     * Defines the value of the type property of a valueChange event object.
     * 
     * @eventType valueChange
     */
    [Event(name="valueChange", type="myLib.events.ComponentEvent")]
	
	/**
	 * @author SamYStudiO
	 */
	public class NumericStepper extends AStepper implements INumericStepper 
	{
		/**
		 * @private
		 */
		protected var _minimum : Number = 0;
		
		[Inspectable(defaultValue=0)]
		/**
		 * @inheritDoc
		 */
		public function get minimum() : Number
		{
			return _minimum;
		}
		
		public function set minimum( n : Number ) : void
		{
			if( _minimum == n || ( _inspector && !_isLivePreview && _minimum != 0 ) ) return;
			
			_minimum = n;
			
			if( _value < n ) value = n;
		}

		/**
		 * @private
		 */
		protected var _maximum : Number = 10;
		
		[Inspectable(defaultValue=10)]
		/**
		 * @inheritDoc
		 */
		public function get maximum() : Number
		{
			return _maximum;
		}
		
		public function set maximum( n : Number ) : void
		{
			if( _maximum == n || ( _inspector && !_isLivePreview && _maximum != 10 ) ) return;
			
			_maximum = n;
			
			if( _value > n ) value = n;
		}
		
		/**
		 * @private
		 */
		protected var _stepSize : Number = 1;
		
		[Inspectable(defaultValue=1)]
		/**
		 * @inheritDoc
		 */
		public function get stepSize() : Number
		{
			return _stepSize;
		}
		
		public function set stepSize( n : Number ) : void
		{
			if( _stepSize == n || ( _inspector && !_isLivePreview && _stepSize != 1 ) ) return;
			
			_stepSize = n;
			
			value = _value;
		}
		
		/**
		 * @private
		 */
		protected var _value : Number = 0;
		
		[Inspectable(defaultValue=0)]
		/**
		 * @inheritDoc
		 */
		public function get value() : Number
		{
			return _value;
		}
		
		public function set value( n : Number ) : void
		{
			if( ( _value == n && Number( _textInput.text ) == _value ) || ( _inspector && !_isLivePreview && _value != 0 ) ) return;
			
			if( isNaN( n ) ) _textInput.text = "";
			else
			{
				var m : Number = n % _stepSize;
				
				if( m == 0 ) { /*good value*/ }
				else if( m < _stepSize / 2 ) n = n - m;
				else n = n + _stepSize - m;
				
				n = Math.max( Math.min( _maximum , n ) , _minimum );
				
				_textInput.text = String( n );
			}
			
			if( _value != n )
			{
				_value = n;
				
				dispatchEvent( new ComponentEvent( ComponentEvent.VALUE_CHANGE ) );
			}
		}
		
		[Inspectable(defaultValue=true)]
		/**
		 * @inheritDoc
		 */
		public override function get editable() : Boolean
		{
			return super.editable;
		}
		
		public override function set editable( b : Boolean ) : void
		{
			if( _editable == b || ( _inspector && !_isLivePreview && !_editable ) ) return;
			
			_editable = b;
			_textInput.textField.type = b ? TextFieldType.INPUT : TextFieldType.DYNAMIC;
			_textInput.textField.selectable =
			_textInput.mouseEnabled = _textInput.mouseChildren = _enabled ? b : false;
			
			_focusTarget = _editable ? _textInput as InteractiveObject : null;
		}
		
		/**
		 * @inheritDoc
		 */
		public override function get text() : String
		{
			return _textInput.text;
		}
		
		public override function set text( s : String ) : void
		{
			_textInput.text = s;
		}
		
		/**
		 * Build a new NumericStepper instance. Default size is 100*20.
		 * @param parentContainer The parent DisplayObjectContainer where add this NumericStepper.
		 * @param initStyle The initial style object for NumericStepper initialization.
		 * @param skin The IStepperSkin to use instead of default skin.
		 * 
		 * @see myLib.styles.StyleManager
		 */
		public function NumericStepper( parentContainer : DisplayObjectContainer = null , initStyle : Object = null , skin : IStepperSkin = null )
		{
			super( parentContainer , initStyle , skin );
		}
		
		/**
		 * @inheritDoc
		 */
		public override function getValue(  ) : *
		{
			return _value;
		}
		
		/**
		 * @inheritDoc
		 */
		public override function setValue( value : * ) : void
		{
			this.value = Number( value );
		}
		
		/**
		 * @private
		 */
		protected override function _init(  ) : void
		{
			super._init();
			
			_textInput.textField.restrict = "0-9\\-";
			_textInput.textField.addEventListener( TextEvent.TEXT_INPUT , _inputChanged , false , 0 , true );
			_textInput.text = "0";
			
			editable = true;
		}
		
		/**
		 * @private
		 */
		protected override function _next( e : Event = null ) : void
		{
			if( _invertNextPrevious ) value -= _stepSize;
			else value += _stepSize;
			
			super._next( e );
		}

		/**
		 * @private
		 */
		protected override function _previous( e : Event = null ) : void
		{
			if( _invertNextPrevious ) value += _stepSize;
			else value -= _stepSize;
			
			super._previous( e );
		}
		
		/**
		 * @private
		 */
		protected override function _labelChanged( e : Event = null ) : void
		{
			if( _textInput.text == "-" ) return;
			
			value = Number( _textInput.text );
		}

		/**
		 * @private
		 */
		protected function _inputChanged( e : TextEvent ) : void
		{
			if( ( e.text == "-" && ( e.currentTarget as TextField ).selectionBeginIndex > 0 ) || e.text.indexOf( "-" ) > 0 ) e.preventDefault();
		}
		
		/**
		 * @private
		 */
		protected function _focusOut( e : FocusEvent ) : void
		{
			if( _textInput.text == "-" ) value = _value;
		}
		
		/**
		 * @private
		 */
		protected override function _keyDown( e : KeyboardEvent ) : void
		{
			switch( true ) 
			{
				case e.keyCode == Keyboard.HOME : value = _minimum; break;
				case e.keyCode == Keyboard.END : value = _maximum; break;
				
				default : super._keyDown( e );
			}
		}
	}
}
