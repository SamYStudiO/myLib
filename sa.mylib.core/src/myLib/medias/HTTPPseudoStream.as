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
	import flash.events.NetStatusEvent;
	import flash.events.TimerEvent;
	import flash.system.LoaderContext;
	/**
	 * @author SamYStudiO ( contact@samystudio.net )
	 */
	internal class HTTPPseudoStream extends VideoStream
	{
		/**
		 * @private
		 */
		protected var _sawSeek : Boolean;
		
		/**
		 * @private
		 */
		protected var _sawTimelineSeek : Boolean;
		
		/**
		 * @private
		 */
		protected var _oldTime : uint;
		
		/**
		 * @private
		 */
		protected var _currentStartPosition : uint;
		
		/**
		 * @private
		 */
		protected var _time : uint;
		
		/**
		 * @inheritDoc
		 */
		public override function get position() : uint
		{
			return _sawSeek && _oldTime == uint( _netStream.time * 1000 ) ? _time : _netStream.time * 1000;
		}
		
		/**
		 * 
		 */
		public function HTTPPseudoStream ( streamClient : IStreamClient = null )
		{
			super( false , streamClient );
		}
		
		/**
		 * @inheritDoc
		 */
		public override function play( media : StreamMedia ) : void
		{
			_media = media;
			_duration = media.duration;
			_loaderTimer.start();
			
			var context : LoaderContext = media.context as LoaderContext;
			
			_netStream.checkPolicyFile = context != null && context.checkPolicyFile;
			_netStream.play( _fixURL( _media.request.url ) );
			_netStream.pause();
			_netStream.seek( 0 );
		}
		
		/**
		 * @inheritDoc
		 */
		public override function resume( ) : void
		{
			if( isPlaying || _media == null ) return;
			
			if( _isComplete )
			{
				seek( 0 );
			
				_isComplete = false;
			}
			else
			{
				_netStream.resume();
				
				_playingTimer.start( );
				
				if( _firstStart )
				{
					_firstStart = false;
					dispatchEvent( new StreamEvent( StreamEvent.PLAY_START , _media ) );
				}
				
				dispatchEvent( new StreamEvent( StreamEvent.RESUME , _media ) );
			}
		}
		
		/**
		 * @inheritDoc
		 */
		public override function stop(  ) : void
		{
			if( !isPlaying && _netStream.time == 0 ) return;
			
			_isComplete = false;
			
			if( _currentStartPosition != 0 )
			{
				seek( 0 );
				_netStream.pause();
			}
			else
			{
				_netStream.pause();
				_netStream.seek( 0 );
			}
			
			super.stop();
		}
		
		/**
		 * @inheritDoc
		 */
		public override function seek( milliSeconds : uint ) : void
		{
			_seek( milliSeconds );
		}
		
		/**
		 * @inheritDoc
		 */
		public override function timelineSeek( milliSeconds : uint ) : void
		{
			_seek( milliSeconds , true );
		}
		
		/**
		 * @inheritDoc
		 */
		public override function _metaData( e : StreamClientEvent ) : void
		{
			super._metaData( e );
			
			// TODO can be achieved with no keyframe?
			//if( _media.metaData.keyframes == undefined || _media.metaData.keyframes.times == undefined || _media.metaData.keyframes.times.length == 0 )
				//throw new Error( this + " No keyframes object found within metadata, could not read file using HTTPStream" );
		}
		
		/**
		 * @private
		 */
		protected function _seek( milliSeconds : uint , timeline : Boolean = false ) : void
		{
			if( _media == null ) return;
			
			var n : uint = Math.min( milliSeconds , _duration );
			
			_oldTime = uint( _netStream.time * 1000 );
			
			_media.position = _time = Number( _getTimeFromMeta( n ) ) * 1000;
			
			if( timeline ) _sawTimelineSeek = true;
			else _sawSeek = true;
			
			_isComplete = n == _duration;
			
			if( n < _currentStartPosition && !timeline )
			{
				_netStream.play( _fixURL( _media.request.url ) );
				_netStream.pause();
				
				
				_loaderTimer.start();
				
				_bufferEmpty();
			}
			else
			{
				_netStream.seek( _time / 1000 );
			}
		}
		
		/**
		 * @private
		 */
		protected override function _status( e : NetStatusEvent ) : void
		{
			var code : String = e.info.code;
			
			switch( true )
			{
				case code == "NetStream.Buffer.Empty" && !_isComplete : 
					
					if( _sawSeek )
					{
						_netStream.play( _fixURL( _media.request.url ) );
						_netStream.pause();
					}
					
					_loaderTimer.start();
					_bufferEmpty();
					
					break;	
				
				case code == "NetStream.Play.Stop" && isPlaying && _isLoaded :
					
					if( !_isComplete )
					{ 
						_isComplete = true;
						_playComplete(); 
					}
					
					break;	
				
				case code == "NetStream.Play.StreamNotFound" :
					dispatchEvent( new StreamEvent( StreamEvent.STREAM_NOT_FOUND , _media ) ); break;	
			
				case code == "NetStream.Seek.InvalidTime" : 
				
				if( _sawSeek )
				{
					_netStream.play( _fixURL( _media.request.url ) );
					_netStream.pause();
					_loaderTimer.start();
					_bufferEmpty();
				}
			
				default : break;
			}
		}
		
		/**
		 * @private
		 */
		protected override function _playProgress( e : TimerEvent ) : void 
		{
			if( _oldTime != uint( _netStream.time * 1000 ) )
			{
				_sawSeek = false;
				_sawTimelineSeek = false;
			}
			
			super._playProgress( e );
		}
		
		/**
		 * @private
		 */
		protected function _fixURL( url : String ) : String
		{
			var r : RegExp = /\[[0-9a-zA-Z_.]+\]/g;
			var s : String = url;
			var pattern : * = r.exec( url );
			
			while( pattern != null ) 
			{
				var pa : Array = pattern[ 0 ].toString().split( "" );
				pa.pop();
				pa.shift();
				
				var p : String = pa.join( "" );
				var v : String;
				
				if( p == "keyframes.filepositions" )
				{
					try
					{
						v = _getFilePositionFromMeta( _media.position );
						
						_currentStartPosition = uint( _getTimeFromMeta( _media.position ) ) * 1000;
					}
					catch( e : Error ) { throw new Error( this + " invalid metadata from keyframes.filepositions array, check video metadata" ); }
				}
				else if( p == "keyframes.times" )
				{
					try
					{
						v = _getTimeFromMeta( _media.position );
						
						_currentStartPosition = uint( v ) * 1000;
					}
					catch( e : Error ) { throw new Error( this + " invalid metadata from keyframes.times array, check video metadata" ); }
				}
				else
				{
					try
					{
						v = _media[ p ].toString();
						
						if( p == "position" ) _currentStartPosition = _media.position;
					}
					catch( e : Error ) { v = ""; }
				}
				
				s = s.split( "[" + p + "]" ).join( v );
				
				pattern = r.exec( url );
			}
			
			return s;
		}
		
		/**
		 * @private
		 */
		protected function _getTimeFromMeta( position : uint ) : String
		{
			if( position == 0 ) return "0";
			
			if( _media.metaData == null || _media.metaData.keyframes == undefined ) return ( position / 1000 ).toString();
					
			var aTimes : Array = _media.metaData.keyframes.times;
			var pos : Number = position / 1000;
			
			var i : int = -1;
			var l : uint = aTimes.length;
			
			while( ++i < l ) 
			{
				if( ( aTimes[ i ] <= pos ) && ( i == l - 1 || aTimes[ i + 1 ] >= pos  ) )
				{
					return aTimes[ i ].toString();
				}
			}
			
			return null;
		}
		
		/**
		 * @private
		 */
		protected function _getFilePositionFromMeta( position : uint ) : String
		{
			if( position == 0 ) return "0";
			
			var aTimes : Array = _media.metaData.keyframes.times;
			var aPositions : Array = _media.metaData.keyframes.filepositions;
			var pos : Number = position / 1000;
			
			var i : int = -1;
			var l : uint = aTimes.length;
			
			while( ++i < l ) 
			{
				if( ( aTimes[ i ] <= pos ) && ( i == l - 1 || aTimes[ i + 1 ] >= pos  ) )
				{
					return aPositions[ i ].toString();
				}
			}
			
			return null;
		}
	}
}
