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
	import myLib.controls.ISlider;
	import myLib.utils.TimeFormatter;

	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.StageDisplayState;
	import flash.events.Event;
	import flash.events.FullScreenEvent;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	/**
	 * SimpleMediaController is a simple way to add controls to your MediaPlayer. SimpleMediaController does not act as a component, so it can be easily customized and layout.
	 * When MediaPlayer is added to authoring tool scene a copy of SimpleMediaController is added in library. You have to drag and drop it manually from library
	 * if you need it. All control assets are optional so you can remove any of these assets.
	 * Inherit SimpleMediaController if you need more complexe assets and keep assets instance names.
	 * 
	 * @see MediaPlayer#controller
	 * 
	 * @author SamYStudiO ( contact@samystudio.net )
	 */
	public dynamic class SimpleMediaController extends MovieClip implements IMediaController 
	{
		/**
		 * @private
		 */
		protected var _oldVolume : Number;
		
		/**
		 * @private
		 */
		protected var _isMute : Boolean;
		
		/**
		 * @private
		 */
		protected var _wasPlaying : Boolean;
		
		/**
		 * @private
		 */
		protected var _noTimelineDispatch : Boolean;
		
		/**
		 * Get or set the time format used with time elapsed and duration TextField assets.
		 * 
		 * @see myLib.utils.TimeFormatter
		 */
		public static var TIME_FORMAT : String = "mm:SS";
		
		/**
		 * The MovieClip used to call MediaPlayer.play method.
		 * If the MovieClip used to call MediaPlayer.pause method is null, this MovieClip act as a play/pause button.
		 */
		public var playAsset : MovieClip;
		
		/**
		 * The MovieClip used to call MediaPlayer.pause method.
		 * If this MovieClip is null, The MovieClip used to call MediaPlayer.play method act as a play/pause button.
		 */
		public var pauseAsset : MovieClip;
		
		/**
		 * The MovieClip used to call MediaPlayer.stop method.
		 */
		public var stopAsset : MovieClip;
		
		/**
		 * The MovieClip used to call MediaPlayer.next method.
		 */
		public var nextAsset : MovieClip;
		
		/**
		 * The MovieClip used to call MediaPlayer.previous method.
		 */
		public var previousAsset : MovieClip;
		
		/**
		 * The MovieClip used to switch volume on/off.
		 */
		public var muteAsset : MovieClip;
		
		/**
		 * The MovieClip used to map MediaPlayer.repeat property.
		 */
		public var repeatAsset : MovieClip;
		
		/**
		 * The MovieClip used to map MediaPlayer.loop property.
		 */
		public var loopAsset : MovieClip;
		
		/**
		 * The MovieClip used to map MediaPlayer.random property.
		 */
		public var randomAsset : MovieClip;
		
		/**
		 * The MovieClip used to switch fullscreen mode.
		 */
		public var fullscreenAsset : MovieClip;
		
		/**
		 * The MovieClip used to show media loading progression.
		 */
		public var loaderBarAsset : MovieClip;
		
		/**
		 * The Slider used to show media progression.
		 */
		public var timelineAsset : ISlider;
		
		/**
		 * The Slider used to adjust MediaPLayer volume.
		 */
		public var volumeAsset : ISlider;
		
		/**
		 * The TextField used to display time elapsed.
		 */
		public var timeElapsedAsset : TextField;
		
		/**
		 * The TextField used to display time left.
		 */
		public var timeLeftAsset : TextField;
		
		/**
		 * The TextField used to display media duration.
		 */
		public var durationAsset : TextField;
		
		/**
		 * The TextField used to display media name.
		 */
		public var trackNameAsset : TextField;
		
		/**
		 * @private
		 */
		protected var _mediaPlayer : IMediaPlayer;

		/**
		 * @inheritDoc
		 */
		public function get mediaPlayer () : IMediaPlayer
		{
			return _mediaPlayer;
		}
		
		public function set mediaPlayer ( player : IMediaPlayer ) : void
		{
			if( _mediaPlayer != null )
			{
				_mediaPlayer.removeEventListener( StreamEvent.BUFFERING , _buffering );
				_mediaPlayer.removeEventListener( StreamEvent.LOADING , _loading );
				_mediaPlayer.removeEventListener( StreamEvent.PLAY_PROGRESS , _playing );
				_mediaPlayer.removeEventListener( StreamEvent.PLAY , _status );
				_mediaPlayer.removeEventListener( StreamEvent.RESUME , _status );
				_mediaPlayer.removeEventListener( StreamEvent.PAUSE , _status );
				_mediaPlayer.removeEventListener( StreamEvent.STOP , _status );
				_mediaPlayer.removeEventListener( StreamEvent.PLAY_COMPLETE , _status );				_mediaPlayer.removeEventListener( StreamEvent.META_DATA , _status );				_mediaPlayer.removeEventListener( StreamEvent.CLOSE , _status );
			}
			
			_mediaPlayer = player;
		
			_mediaPlayer.addEventListener( StreamEvent.BUFFERING , _buffering , false , 0 , true );
			_mediaPlayer.addEventListener( StreamEvent.LOADING , _loading , false , 0 , true );
			_mediaPlayer.addEventListener( StreamEvent.PLAY_PROGRESS , _playing , false , 0 , true );
			_mediaPlayer.addEventListener( StreamEvent.PLAY , _status , false , 0 , true );
			_mediaPlayer.addEventListener( StreamEvent.RESUME , _status , false , 0 , true );
			_mediaPlayer.addEventListener( StreamEvent.PAUSE , _status , false , 0 , true );
			_mediaPlayer.addEventListener( StreamEvent.STOP , _status , false , 0 , true );
			_mediaPlayer.addEventListener( StreamEvent.PLAY_COMPLETE , _status , false , 0 , true );			_mediaPlayer.addEventListener( StreamEvent.META_DATA , _status , false , 0 , true );			_mediaPlayer.addEventListener( StreamEvent.CLOSE , _status , false , 0 , true );
			
			_oldVolume = _mediaPlayer.volume;
			
			if( volumeAsset != null )
				volumeAsset.value = _oldVolume;
		
			if( pauseAsset == null && playAsset != null ) playAsset.gotoAndStop( _mediaPlayer.checkStates( MediaPlayerState.PLAYING ) ? 2 : 1 );
			
			if( repeatAsset != null ) repeatAsset.gotoAndStop( _mediaPlayer.repeat ? 2 : 1 );
			if( loopAsset != null ) loopAsset.gotoAndStop( _mediaPlayer.loop ? 2 : 1 );
			if( randomAsset != null ) randomAsset.gotoAndStop( _mediaPlayer.random ? 2 : 1 );
		}
		
		/**
		 * Build a new SimpleMediaController instance.
		 * 
		 * @param mediaPlayer The MediaPlayer instance to control.
		 */
		public function SimpleMediaController( mediaPlayer : MediaPlayer = null )
		{
			// Use getChildByName to retrieve asset to avoid definiton conflicts
			// since designer will certainly not uncheck "Automatically declare stage instance" checkbox in publish settings.
			playAsset = getChildByName( "mcPlay" ) as MovieClip;			pauseAsset = getChildByName( "mcPause" ) as MovieClip;			stopAsset = getChildByName( "mcStop" ) as MovieClip;			nextAsset = getChildByName( "mcNext" ) as MovieClip;			previousAsset = getChildByName( "mcPrevious" ) as MovieClip;			muteAsset = getChildByName( "mcMute" ) as MovieClip;			repeatAsset = getChildByName( "mcRepeat" ) as MovieClip;			loopAsset = getChildByName( "mcLoop" ) as MovieClip;			randomAsset = getChildByName( "mcRandom" ) as MovieClip;			fullscreenAsset = getChildByName( "mcFullscreen" ) as MovieClip;			loaderBarAsset = getChildByName( "mcLoaderBar" ) as MovieClip;			timelineAsset = getChildByName( "mcTimeline" ) as ISlider;			volumeAsset = getChildByName( "mcVolume" ) as ISlider;			timeElapsedAsset = getChildByName( "tfTimeElapsed" ) as TextField;			timeLeftAsset = getChildByName( "tfTimeLeft" ) as TextField;			durationAsset = getChildByName( "tfDuration" ) as TextField;			trackNameAsset = getChildByName( "tfTrackName" ) as TextField;
			
			if( mediaPlayer != null ) this.mediaPlayer = mediaPlayer;
			
			if( stage == null ) addEventListener( Event.ADDED_TO_STAGE , _added , false , 0 , true );
			else _added();
			
			_init();
		}
		
		/**
		 * @private
		 */
		protected function _added( e : Event = null ) : void
		{
			removeEventListener( Event.ADDED_TO_STAGE , _added );
			
			stage.addEventListener( FullScreenEvent.FULL_SCREEN , _fullscreenChanged , false , 0 , true );
		}
		
		/**
		 * @private
		 */
		protected function _fullscreenChanged( e : FullScreenEvent ) : void
		{
			if( fullscreenAsset != null )
				fullscreenAsset.gotoAndStop( e.fullScreen ? 2 : 1 );
		}

		/**
		 * @private
		 */
		protected function _init(  ) : void
		{
			if( playAsset != null )
			{
				playAsset.buttonMode = true;
				playAsset.addEventListener( MouseEvent.CLICK, _play , false , 0 , true );
			}
			if( pauseAsset != null )
			{
				pauseAsset.buttonMode = true;
				pauseAsset.addEventListener( MouseEvent.CLICK, _pause , false , 0 , true );
			}
			if( stopAsset != null )
			{
				stopAsset.buttonMode = true;
				stopAsset.addEventListener( MouseEvent.CLICK, _stop , false , 0 , true );
			}
			if( nextAsset != null )
			{
				nextAsset.buttonMode = true;
				nextAsset.addEventListener( MouseEvent.CLICK, _next , false , 0 , true );
			}
			if( previousAsset != null )
			{
				previousAsset.buttonMode = true;
				previousAsset.addEventListener( MouseEvent.CLICK, _previous , false , 0 , true );
			}
			if( muteAsset != null )
			{
				muteAsset.buttonMode = true;
				muteAsset.addEventListener( MouseEvent.CLICK, _mute , false , 0 , true );
			}
			if( repeatAsset != null )
			{
				repeatAsset.buttonMode = true;
				repeatAsset.addEventListener( MouseEvent.CLICK, _repeat , false , 0 , true );
			}
			if( loopAsset != null )
			{
				loopAsset.buttonMode = true;
				loopAsset.addEventListener( MouseEvent.CLICK, _loop , false , 0 , true );
			}
			if( randomAsset != null )
			{
				randomAsset.buttonMode = true;
				randomAsset.addEventListener( MouseEvent.CLICK, _random , false , 0 , true );
			}
			if( fullscreenAsset != null )
			{
				fullscreenAsset.buttonMode = true;
				fullscreenAsset.addEventListener( MouseEvent.CLICK, _fullscreen , false , 0 , true );
			}
			
			if( timelineAsset != null )
			{
				timelineAsset.focusEnabled = false;
				
				timelineAsset.addEventListener( MouseEvent.MOUSE_DOWN , _forceSeekPause , true , 0 , true );
				timelineAsset.addEventListener( MouseEvent.MOUSE_UP , _restoreWasPlaying , false , 0 , true );
				timelineAsset.addEventListener( Event.CHANGE , _updatePosition , false , 0 , true );
				
				timelineAsset.allowTrackDrag = true;
				timelineAsset.minimum = 0;				timelineAsset.maximum = 100;
			}
			
			if( volumeAsset != null )
			{
				volumeAsset.addEventListener( Event.CHANGE , _updateVolume , false , 0 , true );
				
				volumeAsset.allowTrackDrag = true;
				volumeAsset.minimum = 0;
				volumeAsset.maximum = 1;
			}
		}
		
		/**
		 * @private
		 */
		protected function _play( e : MouseEvent ) : void
		{
			if( _mediaPlayer.checkStates( MediaPlayerState.PLAYING ) && pauseAsset == null ) _mediaPlayer.pause( );
			else _mediaPlayer.play( );
		}
	
		/**
		 * @private
		 */
		protected function _pause ( e : MouseEvent ) : void
		{
			_mediaPlayer.pause( );
		}
	
		/**
		 * @private
		 */
		protected function _stop ( e : MouseEvent ) : void
		{
			_mediaPlayer.stop( );
		}
	
		/**
		 * @private
		 */
		protected function _next ( e : MouseEvent ) : void
		{
			_mediaPlayer.next();
		}
	
		/**
		 * @private
		 */
		protected function _previous ( e : MouseEvent ) : void
		{
			_mediaPlayer.previous();
		}
	
		/**
		 * @private
		 */
		protected function _mute ( e : MouseEvent ) : void
		{
			if( _isMute )
			{
				_mediaPlayer.volume = _oldVolume;
				
				if( volumeAsset != null )
					volumeAsset.value = _oldVolume;
				
				_isMute = false;
				
				muteAsset.gotoAndStop( 1 );
			}
			else
			{
				_oldVolume = _mediaPlayer.volume;
				_mediaPlayer.volume = 0;
				
				if( volumeAsset != null )
					volumeAsset.value = 0;
					
				_isMute = true;
				
				muteAsset.gotoAndStop( 2 );
			}
		}
	
		/**
		 * @private
		 */
		protected function _repeat ( e : MouseEvent ) : void
		{
			repeatAsset.gotoAndStop( repeatAsset.currentFrame == 1 ? 2 : 1 );
			
			_mediaPlayer.repeat = repeatAsset.currentFrame == 2;
		}
	
		/**
		 * @private
		 */
		protected function _loop ( e : MouseEvent ) : void
		{
			loopAsset.gotoAndStop( loopAsset.currentFrame == 1 ? 2 : 1 );
			
			_mediaPlayer.loop = loopAsset.currentFrame == 2;
		}
	
		/**
		 * @private
		 */
		protected function _random ( e : MouseEvent ) : void
		{
			randomAsset.gotoAndStop( randomAsset.currentFrame == 1 ? 2 : 1 );
			
			_mediaPlayer.random = randomAsset.currentFrame == 2;
		}
		
		/**
		 * @private
		 */
		protected function _fullscreen( e : MouseEvent ) : void
		{
			stage.displayState = fullscreenAsset.currentFrame == 1 ? StageDisplayState.FULL_SCREEN : StageDisplayState.NORMAL;
		}

		/**
		 * @private
		 */
		protected function _forceSeekPause ( e : MouseEvent ) : void
		{
			_wasPlaying = _mediaPlayer.checkStates( MediaPlayerState.PLAYING );
			_mediaPlayer.pause( );
			
			stage.addEventListener( MouseEvent.MOUSE_UP , _mouseUpOutside , false , 0 , true );
		}
	
		/**
		 * @private
		 */
		protected function _restoreWasPlaying ( e : MouseEvent = null ) : void
		{
			_mediaPlayer.seekPercentage( timelineAsset.value );
			
			if( _wasPlaying ) _mediaPlayer.resume( );
		}
	
		/**
		 * @private
		 */
		protected function _updateVolume ( e : Event ) : void
		{
			_mediaPlayer.volume = volumeAsset.value;
			
			if( _isMute && _mediaPlayer.volume > 0 )
			{
				_isMute = false;
				
				if( muteAsset != null )
					muteAsset.gotoAndStop( 1 );
			}
			else if( !_isMute && _mediaPlayer.volume == 0 )
			{
				_isMute = true;
				
				if( muteAsset != null )
					muteAsset.gotoAndStop( 2 );
			}
		}
	
		/**
		 * @private
		 */
		protected function _updatePosition ( e : Event ) : void
		{
			if( !_mediaPlayer.checkStates( MediaPlayerState.PLAYING ) && !_noTimelineDispatch )
				_mediaPlayer.timelineSeekPercentage( timelineAsset.value );
			
			_updateTime();
		}
	
		/**
		 * @private
		 */
		protected function _playing ( e : StreamEvent ) : void
		{
			if( timelineAsset != null )
				timelineAsset.value = ( e.media.position / e.media.duration ) * 100;
			
			_updateTime();
		}
		
		/**
		 * @private
		 */
		protected function _updateTime(  ) : void
		{
			if( timeElapsedAsset != null ) timeElapsedAsset.text = TimeFormatter.format( _mediaPlayer.currentMedia.position , TIME_FORMAT );
			if( timeLeftAsset != null )
			{
				if( _mediaPlayer.currentMedia.duration == 1 ) timeLeftAsset.text = TimeFormatter.format( 0 , TIME_FORMAT );
				else timeLeftAsset.text = TimeFormatter.format( _mediaPlayer.currentMedia.duration - _mediaPlayer.currentMedia.position + 999 , TIME_FORMAT );
			}
		}
	
		/**
		 * @private
		 */
		protected function _buffering ( e : StreamEvent ) : void
		{
			
		}
	
		/**
		 * @private
		 */
		protected function _loading ( e : StreamEvent ) : void
		{
			if( loaderBarAsset != null )
			{
				var r : Number = e.media.bytesLoaded / e.media.bytesTotal;
				
				if( isNaN( r ) || r < 0 ) loaderBarAsset.scaleX = 0;
				else loaderBarAsset.scaleX = Math.max( 0 , r );
			}
		}
	
		/**
		 * @private
		 */
		protected function _status ( e : StreamEvent ) : void
		{
			switch( e.type )
			{
				case StreamEvent.CLOSE :
					enabled = false;
					break;
				
				case StreamEvent.PLAY 	: 
					if( timelineAsset != null ) 
					{
						_noTimelineDispatch = true;
						timelineAsset.value = 0; 
						_noTimelineDispatch = false;
					}
					if( timeElapsedAsset != null ) timeElapsedAsset.text = TimeFormatter.format( 0 , TIME_FORMAT );
					if( timeLeftAsset != null ) timeLeftAsset.text = TimeFormatter.format( 0 , TIME_FORMAT );					if( durationAsset != null ) durationAsset.text = TimeFormatter.format( 0 , TIME_FORMAT );
					if( trackNameAsset != null ) trackNameAsset.text = e.media.name;
					if( pauseAsset == null && playAsset != null ) playAsset.gotoAndStop( 1 ); 
					
					break;
					
				case StreamEvent.RESUME 	: 
					if( pauseAsset == null && playAsset != null ) playAsset.gotoAndStop( 2 ); 
					break;
					
				case StreamEvent.PAUSE	: 
					if( playAsset != null ) playAsset.gotoAndStop( 1 ); 
					break;
					
				case StreamEvent.STOP 	: 
					if( timeElapsedAsset != null ) timeElapsedAsset.text = TimeFormatter.format( 0 , TIME_FORMAT );
					if( timeLeftAsset != null ) timeLeftAsset.text = TimeFormatter.format( 0 , TIME_FORMAT );
					if( durationAsset != null ) durationAsset.text = TimeFormatter.format( 0 , TIME_FORMAT );
					if( playAsset != null ) playAsset.gotoAndStop( 1 ); 
					if( timelineAsset != null ) 
					{
						_noTimelineDispatch = true;
						timelineAsset.value = 0; 
						_noTimelineDispatch = false;
					}
					break;
					
				case StreamEvent.PLAY_COMPLETE : 
					if( playAsset != null ) playAsset.gotoAndStop( 1 ); 
					if( timelineAsset != null )
					{
						_noTimelineDispatch = true;
						timelineAsset.value = _mediaPlayer.rewindOnComplete ? 0 : 100; 
						_noTimelineDispatch = false;
					}
					break;
					
				case StreamEvent.META_DATA : 
					enabled = true;
					if( durationAsset != null ) durationAsset.text = TimeFormatter.format( e.media.duration , TIME_FORMAT );
					break;
			}
		}
		
		
		/**
		 * @private
		 */
		protected function _mouseUpOutside( e : MouseEvent ) : void
		{
			if( e.target != timelineAsset && !( timelineAsset.contains( e.target as DisplayObject ) ) ) _restoreWasPlaying();
			
			stage.removeEventListener( MouseEvent.MOUSE_UP  , _mouseUpOutside );
		}
	}
}