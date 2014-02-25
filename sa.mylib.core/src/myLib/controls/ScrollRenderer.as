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
	 * ScrollRenderer defines constants to use with ScrollPane scrollRenderer property of List scrollRenderer property.
	 * 
	 * @author SamYStudiO ( contact@samystudio.net )
	 */
	public final class ScrollRenderer 
	{
		/**
		 * Constant for a ScrollBar render.
		 */
		public static const SCROLLBAR : String = "myLib.controls.ScrollBar";
		
		/**
		 * Constant for a MouseScroll render.
		 */
		public static const MOUSESCROLL : String = "myLib.controls.MouseScroll";
		
		/**
		 * Constant for a PanoramaScroll render.
		 */
		public static const PANORAMASCROLL : String = "myLib.controls.PanoramaScroll";
		
		/**
		 * Constant for a TouchScroll render.
		 */
		public static const TOUCHSCROLL : String = "myLib.controls.TouchScroll";
		
		/**
		 * Constant for no scroll.
		 */
		public static const OFF : String = "off";
		
		/**
		 * @private
		 */
		public function ScrollRenderer()
		{
			throw new Error( this + " cannot be instantiated" );
		}
	}
}
