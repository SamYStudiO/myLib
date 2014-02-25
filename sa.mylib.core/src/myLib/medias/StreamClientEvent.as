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
	import flash.events.Event;
	/**
	 * @author SamYStudiO
	 */
	public class StreamClientEvent extends Event 
	{
		/**
		 *
		 */
		public static const META_DATA : String = "onMetaData";
		
		/**
		 *
		 */
		public static const XMP_DATA : String = "onXMPData";
		
		/**
		 *
		 */
		public static const CUE_POINT : String = "onCuePoint";
		
		/**
		 *
		 */
		public static const IMAGE_DATA : String = "onImageData";
		
		/**
		 *
		 */
		public static const PLAY_STATUS : String = "onPlayStatus";
		
		/**
		 *
		 */
		public static const TEXT_DATA : String = "onTextData";
		
		/**
		 *
		 */
		public static const LAST_SECOND : String = "onLastSecond";
		
		/**
		 *
		 */
		public var infos : Object;
		
		/**
		 * 
		 */
		public function StreamClientEvent( type : String , infos : Object = null , bubbles : Boolean = false , cancelable : Boolean = false )
		{
			super( type , bubbles , cancelable );
			
			this.infos = infos;
		}
	}
}
