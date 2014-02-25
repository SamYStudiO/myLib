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
package myLib.controls {
	import myLib.controls.skins.ISkin;
	import myLib.core.AComponent;
	import myLib.core.IScroll;
	import myLib.core.InvalidationType;
	import myLib.events.ComponentEvent;
	import myLib.utils.ClassUtils;

	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.utils.getDefinitionByName;
	/**
	 * ScrollPane is a manager fo an horizontal and verical scroll component.
	 * ScrollPane is equivalent to add a horizontal and a vertical scroll with the same target, this only make easier scrolls resize.
	 * 
	 * @author SamYStudiO ( contact@samystudio.net )
	 */
	public class ScrollPane extends AComponent implements IScrollPane	{
		/**
		 * @private
		 */
		protected var _scrollSkin : ISkin;
		
		/**
		 * @private
		 */
		protected override function get _defaultHeight() : Number
		{
			return 100;	
		}

		[Inspectable]
		/**
		 * @private
		 */
		public function get scrollTargetName() : String
		{
			return _scrollTarget.name;	
		}
		
		public function set scrollTargetName( target : String ) : void
		{
			if( !_inspector && !_isLivePreview ) throw new Error( this + " scrollTargetName property is internal and used by Flash component inspector panel , use scrollTarget property to assign a DisplayObject" );
			
			if( _inspector && !_isLivePreview && _scrollTarget != null ) return;
			
			if( _scrollTarget != null ) return;
			
			try
			{
				scrollTarget = parent.getChildByName( target );
			}
			catch ( e : Error )
			{
				throw new Error( this + " ScrollTarget named '" + target + "' not found" );
			}
		}
		
		/**
		 * @private
		 */
		protected var _scrollTarget : DisplayObject;
		
		/**
		 * @inheritDoc
		 */
		public function get scrollTarget () : DisplayObject
		{
			return _scrollTarget;
		}
		
		public function set scrollTarget( o : DisplayObject ) : void
		{
			if( o == _scrollTarget ) return;
			
			if( _verticalScroll != null )
			{
				_verticalScroll.scrollTarget = o;				_horizontalScroll.scrollTarget = o;
			}
			
			if( _scrollTarget != null && contains( _scrollTarget ) ) removeChild( _scrollTarget );
			
			_scrollTarget = o;
			
			addChildAt( _scrollTarget , 0 );
			
			invalidate( InvalidationType.DATA );
		}
		
		/**
		 * @private
		 */
		protected var _scrollRenderer : * = ScrollBar;
		
		[Inspectable(defaultValue="myLib.controls.ScrollBar",enumeration="myLib.controls.ScrollBar,myLib.controls.MouseScroll,myLib.controls.PanoramaScroll")]
		/**
		 * @inheritDoc
		 */
		public function get scrollRenderer() : *
		{
			return _scrollRenderer;
		}
		
		public function set scrollRenderer( definition : * ) : void
		{
			if( _inspector && !_isLivePreview && _scrollRenderer != ScrollBar ) return;
			
			_scrollRenderer = definition;
			
			_createChildren( );
			_init( );
			_draw( );
		}
		
		/**
		 * @private
		 */
		protected var _scrollSize : Number = 20;

		[Inspectable(defaultValue=20)]
		/**
		 * @inheritDoc
		 */
		public function get scrollSize() : Number
		{
			return _scrollSize;
		}
		
		public function set scrollSize( n : Number ) : void
		{
			if( !isNaN( _scrollSnap ) || ( _inspector && !_isLivePreview && _scrollSize != 20 ) ) return;
			
			_scrollSize = n;
			
			_verticalScroll.scrollSize = _scrollSize;
			_horizontalScroll.scrollSize = _scrollSize;
		}
		
		/**
		 * @private
		 */
		protected var _scrollSnap : Number;
		
		/**
		 * @inheritDoc
		 */
		public function get scrollSnap() : Number
		{
			return _scrollSnap;
		}
		
		public function set scrollSnap( n : Number ) : void
		{
			if( _inspector && !_isLivePreview && !isNaN( _scrollSnap ) ) return;
			
			_scrollSnap = n;
            if( !isNaN( _scrollSnap ) ) _scrollSize = n;
			
			_verticalScroll.scrollSnap = _scrollSnap;
			_horizontalScroll.scrollSnap = _scrollSnap;
		}
		
		/**
		 * @private
		 */
		protected var _useBitmapScrolling : Boolean;
		
		[Inspectable(defaultValue=false)]
		/**
		 * @inheritDoc
		 */
		public function get useBitmapScrolling() : Boolean
		{
			return _useBitmapScrolling;
		}
		
		public function set useBitmapScrolling( b : Boolean ) : void
		{
			if( _inspector && !_isLivePreview && _useBitmapScrolling ) return;
			
			_useBitmapScrolling = b;
			
			_verticalScroll.useBitmapScrolling = _useBitmapScrolling;
			_horizontalScroll.useBitmapScrolling = _useBitmapScrolling;
		}
		
		/**
		 * @private
		 */
		protected var _scrollTweenFunction : Function;
		
		/**
		 * @inheritDoc
		 */
		public function get scrollTweenFunction() : Function
		{
			return _scrollTweenFunction;
		}
		
		public function set scrollTweenFunction( easeFunction : Function ) : void
		{
			if( isNaN( _scrollTweenDuration ) ) _scrollTweenDuration = 10;
			
			_verticalScroll.scrollTweenFunction = _scrollTweenFunction;
			_horizontalScroll.scrollTweenFunction = _scrollTweenFunction;
		}
		
		/**
		 * @private
		 */
		protected var _scrollTweenDuration : Number = 10;
		
		/**
		 * @inheritDoc
		 */
		public function get scrollTweenDuration() : Number
		{
			return _scrollTweenDuration;
		}
		
		public function set scrollTweenDuration( n : Number ) : void
		{
			_scrollTweenDuration = n;
			
			_verticalScroll.scrollTweenDuration = _scrollTweenDuration;
			_horizontalScroll.scrollTweenDuration = _scrollTweenDuration;
		}
		
		/**
		 * @inheritDoc
		 */
		public function get maxScrollV() : Number
		{
			return _verticalScroll.maxScroll;
		}
		
		/**
		 * @inheritDoc
		 */
		public function get maxScrollH() : Number
		{
			return _horizontalScroll.maxScroll;
		}
		
		/**
		 * @inheritDoc
		 */
		public function get usefulV() : Boolean
		{
			return _verticalScroll.useful;
		}
		
		/**
		 * @inheritDoc
		 */
		public function get usefulH() : Boolean
		{
			return _horizontalScroll.useful;
		}
		
		/**
		 * @private
		 */
		protected var _verticalScroll : IScroll;
		
		/**
		 * @inheritDoc
		 */
		public function get verticalScroll () : IScroll
		{
			return _verticalScroll;
		}
		
		/**
		 * @private
		 */
		protected var _horizontalScroll : IScroll;
		
		/**
		 * @inheritDoc
		 */
		public function get horizontalScroll () : IScroll
		{
			return _horizontalScroll;
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
			
			_verticalScroll.enabled = _horizontalScroll.enabled = b;
			
			super.enabled = b;
		}
		
		/**
		 * Build a new ScrollPane instance. Default size is 100*100.
		 * @param parentContainer The parent DisplayObjectContainer where add this ScrollPane.
		 * @param initStyle The initial style object for ScrollPane initialization.
		 * @param skin The scrollBarSkin to use with ScrollBar instances.
		 * 
		 * @see myLib.styles.StyleManager
		 */
		public function ScrollPane ( parentContainer : DisplayObjectContainer = null , initStyle : Object = null , scrollSkin : ISkin = null )		{
			_scrollSkin = scrollSkin;
			
			super( parentContainer , initStyle , _scrollSkin );
		}

		/**
		 * @inheritDoc
		 */
		public function update( lockPosition : Boolean = true , newWidth : Number = NaN , newHeight : Number = NaN ) : void
		{
			_verticalScroll.update( lockPosition , newWidth , newHeight );			_horizontalScroll.update( lockPosition , newWidth , newHeight );
			
			invalidate( InvalidationType.DATA );
		}
		
		/**
		 * @inheritDoc
		 */
		public function scroll( verticalAmount : Number , horizontalAmount : Number ) : void
		{
			if( !isNaN( verticalAmount ) ) _verticalScroll.scroll( verticalAmount );
			if( !isNaN( horizontalAmount ) ) _horizontalScroll.scroll( horizontalAmount );
		}
		
		/**
		 * @inheritDoc
		 */
		public function setScrollPosition( verticalPosition : Number , horizontalPosition : Number , percentage : Boolean = false ) : void
		{
			_verticalScroll.setScrollPosition( verticalPosition , percentage );
			_horizontalScroll.setScrollPosition( horizontalPosition , percentage );
		}
		
		/**
		 * @inheritDoc
		 */
		public function getVerticalScrollPosition( percentage : Boolean = false ) : Number
		{
			return _verticalScroll.getScrollPosition( percentage );
		}
		
		/**
		 * @inheritDoc
		 */
		public function getHorizontalScrollPosition( percentage : Boolean = false ) : Number
		{
			return _horizontalScroll.getScrollPosition( percentage );
		}
		
		/**
		 * @inherit
		 */
		public function tweenToPosition( verticalPosition : Number , horizontalPosition : Number , ease : Function = null , duration : Number = 500 , durationAsMilliseconds : Boolean = true ) : void
		{
			_verticalScroll.tweenToPosition( verticalPosition , ease , duration , durationAsMilliseconds );
			_horizontalScroll.tweenToPosition( horizontalPosition , ease , duration , durationAsMilliseconds );
		}
		
		/**
		 * @inheritDoc
		 */
		public function scrollToChild( child : DisplayObject , alignmentPoint : String = null ) : void
		{
			_verticalScroll.scrollToChild( child , alignmentPoint );
			_horizontalScroll.scrollToChild( child , alignmentPoint );
		}
		
		/**
		 * @inheritDoc
		 */
		public function tweenToChild( child : DisplayObject , alignmentPoint : String = null , ease : Function = null , duration : Number = 500 , durationAsMilliseconds : Boolean = true ) : void
		{
			_verticalScroll.tweenToChild( child , alignmentPoint , ease , duration , durationAsMilliseconds );
			_horizontalScroll.tweenToChild( child , alignmentPoint , ease , duration , durationAsMilliseconds );
		}

		/**
		 * @private
		 */
		protected override function _createChildren(  ) : void
		{
			_removeChildren();
			
			var ScrollClass : Class = _scrollRenderer is Class ? _scrollRenderer : getDefinitionByName( _scrollRenderer ) as Class;
			
			if( _verticalScroll != null ) _verticalScroll.scrollTarget = null;			if( _horizontalScroll != null ) _horizontalScroll.scrollTarget = null;
			
			_verticalScroll = ClassUtils.getInstance( ScrollClass , null , null , _scrollSkin ) as IScroll;			_horizontalScroll = ClassUtils.getInstance( ScrollClass , null , null , _scrollSkin ) as IScroll;
			
			_verticalScroll.owner = this;
			_horizontalScroll.owner = this;
			
			if( _scrollTarget != null ) addChild( _scrollTarget );
						addChild( _verticalScroll as DisplayObject );
			addChild( _horizontalScroll as DisplayObject );
		}

		/**
		 * @private
		 */
		protected override function _init(  ) : void
		{
			_horizontalScroll.direction = ScrollDirection.HORIZONTAL;
			
			_verticalScroll.addEventListener( ComponentEvent.VISIBLE_CHANGED , _visibleChanged , false , 0 , true );			_horizontalScroll.addEventListener( ComponentEvent.VISIBLE_CHANGED , _visibleChanged , false , 0 , true );
			
			_verticalScroll.scrollTarget = _scrollTarget;			_horizontalScroll.scrollTarget = _scrollTarget;
			
			_verticalScroll.enabled = _horizontalScroll.enabled = _enabled;
			_verticalScroll.useHandCursor = _horizontalScroll.useHandCursor = useHandCursor;
			_verticalScroll.useBitmapScrolling = _horizontalScroll.useBitmapScrolling = _useBitmapScrolling;
			_verticalScroll.scrollSnap = _horizontalScroll.scrollSnap = _scrollSnap;
			_verticalScroll.scrollSize = _horizontalScroll.scrollSize = _scrollSize;
		}

		/**
		 * @private
		 */
		protected override function _draw(  ) : void
		{
			if( !_verticalScroll.wrapTarget )
			{
				_verticalScroll.height = _height;
				_verticalScroll.x = _width - _verticalScroll.width;
			}
			else
			{
				_verticalScroll.setSize( _width , _height );	
			}
			
			if( !_horizontalScroll.wrapTarget )
			{
				_horizontalScroll.width = _width;
				_horizontalScroll.y = _height - _horizontalScroll.height;
			}
			else
			{
				_horizontalScroll.setSize( _width , _height );	
			}
			
			_verticalScroll.removeEventListener( ComponentEvent.VISIBLE_CHANGED , _visibleChanged );
            _horizontalScroll.removeEventListener( ComponentEvent.VISIBLE_CHANGED , _visibleChanged );
			
			_verticalScroll.draw( );
			_horizontalScroll.draw( );
			
			if( !_horizontalScroll.wrapTarget )
			{
				_verticalScroll.height = _horizontalScroll.useful ? _height - _horizontalScroll.height : _height;
				_verticalScroll.draw( );
			}
			
			if( !_verticalScroll.wrapTarget )
            {
                _horizontalScroll.width = _verticalScroll.useful ? _width - _verticalScroll.width : _width;
                _horizontalScroll.draw( );
            }
			
			_verticalScroll.addEventListener( ComponentEvent.VISIBLE_CHANGED , _visibleChanged , false , 0 , true );
            _horizontalScroll.addEventListener( ComponentEvent.VISIBLE_CHANGED , _visibleChanged , false , 0 , true );
		}
		
		/**
		 * @private
		 */
		protected function _visibleChanged ( e : ComponentEvent ) : void
		{
			_draw();
		}	}
}
