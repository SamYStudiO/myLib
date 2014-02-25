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
	import myLib.core.IComponent;
	
	import flash.display.DisplayObject;	
	/**
	 * @author SamYStudiO
	 */
	public interface IScroll extends IComponent 
	{
		/**
		 * Get or set the scroll position applied when scroll component becomes visible.
		 * 
		 * @default 0
		 */
		function get scrollPositionPercentageOnVisible() : Number;
		function set scrollPositionPercentageOnVisible( n : Number ) : void;
		
		/**
		 * Get or set scroll target that is scrolled with this component.
		 */
		function get scrollTarget() : DisplayObject;
		function set scrollTarget( o : DisplayObject ) : void;
		
		/**
		 * Get or set scroll direction as defined in ScrollDirection constants.
		 * 
		 * @default vertical
		 * @see myLib.controls.ScrollDirection
		 */
		function get direction() : String;
		function set direction( s : String ) : void;
		
		/**
		 * Get or set scroll size or velocity with TouchScroll.
		 * 
		 * @default 20
		 */
		function get scrollSize() : Number;
		function set scrollSize( n : Number ) : void;
		
		/**
		 * Get or set scroll snapping. scrollSnap is used with Scrollbar to match scroll size when scroll is used with thumb.
		 */
		function get scrollSnap() : Number;
		function set scrollSnap( n : Number ) : void;
		
		/**
		 * Get or set page size. Page size is the visible scroll target area size.
		 * 
		 * @throws An Error if scroll target is a scrollable TextField.
		 */
		function get pageSize() : Number;
		function set pageSize( n : Number ) : void;
		
		/**
		 * Get or set a Boolean that indicates if bitmap scrolling is active.
		 * Bitmap scrolling use scrollRect associated with cacheAsBitmap to optmize stage render.
		 * 
		 * @default false
		 */
		function get useBitmapScrolling() : Boolean;
		function set useBitmapScrolling( b : Boolean ) : void;
		
		/**
		 * Get or set scroll tween function.
		 */
		function get scrollTweenFunction() : Function;
		function set scrollTweenFunction( easeFunction : Function ) : void;
		
		/**
		 * Get or set scroll tween duration that is used when a scroll function is defined.
		 * 
		 * @default 10
		 */
		function get scrollTweenDuration() : Number;
		function set scrollTweenDuration( n : Number ) : void;
		
		/**
		 * Get max scroll position with the current target.
		 */
		function get maxScroll() : Number;
		
		/**
		 * Get a Boolean that indicates if scroll component is currently useful.
		 * A Scroll component is useful when scroll target size > pageSize.
		 */
		function get useful() : Boolean;
		
		/**
		 * Get a Boolean that indicates if scroll component wrapping target or is positioned left/right/up/down depending on scroll position.
		 */
		function get wrapTarget() : Boolean;
		
		/**
		 * Get or set a Boolean that indicates if keyboard is enabled.
		 * 
		 * @default true
		 */
		function get keyboardEnabled() : Boolean;
		function set keyboardEnabled( b : Boolean ) : void;
		
		/**
		 * Update the scroll target size. When scroll target size changed scroll component need to be update to adjust its paramaters with scroll target.
		 * 
		 * @param lockPosition A Boolean that indicates if scroll position before update is keep after update.
		 * @param newWidth The new scroll target width (in some case you may want use a different width that real target width).
		 * @param newHeight The new scroll target height (in some case you may want use a different height that real target height).
		 */
		function update( lockPosition : Boolean = true , newWidth : Number = NaN , newHeight : Number = NaN ) : void;
		
		/**
		 * Do a scroll operation with the amount specified.
		 * 
		 * @param amount amount pixels to scroll.
		 * 
		 * @return The new scroll position between 0 and maxScroll.
		 */
		function scroll( amount : Number ) : Number;
		
		/**
		 * Search specified DisplayObject within scroll target and scroll to display it in the visible area.
		 * 
		 * @param child The scroll target child to search.
		 * @param alignmentPoint A alignment point as defined in AlignmentPoint constants the children position in the visible area.
		 * @return A Bollean that indicates if operation is successful.
		 * @see myLib.displayUtils.AlignmentPoint
		 */
		function scrollToChild( child : DisplayObject , alignmentPoint : String = null ) : Boolean;
		
		/**
		 * Scroll using the tween engine to the specified position.
		 * 
		 * @param position The position to reach.
		 * @param ease The ease function to use with tween engine.
		 * @param duration The tween duration.
		 * @param durationAsMilliseconds Use milliseconds (default true) or frame for duration.
		 */
		function tweenToPosition( position : Number , ease : Function = null , duration : Number = 500 , durationAsMilliseconds : Boolean = true ) : void;
		
		/**
		 * Search specified DisplayObject within scroll target and scroll using tween engine to display it in the visible area.
		 * 
		 * @param child The scroll target child to search.
		 * @param alignmentPoint A alignment point as defined in AlignmentPoint constants the children position in the visible area.
		 * @param ease The ease function to use with tween engine.
		 * @param duration The tween duration.
		 * @param durationAsMilliseconds Use milliseconds (default true) or frame for duration.
		 * @return A Boolean that indicates if operation is successful.
		 * @see myLib.displayUtils.AlignmentPoint
		 */
		function tweenToChild( child : DisplayObject , alignmentPoint : String = null , ease : Function = null , duration : Number = 500 , durationAsMilliseconds : Boolean = true ) : Boolean;
		
		/**
		 * Set the specified scroll position.
		 * @param position The position between 0 and maxScroll if percentage is false, else between 0 and 100.
		 * @param percentage A Boolean that indicates if scroll position is set in percentage or pixels.
		 */
		function setScrollPosition( position : Number , percentage : Boolean = false ) : void;
		
		/**
		 * Get the current scroll position.
		 * @param percentage A Boolean that indicates if you get scroll position in percentage or pixels.
		 */
		function getScrollPosition( percentage : Boolean = false ) : Number;
	}
}
