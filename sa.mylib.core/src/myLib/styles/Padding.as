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
package myLib.styles 
{
	/**
	 * Padding class is a simple Object that defined a left, top, right and bottom properties.
	 * Padding is useful with TextField and components layout.
	 * 
	 * @author SamYStudiO ( contact@samystudio.net )
	 */
	public final class Padding 
	{
		/**
		 * Get or set the padding left value.
		 */
		public var left : Number;
		
		/**
		 * Get or set the padding top value.
		 */
		public var top : Number;
		
		/**
		 * Get or set the padding right value.
		 */
		public var right : Number;
		
		/**
		 * Get or set the padding bottom value.
		 */
		public var bottom : Number;
		
		/**
		 * Build a new Padding instance.
		 * @param left The padding left value		 * @param top The padding top value		 * @param right The padding right value		 * @param bottom The padding bottom value
		 */
		public function Padding( left : Number = 0 , top : Number = 0 , right : Number = 0 , bottom : Number = 0 )
		{
			this.left = left;			this.top = top;			this.right = right;			this.bottom = bottom;
		}
		
		/**
		 * Return a string that contains all the properties of the Padding object.
		 * 
		 * @return The Padding object string representation.
		 */
		public function toString(  ) : String
		{
			return "[object Padding left=" + left + " ,top=" + top + " ,right=" + right + " ,bottom=" + bottom + "]";
		}
	}
}
