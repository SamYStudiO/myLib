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
package myLib.colors
{
	import myLib.colors.colorSpaces.RGBColor;		import flash.display.DisplayObject;	import flash.geom.ColorTransform;		/**
	 * Colorize class apply colorTransformation to DisplayObject.
	 * 
	 * @author SamYStudiO ( contact@samystudio.net )
	 */
	public final class Colorize
	{
		/**
		 * @private
		 */
		public function Colorize ( )
		{
			throw new Error( this + " cannot be instantiated" );
		}
	
		/**
		 * Apply a solid color to DisplayObject.
		 * @param target The DisplayObject to tint.
		 * @param color The haxadecimal color to apply to object.
		 */
		public static function tint ( target : DisplayObject , color : uint ) : void
		{
			var rgb : RGBColor = new RGBColor( color );
			
			target.transform.colorTransform = new ColorTransform( 0 , 0 , 0 , 1 , rgb.r , rgb.g , rgb.b , 0 );
		}
	
		/**
		 * Apply a solid color to a black gradient.
		 * @param target The DisplayObject to tint.
		 * @param color The haxadecimal color to apply to object.
		 */
		public static function tintBlack ( target : DisplayObject , color : uint ) : void
		{
			var rgb : RGBColor = new RGBColor( color );
			
			target.transform.colorTransform = new ColorTransform( 1 , 1 , 1 , 1 , rgb.r , rgb.g , rgb.b , 0 );
		}
	
		/**
		 * Apply a solid color to a white gradient.
		 * @param target The DisplayObject to tint.
		 * @param color The haxadecimal color to apply to object.
		 */
		public static function tintWhite ( target : DisplayObject , color : uint ) : void
		{
			var rgb : RGBColor = new RGBColor( color );
			
			target.transform.colorTransform = new ColorTransform( rgb.r / 255 , rgb.g / 255 , rgb.b / 255 , 1 , 0 , 0 , 0 , 0 );
		}
	}
}