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
package myLib.colors
{
	/**
	 * ColorChannel class contains constants to use with ColorMatrix class.
	 * 
	 * @author SamYStudiO ( contact@samystudio.net )
	 */
	public final class ColorChannel
	{
		/**
		 * Constant to use with red channel.
		 */
		public static const RED : uint = 1;
	
		/**
		 * Constant to use with green channel.
		 */
		public static const GREEN : uint = 2;
	
		/**
		 * Constant to use with blue channel.
		 */
		public static const BLUE : uint = 4;
	
		/**
		 * Constant to use with alpha channel.
		 */
		public static const ALPHA : uint = 8;
		
		/**
		 * @private
		 */
		public function ColorChannel()
		{
			throw new Error( this + " cannot be instantiated" );
		}
	}
}