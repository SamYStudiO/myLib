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
package myLib.controls 
{
	/**
	 * ColorPickerOpenDirection defines constants to use with ColorPicker openDirection property.
	 * 
	 * @see ColorPicker.openDirection
	 * 
	 * @author SamYStudiO ( contact@samystudio.net )
	 */
	public final class ColorPickerOpenDirection 
	{
		/**
		 * Constant for top direction.
		 */
		public static const TOP : String = "top";
		
		/**
		 * Constant for right direction.
		 */
		public static const RIGHT : String = "right";
		
		/**
		 * Constant for bottom direction.
		 */
		public static const BOTTOM : String = "bottom";
		
		/**
		 * Constant for left direction.
		 */
		public static const LEFT : String = "left";
		
		/**
		 * @private
		 */
		public function ColorPickerOpenDirection()
		{
			throw new Error( this + " cannot be instantiated" );
		}
	}
}
