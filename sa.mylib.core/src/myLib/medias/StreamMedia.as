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
	import flash.net.URLRequest;
	/**
	 * StreamMedia stores all informations from media file. Before reading file StreamMedia only have a few informations such as file url, name, etc.
	 * As Soon as StreamMedia file is played with MediaPLayer some new informations are available such as bytesLoaded, bytesTotal, bufferLoaded, bufferTotal, position, metatData, etc.
	 * 
	 * @author SamYStudiO ( contact@samystudio.net )
	 */
	public dynamic final class StreamMedia
	{
		[Inspectable(name="url")]
		/**
		 * @private
		 */
		public var url : String;
		
		/**
		 * Get the media position in milliseconds (value between 0 and media duration).
		 * You should never modify this property.
		 */
		public var position : uint;
		
		[Inspectable(defaultValue=0)]
		/**
		 * Get or set media duration in milliseconds.
		 */
		public var duration : uint;
		
		/**
		 * Get the current bytes loaded.
		 * You should never modify this property.
		 */
		public var bytesLoaded : int;
		
		/**
		 * Get the current bytes total.
		 * You should never modify this property.
		 */
		public var bytesTotal : int;
		
		/**
		 * Get the current buffer bytes loaded.
		 * You should never modify this property.
		 */
		public var bufferBytesLoaded : int;
		
		/**
		 * Get the current buffer bytes total.
		 * You should never modify this property.
		 */
		public var bufferBytesTotal : int;
		
		/**
		 * Get the time left in milliseconds before buffer is full.
		 * You should never modify this property.
		 */
		public var bufferTimeLeft : uint;
		
		/**
		 * Get the time left in milliseconds before load operation is complete.
		 * You should never modify this property.
		 */
		public var loadTimeLeft : uint;
		
		/**
		 * Get or set The IStreamClient object used to catch callback from stream such as onMetaData, onXMPData, etc...
		 * By default media use StreamClient class, if tou need more specifics callback inherit it or make your own by implementing IStreamClient.
		 */
		public var streamClient : IStreamClient;
		
		/**
		 * Get or set the LoaderContext or SoundLoaderContext object needed with load operation.
		 */
		public var context : *;
		
		/**
		 * Get the meta data information from this media file.
		 * Use metaData event with MediaPlayer to make sure this propery is defined.
		 * You should never modify this property.
		 */
		public var metaData : Object;
		
		/**
		 * Get or set the subtitle displayed with this media.
		 */
		public var subTitle : ISubTitle;

		/**
		 * @private
		 */
		protected var _request : URLRequest;

		/**
		 * Get or set the URLRequest object use for load operation.
		 */
		public function get request() : URLRequest
		{
			return _request == null ? new URLRequest( url || "" ) : _request;
		}
		
		public function set request( request : * ) : void
		{
			if( request == null ) throw new ArgumentError( this + " request cannot be null" );
			
			_request = request is URLRequest ? request : new URLRequest( request.toString() );
		}
		
		/**
		 * @private
		 */
		protected var _streamType : String;
		
		[Inspectable(defaultValue="video",enumeration="video,sound,flash,image")]
		/**
		 * Get or set the media type. By default media type (FLV, MP3, ...) is auto defined using file extenstion. Since file extension or url does not always match file type,
		 * this property must sometimes set manually.
		 * Use StreamType constants to defined media type.
		 * @see StreamType
		 */
		public function get streamType() : String
		{
			return _streamType == null ? _getTypeFromURL( request.url ) : _streamType;
		}
		
		public function set streamType( type : String ) : void
		{
			_streamType = type;
		}
		
		/**
		 * @private
		 */
		protected var _name : String;
		
		[Inspectable]
		/**
		 * Get or set file name. By default media name is auto defined using file url, if you need a different file name set this property manually.
		 */
		public function get name() : String
		{
			return ( _name == null || _name == "" ) && request != null ? _getNameFromURL( request.url ) : _name;
		}
		
		public function set name( name : String ) : void
		{
			_name = name;
		}
		
		/**
		 * @private
		 */
		protected var _subTitleURL : String;
		
		[Inspectable]
		/**
		 * @private
		 */
		public function get subTitleURL() : String
		{
			return _subTitleURL;
		}
		
		public function set subTitleURL( url : String ) : void
		{
			_subTitleURL = url;
			
			if( url != "" && url != null ) subTitle = new SubTitle( new URLRequest( url ) );
			else subTitle = null;
		}
		
		/**
		 * @private
		 */
		protected var _previewMedia : StreamMedia;
		
		/**
		 *
		 */
		public function get previewMedia() : StreamMedia
		{
			return _previewMedia;
		}
		
		public function set previewMedia( sm : StreamMedia ) : void
		{
			_previewMedia = sm;
			
			if( sm != null )
			{
				sm.streamType = StreamType.IMAGE;
				sm.previewFrom = this;
			}
		}
		
		/**
		 * @private
		 */
		protected var _tryStageVideo : Boolean;
		
		/**
		 *
		 */
		public function get tryStageVideo() : Boolean
		{
			return _tryStageVideo;
		}
		
		/**
		 * @private
		 */
		internal var previewFrom : StreamMedia;
		
		/**
		 * Build a new StreamMedia instance.
		 * @param request The URLRequest object or String url used for load operation.
		 * @param streamType The media type as defined in StreamType constants.
		 * @param tryStageVideo The media type as defined in StreamType constants.
		 * @param name The media name.
		 * @param duration The media duration if it is already known before media meta data are loaded, leave 0 to wait meta data to get duration.		 * @param subTitle Tthe subtitle displayed with this media.
		 * @param streamClient The client used with netStream callback (a null client generate a default one with only metaData callback).		 * @param context The LoaderContext or SoundLoaderContext object needed with load operation.
		 */
		public function StreamMedia( request : * = null , streamType : String = null , tryStageVideo : Boolean = false , name : String = null , duration : uint = 0 , subTitle : ISubTitle = null , streamClient : IStreamClient = null , context : * = null )
		{
			if( request != null ) _request = request is URLRequest ? request : new URLRequest( request.toString() );
			_name = name;
			_streamType = streamType;
			_tryStageVideo = tryStageVideo;
			
			if( _streamType == null && _request != null ) _streamType = _getTypeFromURL( _request.url );
			if( _name == null && _request != null ) _name = _getNameFromURL( _request.url );
						this.duration = duration;
			this.streamClient = streamClient;
			this.context = context;
			this.subTitle = subTitle;
		}

		/**
		 * Get a String object with essential media informations (name, url and type).
		 * 
		 * @return The String representation of this StreamMedia object.
		 */
		public function toString(  ) : String
		{
			return "[object StreamMedia name=" + name + ", request=" + request.url + ", type=" + streamType + "]";
		}

		/**
		 * @private
		 */
		internal function reset() : void
		{
			position = 0;
			duration = 0;
			bytesLoaded = 0;			bytesTotal = 0;
			bufferBytesLoaded = 0;
			bufferBytesTotal = 0;
			bufferTimeLeft = 0;
			loadTimeLeft = 0;
			metaData = null;
		}

		/**
		 *
		 */
		private function _getNameFromURL( url : String ) : String
		{
			var a : Array = url.split( "." );
			a.pop( );
			a = a.join( "." ).split( "/" ).reverse();
			
			return a[ 0 ];
		}
		
		/**
		 *
		 */
		private function _getTypeFromURL( url : String ) : String
		{
			url = url.toLowerCase();
			var ext : String = url.split( "." ).pop( );
			var fromYoutube : Boolean = url.indexOf( "http://www.youtube.com/v/" ) == 0;
			var fromDailymotion : Boolean = url.indexOf( "http://www.dailymotion.com/video/" ) == 0;
			var rtmp : Boolean = url.indexOf( "rtmp" ) == 0;
			var http : Boolean = url.indexOf( "[" ) > 0;
			
			switch( true )
			{
				case ext == "jpg" 		:  				case ext == "png" 		:  				case ext == "gif" 		: return StreamType.IMAGE;				case ext == "mp3" 		: return StreamType.SOUND;
				case ext == "swf" 		: return StreamType.FLASH;
				case rtmp		 		: return StreamType.RTMP;
				case http		 		: return StreamType.HTTP_PSEUDO_STREAM;
				case fromYoutube		: return StreamType.YOUTUBE;
				case fromDailymotion	: return StreamType.DAILYMOTION;
								default 				:  return StreamType.VIDEO;
			}
		}
	}
}
