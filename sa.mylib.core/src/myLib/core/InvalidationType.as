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
package myLib.core 
{
	/**
	 * InvalidationType defines constants to use with component invalidation.
	 * 
	 * @author SamYStudiO ( contact@samystudio.net )
	 */
	public final class InvalidationType 
	{
		/**
		 * Constant for no invalidation.
		 */
		public static const NONE : uint = 0;
		
		/**
		 * Constant for a resize invalidation.
		 */
		public static const SIZE : uint = 1;
		
		/**
		 * Constant for a state change invalidation.
		 */
		public static const STATE : uint = 2;
		
		/**
		 * Constant for a data change invalidation.
		 */
		public static const DATA : uint = 4;
		
		/**
		 * Constant for all invalidation type.
		 */
		public static const ALL : uint = 7;
		
		/**
		 * @private
		 */
		public function InvalidationType()
		{
			throw new Error( this + " cannot be instantiated" );
		}
	}
}
