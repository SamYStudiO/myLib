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
package myLib.displayUtils 
{
	/**
	 * TextFieldGutter is used to layout TextField within its parent since default gutter size (4/4) can produce unstable layout.
	 * 
	 * @author SamYStudiO ( contact@samystudio.net )
	 */
	public final class TextFieldGutter 
	{
		/**
		 * Get or set the horizontal gutter size.
		 */
		public static var HSIZE : uint = 5;
		
		/**
		 * Get or set the vertical gutter size.
		 */
		public static var VSIZE : uint = 4;
		
		/**
		 * @private
		 */
		public function TextFieldGutter()
		{
			throw new Error( this + " cannot be instantiated" );
		}
	}
}
