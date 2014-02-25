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
	 * AlignmentPoint defines constants to use with AlignmentManager.
	 * 
	 * @author SamYStudiO ( contact@samystudio.net )
	 */
	public final class AlignmentPoint
	{
		/**
		 * Constant for top left alignment.
		 */
		public static const TOP_LEFT : String = "TL";
	
		/**
		 * Constant for top alignment.
		 */
		public static const TOP : String = "T";
	
		/**
		 * Constant for top right alignment.
		 */
		public static const TOP_RIGHT : String = "TR";
	
		/**
		 * Constant for right alignment.
		 */
		public static const RIGHT : String = "R";
	
		/**
		 * Constant for bottom right alignment.
		 */
		public static const BOTTOM_RIGHT : String = "BR";
	
		/**
		 * Constant for bottom alignment.
		 */
		public static const BOTTOM : String = "B";
	
		/**
		 * Constant for bottom left alignment.
		 */
		public static const BOTTOM_LEFT : String = "BL";
	
		/**
		 * Constant for left alignment.
		 */
		public static const LEFT : String = "L";
	
		/**
		 * Constant for center alignment.
		 */
		public static const CENTER : String = "C";	
		
		/**
		 * @private
		 */
		public function AlignmentPoint()
		{
			throw new Error( this + " cannot be instantiated" );
		}
	}
}