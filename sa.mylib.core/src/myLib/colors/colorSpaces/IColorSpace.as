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
	 * @author SamYStudiO ( contact@samystudio.net )
	 */
	public interface IColorSpace
	{
		/**
		 * Convert color object to any other color space.
		 * @param colorSpace The outpout color space, use ColorSpace constants to choose your color space.
		 * @see myLib.colors.colorSpaces.ColorSpace
		 */
		function convert ( colorSpace : String ) : IColorSpace;
	
		/**
		 * Convert color object to an hexadecimal string representation.
		 * @param prefix A prefix to add before string representation.
		 * @return An hexadecimal string representation.
		 */
		function toHex ( prefix : String = "" ) : String;
	
		/**
		 * Convert color object to an Number representation.
		 * @return The color as Number representation.
		 */
		function toNumber () : uint;
	}
}