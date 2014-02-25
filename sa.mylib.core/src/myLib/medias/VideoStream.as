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
	import myLib.ui.STAGE;

	import flash.events.NetStatusEvent;
	import flash.media.SoundTransform;
	import flash.media.StageVideo;
	import flash.media.Video;
	import flash.net.NetConnection;
	import flash.net.NetStream;
	import flash.system.LoaderContext;
	import flash.utils.Dictionary;
	/**
	 * @private
	 * @author SamYStudiO ( contact@samystudio.net )
	 */
	internal class VideoStream extends AStream
	{
		/**
		 * @private
		 */
		protected static var __defaultConnection : NetConnection;
		
		/**
		 * @private
		 */
		protected var _netStream : NetStream;
		
		/**
		 * @private
		 */
		protected var _netConnection : NetConnection;
		
		/**
		 * @private
		 */
		protected var _isComplete : Boolean;
		
		/**
		 * @private
		 */
		protected var _streamClient : IStreamClient;
		
		/**
		 * @private
		 */
		protected var _sawFlush : Boolean;
		
		/**
		 * @private
		 */
		protected var _screen : VideoScreen;
		
		/**
		 * @private
		 */
		protected var _isPaused : Boolean = true;
		
		/**
		 * @private
		 */
		protected var _isStageVideo : Boolean;
		
		/**
		 *
		 */
		public function get isStageVideo() : Boolean
		{
			return _isStageVideo;
		}
		
		/**
		 * @private
		 */
		protected var _stageVideoAvailability : Dictionary =new Dictionary( true );
		
		/**
		 * @inheritDoc
		 */
		public override function get screen() : VideoScreen
		{
			return _screen;
		}
		
		/**
		 * @inheritDoc
		 */
		public override function get handler() : *
		{
			return _netStream;
		}
		
		/**
		 * @inheritDoc
		 */
		public override function get volume() : Number
		{
			return _netStream.soundTransform.volume;
		}
		
		public override function set volume( n : Number ) : void
		{
			var st : SoundTransform = _netStream.soundTransform;
			
			st.volume = n;
			
			_netStream.soundTransform = st;
		}
			
		/**
		 * @inheritDoc
		 */
		public override function get bytesLoaded() : int
		{
			return _netStream.bytesLoaded;
		}
		
		/**
		 * @inheritDoc
		 */
		public override function get bytesTotal() : int
		{
			return _netStream.bytesTotal;
		}
		
		/**
		 * @inheritDoc
		 */
		public override function get position() : uint
		{
			return _netStream.time * 1000;
		}
		
		/**
		 * 
		 */
		public function VideoStream ( isStageVideo : Boolean = false , streamClient : IStreamClient = null )
		{
			_isStageVideo = isStageVideo;
			_streamClient = streamClient == null ? new StreamClient() : streamClient;
			_streamClient.addEventListener( StreamClientEvent.META_DATA , _metaData , false , 0 , true );
			
			if( __defaultConnection == null )
			{
				__defaultConnection = new NetConnection();
				__defaultConnection.connect( null );	
			}

			_netConnection = __defaultConnection;
			
			//if( __defaultConnection.uri == "null" )
			//{
				_netStream = new NetStream( __defaultConnection );
				_netStream.client = _streamClient;
				_netStream.addEventListener( NetStatusEvent.NET_STATUS , _status , false , 0 , true );
				_netStream.bufferTime = MediaPlayer.NETSTREAM_BUFFER_TIME / 1000;
				
				var stageVideoScreen : StageVideo = _getStageVideo();
				
				if( isStageVideo && stageVideoScreen != null )
				{
					_screen = new VideoScreen( stageVideoScreen );
					_screen.stageVideoView.attachNetStream( _netStream );
				}
				else
				{
					_screen = new VideoScreen( new Video() );
					_screen.videoView.attachNetStream( _netStream );
					_screen.videoView.smoothing = true;
					_isStageVideo = false;
				}
			//}
		}

		/**
		 * @inheritDoc
		 */
		public override function play( media : StreamMedia ) : void
		{
			super.play( media );
			
			var context : LoaderContext = media.context as LoaderContext;
			
			_netStream.checkPolicyFile = context != null && context.checkPolicyFile;
			_netStream.play( media.request.url );
			_netStream.pause();
			_netStream.seek( 0 );
		}
		
		/**
		 * @inheritDoc
		 */
		public override function resume( ) : void
		{
			if( isPlaying || _media == null ) return;
			
			if( _isComplete ) _netStream.seek( 0 );
			
			_isComplete = false;
			_isPaused = false;
			
			_netStream.resume();
			
			super.resume();
		}
		
		/**
		 * @inheritDoc
		 */
		public override function stop(  ) : void
		{
			if( !isPlaying && _netStream.time == 0 ) return;
			
			_isComplete = false;
			_isPaused = true;
			
			_netStream.pause();
			_netStream.seek( 0 );
			
			super.stop();
		}
		
		/**
		 * @inheritDoc
		 */
		public override function close(  ) : void
		{
			_netStream.close();
			_isPaused = true;
			delete _stageVideoAvailability[ _screen.view ];
			
			super.close();
		}
		
		/**
		 * @inheritDoc
		 */
		public override function pause(  ) : void
		{
			if( !isPlaying ) return;
			
			_isPaused = true;
			_netStream.pause();
			
			super.pause();
		}
		
		/**
		 * @inheritDoc
		 */
		public override function seek( milliSeconds : uint ) : void
		{
			if( _media == null ) return;
			
			super.seek( milliSeconds );
			
			_isComplete = _media.position == _duration;
			
			_netStream.seek( _media.position / 1000 );
		}

		/**
		 * @private
		 */
		public function _metaData( e : StreamClientEvent ) : void
		{
			if( _media.metaData != null ) return;
			
			var duration : uint = 0;
			
			if( e.infos != null && e.infos.duration != undefined )
				duration = e.infos.duration = e.infos.duration * 1000;
			
			_media.metaData = e.infos;
			
			if( _media.duration == 0 ) _media.duration = duration;
			
			_duration = _media.duration;
			
			dispatchEvent( new StreamEvent( StreamEvent.META_DATA , _media ) );
		}
		
		/**
		 * @private
		 */
		protected function _getStageVideo(  ) : StageVideo
		{
			var list : Vector.<StageVideo> = STAGE.stageVideos;
			
			for each( var screen : StageVideo in list ) 
			{
				if( _stageVideoAvailability[ screen ] == undefined )
				{
					_stageVideoAvailability[ screen ] = true;
					return screen;
				}
			}
			
			return null;
		}
		
		/**
		 * @private
		 */
		protected override function _playComplete(  ) : void
		{
			_isPaused = true;
			_netStream.pause();
			_isComplete = true;
			
			super._playComplete();
		}
		
		/**
		 * @private
		 */
		protected function _status( e : NetStatusEvent ) : void
		{
			var code : String = e.info.code;
			
			switch( true )
			{
				case code == "NetStream.Buffer.Empty" && !_sawFlush : _bufferEmpty(); break;					
				case code == "NetStream.Buffer.Flush" : _sawFlush = true; break;	
				
				case code == "NetStream.Play.Stop" && !_isPaused :
					
					_playComplete();
					break;	
				
				case code == "NetStream.Play.StreamNotFound" :
					dispatchEvent( new StreamEvent( StreamEvent.STREAM_NOT_FOUND , _media ) ); break;	
			
				default : break;
			}
		}
	}
}
