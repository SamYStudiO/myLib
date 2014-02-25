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
 * The Original Code is myLib Framework.
 *
 * The Initial Developer of the Original Code is
 * Samuel EMINET (aka SamYStudiO) contact@samystudio.net.
 * Portions created by the Initial Developer are Copyright (C) 2008-2011
 * the Initial Developer. All Rights Reserved.
 *
 */
package myLib.controls 
{
	import myLib.core.IComponent;
	import myLib.core.IScroll;
	
	import flash.display.DisplayObject;	
	/**
	 * @author SamYStudiO ( contact@samystudio.net )
	 */
	public interface IScrollPane extends IComponent 
	{
		/**
		 * @copy myLib.core.IScroll.scrollTarget
		 */
		function get scrollTarget() : DisplayObject;
		function set scrollTarget( o : DisplayObject ) : void;
		
		/**
		 * Get or set the scroll definition to use with this ScrollPane using ScrollRenderer constants.
		 * 
		 * @default ScrollBar
		 * @see ScrollRenderer
		 */
		function get scrollRenderer() : *;
		function set scrollRenderer( definition : * ) : void;
		
		/**
		 * Get the IScroll asset used to render vertical scroll.
		 */
		function get verticalScroll() : IScroll;
		
		/**
		 * Get the IScroll asset used to render horizontal scroll.
		 */
		function get horizontalScroll() : IScroll;
		
		/**
		 * Get or size scroll size.
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
		 * Get max vertical scroll position with the current target.
		 */
		function get maxScrollV() : Number;
		
		/**
		 * Get max horizontal scroll position with the current target.
		 */
		function get maxScrollH() : Number;
		
		/**
		 * Get a Boolean that indicates if vertical scroll component is currently useful.
		 * A Scroll component is useful when scroll target size > pageSize.
		 */
		function get usefulV() : Boolean;
		
		/**
		 * Get a Boolean that indicates if horizonal scroll component is currently useful.
		 * A Scroll component is useful when scroll target size > pageSize.
		 */
		function get usefulH() : Boolean;
		
		/**
		 * @copy myLib.core.IScroll.update
		 */
		function update( lockPosition : Boolean = true , newWidth : Number = NaN , newHeight : Number = NaN ) : void;
		
		/**
		 * Do a scroll operation with the amount specified.
		 * 
		 * @param amount amount pixels to scroll.
		 * 
		 * @return The new scroll position between 0 and maxScroll.
		 */
		function scroll( verticalAmount : Number , horizontalAmount : Number ) : void;
		
		/**
		 * Search specified DisplayObject within scroll target and scroll to display it in the visible area.
		 * 
		 * @param child The scroll target child to search.
		 * @param alignmentPoint A alignment point as defined in AlignmentPoint constants the children position in the visible area.
		 * @return A Bollean that indicates if operation is successful.
		 * @see myLib.displayUtils.AlignmentPoint
		 */
		function scrollToChild( child : DisplayObject , alignmentPoint : String = null ) : void;
		
		/**
		 * Scroll using the tween engine to the specified position.
		 * 
		 * @param position The position to reach.
		 * @param ease The ease function to use with tween engine.
		 * @param duration The tween duration.
		 */
		function tweenToPosition( verticalPosition : Number , horizontalPosition : Number , ease : Function = null , duration : Number = 500 , durationAsMilliseconds : Boolean = true ) : void;
		
		/**
		 * Search specified DisplayObject within scroll target and scroll using tween engine to display it in the visible area.
		 * 
		 * @param child The scroll target child to search.
		 * @param alignmentPoint A alignment point as defined in AlignmentPoint constants the children position in the visible area.
		 * @param ease The ease function to use with tween engine.
		 * @param duration The tween duration.
		 * @return A Bollean that indicates if operation is successful.
		 * @see myLib.displayUtils.AlignmentPoint
		 */
		function tweenToChild( child : DisplayObject , alignmentPoint : String = null , ease : Function = null , duration : Number = 500 , durationAsMilliseconds : Boolean = true ) : void;
		
		/**
		 * Set the specified scroll position.
		 * @param position The position between 0 and maxScroll if percentage is false, else between 0 and 100.
		 * @param percentage A Boolean that indicates if scroll position is set in percentage or pixels.
		 */
		function setScrollPosition( verticalPosition : Number , horizontalPosition : Number , percentage : Boolean = false ) : void;
		
		/**
		 * Get the current vertical scroll position.
		 * @param percentage A Boolean that indicates if you get scroll position in percentage or pixels.
		 */
		function getVerticalScrollPosition( percentage : Boolean = false ) : Number;
		
		/**
		 * Get the current horizontal scroll position.
		 * @param percentage A Boolean that indicates if you get scroll position in percentage or pixels.
		 */
		function getHorizontalScrollPosition( percentage : Boolean = false ) : Number;
	}
}
