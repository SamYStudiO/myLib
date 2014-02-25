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
	import myLib.colors.colorSpaces.RGBColor;
	import myLib.utils.MathUtils;
	import myLib.utils.NumberUtils;
	
	import flash.filters.ColorMatrixFilter;	
	/**
	 *
	 * @author SamYStudiO ( contact@samystudio.net )
	 */
	public class ColorMatrix
	{
		/**
		 * @private
		 */
		protected static const __IDENTITY_MATRIX : Array = new Array( 	1 , 0 , 0 , 0 , 0 ,
																		0 , 1 , 0 , 0 , 0 ,
																		0 , 0 , 1 , 0 , 0 ,
																		0 , 0 , 0 , 1 , 0 ,
																		0 , 0 , 0 , 0 , 1 );
	
		/**
		 * @private
		 */
		protected var _matrix : Array = new Array();
		
		/**
		 * R_LUM is a constant use with most of color operations.
		 * This property is not declared as a constant so you can change it with 0.212674 alternative value.
		 */
		public static var R_LUM : Number = 0.3086; //0.212671
	
		/**
		 * G_LUM is a constant use with most of color operations.
		 * This property is not declared as a constant so you can change it with 0.715160 alternative value.
		 */
		public static var G_LUM : Number = 0.6094; //0.715160
	
		/**
		 * B_LUM is a constant use with most of color operations.
		 * This property is not declared as a constant so you can change it with 0.072169 alternative value.
		 */
		public static var B_LUM : Number = 0.0820; //0.072169
	
		/**
		 * Get the Array representation of the current ColorMatrix object.
		 */
		public function get matrix () : Array
		{
			return _matrix.concat();
		}
		
		/**
		 * Get the colorMatrixFilter representation of the current ColorMatrix object in order to apply it to a DisplayObject.
		 */
		public function get colorMatrixFilter () : ColorMatrixFilter
		{
			return new ColorMatrixFilter( _matrix.concat() );
		}
		
		/**
		 * Build a new ColorMatrix instance.
		 * @param matrix The matrix to use to initialize ColorMtarix object.
		 */
		public function ColorMatrix ( matrix : Array = null ) 
		{
			_matrix = _fixArray( matrix );
		}
	
		/**
		 * Reset the matrix to its default value.
		 * [ 1 , 0 , 0 , 0 , 0 ,
		 *	 0 , 1 , 0 , 0 , 0 ,
		 *	 0 , 0 , 1 , 0 , 0 ,
		 *	 0 , 0 , 0 , 1 , 0 ,
		 *	 0 , 0 , 0 , 0 , 1 ];
		 */
		public function reset () : void
		{
			_matrix = __IDENTITY_MATRIX.concat( );
		}
	
		/**
		 * Get a clone of the current ColorMatrix object.
		 */
		public function clone () : ColorMatrix
		{
			return new ColorMatrix( _matrix.concat() );
		}

		/**
		 * Concat a matrix transformation to current ColorMatrix object.
		 * @param a The Array represenation of the transformation matrix.
		 */
		public function multiply ( a : Array ) : void
		{
			a = _fixArray( a );
			
			var col : Array = new Array( );
			
			for( var i : uint = 0; i < 5; i++ )
			{
				for( var j : uint = 0; j < 5; j++ ) col[ j ] = _matrix[ j + i * 5 ];
	
				for( j = 0; j < 5; j++ )
				{
					var n : Number = 0;
					
					for ( var k : uint = 0; k < 5; k++ ) n += a[ j + k * 5 ] * col[ k ];
					
					_matrix[ j + i * 5 ] = n;
				}
			}
		}
	
		/**
		 * Modify the visibility of color channels.
		 * @param channels The channels to make visible. Use ColorChannel constants separate by "|".
		 * @see myLib.colors.ColorChannel
		 */
		public function setChannels ( channels : uint = 15 ) : void
		{
			var r : Number = ( 1 | channels ) == channels ? 1 : 0;
			var g : Number = ( 2 | channels ) == channels ? 1 : 0;
			var b : Number = ( 4 | channels ) == channels ? 1 : 0;
			
			var a : Array = [ 	r , 0 , 0 , 0 , 0 ,
								0 , g , 0 , 0 , 0 ,
								0 , 0 , b , 0 , 0 ,
								0 , 0 , 0 , 1 , 0 ,
								0 , 0 , 0 , 0 , 1 ];
			
			multiply( a );
		}
	
		/**
		 * Do a greyScale operation with current matrix.
		 */
		public function grayScale () : void
		{
			var a : Array = [ 	R_LUM , G_LUM , B_LUM , 0 , 0 ,
								R_LUM , G_LUM , B_LUM , 0 , 0 ,
								R_LUM , G_LUM , B_LUM , 0 , 0 ,
								0     , 0     , 0     , 1 , 0 ,
								0     , 0     , 0     , 0 , 1 ];
			
			multiply( a );
		}
	
		/**
		 * Do a invert operation with current matrix.
		 */
		public function invert () : void
		{
			var a : Array = [ 	-1 ,  0 ,  0 , 0 , 255 ,
							 	0  , -1 ,  0 , 0 , 255 ,
							 	0  ,  0 , -1 , 0 , 255 ,
							 	0  ,  0 ,  0 , 1 , 0   ,
							 	0  ,  0 ,  0 , 0 , 1 ];
			
			multiply( a );
		}
	
		/**
		 * Do a threshold operation with current matrix.
		 * @param v The threshold intensity between 0 and 255;
		 */
		public function threshold ( v : Number ) : void
		{
			v = NumberUtils.clamp( v , 0 , 255 );
			
			var r : Number = R_LUM * 256;
			var g : Number = G_LUM * 256;
			var b : Number = B_LUM * 256;
			
			var a : Array = [ 	r , g , b , 0 , -255 * v , 
								r , g , b , 0 , -255 * v , 
								r , g , b , 0 , -255 * v , 
								0 , 0 , 0 , 1 , 0        ,
								0 , 0 , 0 , 0 , 1 ]; 
			multiply( a );
		}
	
		/**
		 * Do a lightness operation with current matrix.
		 * @param v The lightness value between -1 and 1.
		 * @param channels The channels to apply transformation. Use ColorChannel constants separate by "|".
		 * @see myLib.colors.ColorChannel
		 */
		public function lightness ( v : Number , channels : uint = 15 ) : void
		{
			v = NumberUtils.clamp( v , -1 , 1 );
			
			var n : Number = v * 255;
			var r : Number = ( 1 | channels ) == channels ? n : 0;
			var g : Number = ( 2 | channels ) == channels ? n : 0;
			var b : Number = ( 4 | channels ) == channels ? n : 0;
			
			var a : Array = [ 	1 , 0 , 0 , 0 , r ,
								0 , 1 , 0 , 0 , g ,
								0 , 0 , 1 , 0 , b ,
								0 , 0 , 0 , 1 , 0 ,
								0 , 0 , 0 , 0 , 1 ];
			
			multiply( a );
		}
	
		/**
		 * Do a brightness operation with current matrix.
		 * @param v The brightness value between -1 and 1.
		 * @param channels The channels to apply transformation. Use ColorChannel constants separate by "|".
		 * @see myLib.colors.ColorChannel
		 */
		public function brightness ( v : Number , channels : uint = 15 ) : void
		{
			v = NumberUtils.clamp( v , -1 , 1 );
			
			var negative : Boolean = v < 0;
			
			v = Math.abs( v );
			
			var n : Number = v * v * v * 9 + 1;
			
			var r : Number = ( 1 | channels ) == channels ? n : 1;
			var g : Number = ( 2 | channels ) == channels ? n : 1;
			var b : Number = ( 4 | channels ) == channels ? n : 1;
				
			var rl : Number = negative ? -r * ( 204 * v ) : 0;
			var gl : Number = negative ? -g * ( 204 * v ) : 0;
			var bl : Number = negative ? -b * ( 204 * v ) : 0;
			
			var a : Array = [ 	r , 0 , 0 , 0 , rl ,
								0 , g , 0 , 0 , gl ,
								0 , 0 , b , 0 , bl ,
								0 , 0 , 0 , 1 , 0  ,
								0 , 0 , 0 , 0 , 1 ];
			
			multiply( a );
		}
	
		/**
		 * Do a contrast operation with current matrix.
		 * @param v The contrast value between -1 and 1.
		 * @param channels The channels to apply transformation. Use ColorChannel constants separate by "|".
		 * @see myLib.colors.ColorChannel
		 */
		public function contrast ( v : Number , channels : uint = 15 ) : void
		{
			v = NumberUtils.clamp( v , -1 );
			
			var n : Number = v + 1;
			var r : Number = ( 1 | channels ) == channels ? n : 1;
			var g : Number = ( 2 | channels ) == channels ? n : 1;
			var b : Number = ( 4 | channels ) == channels ? n : 1;
			
			var a : Array = [ 	r , 0 , 0 , 0 , 128 * (1 - r) ,
								0 , g , 0 , 0 , 128 * (1 - g) ,
								0 , 0 , b , 0 , 128 * (1 - b) ,
								0 , 0 , 0 , 1 , 0             ,
								0 , 0 , 0 , 0 , 1 ];
			
			multiply( a );
		}
	
		/**
		 * Do a saturation operation with current matrix.
		 * @param v The saturation value between -1 and 1.
		 * @param channels The channels to apply transformation. Use ColorChannel constants separate by "|".
		 * @see myLib.colors.ColorChannel
		 */
		public function saturation ( v : Number , channels : uint = 15 ) : void
		{
			v = NumberUtils.clamp( v , -1 , 1 );
			
			var n : Number = 1 + ( v > 0 ? 3 * v : v );
			var r : Number = ( 1 | channels ) == channels ? ( 1 - n ) * R_LUM : 1;
			var g : Number = ( 2 | channels ) == channels ? ( 1 - n ) * G_LUM : 1;
			var b : Number = ( 4 | channels ) == channels ? ( 1 - n ) * B_LUM : 1;
			
			var a : Array = [ 	r + n , g     , b     , 0 , 0 ,
								r     , g + n , b     , 0 , 0 ,
								r     , g     , b + n , 0 , 0 ,
								0     , 0     , 0     , 1 , 0 ,
								0     , 0     , 0     , 0 , 1 ];
			
			multiply( a );
		}
	
		/**
		 * Do a hue operation with current matrix.
		 * @param v The hue value between -180 and 180.
		 */
		public function hue ( v : Number ) : void
		{
			v = MathUtils.degreeToRadian( NumberUtils.clamp( v , -180 , 180 ) );
	
			var r : Number = R_LUM;
			var g : Number = G_LUM;
			var b : Number = B_LUM;
			var c : Number = Math.cos( v );
			var s : Number = Math.sin( v );
			
			var a : Array = [ 	r + c * ( 1 - r ) + s * -r  , g + c * -g + s * -g           , b + c * -b + s * ( 1 - b ) , 0 , 0 ,
								r + c * -r + s * 0.143      , g + c * ( 1 - g ) + s * 0.140 , b + c * -b + s * -0.283    , 0 , 0 ,
								r + c * -r + s * -( 1 - r ) , g + c * -g + s * g            , b + c * ( 1 - b ) + s * b  , 0 , 0 ,
								0                           , 0                             , 0                          , 1 , 0 ,
								0                           , 0                             , 0                          , 0 , 1 ];
			
			multiply( a );
		}
	
		/**
		 * Do a filter operation with current matrix.
		 * @param color The color to apply as a hexadecimal number.
		 * @param p The intensity of the color between 0 and 100.
		 */
		public function filter ( color : Number , p : Number ) : void
		{
			color = NumberUtils.clamp( color , 0 , 0xFFFFFF );
			p = NumberUtils.clamp( p , -100 , 100 ) / 100;
			
			var ip : Number = 1 - p;
			var r : Number = ( ( color >> 16 ) & 0xff ) / 255;
			var g : Number = ( ( color >> 8  ) & 0xff ) / 255;
			var b : Number = (   color         & 0xff ) / 255;
			
			var a : Array =  [ 	ip + p * r * R_LUM , p * r * G_LUM      , p * r * B_LUM      , 0 , 0 ,
								p * g * R_LUM      , ip + p * g * G_LUM , p * g * B_LUM      , 0 , 0 ,
								p * b * R_LUM      , p * b * G_LUM      , ip + p * b * B_LUM , 0 , 0 ,
								0                  , 0                  , 0                  , 1, 0 ];
			
			
			multiply( a );
		}
	
		/**
		 * Do a colorize operation with current matrix.
		 * @param color The color to apply as a hexadecimal number.
		 * @param p The intensity of the color between 0 and 100.
		 */
		public function colorize ( color : Number , p : Number ) : void
		{
			color = NumberUtils.clamp( color , 0 , 0xFFFFFF );
			p = NumberUtils.clamp( p , -100 , 100 ) / 100;
			
			var rgb : RGBColor = new RGBColor( color );
			var up : Number = Math.abs( p );
			
			var r : Number = rgb.r / 255;
			var g : Number = rgb.g / 255;
			var b : Number = rgb.b / 255;
			
			if( p < 0 )
			{
				r = 1 - r;
				g = 1 - g;
				b = 1 - b;
			}
			
			var irl : Number = 1 - ( 1 - R_LUM ) * up;
			var igl : Number = 1 - ( 1 - G_LUM ) * up;
			var ibl : Number = 1 - ( 1 - B_LUM ) * up;
			
			var rl : Number = R_LUM * up;
			var gl : Number = G_LUM * up;
			var bl : Number = B_LUM * up;
			
			var a : Array = [ 	irl , gl  , bl  , 0 , r * p * 255 ,
								rl  , igl , bl  , 0 , g * p * 255 ,
								rl  , gl  , ibl , 0 , b * p * 255 ,
								0   , 0   , 0   , 1 , 0           ,
								0   , 0   , 0   , 0 , 1 ];
						
			multiply( a );
		}
		
		/**
		 * Get a string representation of ColorMatrix object.
		 */
		public function toString(  ) : String
		{
			return "[object ColorMatrix " + _matrix + "]";
		}
		
		/**
		 * @private
		 */
		protected function _fixArray( a : Array ) : Array
		{
			if( a == null ) a = new Array();
			
			var i : int = -1;	
			
			while( ++i < 25 ) a[ i ] = a[ i ] == null ? __IDENTITY_MATRIX[ i ] : a[ i ];
			
			a.splice( 25 );
			
			return a;
		}
	}
}