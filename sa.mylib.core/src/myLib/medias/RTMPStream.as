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
	import flash.events.NetStatusEvent;
	import flash.events.TimerEvent;
	import flash.media.StageVideo;
	import flash.media.Video;
	import flash.net.NetConnection;
	import flash.net.NetStream;
	import flash.system.LoaderContext;
	/**
	 * @private
	 * @author SamYStudiO ( contact@samystudio.net )
	 */
	internal class RTMPStream extends VideoStream
	{
		/**
		 * @private
		 */
		protected var _sawStop : Boolean;
		
		/**
		 * @private
		 */
		protected var _sawSeek : Boolean;
		
		/**
		 * @private
		 */
		protected var _sawFull : Boolean;
		
		/**
		 * @private
		 */
		protected var _doResumeSeek : Boolean;
		
		/**
		 * @private
		 */
		protected var _doAfterStart : String;
		
		/**
		 * @private
		 */
		protected var _fileSize : uint;
		
		/**
		 * @private
		 */
		protected var _calcBuffer : Boolean = true;
		
		/**
		 * @private
		 */
		protected var _volume : Number;

		/**
		 * @inheritDoc
		 */
		public override function get volume() : Number
		{
			return !_netConnection.connected ? _volume : _netStream.soundTransform.volume;
		}
		
		public override function set volume( n : Number ) : void
		{
			if( !_netConnection.connected )
			{
				_volume = n;
				
				return;
			}
			
			super.volume = _volume = n;
		}
			
		/**
		 * @inheritDoc
		 */
		public override function get bytesLoaded() : int
		{
			return !_netConnection.connected ? 0 : _netStream.bufferLength * 1000;
		}
		
		/**
		 * @inheritDoc
		 */
		public override function get bytesTotal() : int
		{
			return !_netConnection.connected ? 0 : _netStream.bufferTime * 1000;
		}
		
		/**
		 * @inheritDoc
		 */
		public override function get position() : uint
		{
			return !_netConnection.connected ? 0 : _netStream.time * 1000;
		}
		
		/**
		 * 
		 */
		public function RTMPStream ( stageVideo : Boolean , streamClient : IStreamClient = null )
		{
			super( stageVideo , streamClient );
		}

		/**
		 * @inheritDoc
		 */
		public override function play( media : StreamMedia ) : void
		{
			_media = media;
			
			var client : ConnectionClient = new ConnectionClient();
			client.addEventListener( ConnectionEvent.BANDWIDTH_DEFINED , _bandwidthDefined , false , 0 , true );
			
			_netConnection = new NetConnection();
			_netConnection.connect( _getRTMP( _media.request.url ) );
			_netConnection.addEventListener( NetStatusEvent.NET_STATUS , _connectionStatus , false , 0 , true );
			_netConnection.client = client;
			
			_loaderTimer.start();
		}
		
		/**
		 * @inheritDoc
		 */
		public override function resume( ) : void
		{
			if( !_netConnection.connected || isPlaying || _media == null ) return;
			
			if( _sawSeek )
			{
				_doResumeSeek = true;
				return;
			}
			
			if( _isComplete )
			{
				_netStream.seek( 0 );
				_media.position = 0;
			}
			
			if( _isPaused ) _netStream.resume();
				
			_isComplete = false;
			_isPaused = false;
			
			_playingTimer.start( );
			
			dispatchEvent( new StreamEvent( StreamEvent.RESUME , _media ) );
		}
		
		/**
		 * @inheritDoc
		 */
		public override function stop(  ) : void
		{
			if( !_netConnection.connected || ( !isPlaying && _netStream.time == 0 ) ) return;
			
			_isComplete = false;
			
			_netStream.pause();
			_netStream.seek( 0 );
			
			_media.position = 0;
			
			_playingTimer.stop( );
			_isPaused = true;
			_doResumeSeek = false;
			
			dispatchEvent( new StreamEvent( StreamEvent.STOP , _media ) );
		}
		
		/**
		 * @inheritDoc
		 */
		public override function close(  ) : void
		{
			_netConnection.close();
			_netConnection.removeEventListener( NetStatusEvent.NET_STATUS , _connectionStatus );
			
			if( _netStream != null )
			{
				_netStream.close();
				_netStream.removeEventListener( NetStatusEvent.NET_STATUS , _status );
			}
			
			_loaderTimer.stop( );
			_playingTimer.stop( );
			
			dispatchEvent( new StreamEvent( StreamEvent.CLOSE , _media ) );
			
			_netStream = null;
		}
		
		/**
		 * @inheritDoc
		 */
		public override function pause(  ) : void
		{
			if( !_netConnection.connected || _isPaused ) return;
			
			_netStream.pause();
			_isPaused = true;
			_doResumeSeek = false;
			
			_playingTimer.stop( );
			
			dispatchEvent( new StreamEvent( StreamEvent.PAUSE , _media ) );
		}
		
		/**
		 * @inheritDoc
		 */
		public override function seek( milliSeconds : uint ) : void
		{
			if( !_netConnection.connected ) return;
			
			var n : uint = Math.min( milliSeconds , _duration );
			
			_media.position = n;
			
			_isComplete = milliSeconds == _duration;

			_netStream.seek( milliSeconds / 1000 );
			
			_sawStop = false;
			_sawSeek = true;
			_doResumeSeek = false;
		}
		
		/**
		 * @inheritDoc
		 */
		public override function _metaData( e : StreamClientEvent ) : void
		{
			if( _media.metaData != null ) return;
			
			super._metaData( e );
			
			_fileSize = uint( e.infos.filesize );
			
			_netStream.pause();
		}
		
		/**
		 *
		 */
		private function _initStream(  ) : void
		{
			_netStream = new NetStream( _netConnection );
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
		}
		
		/**
		 *
		 */
		private function _connectionStatus ( e : NetStatusEvent ) : void
		{
			switch( e.info.code )
			{
				case "NetConnection.Connect.Success" : 
				
					_initStream();
					
					_netConnection.call( "checkBandwidth" , null );
					
					break;
			}
		}
		
		/**
		 *
		 */
		protected override function _status( e : NetStatusEvent ) : void
		{
			var code : String = e.info.code;
			
			switch( true )
			{
				case code == "NetStream.Seek.Notify" : 
				
					_sawSeek = false;
					
					if( _doResumeSeek ) resume();
					
					_doResumeSeek = false;
				
					break;
				
				case code == "NetStream.Play.Start" : 
					
					_sawStop = false;
					
					if( !_isBuffered && _duration > 0 ) _netStream.pause();
					
					break;
				
				case code == "NetStream.Buffer.Full" : 
					
					_sawStop = false;					_sawFull = true;
					
					break;
				
				case code == "NetStream.Buffer.Empty" :
					
					if( _netStream.bufferLength > 1 ) break;
					
					if( _sawStop )
					{
						_isComplete = true;
						_playComplete();
					}
					else
					{
						_bufferEmpty();
					}
					
					_sawStop = false;
					_sawFull = false;
					
					break;
				
				case code == "NetStream.Play.Stop" && isPlaying :
				
					_sawStop = true;
					
					break;	
				
				case code == "NetStream.Play.StreamNotFound" :
					dispatchEvent( new StreamEvent( StreamEvent.STREAM_NOT_FOUND , _media ) ); break;	
			
				default : break;
			}
		}
		
		/**
		 * @private
		 */
		protected override function _loadProgress( e : TimerEvent ) : void
		{
			_isLoaded = _isBuffered = _sawFull ;
			
			if( !_isBuffered )
			{
				if( _duration > 0 && _bandwidth > 0 )
				{
					var durationAsSecond : Number = _duration / 1000;
					var read : Number = _netStream.time / durationAsSecond;
					var sizeToLoad : uint = _fileSize * ( 1 - read );
					
					if( sizeToLoad > 0 )
					{
						if( _calcBuffer )
						{
							var totalDownloadTime : uint = sizeToLoad / _bandwidth * 1000;
							var timeLeft : Number = durationAsSecond - _netStream.time;
							var bt : int = _media.bufferBytesTotal = _media.bytesTotal = ( ( totalDownloadTime / 1000 ) - timeLeft ) * _bandwidth;
							
							_netStream.bufferTime = bt / sizeToLoad * timeLeft;
							
							_calcBuffer = false;
						}
						
						_media.bufferBytesLoaded = _media.bytesLoaded = _netStream.bufferLength / _netStream.bufferTime * _media.bufferBytesTotal;
						
						_media.bufferTimeLeft =
						_media.loadTimeLeft = ( _netStream.bufferTime - _netStream.bufferLength ) * 1000;
					}
					
					if( _media.bufferBytesTotal <= 0 ) _isBuffered = true;
				}
				
				dispatchEvent( new StreamEvent( StreamEvent.BUFFERING , _media ) );
			}
			
			dispatchEvent( new StreamEvent( StreamEvent.LOADING , _media ) );
			
			if( _isBuffered )
			{
				_media.bufferTimeLeft = _media.loadTimeLeft = 0;
				_media.bytesLoaded = _media.bufferBytesLoaded = _media.bufferBytesTotal;
				
				_sawFull = false;
				_loaderTimer.stop();
				
				dispatchEvent( new StreamEvent( StreamEvent.BUFFER_FULL , _media ) );	
				dispatchEvent( new StreamEvent( StreamEvent.LOADING_COMPLETE , _media ) );
			}
		}
		
		/**
		 * @private
		 */
		protected override function _bufferEmpty(  ) : void
		{
			_isBuffered = false; 
			_bufferStartTimer = 0;
			_calcBuffer = true;
			
			_playingTimer.stop( );
			_loaderTimer.start();
			
			dispatchEvent( new StreamEvent( StreamEvent.BUFFER_EMPTY , _media ) );
		}
		
		/**
		 * @private
		 */
		protected function _bandwidthDefined ( e : ConnectionEvent ) : void
		{
			_bandwidth = e.bandwidth;
			
			var context : LoaderContext = _media.context as LoaderContext;
			
			_netStream.checkPolicyFile = context != null && context.checkPolicyFile;
			_netStream.play( _getFile( _media.request.url ) );
		}
		
		/**
		 * @private
		 */
		protected function _getRTMP( url : String ) : String
		{
			var a : Array = url.split( "/" );
			
			a = a.slice( 0 , 4 );
			
			return a.join( "/" ) + "/";
		}
		
		/**
		 * @private
		 */
		protected function _getFile( url : String ) : String
		{
			return url.split( _getRTMP( url ) ).join( "" );
		}
	}
}
