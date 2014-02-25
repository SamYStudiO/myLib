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
	import myLib.assets.IAsset;
	import myLib.core.IComponent;
	/**
	 * @author SamYStudiO ( contact@samystudio.net )
	 */
	public interface ISlider extends IComponent 
	{
		/**
		 * Get or set a Boolean that indicates if track drag is allow.
		 * 
		 * @default false
		 */
		function get allowTrackDrag() : Boolean;
		function set allowTrackDrag( b : Boolean ) : void;
		
		/**
		 * Get or set a Boolean that indicates if track drag tween is allow.
		 * 
		 * @default false
		 */
		function get allowTrackDragTween() : Boolean;
		function set allowTrackDragTween( b : Boolean ) : void;
		
		/**
		 * Get or set a Boolean that indicates if a tween from track bounds is allow.
		 * 
		 * @default false
		 */
		function get allowBoundsTween() : Boolean;
		function set allowBoundsTween( b : Boolean ) : void;
		
		/**
		 * Get or set the thumb tween duration.
		 * 
		 * @default 0
		 */
		function get thumbTweenDuration() : uint;
		function set thumbTweenDuration( n : uint ) : void;
		
		/**
		 * Get or set the thumb tween funtion.
		 * 
		 * @default Regular.easeOut
		 */
		function get thumbTweenFunction() : Function;
		function set thumbTweenFunction( f : Function ) : void;
		
		/**
		 * Get or set slider direction as defined in SliderDirection constants.
		 * 
		 * @default horizontal
		 * @see myLib.controls.SliderDirection
		 */
		function get direction() : String;
		function set direction( s : String ) : void;
		
		/**
		 * Get or set the minimum value when thumb is at the top or left.
		 */
		function get minimum() : Number;
		function set minimum( n : Number ) : void;
		
		/**
		 * Get or set the maximum value when thumb is at the bottom or right.
		 */
		function get maximum() : Number;
		function set maximum( n : Number ) : void;
		
		/**
		 * Get or set thumb value between minimum value and maximum value.
		 */
		function get value() : Number;
		function set value( n : Number ) : void;
		
		/**
		 * Get or set thumb snap interval.
		 */
		function get snapInterval() : Number;
		function set snapInterval( n : Number ) : void;
		
		/**
		 * Get or set the thumb alignment with track asset using SliderThumbAlignment constants.
		 * 
		 * @default SliderThumbAlignment.CENTER
		 * @see SliderThumbAlignment
		 */
		function get thumbVerticalAlignment() : String;
		function set thumbVerticalAlignment( s : String ) : void;
		
		/**
		 * Get the IAsset used to render track.
		 */
		function get trackAsset() : IAsset;
		
		/**
		 * Get the IAsset used to render thumb.
		 */
		function get thumbAsset() : IAsset;
		
		/**
		 * Get the IAsset used to render progress bar.
		 */
		function get progressAsset() : IAsset;
	}
}
