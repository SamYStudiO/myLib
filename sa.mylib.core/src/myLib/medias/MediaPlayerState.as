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
	public final class MediaPlayerState
	{
		/**
		 *
		 */
		public static const CLOSED : uint = 0;
		
		/**
		 *
		 */
		public static const STOPPED : uint = 1;
		
		/**
		 *
		 */
		public static const PAUSED : uint = 2;
		
		/**
		 *
		 */
		public static const PLAYING : uint = 4;
		
		/**
		 *
		 */
		public static const BUFFERING : uint = 8;
		
		/**
		 *
		 */
		public static const LOADING : uint = 16;
		
		/**
		 *
		 */
		public static const BUFFERED : uint = 32;
		
		/**
		 *
		 */
		public static const LOADED : uint = 64;
		
		/**
		 *
		 */
		public static const SUB_LOADING : uint = 128;
		
		/**
		 *
		 */
		public static const SUB_LOADED : uint = 256;
		
		/**
		 * @private
		 */
		public function MediaPlayerState()
		{
			throw new Error( this + " cannot be instantiated" );
		}
	}
}
