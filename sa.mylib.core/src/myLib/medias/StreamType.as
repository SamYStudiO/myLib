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
package myLib.medias 
{
	/**
	 * StreamType class defines constants to used with StreamMedia streamType property.
	 * 
	 * @see StreamMedia#streamType
	 * 
	 * @author SamYStudiO ( contact@samystudio.net )
	 */
	public final class StreamType 
	{
		/**
		 * Classic Video file type.
		 */
		public static const VIDEO : String = "video";
		
		/**
		 * RTMP file type.
		 */
		public static const RTMP : String = "RTMP";
		
		/**
		 * HTTPPseudoStream file type.
		 */
		public static const HTTP_PSEUDO_STREAM : String = "HTTPPseudoStream";
		
		/**
		 * Youtube platform file.
		 */
		public static const YOUTUBE : String = "youtube";
		public static const YOUTUBE_CHROMELESS : String = "youtubeChromeless";
		
		/**
		 * Dailymotion platform file.
		 */
		public static const DAILYMOTION : String = "dailymotion";
		public static const DAILYMOTIONE_CHROMELESS : String = "dailymotionChromeless";
		
		/**
		 * Sound file type.
		 */
		public static const SOUND : String = "sound";
		
		/**
		 * SWF flash movie file type.
		 */
		public static const FLASH : String = "flash";
		
		/**
		 * Picture file type (JPG, PNG).
		 */
		public static const IMAGE : String = "image";
		
		/**
		 * @private
		 */
		public function StreamType()
		{
			throw new Error( this + " cannot be instantiated" );
		}
	}
}
