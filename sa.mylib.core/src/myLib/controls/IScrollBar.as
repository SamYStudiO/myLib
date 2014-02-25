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
	import myLib.assets.IAsset;	import myLib.core.IScroll;	
	/**
	 * @author SamYStudiO ( contact@samystudio.net )
	 */
	public interface IScrollBar extends IScroll 
	{
		/**
		 * Get or set a Boolean that indicates if scroll is still visible when ScrollBar is useless.
		 * 
		 * @default false
		 */
		function get visibleOnUseless() : Boolean;
		function set visibleOnUseless( b : Boolean ) : void;
		
		/**
		 * Get or set the time in milliseconds when a button control is press before auto repeat is active.
		 * 
		 * @default 250
		 */
		function get autoRepeatTimeout() : uint;
		function set autoRepeatTimeout( n : uint ) : void;
		
		/**
		 * Get or set a Boolean that indicates if mouse wheel is enabled.
		 * 
		 * @default true
		 */
		function get mouseWheelEnabled() : Boolean;
		function set mouseWheelEnabled( b : Boolean ) : void;
		
		/**
		 * Get or set a Boolean that indicates if scroll target need focus to make mouse wheel enabled.
		 * If false mouse wheel only need mouse over target to make wheel active.
		 * 
		 * @default false
		 */
		function get mouseWheelNeedTargetFocus() : Boolean;
		function set mouseWheelNeedTargetFocus( b : Boolean ) : void;
		
		/**
		 * Get or set the up and down controls position using ScrollBarUpDownPosition constants.
		 * 
		 * @default topBottom
		 * @see myLib.controls.ScrollBarUpDownPosition
		 */
		function get upDownPosition() : String;
		function set upDownPosition( s : String ) : void;
		
		/**
		 * Get or set a Boolean that indicates if ScrollBar use up and down controls.
		 * 
		 * @default true
		 */
		function get useUpDown() : Boolean;
		function set useUpDown( b : Boolean ) : void;
		
		/**
		 * Get or set a Boolean that indicates if ScrollBar use thumb control.
		 * 
		 * @default true
		 */
		function get useThumb() : Boolean;
		function set useThumb( b : Boolean ) : void;
		
		/**
		 * Get or set a Boolean that indicates if ScrollBar use thumb background control.
		 * 
		 * @default true
		 */
		function get useThumbBackground() : Boolean;
		function set useThumbBackground( b : Boolean ) : void;
		
		/**
		 * Get or set a Boolean that indicates if thumb is resize relative to content size.
		 * 
		 * @default true
		 */
		function get thumbResizeEnabled() : Boolean;
		function set thumbResizeEnabled( b : Boolean ) : void;
		
		/**
		 * Get or set a Boolean that indicates thumb minimum size when thumb resize is enabled.
		 * 
		 * @default 10
		 */
		function get thumbMinimumSize() : Number;
		function set thumbMinimumSize( n : Number ) : void;
		
		/**
		 * Get or set the mouse wheel delta size. If value is 0 delta size is equivalent to ScrollBar page size.
		 * 
		 * @default 0
		 */
		function get mouseWheelDeltaSize() : Number;
		function set mouseWheelDeltaSize( size : Number ) : void;
		
		/**
		 * Get IAsset used to render up control.
		 */
		function get upAsset() : IAsset;
		
		/**
		 * Get IAsset used to render down control.
		 */
		function get downAsset() : IAsset;
		
		/**
		 * Get IAsset used to render thumb control.
		 */
		function get thumbAsset() : IAsset;
		
		/**
		 * Get IAsset used to render thumb background control.
		 */
		function get thumbBackgroundAsset() : IAsset;
	}
}
