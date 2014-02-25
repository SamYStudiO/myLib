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
package myLib.utils {
	/**
	 * Utils for String operations.
	 * 
	 * @author SamYStudiO ( contact@samystudio.net )
	 */
	public final class StringUtils 	{
		/**
		 * @private
		 */
		public function StringUtils()
		{
			throw new Error( this + " cannot be instantiated" );
		}
		
		/**
		 * Test if string is a white space.
		 * @return true if string is a white space.
		 */
		public static function isWhitespace( s : String ) : Boolean
		{
			switch( s )
	        {
	            case " "  :
	            case "\t" :
	            case "\r" :
	            case "\n" :
	            case "\f" :
	                return true;
	
	            default :
	                return false;
	        }
		}
		
		/**
		 * Remove white spaces from string at left and right.
		 * @return a string where white spaces from left and right are removed
		 */
		public static function trim( s : String ) : String
		{
			return trimRight( trimLeft( s ) );
		}
		
		/**
		 * Remove white spaces from string at left.
		 * @return a string where white spaces from left are removed
		 */
		public static function trimLeft( s : String ) : String
		{
			while( isWhitespace( s.charAt( 0 ) ) )
			{
				s = s.substr( 1 );	
			}
			
			return s;
		}
		
		/**
		 * Remove white spaces from string at right.
		 * @return a string where white spaces from right are removed
		 */
		public static function trimRight( s : String ) : String
		{
			while( isWhitespace( s.charAt( s.length - 1 ) ) )
			{
				s = s.substr( 0 , s.length - 1 );	
			}
			
			return s;
		}
		
		/**
		 * Capitalize first char from specified string
		 * @return a string with first char capitalized
		 */
		public static function capitalize( s : String ) : String
		{
			return s.charAt( 0 ).toUpperCase() + s.substr( 1 );
		}
		
		/**
		 * Test if string is a valid email.
		 * @return true if string is a valid email.
		 */
		public static function isEmail( s : String ) : Boolean
		{
			return /^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,6}$/i.test( s );
		}
	}
}
