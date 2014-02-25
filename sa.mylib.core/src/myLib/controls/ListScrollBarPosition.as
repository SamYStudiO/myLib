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
	 * ComboBoxScrollBarPosition defines constants to use with List and ComboBox scrollBarPosition property.
	 * 
	 * @see List.scrollBarPosition
	 * 
	 * @author SamYStudiO ( contact@samystudio.net )
	 */
	public final class ListScrollBarPosition 
	{
		/**
		 * Constant for left positon.
		 */
		public static const LEFT : String = "left";
		
		/**
		 * Constant for right position.
		 */
		public static const RIGHT : String = "right";
		
		/**
		 * @private
		 */
		public function ListScrollBarPosition()
		{
			throw new Error( this + " cannot be instantiated" );
		}
	}
}
