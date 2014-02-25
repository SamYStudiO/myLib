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
	import myLib.data.SimpleCollection;			
	/**
	 * PlayList is a list of medias played with MediaPlayer component.
	 * 
	 * @see MediaPLayer#playList
	 * @author SamYStudiO ( contact@samystudio.net )
	 */
	public final class PlayList extends SimpleCollection
	{
		/**
		 * Build a new PlayList instance.
		 * 
		 * @param medias The list of medias to add.
		 */
		public function PlayList ( ...medias : Array )
		{
			super( medias , StreamMedia );
		}

		/**
		 * Get a random media from current PlayList.
		 * 
		 * @param fromMedia a media to exclude from random search.
		 * @return A random StreamMedia object from PlayList.
		 */
		public function getRandom( fromMedia : StreamMedia = null ) : StreamMedia
		{
			if( _data.length <= 1 ) return _data[ 0 ] as StreamMedia;
			
			var media : StreamMedia;
			
			while( media == null || media == fromMedia )
				media = _data[ Math.floor( Math.random() * _data.length ) ] as StreamMedia;
			
			return media;
		}
		
		/**
		 * Get media in current PlayList with the specified name.
		 * 
		 * @param name StreamMedia name to find.
		 * @return The streamMedia object with the specified name or null if not exist.
		 */
		public function getItembyName( name : String ) : StreamMedia
		{
			var l : uint = _data.length;
			
			for( var i : uint = 0; i < l; i++ ) 
			{
				var media : StreamMedia = _data[ i ] as StreamMedia;
				
				if( name == media.name ) return media;
			}
			
			return null;
		}
	}
}
