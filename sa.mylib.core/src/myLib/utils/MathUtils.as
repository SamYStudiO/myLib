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
	 * Utils for Maths operations.
	 * 
	 * @author SamYStudiO ( contact@samystudio.net )
	 */
	public final class MathUtils
	{
		/**
		 * @private
		 */
		public function MathUtils()
		{
			throw new Error( this + " cannot be instantiated" );
		}
		
		/**
		 * Convert an radian angle to degree angle.
		 * @param rad The radian angle to convert.
		 * @return The angle in degree.
		 */
		public static function radianToDegree ( rad : Number ) : Number
		{
			return rad * 180 / Math.PI;
		}
	
		/**
		 * Convert an degree angle to radian angle.
		 * @param deg The degree angle to convert.
		 * @return The angle in radian.
		 */
		public static function degreeToRadian ( deg : Number ) : Number
		{
			return deg / 180 * Math.PI;	
		}
	
		/**
		 * Perform a 2D equation.
		 * @param a value a.		 * @param b value b.		 * @param c value c.
		 * @return An object with properties r1 and r2. If only one result is possible only r1 is defined.
		 */
		public static function equation2D ( a : Number , b : Number , c : Number ) : Object
		{
			var d : Number = Math.pow( b , 2 ) - 4 * a * c;
			
			if( d < 0 ) return null;
			
			if( d == 0 ) return { r1 : b / 2 * a };
			else
			{
				var r1 : Number = ( -b + Math.sqrt( d ) ) / 2 * a;
				var r2 : Number = ( -b - Math.sqrt( d ) ) / 2 * a;
				
				return { r1 : r1 , r2 : r2 };
			}
		}	
	
		/**
		 * Perform a Pythagorean Theorem in a triangle.
		 * @param s1 Side 1 size.		 * @param s2 Side 2 size.
		 * @param searchHypotenuse A Boolean that indicates if the unkown size is hypothenus.
		 * @return The size of third side.
		 */
		public static function pythagoras ( s1 : Number , s2 : Number , searchHypotenuse : Boolean = false ) : Number
		{
			if( searchHypotenuse ) return Math.sqrt( s1 * s1 + s2 * s2 );
			else
			{
				var hypo : Number = Math.max( s1 , s2 );
				var side : Number = Math.min( s1 , s2 );
				
				return Math.sqrt( hypo * hypo - side * side );
			}
		}
	}
}