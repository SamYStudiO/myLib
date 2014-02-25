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

	import flash.display.AVM1Movie;
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.TimerEvent;
	import flash.media.SoundTransform;
	import flash.system.LoaderContext;
	/**
	 * @private
	 * 
	 * @author SamYStudiO ( contact@samystudio.net )
	 */
	internal class LoaderStream extends AStream 
	{
		/**
		 * @private
		 */
		protected var _timer : Timer = new Timer( );
		
		/**
		 * @private
		 */
		protected var _mc : MovieClip;
		
		/**
		 * @private
		 */
		protected var _isInit : Boolean;
		
		/**
		 * @private
		 */
		protected var _volume : Number = 1;
		
		/**
		 * @private
		 */
		protected var _isPaused : Boolean = true;
		
		/**
		 * @private
		 */
		protected var _dispatchComplete : Boolean;
		
		/**
		 * @private
		 */
		protected var _screen : VideoScreen = new VideoScreen( new Loader( ) );

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
			return _screen.view;
		}
		
		/**
		 * @inheritDoc
		 */
		public override function get volume () : Number
		{
			if( _isMovie( ) && _isInit ) return _mc.soundTransform.volume;
			
			return _volume;
		}
		
		public override function set volume ( n : Number ) : void
		{
			_volume = n;
			
			if( _isMovie( ) )
			{
				var st : SoundTransform = _mc.soundTransform;
				
				st.volume = n;
				_mc.soundTransform = st;
			}
		}
		
		/**
		 * @inheritDoc
		 */
		public override function get bytesLoaded() : int
		{
			return _screen.loaderView.contentLoaderInfo.bytesLoaded;
		}
		
		/**
		 * @inheritDoc
		 */
		public override function get bytesTotal() : int
		{
			return _screen.loaderView.contentLoaderInfo.bytesTotal;
		}
		
		/**
		 * @inheritDoc
		 */
		public override function get position() : uint
		{
			if( _isMovie( ) && _screen.loaderView.stage != null )
				return _mc.currentFrame / _screen.loaderView.contentLoaderInfo.frameRate * 1000;
			else
				return _isInit ? Math.min( _timer.currentTime , _duration ) : 0;
		}
		
		/**
		 * 
		 */
		public function LoaderStream ()
		{
			_screen.loaderView.contentLoaderInfo.addEventListener( Event.INIT , _init , false , 0 , true );			_screen.loaderView.contentLoaderInfo.addEventListener( Event.COMPLETE , _loadingComplete , false , 0 , true );			_screen.loaderView.contentLoaderInfo.addEventListener( IOErrorEvent.IO_ERROR , _streamError , false , 0 , true );			_timer.addEventListener( TimerEvent.TIMER , _checkComplete , false , 0 , true );
		}
		
		/**
		 * @inheritDoc
		 */
		public override function play ( media : StreamMedia ) : void
		{
			super.play( media );
			
			_screen.loaderView.load( media.request , media.context as LoaderContext );
		}
		
		/**
		 * @inheritDoc
		 */
		public override function resume () : void
		{
			if( !_isInit ) return;
			
			_isPaused = false;
			
			if( _isMovie( ) )
			{
				_mc.play();	
				
				if( _dispatchComplete ) _complete();
			}
			else _timer.start();
			
			super.resume();
		}
		
		/**
		 * @inheritDoc
		 */
		public override function stop () : void
		{
			if( !_isInit ) return;
			
			if( _isMovie( ) )
			{
				_mc.stop();
				_mc.gotoAndStop( 1 );
			}
			else _timer.reset();
			
			_isPaused = true;
			
			super.stop();
		}
		
		/**
		 * @inheritDoc
		 */
		public override function close () : void
		{
			if( _isMovie(  ) )
			{
				_mc.removeEventListener( Event.ENTER_FRAME , _checkBuffer );
				_mc.stop();	
			}
			
			try
			{
				_screen.loaderView.close();
			}
			catch( e : Error ) {}
			
			_screen.loaderView.unload();
			_timer.reset();
			
			_isPaused = true;
			
			super.close();
		}
		
		/**
		 * @inheritDoc
		 */
		public override function pause () : void
		{
			if( !_isInit ) return;
			
			if( _isMovie( ) ) _mc.stop();
			else _timer.stop();
			
			_isPaused = true;
			
			super.pause();
		}
		
		/**
		 * @inheritDoc
		 */
		public override function seek ( milliSeconds : uint ) : void
		{
			if( !_isInit ) return;
			
			if( _isMovie( ) )
			{
				var frame : uint = Math.round( milliSeconds / 1000 * _screen.loaderView.contentLoaderInfo.frameRate );
				
				if( _isPaused )
				{
					_mc.gotoAndStop( Math.max( 1 , Math.min( frame , _mc.framesLoaded ) ) );
					
					_dispatchComplete = frame == _mc.totalFrames;
				}
				else _mc.gotoAndPlay( frame );
			}
			else _timer.currentTime = Math.min( milliSeconds , _duration );
		}
		
		/**
		 * @private
		 */
		protected override function _loadProgress( e : TimerEvent ) : void
		{
			if( _media.streamType == StreamType.FLASH ) super._loadProgress( e );
			else
			{
				var l : int = _media.bytesLoaded = _media.bufferBytesLoaded = bytesLoaded;
				var t : int = _media.bytesTotal = _media.bufferBytesTotal = bytesTotal;
				
				_isLoaded = _isBuffered = l >= t && t > 0;
				
				dispatchEvent( new StreamEvent( StreamEvent.BUFFERING , _media ) );
				dispatchEvent( new StreamEvent( StreamEvent.LOADING , _media ) );
				
				if( _isLoaded )
				{
					if( _duration > 0 )
					{
						_loaderTimer.stop();
						
						dispatchEvent( new StreamEvent( StreamEvent.BUFFER_FULL , _media ) );	
						dispatchEvent( new StreamEvent( StreamEvent.LOADING_COMPLETE , _media ) );
					}
				}
			}
		}
		
		/**
		 * @private
		 */
		protected function _init( e : Event ) : void
		{
			try
			{
				if( _screen.loaderView.content is AVM1Movie ) throw new Error( this + " AVM1 Movie are not allowed with MediaPlayer" );
			}
			catch( e : SecurityError ) {}
			
			try
			{
				_mc = _screen.loaderView.content as MovieClip;
			}
			catch( e : SecurityError ) {}
			
			if( _mc != null )
			{
				_mc.stop();
				_mc.addEventListener( Event.ENTER_FRAME , _checkBuffer , false , 0, true );
			}
			
			_isInit = true;
			
			var o : Object = new Object();			
			_media.metaData = ObjectUtils.merge( _mc , o , false );
			
			o.width = _screen.loaderView.contentLoaderInfo.width;
			o.height = _screen.loaderView.contentLoaderInfo.height;
			o.duration = _isMovie( ) ? _mc.totalFrames / _screen.loaderView.contentLoaderInfo.frameRate * 1000 : MediaPlayer.DEFAULT_IMAGE_DURATION;
			
			if( _media.duration == 0 ) _media.duration = o.duration;
			
			_duration = _media.duration;
			
			dispatchEvent( new StreamEvent( StreamEvent.META_DATA , _media ) );
		}

		/**
		 * @private
		 */
		protected function _loadingComplete( e : Event ) : void
		{
			if( _isMovie( ) )
			{
				_mc.addFrameScript( _mc.totalFrames - 1 , _complete );
				_mc.removeEventListener( Event.ENTER_FRAME , _checkBuffer );
			}
		}
		
		/**
		 * @private
		 */
		protected function _checkComplete( e : TimerEvent ) : void
		{
			if( _timer.currentTime >= _duration )
			{
				dispatchEvent( new StreamEvent( StreamEvent.PLAY_COMPLETE , _media ) );	
				_timer.stop();
			}
		}
		
		/**
		 * @private
		 */
		protected function _complete( ) : void
		{
			if( _isPaused ) return;
			
			_dispatchComplete = false;
			
			( _screen.loaderView.content as MovieClip ).stop( );
			
			dispatchEvent( new StreamEvent( StreamEvent.PLAY_COMPLETE , _media ) );
		}
		
		/**
		 * @private
		 */
		protected function _checkBuffer( e : Event ) : void
		{
			if( _mc.currentFrame + 1  == _mc.framesLoaded && _mc.currentFrame != _mc.totalFrames )
				dispatchEvent( new StreamEvent( StreamEvent.BUFFER_EMPTY , _media ) );
		}
		
		/**
		 * @private
		 */
		protected function _streamError ( e : IOErrorEvent ) : void
		{
			dispatchEvent( new StreamEvent( StreamEvent.STREAM_NOT_FOUND , _media ) );
		}
		
		/**
		 * @private
		 */
		protected function _isMovie(  ) : Boolean
		{
			try
			{
				return _screen.loaderView.content is MovieClip && ( _screen.loaderView.content as MovieClip ).totalFrames > 1;
			}
			catch( e : SecurityError )
			{
				
			}
			
			return false;
		}
	}
}
