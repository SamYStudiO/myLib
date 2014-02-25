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
	import myLib.utils.NumberUtils;						
	/**
	 * RGBColor is a representation of RGB color space.
	 * You can easily convert this object to others color spaces.
	 * 
	 * @author SamYStudiO ( contact@samystudio.net )
	 */
	public final class RGBColor implements IColorSpace
	{
		/**
		 * 
		 */
		private var _red : uint;
		
		/**
		 * The red value between 0 and 255.
		 */
		public function get r () : uint
		{
			return _red;
		}
		
		public function set r ( rv : uint ) : void
		{
			_red = NumberUtils.clamp( rv , 0 , 255 );
		}
	
		/**
		 * 
		 */
		private var _green : uint;
		
		/**
		 * The green value between 0 and 255.
		 */
		public function get g () : uint
		{
			return _green;
		}
		
		public function set g ( gv : uint ) : void
		{
			_green = NumberUtils.clamp( gv , 0 , 255 );
		}
	
		/**
		 * 
		 */
		private var _blue : uint;
		
		/**
		 * The blue value between 0 and 255.
		 */
		public function get b () : uint
		{
			return _blue;
		}
	
		public function set b ( bv : uint ) : void
		{
			_blue = NumberUtils.clamp( bv , 0 , 255 );
		}
	
		/**
		 * 	Build a new RGBColor object.
		 * 	<p>if only first argument is set, this argument is use as a hexadecimal number value (between 0x00000 and 0xFFFFFF) to initialize color.</p>
		 * 	@param r The hue value to use to initialize object between 0 and 255.
		 * 	@param g The saturation value to use to initialize object between 0 and 255.
		 * 	@param b The lightness value to use to initialize object between 0 and 255.
		 */
		public function RGBColor ( r : uint = 0 , g : uint = 0 , b : uint = 0 )
		{
			if( ( arguments as Array ).length == 1 )
			{
				var s : String = r.toString( 16 );
				
				while( s.length < 6 ) s = "0" + s;	
				
				r = uint( "0x" + s.substr( 0 , 2 ) );	
				g = uint( "0x" + s.substr( 2 , 2 ) );	
				b = uint( "0x" + s.substr( 4 , 2 ) );	
			}
			
			_red = NumberUtils.clamp( r , 0 , 255 );
			_green = NumberUtils.clamp( g , 0 , 255 );
			_blue = NumberUtils.clamp( b , 0 , 255 );
		}
	
		/**
		 * @inheritDoc
		 */
		public function convert ( colorSpace : String ) : IColorSpace
		{
			var method : String = "RGB2" + colorSpace.toUpperCase( );
	
			return ColorConvert[ method ].apply( null , [ this ] ) as IColorSpace;
		}
	
		/**
		 * @inheritDoc
		 */
		public function toHex ( prefix : String = "" ) : String
		{
			prefix = prefix ? prefix : "";
			
			return prefix + ColorConvert.RGB2Hex( this );
		}
	
		/**
		 * @inheritDoc
		 */
		public function toNumber () : uint
		{
			return uint( toHex( "0x" ) );
		}
		
		/**
		 * Convert RGBcolor to an String representation with red, green and blue values.
		 */
		public function toString(  ) : String
		{
			return "[object RGBColor r : " + r + " , g : " + g + " , b : " + b + " , " + toHex( "0x" ) + "]";
		}
	}
}