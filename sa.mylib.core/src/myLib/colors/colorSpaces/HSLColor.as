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
package myLib.colors.colorSpaces
{
	import myLib.colors.colorSpaces.RGBColor;
	import myLib.utils.NumberUtils;	
	/**
	 * HSLColor is a representation of HSL color space.
	 * You can easily convert this object to others color spaces.
	 * 
	 * @author SamYStudiO ( contact@samystudio.net )
	 */
	public final class HSLColor implements IColorSpace
	{
		/**
		 * 
		 */		private var _hue : uint;
		
		/**
		 * The hue value between 0 and 360.
		 */
		public function get h () : uint
		{
			return _hue;
		}
		
		public function set h ( hv : uint ) : void
		{
			_hue = NumberUtils.clamp( hv , 0 , 360 );
		}
	
		/**
		 * 
		 */
		private var _saturation : uint;
		
		/**
		 * The saturation value between 0 and 100.
		 */
		public function get s () : uint
		{
			return _saturation;
		}
		
		public function set s ( sv : uint ) : void
		{
			_saturation = NumberUtils.clamp( sv , 0 , 100 );
		}
	
		/**
		 * 
		 */
		private var _lightness : uint;
		
		/**
		 * The lightness value between 0 and 100.
		 */
		public function get l () : uint
		{
			return _lightness;
		}
	
		public function set l ( lv : uint ) : void
		{
			_lightness = NumberUtils.clamp( lv , 0 , 100 );
		}
	
		/**
		 * 	Build a new HSLColor object.
		 * 	<p>if only first argument is set, this argument is use as a hexadecimal number value (between 0x00000 and 0xFFFFFF) to initialize color.</p>
		 * 	@param h The hue value to use to initialize object between 0 and 360.
		 * 	@param s The saturation value to use to initialize object between 0 and 100.
		 * 	@param l The lightness value to use to initialize object between 0 and 100.
		 */
		public function HSLColor ( h : uint = 0 , s : uint = 0 , l : uint = 0 )
		{
			if( ( arguments as Array ).length == 1 )
			{
				var hsl : HSLColor = new RGBColor( h ).convert( ColorSpace.HSL ) as HSLColor;
				
				h = hsl.h;
				s = hsl.s;
				l = hsl.l;
			}
			
			_hue = NumberUtils.clamp( h , 0 , 360 );
			_saturation = NumberUtils.clamp( s , 0 , 100 );
			_lightness = NumberUtils.clamp( l , 0 , 100 );
		}
	
		/**
		 * @inheritDoc
		 */
		public function convert ( colorSpace : String ) : IColorSpace
		{
			var method : String = "HSL2" + colorSpace.toUpperCase( );
	
			return ColorConvert[ method ].apply( null , [ this ] ) as IColorSpace;
		}
	
		/**
		 * @inheritDoc
		 */
		public function toHex ( prefix : String = "" ) : String
		{
			prefix = prefix ? prefix : "";
			
			return prefix + ColorConvert.HSL2Hex( this );
		}
	
		/**
		 * @inheritDoc
		 */
		public function toNumber () : uint
		{
			return uint( toHex( "0x" ) );
		}
		
		/**
		 * Convert HSBcolor to an String representation with hue, saturation and lightness values.
		 */
		public function toString(  ) : String
		{
			return "[object HSLColor h : " + h + " , s : " + s + " , l : " + l + " , " + toHex( "0x" ) + "]";
		}	
	}
}