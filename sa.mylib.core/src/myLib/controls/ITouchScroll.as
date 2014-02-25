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
 * Portions created by the Initial Developer are Copyright (C) 2008-2012
 * the Initial Developer. All Rights Reserved.
 *
 */
package myLib.controls
{
	import myLib.assets.IAsset;
	import myLib.core.IScroll;
	import myLib.styles.Padding;

	/**
	 * @author SamYStudiO ( contact@samystudio.net )
	 */
	public interface ITouchScroll extends IScroll
	{
		/**
		 * 
		 * @default 5
		 */
		function get thumbWidth() : Number;
		function set thumbWidth( w : Number ) : void;
		
		/**
		 * Show or hide thumb asset.
		 * 
		 * @default true
		 */
		function get useThumbAsset() : Boolean;
		function set useThumbAsset( b : Boolean ) : void;
		
		/**
		 * Get or set a Number that indicates thumb minimum size when thumb resize is enabled.
		 * 
		 * @default 10
		 */
		function get thumbMinimumSize() : Number;
		function set thumbMinimumSize( n : Number ) : void;
		
		/**
		 * 
		 * @default 3
		 */
		function get bouncePageRatio() : Number;
		function set bouncePageRatio( n : Number ) : void;
		
		/**
		 * 
		 * @default 3
		 */
		function get bounceOnUseless() : Boolean;
		function set bounceOnUseless( n : Boolean ) : void;
		
		
		/**
		 * Get or set padding used to draw thumb.
		 * 
		 * @default 2,2,2,2
		 */
		function get thumbPadding() : Padding;
		function set thumbPadding( padding : Padding ) : void;
		
		/**
         * @default 
         */
        function get eventsStoppedFromPropagation() : Array
        function set eventsStoppedFromPropagation( a : Array ) : void
		
		/**
		 * Get IAsset used to render thumb control.
		 */
		function get thumbAsset() : IAsset;
	}
}
