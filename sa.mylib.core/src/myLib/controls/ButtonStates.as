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
	 *  ButtonStates defines Button states (up, over, ...).
	 *  These values must match MovieTextFieldAsset frame label
	 * 
	 * @author SamYStudiO ( contact@samystudio.net )
	 */
	public final class ButtonStates 
	{
		/**
		 * Value name for an up state.
		 */
		public static var UP : String = "up";
		
		/**
		 * Value name for an up selected state.
		 */
		public static var UP_SELECTED : String = "upSelected";
		
		/**
		 * Value name for an over state.
		 */
		public static var OVER : String = "over";
		
		/**
		 * Value name for an over selected state.
		 */
		public static var OVER_SELECTED : String = "overSelected";
		
		/**
		 * Value name for a down state.
		 */
		public static var DOWN : String = "down";
		
		/**
		 * Value name for a down selected state.
		 */
		public static var DOWN_SELECTED : String = "downSelected";
		
		/**
		 * Value name for a disabled state.
		 */
		public static var DISABLED : String = "disabled";
		
		/**
		 * Value name for a disabled selected state.
		 */
		public static var DISABLED_SELECTED : String = "disabledSelected";
		
		/**
		 * @private
		 */
		public function ButtonStates()
		{
			throw new Error( this + " cannot be instantiated" );
		}
	}
}
