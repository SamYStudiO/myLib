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
package myLib.utils
{
	/**
	 * Utils for Number operations.
	 * 
	 * @author SamYStudiO ( contact@samystudio.net )
	 */
	public final class NumberUtils
	{
		/**
		 * @private
		 */
		public function NumberUtils()
		{
			throw new Error( this + " cannot be instantiated" );
		}
		
		/**
		 * Test if a Number is an integer.
		 * @return true if Number is a integer.
		 */
		public static function isInteger ( n : Number ) : Boolean
		{
			return int( n ) == n;
		}
		
		/**
		 * Test if a Number is even.
		 * @return true if Number is even.
		 */
		public static function isEven ( n : Number ) : Boolean
		{
			return int( n / 2 ) == n / 2;
		}
		
		/**
		 * Test if a Number is odd.
		 * @return true if Number is odd.
		 */
		public static function isOdd ( n : Number ) : Boolean
		{
			return int( n / 2 ) != n / 2;
		}
	
		/**
		 * Clamp a number betwen min and max value.
		 * @param n The Number to clamp.
		 * @param min The minimum value for the Number.		 * @param max The maximum value for the Number.
		 * @param throwError A Boolean that indicates if Number out of range throw an Error or is clamp to match min or max value.
		 * @return The Number between min and max value.
		 * @throws A Error if Number is out of range and throwError argument is true.
		 */
		public static function clamp ( n : Number , min : Number = Number.NEGATIVE_INFINITY , max : Number = Number.POSITIVE_INFINITY , throwError : Boolean = false ) : Number
		{
			if( throwError && ( n < min || n > max || isNaN( n ) ) ) throw new Error( "Number " + n + " is out of range; minimum > " + min + "; maximum > " + max );
			
			if( n < min || isNaN( n ) ) n = min;
			else if( n > max ) n = max;
			
			return n;
		}
		
		/**
		 * Get the number sign (positive or negative).
		 * 
		 * @return 1 if positive else -1 if negative.
		 */
		public static function sign( n : Number ) : int
		{
			return n < 0 ? -1 : 1;
		}
	
		/**
		 * Convert A Number to a string money format.
		 * @param n The Number to convert.
		 * @param floatSeparator The char used as float.
		 * @param thousSeparator The char used for thousand separator.
		 * @return The Number converted to money format.
		 */
		public static function moneyFormat ( n : Number , floatSeparator : String = "." , thousSeparator : String = " " ) : String
		{
			var float : String = String( n.toFixed( 2 ) ).slice( -2 );
			var s : String = String( n ).split( "." )[ 0 ];
			var aSplit : Array = new Array( );
			
			while( s.slice( -3 ).length == 3 )
			{
				aSplit.push( thousSeparator + s.slice( -3 ) );
				s = s.substr( 0 , s.length - 3 );
			}
			
			aSplit.reverse( );
			
			s = s + aSplit.join( "" ) + floatSeparator + float;
			
			if( s.charAt( 0 ) == thousSeparator ) s = s.substr( 1 );
			
			return s;
		}
		
		/**
		 * Convert a Number to a string digit format.
		 * @param n The Number to convert.
		 * @param length The minimum Number of digit.
		 * @return The Number with all "0" necessary to match digit length.
		 */
		public static function digitFormat( n : Number , length : uint = 2 ) : String
		{
			var a : Array = n.toString().split( "." );
			var s : String = isNaN( n ) ? "" : a[ 0 ];
			
			while( s.length < length ) s = "0" + s;
			
			return s + ( a.length > 1 && !isNaN( n ) ? "." + a[ 1 ] : "" );
		}
	}
}