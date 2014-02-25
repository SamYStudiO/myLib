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
	import myLib.utils.ObjectUtils;
	import myLib.utils.Timer;

	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.TimerEvent;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundLoaderContext;
	import flash.media.SoundTransform;
	/**
	 * @private
	 * 
	 * @author SamYStudiO ( contact@samystudio.net )
	 */
	internal class SoundStream extends AStream
	{
		/**
		 * @private
		 */
		protected var _sound : Sound = new Sound( );
		
		/**
		 * @private
		 */
		protected var _soundChannel : SoundChannel;
		
		/**
		 * @private
		 */
		protected var _soundTransform : SoundTransform;
		
		/**
		 * @private
		 */
		protected var _timer : Timer = new Timer();
		
		/**
		 * @private
		 */
		protected var _internalMetaDataTimer : Timer = new Timer( 2000 );
		
		/**
		 * @private
		 */
		protected var _isComplete : Boolean;
		
		/**
		 * @inheritDoc
		 */
		public override function get handler() : *
		{
			return _sound;
		}
		
		/**
		 * @private
		 */
		protected var _volume : Number = 1;
		
		/**
		 *
		 */
		public override function get volume() : Number
		{
			return _soundChannel == null ? _volume : _soundChannel.soundTransform.volume;
		}
		
		public override function set volume( n : Number ) : void
		{
			_volume = n;
			
			if( _soundChannel == null ) return;
			
			var st : SoundTransform = _soundChannel.soundTransform;
			
			st.volume = n;
			
			_soundChannel.soundTransform = st;
		}
		
		/**
		 *
		 */
		public override function get bytesLoaded() : int
		{
			return _sound.bytesLoaded;
		}
		
		/**
		 *
		 */
		public override function get bytesTotal() : int
		{
			return _sound.bytesTotal;
		}
		
		/**
		 *
		 */
		public override function get position() : uint
		{
			return _soundChannel == null ? _media.position : _soundChannel.position;
		}
		
		/**
		 * 
		 */
		public function SoundStream (  )
		{
			_sound.addEventListener( Event.COMPLETE , _loadingComplete , false , 0 , true );			_sound.addEventListener( Event.ID3 , _id3 , false , 0 , true );
			_sound.addEventListener( IOErrorEvent.IO_ERROR , _streamError , false , 0 , true );
			
			_timer.addEventListener( TimerEvent.TIMER , _checkBuffer , false , 0 , true );			_internalMetaDataTimer.addEventListener( TimerEvent.TIMER , _internalMeta , false , 0 , true );
		}
		
		/**
		 *
		 */
		public override function play( media : StreamMedia ) : void
		{
			_sound.load( media.request , media.context as SoundLoaderContext );
			
			_timer.start();

			_internalMetaDataTimer.start();
			
			super.play( media );
		}
		
		/**
		 * 
		 */
		public override function resume ( ) : void
		{
			if( isPlaying ) return;
			
			_soundChannel = _buildSoundChannel( _isComplete ? 0 : position );
		
			_isComplete = false;
		
			super.resume();
		}
		
		/**
		 *
		 */
		public override function pause( ) : void
		{
			if( !isPlaying ) return;
			
			_media.position = _soundChannel.position;
			
			_clearSoundChannel();
			
			super.pause();
		}
		
		/**
		 *
		 */
		public override function seek( milliSeconds : uint ) : void
		{
			var n : uint = Math.min( milliSeconds , _duration );
			
			_soundChannel = _buildSoundChannel( n , 0 , _soundTransform );
			
			_media.position = _soundChannel.position;
			_isComplete = _media.position == _duration;
			
			_clearSoundChannel();
		}
		
		/**
		 *
		 */
		public override function stop( ) : void
		{
			if( !isPlaying && position == 0 ) return;
			
			_isComplete = false;
			
			if( _soundChannel != null )
			{
				_soundTransform = _soundChannel.soundTransform;
				_soundChannel.stop( );
				_soundChannel.removeEventListener( Event.SOUND_COMPLETE , _complete );
				_soundChannel = null;
			}
			
			super.stop();
		}
		
		/**
		 *
		 */
		public override function close(  ) : void
		{
			_clearSoundChannel();
			
			try
			{
				_sound.close();
			}
			catch( e : Error ) {}
			
			
			_internalMetaDataTimer.stop();
			
			super.close();
		}
		
		/**
		 * @private
		 */
		protected function _clearSoundChannel(  ) : void
		{
			if( _soundChannel != null )
			{
				_soundTransform = _soundChannel.soundTransform;
				_soundChannel.stop( );
				_soundChannel.removeEventListener( Event.SOUND_COMPLETE , _complete );
				_soundChannel = null;
			}
		}
		
		/**
		 * @private
		 */
		protected function _buildSoundChannel( startTime : Number = 0 , loop : int = 0 , soundTransform : SoundTransform = null ) : SoundChannel
		{
			_clearSoundChannel();
			
			var sc : SoundChannel = _sound.play( startTime , loop , soundTransform );
			
			sc.addEventListener( Event.SOUND_COMPLETE , _complete , false , 0 , true );
			
			var st : SoundTransform = sc.soundTransform;
			
			st.volume = _volume;
			
			sc.soundTransform = st;
			
			return sc;
		}
		
		/**
		 * @private
		 */
		protected function _id3( e : Event ) : void
		{
			var o : Object = new Object();
			
			_media.metaData = ObjectUtils.merge( _sound.id3 , o , false );
			
			o.duration = _sound.id3 != null && !isNaN( Number( _sound.id3.TLEN ) ) ? Number( _sound.id3.TLEN ) : 0;
			
			if( _media.duration == 0 ) _media.duration = o.duration;
			
			_duration = _media.duration;
			
			if( _duration > 0 )
			{
				_internalMetaDataTimer.stop();
				
				dispatchEvent( new StreamEvent( StreamEvent.META_DATA , _media ) );
			}
		}
		
		/**
		 * @private
		 */
		protected function _internalMeta( e : TimerEvent ) : void
		{
			if( _sound.length > 0 && _sound.bytesTotal > 0 && _sound.bytesLoaded > 0 )
			{
				_media.metaData = new Object();
				
				_media.metaData.duration = _sound.length * _sound.bytesTotal / _sound.bytesLoaded;				
				if( _media.duration == 0 ) _media.duration = _media.metaData.duration;
				
				_duration = _media.duration;
				
				_internalMetaDataTimer.stop();
				
				_sound.removeEventListener( Event.ID3 , _id3 );
				
				dispatchEvent( new StreamEvent( StreamEvent.META_DATA , _media ) );
			}
		}
		
		/**
		 * @private
		 */
		protected function _loadingComplete( e : Event ) : void
		{
			_timer.stop();
		}
		
		/**
		 * @private
		 */
		protected function _complete( e : Event ) : void
		{
			_clearSoundChannel();
			
			_isComplete = true;
			
			_media.position = _media.duration;
			
			_playingTimer.stop( );
			
			dispatchEvent( new StreamEvent( StreamEvent.PLAY_COMPLETE , _media ) );
		}
		
		/**
		 *
		 */
		protected function _checkBuffer( e : Event ) : void
		{
			if( _soundChannel != null && _soundChannel.position + 1000 > _sound.length
					&& _soundChannel.position < _sound.length - 1000 &&_sound.length > 0 )
							dispatchEvent( new StreamEvent( StreamEvent.BUFFER_EMPTY , _media ) );
		}
		
		/**
		 *
		 */
		protected function _streamError ( e : IOErrorEvent ) : void
		{
			dispatchEvent( new StreamEvent( StreamEvent.STREAM_NOT_FOUND , _media ) );
		}
	}
}
