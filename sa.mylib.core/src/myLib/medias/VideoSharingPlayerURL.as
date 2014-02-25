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
	public final class VideoSharingPlayerURL
	{
		/**
		 *
		 */
		public static var YOUTUBE_CHROMELESS : String = "http://www.youtube.com/apiplayer?version=3";
		public static var YOUTUBE : String = "http://www.youtube.com/v/[ID]?version=3";
		
		/**
		 *
		 */
		public static var DAILYMOTION_CHROMELESS : String = "http://www.dailymotion.com/swf?enableApi=1&chromeless=1";
		public static var DAILYMOTION : String = "http://www.dailymotion.com/swf?enableApi=1&chromeless=0";
		
		/**
		 * @private
		 */
		public function VideoSharingPlayerURL()
		{
			throw new Error( this + " cannot be instantiated" );
		}
	}
}
