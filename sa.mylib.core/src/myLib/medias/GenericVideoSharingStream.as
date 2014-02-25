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
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.net.LocalConnection;
	import flash.net.NetStream;
	import flash.net.URLRequest;
	import flash.system.Capabilities;
	import flash.system.Security;

	/**
	 * @author SamYStudiO ( contact@samystudio.net )
	 */
	internal class GenericVideoSharingStream extends AStream
	{
		/**
		 * @private
		 */
		protected var _playerHandler : Loader = new Loader();

		/**
		 * @private
		 */
		protected var _player : Object;

		/**
		 * @private
		 */
		protected var _playerIsReady : Boolean;

		/**
		 * @private
		 */
		protected var _metaDispatch : Boolean;

		/**
		 * @private
		 */
		protected var _closed : Boolean;
		
		/**
		 * @private
		 */
		protected var _isComplete : Boolean;

		/**
		 * @inheritDoc
		 */
		public override function get handler() : *
		{
			return _player;
		}
		
		/**
		 * @private
		 */
		protected var _screen : VideoScreen = new VideoScreen( new GenericVideoSharingScreen() );

		/**
		 * @inheritDoc
		 */
		public override function get screen() : VideoScreen
		{
			return _screen;
		}

		protected var _volume : Number = 1;

		/**
		 * @inheritDoc
		 */
		public override function get volume() : Number
		{
			return _playerIsReady ? _player.getVolume() : _volume;
		}

		public override function set volume( n : Number ) : void
		{
			_volume = n;

			if ( _playerIsReady )
				_player.setVolume( _volume * 100 );
		}

		/**
		 * @inheritDoc
		 */
		public override function get bytesLoaded() : int
		{
			return _playerIsReady ? _player.getVideoBytesLoaded() : 0;
		}

		/**
		 * @inheritDoc
		 */
		public override function get bytesTotal() : int
		{
			return _playerIsReady ? _player.getVideoBytesTotal() : -1;
		}

		/**
		 * @inheritDoc
		 */
		public override function get duration() : uint
		{
			return _playerIsReady ? _player.getDuration() : 0;
		}

		/**
		 * @inheritDoc
		 */
		public override function get position() : uint
		{
			return _playerIsReady ? _player.getCurrentTime() * 1000 : 0;
		}

		/**
		 * @inheritDoc
		 */
		public override function get isPlaying() : Boolean
		{
			return _playerIsReady ? _player.getPlayerState() == 1 : false;
		}

		/**
		 * 
		 */
		public function GenericVideoSharingStream()
		{
			_playerHandler.contentLoaderInfo.addEventListener( Event.INIT , _playerInit , false , 0 , true );
		}

		/**
		 * @inheritDoc
		 */
		public override function play( media : StreamMedia ) : void
		{
			super.play( media );
			
			if ( Capabilities.playerType != "Desktop" )
			{
				Security.allowDomain( _getDomain( ) );
			}

			_playerHandler.load( new URLRequest( _getPlayer( ) ) );
		}

		/**
		 * @inheritDoc
		 */
		public override function resume() : void
		{
			if ( _playerIsReady )
			{
				if ( _isComplete ) seek( 0 );

				_isComplete = false;
				_player.playVideo();
			}
		}

		/**
		 * @inheritDoc
		 */
		public override function stop() : void
		{
			super.stop();

			if ( _playerIsReady )
			{
				_isComplete = false;
				seek( 0 );
				_player.pauseVideo();
			}
		}

		/**
		 * @inheritDoc
		 */
		public override function close() : void
		{
			super.close( );
			
			_playerHandler.contentLoaderInfo.removeEventListener( Event.INIT , _playerInit );
			_closed = true;
			
			if ( _playerIsReady )
			{
				_player.removeEventListener( "onStateChange" , _playerStateChange );
				_player.stopVideo();
				_player.destroy();
			}
			
			try
			{
				_playerHandler.close();
			}
			catch( e : Error )
			{
				
			}
			
			_playerHandler.unloadAndStop();
		}

		/**
		 * @inheritDoc
		 */
		public override function pause() : void
		{
			if ( _playerIsReady )
				_player.pauseVideo();
		}

		/**
		 * @inheritDoc
		 */
		public override function seek( milliSeconds : uint ) : void
		{
			super.seek( milliSeconds );

			if ( _playerIsReady )
			{
				_isComplete = _media.position == _player.getDuration();
				_player.seekTo( milliSeconds / 1000 , true );
			}
		}

		/**
		 * @inheritDoc
		 */
		public override function timelineSeek( milliSeconds : uint ) : void
		{
			seek( milliSeconds );
		}

		/**
		 * @private
		 */
		protected function _playerInit( e : Event ) : void
		{
			_player = _playerHandler.content;
			_player.addEventListener( "onReady" , _playerReady , false , 0 , true );
			_player.addEventListener( "onError" , _playerError , false , 0 , true );
			_player.addEventListener( "onStateChange" , _playerStateChange , false , 0 , true );
			_player.addEventListener( "onPlaybackQualityChange" , _playerQualityChange , false , 0 , true );
			
			_screen.genericVideoSharingView.screen = _player;
		}

		/**
		 * @private
		 */
		protected function _playerReady( e : Event ) : void
		{
			if( _closed )
			{
				_player.removeEventListener( "onStateChange" , _playerStateChange );
				_player.stopVideo();
				_player.destroy();
			}
			else
			{
				_playerIsReady = true;

				if( _media.request.url.indexOf( "http" ) < 0 ) _player.loadVideoById( _media.request.url , 0 , "highres" );
				else _player.loadVideoByUrl( _media.request.url , 0 , "highres" );
			}
		}

		/**
		 * @private
		 */
		protected function _playerError( e : Event ) : void
		{
			dispatchEvent( new StreamEvent( StreamEvent.STREAM_NOT_FOUND , _media ) );
		}

		/**
		 * @private
		 */
		protected function _playerStateChange( e : Event ) : void
		{
			switch( Object( e ).data )
			{
				case -1 :
					break;
				
				case 0 :
					_isComplete = true;
					_playComplete();
					break;
				
				case 1 :
					if ( _isComplete )
						_player.pauseVideo();
					else
					{
						if( _firstStart )
						{
							_firstStart = false;
							dispatchEvent( new StreamEvent( StreamEvent.PLAY_START , _media ) );
						}
						
						_playingTimer.start( );
						
						dispatchEvent( new StreamEvent( StreamEvent.RESUME , _media ) );
					}
					break;
				
				case 2 :
					_playingTimer.stop( );
			
					dispatchEvent( new StreamEvent( StreamEvent.PAUSE , _media ) );
				
					break;
				
				case 3 :
					_bufferEmpty();
					break;
				
				case 5 :
					dispatchEvent( new StreamEvent( StreamEvent.BUFFER_FULL , _media ) );
					break;
				
				default :
					break;
			}
		}

		/**
		 * @private
		 */
		protected function _playerQualityChange( e : Event ) : void
		{
		}

		/**
		 * @private
		 */
		protected override function _loadProgress( e : TimerEvent ) : void
		{
			var l : int = _media.bytesLoaded = bytesLoaded;
			var t : int = _media.bytesTotal = bytesTotal;

			_isLoaded = l >= t && t > 0;

			if ( !_metaDispatch && _playerIsReady && _player.getDuration() > 0 )
			{
				var o : Object = new Object();
				o.duration = _player.getDuration() * 1000;
				o.width = _player.width;
				o.height = _player.height;

				_media.metaData = o;

				if ( _media.duration == 0 ) _media.duration = o.duration;

				_duration = o.duration;

				_metaDispatch = true;

				dispatchEvent( new StreamEvent( StreamEvent.META_DATA , _media ) );
			}

			if ( !_isBuffered )
			{
				_isBuffered = _playerIsReady && _player.getPlayerState() != 3 && _player.getPlayerState() != -1;

				dispatchEvent( new StreamEvent( StreamEvent.BUFFERING , _media ) );

				if ( _isBuffered )
				{
					dispatchEvent( new StreamEvent( StreamEvent.BUFFER_FULL , _media ) );
				}
			}

			dispatchEvent( new StreamEvent( StreamEvent.LOADING , _media ) );

			if ( _isLoaded )
			{
				if ( _duration > 0 )
				{
					_loaderTimer.stop();

					if ( !_isBuffered )
					{
						_isBuffered = true;
						dispatchEvent( new StreamEvent( StreamEvent.BUFFER_FULL , _media ) );
					}

					dispatchEvent( new StreamEvent( StreamEvent.LOADING_COMPLETE , _media ) );
				}
				else if ( handler is NetStream && new LocalConnection().domain != "localhost" ) throw new Error( this + " WARNING : no metadata found within current media, controls may be unstable" );
			}
		}
		
		/**
		 * @private
		 */
		protected function _getPlayer(  ) : String
		{
			var s : String = VideoSharingPlayerURL.YOUTUBE;
			
			switch( _media.streamType ) 
			{
				case StreamType.YOUTUBE : s = VideoSharingPlayerURL.YOUTUBE; break;
				case StreamType.YOUTUBE_CHROMELESS : s =  VideoSharingPlayerURL.YOUTUBE_CHROMELESS; break;
				case StreamType.DAILYMOTION : s =  VideoSharingPlayerURL.DAILYMOTION; break;
				case StreamType.DAILYMOTIONE_CHROMELESS : s =  VideoSharingPlayerURL.DAILYMOTION_CHROMELESS; break;
			}
			
			if( _media.request.url.indexOf( "http" ) < 0 )
			{
				s = s.replace( "[ID]" , _media.request.url );
			}
			
			return s;
		}
		
		/**
		 * @private
		 */
		protected function _getDomain(  ) : String
		{
			var player : String = _getPlayer();
			
			return player.split( "/" )[ 2 ];
		}
	}
}
