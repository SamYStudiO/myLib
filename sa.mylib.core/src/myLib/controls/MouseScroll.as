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
	import myLib.core.AMouseScroll;
	import myLib.my_internal;

	import flash.display.DisplayObjectContainer;
	import flash.events.Event;

	[InspectableList("direction","enabled","inactiveAreaPercentage","maxScrollSize","minScrollSize","scrollTargetName","useBitmapScrolling")]
	/**
	 * MouseScroll use mouse position to scroll content. The scroll speed is relaive to disatance between content center and content border.
	 * 
	 * @author SamYStudiO ( contact@samystudio.net )
	 */
	public class MouseScroll extends AMouseScroll implements IMouseScroll
	{
		/**
		 * @private
		 */
		protected var _minScrollSize : Number = 1;
		
		[Inspectable(defaultValue=1)]
		/**
		 * @inheritDoc
		 */
		public function get minScrollSize() : Number
		{
			return _minScrollSize;
		}
		
		public function set minScrollSize( n : Number ) : void
		{
			if( _inspector && !_isLivePreview && _minScrollSize != 1 ) return;
			
			_minScrollSize = n;
		}
		
		/**
		 * @private
		 */
		protected var _maxScrollSize : Number = 20;
		
		[Inspectable(defaultValue=20)]
		/**
		 * @inheritDoc
		 */
		public function get maxScrollSize() : Number
		{
			return _maxScrollSize;
		}
		
		public function set maxScrollSize( n : Number ) : void
		{
			if( _inspector && !_isLivePreview && _maxScrollSize != 20 ) return;
			
			_maxScrollSize = n;
		}
		
		/**
		 * @private
		 */
		protected var _inactiveAreaPercentage : Number = 30;
		
		[Inspectable(defaultValue=30)]
		/**
		 * @inheritDoc
		 */
		public function get inactiveAreaPercentage() : Number
		{
			return _inactiveAreaPercentage;
		}
		
		public function set inactiveAreaPercentage( n : Number ) : void
		{
			if( _inspector && !_isLivePreview && _inactiveAreaPercentage != 30 ) return;
			
			_inactiveAreaPercentage = n;
		}
		
		/**
		 * Build a new MouseScroll instance. Default size is 100*100.
		 * @param parentContainer The parent DisplayObjectContainer where add this MouseScroll.
		 * @param initStyle The initial style object for MouseScroll initialization.
		 * 
		 * @see myLib.styles.StyleManager
		 */
		public function MouseScroll ( parentContainer : DisplayObjectContainer = null , initStyle : Object = null )
		{
			super( parentContainer , initStyle );
		}
		
		/**
		 * @private
		 */
		protected override function _scroll ( e : Event = null , size : Number = NaN ) : Number
		{
			var nextPos : Number = _scrollPosition;
			var yMin : Number;
			var yMax : Number;
			var y : Number;
			var r : Number;
			var s : Number; 
			var pageSize : Number = _isScrollableTextField ? _height : this.pageSize;			var maxScrollSize : Number = _isScrollableTextField && !_horizontal ? 1 : _maxScrollSize;
			var sensitiveArea : Number = 100 - _inactiveAreaPercentage;
			
			if( !isNaN( size ) )
			{
				nextPos += size;
			}
			else if( mouseY >= pageSize - ( pageSize * sensitiveArea / 200 ) )
			{
				yMin = pageSize - ( pageSize * sensitiveArea / 200 );
				yMax = pageSize - yMin;
				y = mouseY - yMin;
				r = y / yMax;
				s = ( maxScrollSize - _minScrollSize ) * r + _minScrollSize;
				
				nextPos += s;
			}
			else if( mouseY <= pageSize * sensitiveArea / 200 )
			{
				yMax = pageSize * sensitiveArea / 200;
				y = mouseY;
				r = 1 - y / yMax;
				s = ( maxScrollSize - _minScrollSize ) * r + _minScrollSize;
				
				nextPos -= s;
			}
			
			if( _scrollTweenFunction != null && _scrollPosition != nextPos )
			{
				_tween.stop( );
				_tween.addProp( my_internal::_setScrollPosition , _scrollTweenFunction , _scrollPosition , nextPos );
				_tween.duration = scrollTweenDuration;
				_tween.start( 0 , true );
			}
			else setScrollPosition( nextPos );
			
			return getScrollPosition( );
		}
	}
}
