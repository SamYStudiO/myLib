/* * The contents of this file are subject to the Mozilla Public License Version * 1.1 (the "License"); you may not use this file except in compliance with * the License. You may obtain a copy of the License at  * *        http://www.mozilla.org/MPL/  * * Software distributed under the License is distributed on an "AS IS" basis, * WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License * for the specific language governing rights and limitations under the License.  * * The Original Code is myLib. * * The Initial Developer of the Original Code is * Samuel EMINET (aka SamYStudiO) contact@samystudio.net. * Portions created by the Initial Developer are Copyright (C) 2008-2011 * the Initial Developer. All Rights Reserved. * */package myLib.colors.colorSpaces{	import myLib.colors.colorSpaces.HSBColor;
	import myLib.colors.colorSpaces.HSLColor;
	import myLib.colors.colorSpaces.RGBColor;	
	/**
	 * Color space conversion algorythm, use ColorConvert to convert multiple color space each others.	 * reference : http://www.easyrgb.com/math.php.
	 * @author SamYStudiO ( contact@samystudio.net )
	 */
	public final class ColorConvert
	{		/**		 * @private		 */		public function ColorConvert()		{			throw new Error( this + " cannot be instantiated" );		}		
		/**
		 * Convert RGB color space to HSB(HSV) color space.
		 * (better saturation representation, for better brightness prefere HSL) 
		 * @param rgb RGBColor object to convert to HSB color space.
		 * @return An HSBColor object with hue, saturation and brightness value.
		 */
		public static function RGB2HSB ( rgb : RGBColor ) : HSBColor
		{
			var r : Number = rgb.r / 255;
			var g : Number = rgb.g / 255;
			var b : Number = rgb.b / 255;
			
			var h : Number , s : Number , v : Number;
	
			var minValue : Number = Math.min( Math.min( r , g ) , b );
			var maxValue : Number = Math.max( Math.max( r , g ) , b );
			var delta : Number = maxValue - minValue;
			
			// brightness
			v = maxValue;
			
			// hue & saturation
			if( delta == 0 )
			{
				h = 0;
				s = 0;
			}
			else
			{
				// saturation
				s = delta / maxValue;
				
				// hue
				var deltaR : Number = ( ( ( maxValue - r ) / 6 ) + (delta / 2 ) ) / delta;
				var deltaG : Number = ( ( ( maxValue - g ) / 6 ) + (delta / 2 ) ) / delta;
				var deltaB : Number = ( ( ( maxValue - b ) / 6 ) + (delta / 2 ) ) / delta;
				
				if( r == maxValue )
					h = deltaB - deltaG;
				else if (g == maxValue)
					h = ( 1 / 3 ) + deltaR - deltaB;
				else if (b == maxValue)
					h = ( 2 / 3 ) + deltaG - deltaR;
				
				if ( h < 0 ) h++;
				if ( h > 1 ) h--;
			}
	
			return new HSBColor( Math.round( h * 360 ) , Math.round( s * 100 ) , Math.round( v * 100 ) );
		}
	
		/**
		 * Convert HSV color space to RGB color space.
		 * @param hsb HSBColor object to convert to RGB color space.
		 * @return A RGBColor object with red, green and blue value.
		 */
		public static function HSB2RGB ( hsb : HSBColor ) : RGBColor
		{
			var h : Number = hsb.h / 360;
			var s : Number = hsb.s / 100;
			var v : Number = hsb.b / 100;
			
			var r : Number, g : Number, b : Number;
		
			if ( s == 0 ) r = g = b = v;
			else
			{				var h2 : Number = h * 6;
				var test : Number = Math.round( h2 );
				var r1 : Number = v * ( 1 - s );
				var r2 : Number = v * ( 1 - s * ( h2 - test ) );
				var r3 : Number = v * ( 1 - s * ( 1 - ( h2 - test ) ) );
	
				switch( test )
				{
					case 0 :
						r = v;
						g = r3;
						b = r1;
						break;
				
					case 1 :
						r = r2;
						g = v;
						b = r1;
						break;
					
					case 2 :
						r = r1;
						g = v;
						b = r3;
						break;
					
					case 3 :
						r = r1;
						g = r2;
						b = v;
						break;
					
					case 4 :
						r = r3;
						g = r1;
						b = v;
						break;
					
					default :
						r = v;
						g = r1;
						b = r2;
						break;
				}
			}
			
			return new RGBColor( Math.round( r * 255 ) , Math.round( g * 255 ) , Math.round( b * 255 ) );
		}
	
		/**
		 * Convert RGB color space to HSL color space.
		 * (better brightness representation, for better saturation prefere HSL).
		 * @param rgb RGBColor color object to convert to HSL color space.
		 * @return An HSLColor object with hue, saturation and lightness value.
		 */
		public static function RGB2HSL ( rgb : RGBColor ) : HSLColor
		{
			var r : Number = rgb.r / 255;
			var g : Number = rgb.g / 255;
			var b : Number = rgb.b / 255;			
			var h : Number, s : Number, l : Number;
			
			var minValue : Number = Math.min( Math.min( r , g ) , b );
			var maxValue : Number = Math.max( Math.max( r , g ) , b );
			var delta : Number = maxValue - minValue;
			
			// brightness
			l = ( maxValue + minValue ) / 2;
			
			// hue & saturation
			if(delta == 0)
			{
				h = 0;
				s = 0;
			}
			else
			{
				// saturation
				if ( l < .5 ) s = delta / ( maxValue + minValue );
				else s = delta / ( 2 - maxValue - minValue );
				
				// hue
				var deltaR : Number = ( ( ( maxValue - r ) / 6 ) + ( delta / 2 ) ) / delta;
				var deltaG : Number = ( ( ( maxValue - g ) / 6 ) + ( delta / 2 ) ) / delta;
				var deltaB : Number = ( ( ( maxValue - b ) / 6 ) + ( delta / 2 ) ) / delta;
				
				if( r == maxValue )
					h = deltaB - deltaG;
				else if ( g == maxValue )
					h = ( 1 / 3) + deltaR - deltaB;
				else if (b == maxValue )
					h = ( 2 / 3 ) + deltaG - deltaR;
				
				if ( h < 0 ) h++;
				if ( h > 1 ) h--;
			}
	
			return new HSLColor( Math.round( h * 360 ) , Math.round( s * 100 ) , Math.round( l * 100 ) );
		}
	
		/**
		 * Convert HSL colorspace to RGB color space.
		 * @param hsl HSLColor object to convert to RGB color space.
		 * @return An RGBColor object with red, green and blue value.
		 */
		public static function HSL2RGB ( hsl : HSLColor ) : RGBColor
		{
			var h : Number = hsl.h / 360;
			var s : Number = hsl.s / 100;
			var l : Number = hsl.l / 100;
	
			var r : Number , g : Number , b : Number , temp1 : Number , temp2 : Number;
			
			var hueToRGB : Function = function( v1 : Number , v2 : Number , vH : Number ) : Number
			{
				if ( vH < 0 ) vH++;
			
				if ( vH > 1 ) vH--;
			
				//===================
	
				if ( ( 6 * vH ) < 1 )
					return ( v1 + ( v2 - v1 ) * 6 * vH );
			
				if ( ( 2 * vH ) < 1 )
					return (v2);
			
				if ( ( 3 * vH ) < 2 )
					return ( v1 + ( v2 - v1 ) * ( ( 2 / 3 ) - vH ) * 6 );
			
				return v1;
			};
			
			if( s == 0 ) r = g = b = l * 255;
			else
			{
				if( l < .5 ) temp2 = l * ( 1 + s );
				else temp2 = ( l + s ) - ( l * s );
				
				temp1 = 2 * l - temp2;
				
				r = 255 * hueToRGB( temp1 , temp2 , h + ( 1 / 3 ) ); 
				g = 255 * hueToRGB( temp1 , temp2 , h );
				b = 255 * hueToRGB( temp1 , temp2 , h - ( 1 / 3 ) );
			}
			
			return new RGBColor( Math.round( r ) , Math.round( g ) , Math.round( b ) );
		}
	
		/**		 * Convert HSL colorspace to hexadecimal color space.		 * @param rgb RGBColor object to convert to hexadecimal color space.		 * @return A hexadecimal string representation of RGB color.		 */
		public static function RGB2Hex ( rgb : RGBColor ) : String
		{
			var r : String = rgb.r.toString( 16 );
			var g : String = rgb.g.toString( 16 );
			var b : String = rgb.b.toString( 16 );						if( r.length == 1 ) r = "0" + r;			if( g.length == 1 ) g = "0" + g;			if( b.length == 1 ) b = "0" + b;	
			return r + g + b;
		}
	
		/**		 * Convert HSB colorspace to HSL color space.		 * @param hsb HSBColor object to convert to HSL color space.		 * @return An HSLColor object with hue, saturation and lightness value.		 */
		public static function HSB2HSL ( hsb : HSBColor ) : HSLColor
		{
			var rgb : RGBColor = HSB2RGB( hsb );
			var hsl : HSLColor = RGB2HSL( rgb );
			
			return hsl;
		}
	
		/**		 * Convert HSL colorspace to HSB color space.		 * @param hsl HSLColor object to convert to HSB color space.		 * @return An HSBColor object with hue, saturation and lightness value.		 */
		public static function HSL2HSB ( hsl : HSLColor ) : HSBColor
		{
			var rgb : RGBColor = HSL2RGB( hsl );
			var hsb : HSBColor = RGB2HSB( rgb );
			
			return hsb;
		}
	
		/**		 * Convert HSB colorspace to hexadecimal color space.		 * @param hsb HSBColor object to convert to hexadecimal color space.		 * @return A hexadecimal string representation of HSB color.		 */
		public static function HSB2Hex ( hsb : HSBColor ) : String
		{
			var rgb : RGBColor = HSB2RGB( hsb );
	
			return RGB2Hex( rgb );
		}
	
		/**		 * Convert HSL colorspace to hexadecimal color space.		 * @param hsl HSLColor object to convert to hexadecimal color space.		 * @return A hexadecimal string representation of HSL color.		 */
		public static function HSL2Hex ( hsl : HSLColor ) : String
		{
			var rgb : RGBColor = HSL2RGB( hsl );			
			return RGB2Hex( rgb );
		}
	}}