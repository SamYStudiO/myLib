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
	import myLib.assets.core;
	import myLib.controls.skins.ISliderSkin;
	import myLib.controls.skins.my_skinset;
	import myLib.core.AFieldComponent;
	import myLib.core.InvalidationType;
	import myLib.events.ComponentEvent;
	import myLib.form.IField;
	import myLib.transitions.Tween;

	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import flash.ui.Keyboard;

	/**
     * Defines the value of the type property of a valueChange event object.
     * 
     * @eventType valueChange
     */
    [Event(name="valueChange", type="myLib.events.ComponentEvent")]
    
	/**
	 * Slider consist of a thumb you can drag along a track.
	 * 
	 * @author SamYStudiO ( contact@samystudio.net )
	 */
	public class Slider extends AFieldComponent implements ISlider, IField
	{
		/**
		 * @private
		 */
		protected var _sliderSkin : ISliderSkin;
		
		/**
		 * @private
		 */
		protected var _thumbTween : Tween;
		
		/**
		 * @private
		 */
		protected var _progressTween : Tween;
		
		/**
		 * @private
		 */
		protected var _isDragging : Boolean;
		
		/**
		 * @private
		 */
		protected var _mouseOffset : Number = 0;
		
		/**
		 * @private
		 */
		protected override function get _defaultHeight() : Number
		{
			return 2;	
		}
		
		/**
		 * @private
		 */
		protected var _allowTrackDrag : Boolean;
		
		[Inspectable]
		/**
		 * @inheritDoc
		 */
		public function get allowTrackDrag() : Boolean
		{
			return _allowTrackDrag;
		}
		
		public function set allowTrackDrag( b : Boolean ) : void
		{
			if( _inspector && !_isLivePreview && _allowTrackDrag ) return;
			
			_allowTrackDrag = b;
		}
		
		/**
		 * @private
		 */
		protected var _allowTrackDragTween : Boolean;
		
		[Inspectable]
		/**
		 * @inheritDoc
		 */
		public function get allowTrackDragTween() : Boolean
		{
			return _allowTrackDragTween;
		}
		
		public function set allowTrackDragTween( b : Boolean ) : void
		{
			if( _inspector && !_isLivePreview && _allowTrackDragTween ) return;
			
			_allowTrackDragTween = b;
		}
		
		/**
		 * @private
		 */
		protected var _allowBoundsTween : Boolean;
		
		[Inspectable]
		/**
		 * @inheritDoc
		 */
		public function get allowBoundsTween() : Boolean
		{
			return _allowBoundsTween;
		}
		
		public function set allowBoundsTween( b : Boolean ) : void
		{
			if( _inspector && !_isLivePreview && _allowBoundsTween ) return;
			
			_allowBoundsTween = b;
		}
		
		/**
		 * @private
		 */
		protected var _thumbTweenDuration : uint = 0;
		
		[Inspectable]
		/**
		 * @inheritDoc
		 */
		public function get thumbTweenDuration() : uint
		{
			return _thumbTweenDuration;
		}
		
		public function set thumbTweenDuration( n : uint ) : void
		{
			if( _inspector && !_isLivePreview && _thumbTweenDuration != 0 ) return;
			
			_thumbTweenDuration = n;
		}
		
		/**
		 * @private
		 */
		protected var _thumbTweenFunction : Function;
		
		/**
		 * @inheritDoc
		 */
		public function get thumbTweenFunction() : Function
		{
			return _thumbTweenFunction;
		}
		
		public function set thumbTweenFunction( f : Function ) : void
		{
			_thumbTweenFunction = f;
		}

		/**
		 * @private
		 */
		protected var _horizontal : Boolean = true;
		
		[Inspectable(defaultValue="horizontal",enumeration="vertical,horizontal")]
		/**
		 * @inheritDoc
		 */
		public function get direction() : String
		{
			return _horizontal ? SliderDirection.HORIZONTAL : SliderDirection.VERTICAL;
		}

		public function set direction( s : String ) : void
		{
			if( s == direction || _isLivePreview || ( _inspector && !_isLivePreview && !_horizontal ) ) return;
			
			_horizontal = s == SliderDirection.HORIZONTAL;
			
			if ( _horizontal && rotation == 90 )
			{
				rotation = 0;
				core::scaleX = 1;
			}
			else if ( !_horizontal && rotation == 0 )
			{
				rotation = 90;
				core::scaleX = -1;	
			}
		}
		
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
			if( _inspector && !_isLivePreview && _minimum != 0 ) return;
			
			_minimum = n;
			
			if( _value < n && !_inspector ) value = n;
			else _updateThumb();
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
			if( _inspector && !_isLivePreview && _maximum != 10 ) return;
			
			_maximum = n;
			
			if( _value > n && !_inspector ) value = n;
			else _updateThumb();
		}
		
		/**
		 * @private
		 */
		protected var _oldValue : Number = 0;
		
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
			if( _inspector && !_isLivePreview && _value != 0 ) return;
			
			var oldValue : Number = _value;
			
			n = isNaN( n ) ? _minimum : n;
			
			if( _snapInterval != 0 )
			{
				var unsigned : Number = Math.abs( n );
				var sens : int = n >= 0 ? 1 : -1;
				
				if( unsigned < _snapInterval / 2 ) _value = 0;
				else if( unsigned < _snapInterval ) _value = _snapInterval * sens;
				else 
				{
					var m : Number = unsigned % _snapInterval;
					var mini : Number = Math.min( _snapInterval - m , m );
					
					_value = mini == _snapInterval - m ? n + mini * sens : n - mini * sens;
				}
			}
			else _value = n;
			
			_value = Math.max( Math.min( _maximum , _value ) , _minimum );
			
			if( oldValue == _value && !_isLivePreview ) return;
			
			_oldValue = oldValue;
			
			_updateThumb();
			
			dispatchEvent( new ComponentEvent( ComponentEvent.VALUE_CHANGE ) );
		}
		
		/**
		 * @private
		 */
		protected var _snapInterval : Number = 0;
		
		[Inspectable(defaultValue=0)]
		/**
		 * @inheritDoc
		 */
		public function get snapInterval() : Number
		{
			return _snapInterval;
		}
		
		public function set snapInterval( n : Number ) : void
		{
			if( _inspector && !_isLivePreview && _snapInterval != 0 ) return;
			
			_snapInterval = Math.abs( n );
			
			value = _value;
		}
		
		/**
		 * @private
		 */
		protected var _thumbVerticalAlignment : String = SliderThumbAlignment.CENTER;
		
		[Inspectable(defaultValue="center",enumeration="top,center,bottom")]
		/**
		 * @inheritDoc
		 */
		public function get thumbVerticalAlignment() : String
		{
			return _thumbVerticalAlignment;
		}
		
		public function set thumbVerticalAlignment( s : String ) : void
		{
			if( _thumbVerticalAlignment == s || ( _inspector && !_isLivePreview && _thumbVerticalAlignment != SliderThumbAlignment.CENTER ) ) return;
			
			_thumbVerticalAlignment = s;
			
			invalidate( InvalidationType.SIZE );
		}
		 
		/**
		 * @private
		 */
		protected var _trackAsset : IAsset;
		
		/**
		 * @inheritDoc
		 */
		public function get trackAsset() : IAsset
		{
			return _trackAsset;
		}
		
		/**
		 * @private
		 */
		protected var _thumbAsset : IAsset;
		
		/**
		 * @inheritDoc
		 */
		public function get thumbAsset() : IAsset
		{
			return _thumbAsset;
		}
		
		/**
		 * @private
		 */
		protected var _progressAsset : IAsset;
		
		/**
		 * @inheritDoc
		 */
		public function get progressAsset() : IAsset
		{
			return _progressAsset;
		}
		
		/**
		 * @inheritDoc
		 */
		public override function get width() : Number
		{
			return _horizontal ? _width : _height;
		}
		
		public override function set width( w : Number ) : void
		{
			super.width = w;
		}
	
		
		/**
		 * @inheritDoc
		 */
		public override function get height() : Number
		{
			return _horizontal ? _height : _width;
		}
		
		public override function set height( h : Number ) : void
		{
			super.height = h;
		}

		/**
		 * Build a new Slider instance. Default size is 100*2.
		 * @param parentContainer The parent DisplayObjectContainer where add this Slider.
		 * @param initStyle The initial style object for Slider initialization.
		 * @param skin The ISliderSkin to use instead of default skin.
		 * 
		 * @see myLib.styles.StyleManager
		 */
		public function Slider ( parentContainer : DisplayObjectContainer = null , initStyle : Object = null , skin : ISliderSkin = null )
		{
			_sliderSkin = skin == null ? my_skinset.getSliderSkin() : skin;
			
			super( parentContainer , initStyle , _sliderSkin );
		}
		
		/**
		 * @inheritDoc
		 */
		public override function setSize( w : Number , h : Number ) : void
		{
			if( _horizontal ) super.setSize( w , h );
			else super.setSize( h , w );
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
		protected override function _createChildren(  ) : void
		{
			_trackAsset = _sliderSkin.getTrackAsset();			_thumbAsset = _sliderSkin.getThumbAsset();			_progressAsset = _sliderSkin.getProgressAsset();
			
			if( _trackAsset != null )
			{
				_trackAsset.owner =this;
				addChild( _trackAsset as DisplayObject );			}
			if( _progressAsset != null )
			{
				_progressAsset.owner = this;
				_progressAsset.mouseEnabled = false;				_progressAsset.mouseChildren = false;
				
				addChild( _progressAsset as DisplayObject );	
			}			if( _thumbAsset != null )
			{
				_thumbAsset.owner = this;
				addChild( _thumbAsset as DisplayObject );
			}
		}
		
		/**
		 * @private
		 */
		protected override function _init(  ) : void
		{
			if( _thumbAsset != null )
			{
				_thumbAsset.addEventListener( MouseEvent.MOUSE_DOWN , _thumbDown , false , 0 , true );				_thumbAsset.addEventListener( MouseEvent.MOUSE_UP , _thumbUp , false , 0 , true );
				_thumbAsset.focusEnabled = false;
			}			
			if( _trackAsset != null )
			{
				_trackAsset.addEventListener( MouseEvent.MOUSE_DOWN , _trackDown , false , 0 , true );				_trackAsset.addEventListener( MouseEvent.MOUSE_UP , _trackUp , false , 0 , true );				_trackAsset.addEventListener( MouseEvent.CLICK , _move , false , 0 , true );
				_trackAsset.focusEnabled = false;
			}
			
			_errorRectDepth = 2;
			
			addEventListener( KeyboardEvent.KEY_DOWN , _keyDown , false , 0 , true );
		}
		
		/**
		 * @private
		 */
		protected override function _draw(  ) : void
		{
			if( isInvalidate( InvalidationType.SIZE ) )
			{
				if( _trackAsset != null ) _trackAsset.setSize( _width , _height );
				
				if( _progressAsset != null ) _progressAsset.setSize( 0 , _height );
					
				if( _thumbAsset != null && _trackAsset != null )
				{
					var r : Rectangle = _thumbAsset.getRect( this );
					var offset : Number = r.y - _thumbAsset.y;
					offset = _thumbAsset.height / 2 - offset;
					
					switch( _thumbVerticalAlignment ) 
					{
						case SliderThumbAlignment.BOTTOM : _thumbAsset.y = _trackAsset.height - offset; break;
						case SliderThumbAlignment.CENTER : _thumbAsset.y = _trackAsset.height / 2 - offset; break;
						
						default : _thumbAsset.y = -offset; break;
					}
				}
				
				_updateThumb( true );
				
				_trackAsset.draw();
				_progressAsset.draw();
				_thumbAsset.draw();
			}
		}
		
		/**
		 * @private
		 */
		protected function _thumbDown( e : MouseEvent ) : void
		{
			_mouseOffset = thumbAsset.mouseX;
			
			stage.addEventListener( MouseEvent.MOUSE_MOVE , _move , false , 0 , true );			stage.addEventListener( MouseEvent.MOUSE_UP , _thumbUp , false , 0 , true );
			
			_isDragging = true;
		}
		
		/**
		 * @private
		 */
		protected function _thumbUp( e : MouseEvent ) : void
		{
			_mouseOffset = 0;
			
			stage.removeEventListener( MouseEvent.MOUSE_MOVE , _move );			stage.removeEventListener( MouseEvent.MOUSE_UP , _thumbUp );
			
			_isDragging = false;
		}
		
		/**
		 * @private
		 */
		protected function _trackDown( e : MouseEvent ) : void
		{
			if( !_allowTrackDrag ) return;
			
			_move();
			
			stage.addEventListener( MouseEvent.MOUSE_MOVE , _move , false , 0 , true );
			stage.addEventListener( MouseEvent.MOUSE_UP , _trackUp , false , 0 , true );
		}
		
		/**
		 * @private
		 */
		protected function _trackUp( e : MouseEvent ) : void
		{
			stage.removeEventListener( MouseEvent.MOUSE_MOVE , _move );
			stage.removeEventListener( MouseEvent.MOUSE_UP , _trackUp );
		}
		
		/**
		 * @private
		 */
		// TODO if thumbAsset has no graphics and with should be 0 width is 100??? (defaut button size)
		// Actually thumb asset is created even if there is no asset definition. @see SliderSkin.getThumbAsset
		protected function _move( e : MouseEvent = null ) : void
		{
			var s : Sprite = _thumbAsset as Sprite;
			var thumbWidth : Number = s == null || s.width == 0 || ( e != null && e.currentTarget == _trackAsset ) ? 0 : s.width;
			var thumbOffset : Number = s == null || s.width == 0 || ( e != null && e.currentTarget == _trackAsset ) ? 0 : -( s.getRect( this ).x - s.x );
			
			value = ( ( mouseX - _mouseOffset ) / ( _width - ( thumbWidth - thumbOffset ) + thumbOffset ) ) * ( _maximum - _minimum ) + _minimum;
		}
		
		/**
		 * @private
		 */
		protected function _updateThumb( resize : Boolean = false ) : void
		{
			var r : Number = ( _value - _minimum ) / ( _maximum - _minimum );
			
			if( _thumbAsset != null )
			{
				var s : Sprite = _thumbAsset as Sprite;
				var thumbWidth : Number = s == null || s.width == 0 ? 0 : s.width;
				var thumbOffset : Number = s == null || s.width == 0 ? 0 : -( s.getRect( this ).x - s.x );
				var x : Number = r * ( _width - ( thumbWidth - thumbOffset ) + thumbOffset );
			}
			
			var distance : Number = Math.abs( _value - _oldValue );			var distanceMax : Number = _maximum - _minimum;
			
			if( _thumbTweenDuration == 0 || ( _isDragging && !_allowTrackDragTween ) || resize || ( !_allowBoundsTween && distance == distanceMax ) )
			{
				if( _thumbTween != null ) _thumbTween.stop();
				if( _progressTween != null ) _progressTween.stop();
				
				if( _thumbAsset != null ) _thumbAsset.x = x;
				if( _progressAsset != null ) _progressAsset.width = r * _width;
			}
			else
			{
				if( _thumbTween != null ) _thumbTween.stop();				if( _progressTween != null ) _progressTween.stop();
				
				if( _thumbAsset != null )
					_thumbTween = new Tween( _thumbAsset , "x" , _thumbTweenFunction , _thumbAsset.x , x , _thumbTweenDuration , true );				
				if( _progressAsset != null )
					_progressTween = new Tween( _progressAsset , "width" , _thumbTweenFunction , _progressAsset.width , r * _width , _thumbTweenDuration , true );
			}
		}
		
		/**
		 * @private
		 */
		protected function _keyDown ( e : KeyboardEvent ) : void
		{
			var size : Number = _snapInterval == 0 ? 1 : _snapInterval;
			
			switch( e.keyCode )
			{
				case Keyboard.LEFT : value -= size; break;				case Keyboard.RIGHT : value += size; break;				case Keyboard.DOWN : value += size; break;				case Keyboard.UP : value -= size; break;				case Keyboard.END : value = _maximum; break;				case Keyboard.HOME : value = _minimum; break;
			}
		}
	}
}
