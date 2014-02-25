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
package myLib.displayUtils {
	import myLib.displayUtils.USE_PIXEL_SNAPPING;
	import myLib.utils.NumberUtils;
	
	import flash.display.DisplayObject;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	import flash.geom.Transform;	
	/**
	 * SizeManager is useful for resizing DisplayObject and keeping aspect ratio.
	 * 
	 * @author SamYStudiO ( contact@samystudio.net )
	 */
	public final class SizeManager 	{
		/**
		 * @private
		 */
		public function SizeManager()
		{
			throw new Error( this + " cannot be instantiated" );
		}
		
		/**
		 * Change width and height with the specified DisplayObject.
		 * @param o The DisplayObject to resize.
		 * @param w The new with.
		 * @param h The new height.
		 */
		public static function size( o : DisplayObject , w : Number , h : Number ) : void
		{
			o.width = USE_PIXEL_SNAPPING ? Math.round( w ) : w;
			o.height = USE_PIXEL_SNAPPING ? Math.round( h ) : h;
		}
		
		/**
		 * Scale the specified DisplayObject.
		 * @param o The DisplayObject to scale.
		 * @param scale The scale factor.
		 */
		public static function scale ( o : DisplayObject , scale : Number ) : void
		{
			o.scaleX = o.scaleY = scale;
			
			if( USE_PIXEL_SNAPPING && ( !NumberUtils.isInteger( o.width ) || !NumberUtils.isInteger( o.height ) ) )
				size( o , o.width , o.height );
		}
		
		/**
		 * Size the specified DisplayObject keeping its aspect ratio and make its sides match minWidth and minHeight values.
		 * @param o The DisplayObject to resize.
		 * @param minWidth The minimum width after resize.		 * @param minHeight The minimum height after resize.
		 * @param zoomEnabled A Boolean that indicates if zoom resize is enabled.
		 * @param fromOriginSize A Boolean that indicates if resize is calculate using current DisplayObject scale factor or a 1.0 factor.
		 */
		public static function sizeBestFitMin ( o : DisplayObject , minWidth : Number , minHeight : Number , zoomEnabled : Boolean = true , fromOriginSize : Boolean = true ) : void
		{
			if( fromOriginSize )
			{
				var scaleX : Number = o.scaleX;
				var scaleY : Number = o.scaleY;
				
				o.scaleX = o.scaleY = 1;
			}
			
			var pX : Number = ( o.width - minWidth ) / o.width;
			var pY : Number = ( o.height - minHeight ) / o.height;
			var min : Number = Math.min( pX , pY );
			
			if( min < 0 && !zoomEnabled )
			{
				if( fromOriginSize )
				{
					o.scaleX = scaleX;
					o.scaleY = scaleY;
				}
			}
			else size( o , o.width * ( 1 - min ) , o.height * ( 1 - min ) );
		}
		
		/**
		 * Size the specified DisplayObject keeping its aspect ratio and make its sides match maxWidth and maxHeight values.
		 * @param o The DisplayObject to resize.
		 * @param maxWidth The maximum width after resize.
		 * @param maxHeight The maximum height after resize.
		 * @param zoomEnabled A Boolean that indicates if zoom resize is enabled.
		 * @param fromOriginSize A Boolean that indicates if resize is calculate using current DisplayObject scale factor or a 1.0 factor.
		 */
		public static function sizeBestFitMax ( o : DisplayObject , maxWidth : Number , maxHeight : Number , zoomEnabled : Boolean = true , fromOriginSize : Boolean = true ) : void
		{
			if( fromOriginSize )
			{
				var scaleX : Number = o.scaleX;
				var scaleY : Number = o.scaleY;
				
				o.scaleX = o.scaleY = 1;
			}
			
			var pX : Number = ( o.width - maxWidth ) / o.width;
			var pY : Number = ( o.height - maxHeight ) / o.height;
			var max : Number = Math.max( pX , pY );
			
			if( max < 0 && !zoomEnabled )
			{
				if( fromOriginSize )
				{
					o.scaleX = scaleX;					o.scaleY = scaleY;
				}
			}
			else size( o , o.width * ( 1 - max ) , o.height * ( 1 - max ) );
		}
		
		/**
		 * Hack to get correct DisplayObject size with a scrollRect
		 * @param o The DisplayObject where scrollRect is set and we want to retrieve original size
		 * @return A Rectangle object with DisplayObject dimension.
		 * @see http://usecake.com/lab/find-the-height-and-width-of-a-sprite-with-a-scrollrect.html
		 */
		public static function getScrollTargetContentSize ( o : DisplayObject ) : Rectangle
		{
			var transform : Transform = o.transform;
			var currentMatrix : Matrix = transform.matrix;
			var toGlobalMatrix : Matrix = transform.concatenatedMatrix;
			
			toGlobalMatrix.invert();
			
			transform.matrix = toGlobalMatrix;
		 
			var bounds : Rectangle = transform.pixelBounds.clone();
		 
			transform.matrix = currentMatrix;
		 
			return bounds;
		}
	}
}
