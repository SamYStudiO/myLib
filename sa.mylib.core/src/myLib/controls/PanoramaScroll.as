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
	import myLib.my_internal;
	import myLib.core.AMouseScroll;
	import myLib.transitions.easing.Regular;
	
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;	

	[InspectableList("direction","enabled","inactiveMarginSize","scrollTargetName","useBitmapScrolling")]
	/**
	 * PanoramaScroll like MouseScroll component use mouse position to scroll content but there is no speed notion.
	 * When mouse is at the top of content scroll position is 0 and when mouse position is at the bottom scroll position is equivalent to maxScroll.
	 * 
	 * @author SamYStudiO ( contact@samystudio.net )
	 */
	public class PanoramaScroll extends AMouseScroll implements IPanoramaScroll
	{
		/**
		 * @private
		 */
		protected var _inactiveMarginSize : Number = 5;
		
		[Inspectable(defaultValue=5)]
		/**
		 * inheritDoc
		 */
		public function get inactiveMarginSize() : Number
		{
			return _inactiveMarginSize;
		}
		
		public function set inactiveMarginSize( n : Number ) : void
		{
			if( _inspector && !_isLivePreview && _inactiveMarginSize != 5 ) return;
			
			_inactiveMarginSize = n;
		}
		
		/**
		 * Build a new PanoramaScroll instance. Default size is 100*100.
		 * @param parentContainer The parent DisplayObjectContainer where add this PanoramaScroll.
		 * @param initStyle The initial style object for PanoramaScroll initialization.
		 * 
		 * @see myLib.styles.StyleManager
		 */
		public function PanoramaScroll ( parentContainer : DisplayObjectContainer = null , initStyle : Object = null )
		{
			super( parentContainer , initStyle );
		}

		/**
		 * @private
		 */
		protected override function _scroll ( e : Event = null , size : Number = NaN ) : Number
		{
			var nextPos : Number;
			
			if( !isNaN( size ) )
			{
				nextPos += size;
			}
			else 
			{
				var y : Number = Math.min( Math.max( 0 , mouseY ) , pageSize );
				nextPos = Math.round( ( y - _inactiveMarginSize ) / ( pageSize - 2 * _inactiveMarginSize ) * _maxScroll );
			}
			
			if( _scrollPosition != nextPos )
			{
				_tween.stop( );
				_tween.addProp( my_internal::_setScrollPosition , _scrollTweenFunction , _scrollPosition , nextPos );
				_tween.duration = scrollTweenDuration;
				_tween.start( 0 , true );
			}
			
			return getScrollPosition( );
		}
		
		/**
		 * @private
		 */
		protected override function _init(  ) : void
		{
			super._init();
			
			scrollTweenFunction = Regular.easeOut;
		}
	}
}
