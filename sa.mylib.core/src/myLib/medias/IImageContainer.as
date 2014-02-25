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
package myLib.medias
{
	import myLib.core.IComponent;

	import flash.display.BitmapData;
	import flash.display.IBitmapDrawable;
	import flash.geom.Point;
	/**
	 * @author SamYStudiO ( contact@samystudio.net )
	 */
	public interface IImageContainer extends IComponent
	{
		/**
		 * Get or set a Boolean that indicates if images are smoothed.
		 * 
		 * @default true
		 */
		function get smoothing () : Boolean;
		function set smoothing ( b : Boolean ) : void;
		
		/**
		 * <p>Get or set the video scale mode using MediaScaleMode constants.</p>
		 * <p>MediaScaleMode.AUTOSIZE : image cannot resized, size from video metadata is used.</p>
		 * <p>MediaScaleMode.EXACT_FIT : image is resized according ImageContainer size (original aspect ration is not preserved).</p>
		 * <p>MediaScaleMode.NO_BORDER : image is resized according ImageContainer size maintaining aspect ratio but certainly cropped.</p>
		 * <p>MediaScaleMode.SHOW_ALL : image is resized according ImageContainer size maintaining aspect ratio width borders visible (all image area is visible).</p>
		 * 
		 * @see MediaScaleMode
		 * @default noBorder
		 */
		function get scaleMode () : String;
		function set scaleMode ( scaleMode : String ) : void;
		
		/**
		 * Get or set a Boolean that indicates if video zoom is enabled. If false video size may be reduced only. 
		 * 
		 * @default true
		 */
		function get allowScaleZoom () : Boolean;
		function set allowScaleZoom ( scaleZoom : Boolean ) : void;
		
		/**
         * Maximum scale if allowScaleZoom is true. 
         * 
         * @default NaN
         */
        function get maxScale () : Number;
        function set maxScale ( scale : Number ) : void;
		
		/**
		 * Specify video screen alignment within player (this as no effect if videoScaleMode is autoSize or exactFit).
		 * 
		 * @see myLib.displayUtils.AlignmentPoint
		 * @default C
		 */
		function get alignment () : String;
		function set alignment ( align : String ) : void;
		
		/**
		 * 
		 */
		function get ratio() : Number
		
		/**
		 * 
		 */
		function get offset() : Point
		
		/**
		 * 
		 */
		function get bitmapData() : BitmapData
		
		/**
		 * Get or set ImageContainer source.
		 */
		function get source () : IBitmapDrawable;
		function set source ( bd : IBitmapDrawable ) : void;
	}
}
