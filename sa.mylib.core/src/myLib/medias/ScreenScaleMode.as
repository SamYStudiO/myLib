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
 * The Original Code is myLib Framework.
 *
 * The Initial Developer of the Original Code is
 * Samuel EMINET (aka SamYStudiO) contact@samystudio.net.
 * Portions created by the Initial Developer are Copyright (C) 2008-2011
 * the Initial Developer. All Rights Reserved.
 *
 */
package myLib.medias 
{
	/**
	 * @author SamYStudiO ( contact@samystudio.net )
	 */
	public final class ScreenScaleMode 
	{
		/**
		 * MediaPlayer and video cannot resized, size from video metadata is used and MediaPlayer is sized to match video size.
		 */
		public static const AUTOSIZE : String = "autosize";
		
		/**
		 * Video is resized according MediaPlayer size (original aspect ration is not preserved).
		 */
		public static const EXACT_FIT : String = "exactFit";
		
		/**
		 * Video is resized according MediaPlayer size maintaining aspect ratio but certainly cropped.
		 */
		public static const NO_BORDER : String = "noBorder";
		
		/**
		 * Video is resized according MediaPlayer size maintaining aspect ratio width borders visible (all video area is visible).
		 */
		public static const SHOW_ALL : String = "showAll";
		
		/**
		 * @private
		 */
		public function ScreenScaleMode()
		{
			throw new Error( this + " cannot be instantiated" );
		}
	}
}
