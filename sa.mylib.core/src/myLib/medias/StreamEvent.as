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
	 * The StreamEvent class defines the events that are associated with the MediaPlayer class. 
	 * 
	 * @author SamYStudiO ( contact@samystudio.net )
	 */
	public class StreamEvent extends Event 
	{
		/**
		 * Defines the value of the type property of a bufferEmpty event object.
		 * 
		 * @eventType bufferEmpty
		 */
		public static const BUFFER_EMPTY : String = "bufferEmpty";
		
		/**
		 * Defines the value of the type property of a buffering event object.
		 * 
		 * @eventType buffering
		 */
		public static const BUFFERING : String = "buffering";
		
		/**
		 * Defines the value of the type property of a bufferFull event object.
		 * 
		 * @eventType bufferFull
		 */
		public static const BUFFER_FULL : String = "bufferFull";
		
		/**
		 * Defines the value of the type property of a loading event object.
		 * 
		 * @eventType loading
		 */
		public static const LOADING : String = "loading";
		
		/**
		 * Defines the value of the type property of a loadingComplete event object.
		 * 
		 * @eventType loadingComplete
		 */
		public static const LOADING_COMPLETE : String = "loadingComplete";
		
		/**
		 * Defines the value of the type property of a playProgress event object.
		 * 
		 * @eventType playProgress
		 */
		public static const PLAY_PROGRESS : String = "playProgress";
		
		/**
		 * Defines the value of the type property of a playComplete event object.
		 * 
		 * @eventType playComplete
		 */
		public static const PLAY_COMPLETE : String = "playComplete";
		
		/**
		 * Defines the value of the type property of a play event object.
		 * 
		 * @eventType play
		 */
		public static const PLAY : String = "play";
		
		/**
		 * Defines the value of the type property of a play start event object.
		 * 
		 * @eventType playStart
		 */
		public static const PLAY_START : String = "playStart";
		
		/**
		 * Defines the value of the type property of a resume event object.
		 * 
		 * @eventType resume
		 */
		public static const RESUME : String = "resume";
		
		/**
		 * Defines the value of the type property of a pause event object.
		 * 
		 * @eventType pause
		 */
		public static const PAUSE : String = "pause";
		
		/**
		 * Defines the value of the type property of a stop event object.
		 * 
		 * @eventType stop
		 */
		public static const STOP : String = "stop";
		
		/**
		 * Defines the value of the type property of a close event object.
		 * 
		 * @eventType close
		 */
		public static const CLOSE : String = "close";
		
		/**
		 * Defines the value of the type property of a metaData event object.
		 * 
		 * @eventType metaData
		 */
		public static const META_DATA : String = "metaData";
		
		/**
		 * Defines the value of the type property of a streamNotFound event object.
		 * 
		 * @eventType streamNotFound
		 */
		public static const STREAM_NOT_FOUND : String = "streamNotFound";
		
		/**
		 * Get or set the StreamMedia object from wich this event was dispatched.
		 * 
		 * @see StreamMedia
		 */
		public var media : StreamMedia;
		
		/**
		 * Build a new StreamEvent instance.
		 * 
		 * @param type The event type as defined in StreamEvent constants.
		 * @param media The media currently playing with MediaPlayer
		 */
		public function StreamEvent ( type : String , media : StreamMedia , bubbles : Boolean = false , cancelable : Boolean = false )
		{
			super( type , bubbles , cancelable );
			
			this.media = media;
		}
		
		/**
		 * Creates a copy of the StreamEvent object and sets each property's value to match that of the original. 
		 */
		public override function clone(  ) : Event
		{
			return new StreamEvent( type , media , bubbles , cancelable );
		}
		
		/**
		 * Returns a string that contains all the properties of the StreamEvent object.
		 */
		public override function toString(  ) : String
		{
			return formatToString( "StreamEvent", "type" , "media" , "bubbles" , "cancelable" );
		}
	}
}
