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
	/**
	 * ColorSpace class contains constants to use with IColorSpace.convert method.
	 * 
	 * @author SamYStudiO ( contact@samystudio.net )
	 */	public final class ColorSpace
	{
		/**
		 * A string representation og RGB color space.
		 */		public static const RGB : String = "RGB";
			/**
		 * A string representation og HSB color space.
		 */		public static const HSB : String = "HSB";
			/**
		 * A string representation og HSL color space.
		 */		public static const HSL : String = "HSL";
		
		/**
		 * @private
		 */
		public function ColorSpace()
		{
			throw new Error( this + " cannot be instantiated" );
		}	
	}
}