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
	 * ComboBoxDropdownWidthType defines constants to use with ComboBox dropdownWidthType property.
	 * 
	 * @see ComboBox.dropdownWidthType
	 * 
	 * @author SamYStudiO
	 */
	public final class ComboBoxDropdownWidthType 
	{
		/**
		 * The constant for a none type.
		 */
		public static const NONE : String = "none";
		
		/**
		 * The constant for a percentage type.
		 */
		public static const PERCENTAGE : String = "percentage";
		
		/**
		 * The constant for an arrowButton type.
		 */
		public static const ARROW_BUTTON : String = "arrowButton";
		
		/**
		 * The constant for an autoSize type.
		 */
		public static const AUTOSIZE : String = "autoSize";
		
		/**
		 * @private
		 */
		public function ComboBoxDropdownWidthType()
		{
			throw new Error( this + " cannot be instantiated" );
		}
	}
}
