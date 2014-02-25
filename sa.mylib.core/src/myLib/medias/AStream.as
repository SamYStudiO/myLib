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
	import myLib.utils.Timer;

	import flash.events.EventDispatcher;
	import flash.events.TimerEvent;
	import flash.utils.getTimer;
	/**
	 * @private
	 * 
	 * @author SamYStudiO ( contact@samystudio.net )
	 */
	internal class AStream extends EventDispatcher implements IStream 
	{
		/**
		 * @private
		 */
		protected var _media : StreamMedia;
		
		/**
		 * @private
		 */
		protected var _bandwidth : uint;
		
		/**
		 * @private
		 */
		protected var _bufferStartTimer : int;
		
		/**
		 * @private
		 */
		protected var _bufferStartBytesLoaded : int;
		
		/**
		 * @private
		 */
		protected var _isLoaded : Boolean;
		
		/**
		 * @private
		 */
		protected var _isBuffered : Boolean;
		
		/**
		 * @private
		 */
		protected var _firstStart : Boolean = true;
		
		/**
		 * @private
		 */
		protected var _loaderTimer : Timer = new Timer();
		
		/**
		 * @private
		 */
		protected var _playingTimer : Timer = new Timer();
		
		/**
		 * @inheritDoc
		 */
		public function get media () : StreamMedia
		{
			return _media;
		}
		
		/**
		 * @inheritDoc
		 */
		public function get handler () : *
		{
			return null;
		}
		
		/**
		 * @inheritDoc
		 */
		public function get screen () : VideoScreen
		{
			return null;
		}
		
		/**
		 * @inheritDoc
		 */
		public function get volume () : Number
		{
			return 0;
		}
			
		public function set volume ( n : Number ) : void
		{
		}
		
		/**
		 * 
		 */
		public function get bytesLoaded () : int
		{
			return 0;
		}
		
		/**
		 * 
		 */
		public function get bytesTotal () : int
		{
			return 0;
		}
		
		/**
		 * 
		 */
		public function get position () : uint
		{
			return 0;
		}
		
		/**
		 * @private
		 */
		protected var _duration : uint;
		
		/**
		 * 
		 */
		public function get duration () : uint
		{
			return _duration;
		}
		
		/**
		 * @inheritDoc
		 */
		public function get isPlaying() : Boolean
		{
			return _playingTimer.running;
		}
		
		/**
		 * 
		 */
		public function AStream (  )
		{
			_loaderTimer.addEventListener( TimerEvent.TIMER , _loadProgress  , false , 0 , true );
			_playingTimer.addEventListener( TimerEvent.TIMER , _playProgress  , false , 0 , true );
		}
		
		/**
		 * @inheritDoc
		 */
		public function play ( media : StreamMedia ) : void
		{
			_media = media;
			_duration = media.duration;
			
			_loaderTimer.start();
		}
		
		/**
		 * @inheritDoc
		 */
		public function resume () : void
		{
			_playingTimer.start( );
			
			if( _firstStart )
			{
				_firstStart = false;
				dispatchEvent( new StreamEvent( StreamEvent.PLAY_START , _media ) );
			}
			
			dispatchEvent( new StreamEvent( StreamEvent.RESUME , _media ) );
		}
		
		/**
		 * @inheritDoc
		 */
		public function pause () : void
		{
			_playingTimer.stop( );
			
			dispatchEvent( new StreamEvent( StreamEvent.PAUSE , _media ) );
		}
		
		/**
		 * @inheritDoc
		 */
		public function seek ( milliSeconds : uint ) : void
		{
			var n : uint = Math.min( milliSeconds , _duration );
			
			_media.position = n;
		}
		
		/**
		 * @inheritDoc
		 */
		public function timelineSeek ( milliSeconds : uint ) : void
		{
			seek( milliSeconds );
		}
		
		/**
		 * @inheritDoc
		 */
		public function stop () : void
		{
			_playingTimer.stop( );
			_media.position = 0;
			
			dispatchEvent( new StreamEvent( StreamEvent.STOP , _media ) );
		}

		/**
		 * @inheritDoc
		 */
		public function close () : void
		{
			_loaderTimer.stop( );
			_playingTimer.stop( );
			
			_media.reset();
			
			dispatchEvent( new StreamEvent( StreamEvent.CLOSE , _media ) );
		}
		
		/**
		 * @private
		 */
		protected function _loadProgress( e : TimerEvent ) : void
		{
			var l : int = _media.bytesLoaded = bytesLoaded;
			var t : int = _media.bytesTotal = bytesTotal;
			
			_isLoaded = l >= t && t > 0;
			
			if( !_isBuffered )
			{
				if( _bandwidth == 0 ) _detectBandwidth();
				else if( _duration > 0 )
				{
					var duration : uint = ( _duration - position ) / 1000;
					var totalDownloadTime : uint = ( t - _bufferStartBytesLoaded ) / _bandwidth;
	
					var bt : int = _media.bufferBytesTotal = totalDownloadTime <= duration ? -1 : ( totalDownloadTime - duration ) * _bandwidth;
					var bl : int = _media.bufferBytesLoaded = totalDownloadTime <= duration ? 0 : Math.min( l - _bufferStartBytesLoaded , bt );
					
					_media.bufferTimeLeft = totalDownloadTime <= duration ? 0 : ( bt - bl ) / _bandwidth * 1000;
					_media.loadTimeLeft = ( t - l ) / _bandwidth * 1000;
					
					_isBuffered = bl >= bt || l >= t;
				}
				
				dispatchEvent( new StreamEvent( StreamEvent.BUFFERING , _media ) );
				
				if( _isBuffered ) dispatchEvent( new StreamEvent( StreamEvent.BUFFER_FULL , _media ) );	
			}
			
			dispatchEvent( new StreamEvent( StreamEvent.LOADING , _media ) );
			
			if( _isLoaded )
			{
				if( _duration > 0 )
				{
					_loaderTimer.stop();
					
					// if download is too fast ( often local network ) check if buffer is ok
					if( !_isBuffered )
					{
						_isBuffered = true;
						dispatchEvent( new StreamEvent( StreamEvent.BUFFER_FULL , _media ) );	
					}
					
					dispatchEvent( new StreamEvent( StreamEvent.LOADING_COMPLETE , _media ) );
				}
				//else if( handler is NetStream && new LocalConnection().domain != "localhost" ) throw new Error( this + " WARNING : no metadata found within current media, controlls may be unstable" );
			}
		}
		
		/**
		 * @private
		 */
		protected function _playProgress( e : TimerEvent ) : void 
		{
			_media.position = position;
			
			dispatchEvent( new StreamEvent( StreamEvent.PLAY_PROGRESS , _media ) );
		}
		
		/**
		 * @private
		 */
		protected function _detectBandwidth(  ) : void
		{
			var l : int = bytesLoaded;
			var t : int = bytesTotal;
			
			if( t > 0 && _bufferStartTimer == 0 )
			{
				_bufferStartTimer = getTimer();
				_bufferStartBytesLoaded = l;
			}
			
			var d : uint = ( getTimer() - _bufferStartTimer );
			
			if( d > MediaPlayer.BANDWIDTH_DETECTION_DURATION && t > 0 )
			{
				_bandwidth = uint( ( l - _bufferStartBytesLoaded ) / ( d / 1000 ) * MediaPlayer.BANDWIDTH_MARGIN );
			}
		}
		
		/**
		 * @private
		 */
		protected function _bufferEmpty(  ) : void
		{
			if( _isLoaded ) return;
			
			_isBuffered = false; 
			_bandwidth = 0;
			_bufferStartTimer = 0;
			
			_playingTimer.stop( );
			
			dispatchEvent( new StreamEvent( StreamEvent.BUFFER_EMPTY , _media ) );
		}
		
		/**
		 * @private
		 */
		protected function _playComplete(  ) : void
		{
			_media.position = _media.duration;
			
			_playingTimer.stop( );
			
			dispatchEvent( new StreamEvent( StreamEvent.PLAY_COMPLETE , _media ) );
		}
	}
}
