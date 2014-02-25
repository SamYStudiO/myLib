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
	import myLib.assets.IMovieAsset;
	import myLib.assets.ITextFieldAsset;
	import myLib.core.AComponent;
	import myLib.core.InvalidationType;
	import myLib.data.Iterator;
	import myLib.data.RandomIterator;
	import myLib.data.SimpleIterator;
	import myLib.displayUtils.AlignmentManager;
	import myLib.displayUtils.AlignmentPoint;
	import myLib.events.ComponentEvent;

	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.display.PixelSnapping;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.media.Video;
	import flash.text.TextFieldAutoSize;

	/**
	 * Dispatched when buffer is empty with current media.
	 * 
	 * @eventType myLib.medias.StreamEvent.BUFFER_EMPTY
	 */
	[Event(name="bufferEmpty", type="myLib.medias.StreamEvent")]
	/**
	 * Dispatched while current media is buffering.
	 * 
	 * @eventType myLib.medias.StreamEvent.BUFFERING
	 */
	[Event(name="buffering", type="myLib.medias.StreamEvent")]
	/**
	 * Dispatched when current media buffering is complete.
	 * 
	 * @eventType myLib.medias.StreamEvent.BUFFER_FULL
	 */
	[Event(name="bufferFull", type="myLib.medias.StreamEvent")]
	/**
	 * Dispatched while current media is loading.
	 * 
	 * @eventType myLib.medias.StreamEvent.LOADING
	 */
	[Event(name="loading", type="myLib.medias.StreamEvent")]
	/**
	 * Dispatched when current media is loaded.
	 * 
	 * @eventType myLib.medias.StreamEvent.LOADING_COMPLETE
	 */
	[Event(name="loadingComplete", type="myLib.medias.StreamEvent")]
	/**
	 * Dispatched while current media is playing.
	 * 
	 * @eventType myLib.medias.StreamEvent.PLAY_PROGRESS
	 */
	[Event(name="playProgress", type="myLib.medias.StreamEvent")]
	/**
	 * Dispatched when current media is complete.
	 * 
	 * @eventType myLib.medias.StreamEvent.COMPLETE
	 */
	[Event(name="playComplete", type="myLib.medias.StreamEvent")]
	/**
	 * Dispatched when a new media is open with Mediaplayer.
	 * 
	 * @eventType myLib.medias.StreamEvent.PLAY
	 */
	[Event(name="play", type="myLib.medias.StreamEvent")]
	/**
	 * Dispatched when a new media is start the first time with Mediaplayer.
	 * 
	 * @eventType myLib.medias.StreamEvent.PLAY_START
	 */
	[Event(name="playStart", type="myLib.medias.StreamEvent")]
	/**
	 * Dispatched when current media start reading or unpaused.
	 * 
	 * @eventType myLib.medias.StreamEvent.RESUME
	 */
	[Event(name="resume", type="myLib.medias.StreamEvent")]
	/**
	 * Dispatched when current media is paused.
	 * 
	 * @eventType myLib.medias.StreamEvent.PAUSE
	 */
	[Event(name="pause", type="myLib.medias.StreamEvent")]
	/**
	 * Dispatched when current media is stopped.
	 * 
	 * @eventType myLib.medias.StreamEvent.STOP
	 */
	[Event(name="stop", type="myLib.medias.StreamEvent")]
	/**
	 * Dispatched when current media is closed.
	 * 
	 * @eventType myLib.medias.StreamEvent.CLOSE
	 */
	[Event(name="close", type="myLib.medias.StreamEvent")]
	/**
	 * Dispatched when metadas from current media are ready for reading.
	 * 
	 * @eventType myLib.medias.StreamEvent.METADATA
	 */
	[Event(name="metaData", type="myLib.medias.StreamEvent")]
	/**
	 * Dispatched when current media url is invalid so MediaPlayer will not play it.
	 * 
	 * @eventType myLib.medias.StreamEvent.BUFFERING
	 */
	[Event(name="streamNotFound", type="myLib.medias.StreamEvent")]
	[InspectableList("allowScreenScaleZoom","inspectableController","loop","playList","random","repeat","rewindOnComplete","showSubTitle","smoothing","screenAlignment","screenScaleMode","volume")]
	/**
	 * MediaPlayer let you play media files such as :
	 * - FLV
	 * - H.264 file (flash player 9r115 minimum)
	 * - MP3
	 * - SWF movie
	 * - JPG, PNG
	 * - HTTPPseudoStream files (for example with http://xmoov.com/)
	 * - RTMP files
	 * 
	 * MediaPlayer can be used as a slideshow since picture file are allowed.
	 * 
	 * @author SamYStudiO ( contact@samystudio.net )
	 */
	public class MediaPlayer extends AComponent implements IMediaPlayer
	{
		/**
		 * @private
		 */
		protected var _resumeOnDraw : Boolean;

		/**
		 * @private
		 */
		protected var _mediaPlayerSkin : IMediaPlayerSkin;

		/**
		 * @private
		 */
		protected var _stream : IStream;

		/**
		 * @private
		 */
		protected var _autoPlay : Boolean = true;

		/**
		 * @private
		 */
		protected var _iterator : Iterator;

		/**
		 * @private
		 */
		protected var _states : uint;

		/**
		 * @private
		 */
		protected override function get _defaultWidth() : Number
		{
			return 160;
		}

		/**
		 * @private
		 */
		protected override function get _defaultHeight() : Number
		{
			return 120;
		}

		/**
		 * Get the default skin object that is applied with MediaPlayer component instances.
		 */
		public static var DEFAULT_SKIN : MediaPlayerSkin = new MediaPlayerSkin();

		/**
		 * Get or set the default duration in milliseconds for all image medias.
		 * 
		 * @default 5000
		 */
		public static var DEFAULT_IMAGE_DURATION : uint = 5000;

		/**
		 * Get or set the donwload duration in milliseconds before user bandwidth is evaluated.
		 * 
		 * @default 1500
		 */
		public static var BANDWIDTH_DETECTION_DURATION : uint = 1500;

		/**
		 * Get or set the security margin when user bandwidth is calculate. This factor between 0 and 1 will be apply to estimated user bandwith.
		 * 
		 * <p>For example if BANDWIDTH_MARGIN is 0.9 and bandwith is evaluated to 100 ko/s, the streaming duration will be calculate with 90 ko/s.</p>
		 * 
		 * @default 0.9
		 */
		public static var BANDWIDTH_MARGIN : Number = 0.90;

		/**
		 * Get or set the NetStream Object bufferTime property. You should never change this unless you have some problems you can not resolved with BANDWIDTH_MARGIN property.
		 * 
		 * @see #BANDWIDTH_MARGIN
		 * 
		 * @default 1500
		 */
		public static var NETSTREAM_BUFFER_TIME : uint = 1500;

		/**
		 * @private
		 */
		protected var _loop : Boolean;

		[Inspectable]
		/**
		 * @inheritDoc
		 */
		public function get loop() : Boolean
		{
			return _loop;
		}

		public function set loop( b : Boolean ) : void
		{
			if( _inspector && !_isLivePreview && _loop ) return;

			_loop = b;
		}

		/**
		 * @private
		 */
		protected var _repeat : Boolean;

		[Inspectable]
		/**
		 * @inheritDoc
		 */
		public function get repeat() : Boolean
		{
			return _repeat;
		}

		public function set repeat( b : Boolean ) : void
		{
			if( _inspector && !_isLivePreview && _repeat ) return;

			_repeat = b;
		}

		/**
		 * @private
		 */
		protected var _random : Boolean;

		[Inspectable]
		/**
		 * @inheritDoc
		 */
		public function get random() : Boolean
		{
			return _random;
		}

		public function set random( b : Boolean ) : void
		{
			if( _inspector && !_isLivePreview && _random ) return;

			_random = b;

			_updateIterator( b );
		}

		/**
		 * @private
		 */
		protected var _rewindOnComplete : Boolean;

		[Inspectable]
		/**
		 * @inheritDoc
		 */
		public function get rewindOnComplete() : Boolean
		{
			return _rewindOnComplete;
		}

		public function set rewindOnComplete( b : Boolean ) : void
		{
			if( _inspector && !_isLivePreview && _rewindOnComplete ) return;

			_rewindOnComplete = b;
		}

		/**
		 * @private
		 */
		protected var _playList : PlayList;

		[Collection(collectionClass="myLib.medias.PlayList",collectionItem="myLib.medias.StreamMedia",identifier="url")]
		/**
		 * @inheritDoc
		 */
		public function get playList() : PlayList
		{
			return _playList;
		}

		public function set playList( pl : PlayList ) : void
		{
			if( _inspector && !_isLivePreview && _playList != null && _playList.length > 0 ) return;

			_playList = pl;

			_updateIterator( _random );

			if( _inspector && pl != null && pl.length > 0 ) _resumeOnDraw = true;
			else if( pl != null && pl.length > 0 ) resume();
			else _resumeOnDraw = false;
		}

		/**
		 * @private
		 */
		protected var _volume : Number = 1;

		[Inspectable(defaultValue=1)]
		/**
		 * @inheritDoc
		 */
		public function get volume() : Number
		{
			return _volume;
		}

		public function set volume( n : Number ) : void
		{
			if( _inspector && !_isLivePreview && _volume != 1 ) return;

			_volume = n;

			if( _stream != null ) _stream.volume = n;
		}

		/**
		 * @private
		 */
		protected var _smoothing : Boolean = true;

		[Inspectable(defaultValue=true)]
		/**
		 * @inheritDoc
		 */
		public function get smoothing() : Boolean
		{
			return _smoothing;
		}

		public function set smoothing( b : Boolean ) : void
		{
			if( _inspector && !_isLivePreview && !_smoothing ) return;

			_smoothing = b;

			try
			{
				if( _screen is Video ) ( _screen as Video ).smoothing = b;
				if( _screen is Loader && ( _screen as Loader ).content is Bitmap )
					( ( _screen as Loader ).content as Bitmap ).smoothing = b;
			}
			catch( e : SecurityError )
			{
				_smoothing = false;
			}
		}

		/**
		 * @private
		 */
		protected var _screenScaleMode : String = ScreenScaleMode.NO_BORDER;

		[Inspectable(defaultValue="noBorder",enumeration="autoSize,exactFit,noBorder,showAll")]
		/**
		 * @inheritDoc
		 */
		public function get screenScaleMode() : String
		{
			return _screenScaleMode;
		}

		public function set screenScaleMode( scaleMode : String ) : void
		{
			if( _inspector && !_isLivePreview && _screenScaleMode != ScreenScaleMode.NO_BORDER ) return;

			_screenScaleMode = scaleMode;

			invalidate( InvalidationType.SIZE );
		}

		/**
		 * @private
		 */
		protected var _allowScreenScaleZoom : Boolean = true;

		[Inspectable(defaultValue=true)]
		/**
		 * @inheritDoc
		 */
		public function get allowScreenScaleZoom() : Boolean
		{
			return _allowScreenScaleZoom;
		}

		public function set allowScreenScaleZoom( scaleZoom : Boolean ) : void
		{
			if( _inspector && !_isLivePreview && !_allowScreenScaleZoom ) return;

			_allowScreenScaleZoom = scaleZoom;

			invalidate( InvalidationType.SIZE );
		}

		/**
		 * @private
		 */
		protected var _maxScreenScale : Number;

		/**
		 *
		 */
		public function get maxScreenScale() : Number
		{
			return _maxScreenScale;
		}

		public function set maxScreenScale( scale : Number ) : void
		{
			_maxScreenScale = Math.abs( scale );

			invalidate( InvalidationType.SIZE );
		}

		/**
		 * @private
		 */
		protected var _screenAlignment : String = AlignmentPoint.CENTER;

		[Inspectable(defaultValue="C",enumeration="C,TL,T,TR,R,BR,B,BL,L")]
		/**
		 * @inheritDoc
		 */
		public function get screenAlignment() : String
		{
			return _screenAlignment;
		}

		public function set screenAlignment( align : String ) : void
		{
			if( _inspector && !_isLivePreview && _screenAlignment != AlignmentPoint.CENTER ) return;

			_screenAlignment = align;

			invalidate( InvalidationType.SIZE );
		}

		/**
		 * @private
		 */
		protected var _closeOnRemoveFromStage : Boolean = true;

		[Inspectable(defaultValue=true)]
		/**
		 * @inheritDoc
		 */
		public function get closeOnRemoveFromStage() : Boolean
		{
			return _closeOnRemoveFromStage;
		}

		public function set closeOnRemoveFromStage( b : Boolean ) : void
		{
			if( _inspector && !_isLivePreview && !_closeOnRemoveFromStage ) return;

			_closeOnRemoveFromStage = b;
		}

		/**
		 * @private
		 */
		protected var _controller : IMediaController;

		/**
		 * @inheritDoc
		 */
		public function get controller() : IMediaController
		{
			return _controller;
		}

		public function set controller( controller : IMediaController ) : void
		{
			_controller = controller;

			_controller.mediaPlayer = this;
		}

		[Inspectable(name="controller")]
		/**
		 * @private
		 */
		public function set inspectableController( controllerName : String ) : void
		{
			if( !_inspector && !_isLivePreview ) throw new Error( this + " inspectableController property is internal and used by Flash component inspector panel , use controller property instead" );

			if( _inspector && !_isLivePreview && ( _controller != null ) ) return;

			try
			{
				controller = parent.getChildByName( controllerName ) as IMediaController;
			}
			catch( e : Error )
			{
			}
		}

		/**
		 * @private
		 */
		protected var _showSubTitle : Boolean = true;

		[Inspectable(defaultValue=true)]
		/**
		 * @inheritDoc
		 */
		public function get showSubTitle() : Boolean
		{
			return _showSubTitle;
		}

		public function set showSubTitle( b : Boolean ) : void
		{
			if( _inspector && !_isLivePreview && !_showSubTitle ) return;

			_showSubTitle = b;

			if( _subTitleAsset != null )
				_subTitleAsset.visible = b;
		}

		/**
		 * @private
		 */
		protected var _currentMedia : StreamMedia;

		/**
		 * @inheritDoc
		 */
		public function get currentMedia() : StreamMedia
		{
			return _currentMedia;
		}

		/**
		 *
		 */
		public function get screenRatio() : Number
		{
			return _screen != null && _currentMedia != null && _currentMedia.metaData != null ? _screen.width / _currentMedia.metaData.width : 1;
		}

		/**
		 *
		 */
		public function get screenOffset() : Point
		{
			return _screen != null ? new Point( _screen.x , _screen.y ) : new Point();
		}

		/**
		 * @inheritDoc
		 */
		public function get stream() : *
		{
			return _stream != null ? _stream.handler : null;
		}

		/**
		 * @private
		 */
		protected var _screen : VideoScreen;

		/**
		 * @inheritDoc
		 */
		public function get screen() : VideoScreen
		{
			return _screen;
		}

		/**
		 * @private
		 */
		protected var _screenTransition : IMovieAsset;

		/**
		 * @inheritDoc
		 */
		public function get screenTransition() : IMovieAsset
		{
			return _screenTransition;
		}

		/**
		 * @private
		 */
		protected var _subTitleAsset : ITextFieldAsset;

		/**
		 * @inheritDoc
		 */
		public function get subTitleAsset() : ITextFieldAsset
		{
			return _subTitleAsset;
		}

		/**
		 * build a new MediaPlayer instance.
		 * 
		 * @param parentContainer The DisplayObjectContainer where instance is added.
		 * @param initStyle The style Object that will be apply to this instace for intializing.
		 * @param skin The custom skin to used.
		 * 
		 * @see myLib.styles.StyleManager
		 * @see IMediaPlayerSkin
		 * @see MediaPlayerSkin
		 */
		public function MediaPlayer( parentContainer : DisplayObjectContainer = null , initStyle : Object = null , skin : IMediaPlayerSkin = null )
		{
			_mediaPlayerSkin = skin == null ? DEFAULT_SKIN : skin;

			super( parentContainer , initStyle , _mediaPlayerSkin );

			addEventListener( Event.ADDED_TO_STAGE , _added , false , 0 , true );
			addEventListener( Event.REMOVED_FROM_STAGE , _removed , false , 0 , true );
		}
		
		/**
		 * @inheritDoc
		 */
		public override function move( x : Number , y : Number , alignmentPoint : String = "TL" , targetCoordinateSpace : DisplayObjectContainer = null ) : void
		{
			var p : Point = new Point( isNaN( x ) ? _x : x , isNaN( y ) ? _y : y );

			if ( ( alignmentPoint != null && alignmentPoint != AlignmentPoint.TOP_LEFT ) || ( targetCoordinateSpace != null && targetCoordinateSpace != parent ) )
			{
				p = AlignmentManager.getAlignmentPoint( this , alignmentPoint == null ? AlignmentPoint.TOP_LEFT : alignmentPoint , targetCoordinateSpace , p.x , p.y );
			}

			if ( p.x == _x && p.y == _y && _isInitialized ) return;
			
			super.move( x , y , alignmentPoint , targetCoordinateSpace );
			
			if( ( _stream is VideoStream ) && ( _stream as VideoStream ).isStageVideo ) invalidate( InvalidationType.SIZE );
		}

		/**
		 * @inheritDoc
		 * 
		 */
		public function play( media : StreamMedia = null , autoPlay : Boolean = true ) : void
		{
			if( ( media == _currentMedia && media != null ) || ( media == null && _currentMedia != null ) )
			{
				resume();
				return;
			}

			if( media == null ) throw new Error( this + " cannot play null media" );

			if( _stream != null )
			{
				if( _screenTransition != null && _screenTransition.currentFrame != 1 )
				{
					_capture();
					_screenTransition.gotoAndStop( 1 );
				}

				close();
			}

			var m : StreamMedia = media.previewMedia != null && !autoPlay ? media.previewMedia : media;

			_currentMedia = m;
			_autoPlay = autoPlay;

			switch( m.streamType )
			{
				case StreamType.VIDEO 					:
					_stream = new VideoStream( m.tryStageVideo , m.streamClient );
					break;
				case StreamType.RTMP 					:
					_stream = new RTMPStream( m.tryStageVideo , m.streamClient );
					break;
				case StreamType.HTTP_PSEUDO_STREAM 		:
					_stream = new HTTPPseudoStream( m.streamClient );
					break;
				case StreamType.YOUTUBE 				:
				case StreamType.YOUTUBE_CHROMELESS 		:
				case StreamType.DAILYMOTION 			:
				case StreamType.DAILYMOTIONE_CHROMELESS :
					_stream = new GenericVideoSharingStream();
					break;
				case StreamType.SOUND 					:
					_stream = new SoundStream();
					break;
				case StreamType.FLASH 					:
				case StreamType.IMAGE 					:
					_stream = new LoaderStream();
					break;
			}

			_screen = _stream.screen;

			if( _screen.displayObjectView != null )
			{
				_screen.displayObjectView.visible = false;

				if( _screenTransition != null ) ( _screenTransition.getChildAt( 1 ) as MovieClip ).addChild( _screen.displayObjectView );
				else addChild( _screen.displayObjectView );
			}

			_stream.addEventListener( StreamEvent.PLAY , _propagateEvent , false , 0 , true );
			_stream.addEventListener( StreamEvent.LOADING , _propagateEvent , false , 0 , true );
			_stream.addEventListener( StreamEvent.BUFFER_EMPTY , _propagateEvent , false , 0 , true );
			_stream.addEventListener( StreamEvent.META_DATA , _mediaMetaData , false , 0 , true );
			_stream.addEventListener( StreamEvent.BUFFERING , _propagateEvent , false , 0 , true );
			_stream.addEventListener( StreamEvent.BUFFER_FULL , _mediaBufferFull , false , 0 , true );
			_stream.addEventListener( StreamEvent.PLAY_START , _propagateEvent , false , 0 , true );
			_stream.addEventListener( StreamEvent.LOADING_COMPLETE , _propagateEvent , false , 0 , true );
			_stream.addEventListener( StreamEvent.PLAY_PROGRESS , _mediaPlayProgress , false , 0 , true );
			_stream.addEventListener( StreamEvent.PLAY_COMPLETE , _mediaPlayComplete , false , 0 , true );
			_stream.addEventListener( StreamEvent.RESUME , _mediaResume , false , 0 , true );
			_stream.addEventListener( StreamEvent.PAUSE , _mediaPause , false , 0 , true );
			_stream.addEventListener( StreamEvent.STOP , _mediaStop , false , 0 , true );
			_stream.addEventListener( StreamEvent.CLOSE , _mediaClose , false , 0 , true );
			_stream.addEventListener( StreamEvent.STREAM_NOT_FOUND , _streamError , false , 0 , true );

			if( m.subTitle && m.previewFrom == null )
			{
				_addStates( MediaPlayerState.SUB_LOADING );
				m.subTitle.addEventListener( Event.COMPLETE , _subLoaded , false , 0 , true );
				m.subTitle.load();
			}
			else
			{
				_addStates( MediaPlayerState.BUFFERING | MediaPlayerState.PAUSED );
				_stream.play( m );
			}

			// make sure iterator position is correct if media is played manually and no next action was called before.
			if( _iterator != null )
			{
				var itemIndex : int = _iterator.getItemPosition( media );

				if( itemIndex > -1 ) _iterator.position = itemIndex + 1;
			}

			dispatchEvent( new StreamEvent( StreamEvent.PLAY , _currentMedia ) );
		}

		/**
		 * @inheritDoc
		 */
		public override function setSize( w : Number , h : Number ) : void
		{
			if( _screenScaleMode == ScreenScaleMode.AUTOSIZE ) return;

			super.setSize( w , h );
		}

		/**
		 * @inheritDoc
		 */
		public function resume() : void
		{
			if( _stream == null )
			{
				if( _playList != null )
				{
					play( _iterator.next() as StreamMedia );
				}
			}
			else
			{
				if( _stream.media.previewFrom != null ) play( _stream.media.previewFrom );
				else _stream.resume();
			}
		}

		/**
		 * @inheritDoc
		 */
		public function stop() : void
		{
			if( _stream != null ) _stream.stop();
		}

		/**
		 * @inheritDoc
		 */
		public function close() : void
		{
			if( _stream != null ) _stream.close();

			_stream = null;
		}

		/**
		 * @inheritDoc
		 */
		public function pause() : void
		{
			if( _stream != null ) _stream.pause();
		}

		/**
		 * @inheritDoc
		 */
		public function seek( milliSeconds : uint ) : void
		{
			if( _stream != null ) _stream.seek( milliSeconds );
		}

		/**
		 * @inheritDoc
		 */
		public function seekPercentage( n : Number ) : void
		{
			if( _stream == null || _currentMedia == null || _currentMedia.metaData == null  ) return;

			if( _currentMedia.duration > 0 )
			{
				_stream.seek( _currentMedia.duration * Math.min( 100 , Math.abs( n ) ) / 100 );
			}
		}

		/**
		 * @inheritDoc
		 */
		public function timelineSeek( milliSeconds : uint ) : void
		{
			if( _stream != null ) _stream.timelineSeek( milliSeconds );
		}

		/**
		 * @inheritDoc
		 */
		public function timelineSeekPercentage( n : Number ) : void
		{
			if( _stream == null || _currentMedia == null || _currentMedia.metaData == null  ) return;

			if( _currentMedia.duration > 0 )
			{
				_stream.timelineSeek( _currentMedia.duration * Math.min( 100 , Math.abs( n ) ) / 100 );
			}
		}

		/**
		 * @inheritDoc
		 */
		public function next() : void
		{
			if( _iterator == null ) return;

			if( _loop && !_iterator.hasNext() ) _iterator.reset();

			if( _iterator.hasNext() )
				play( _iterator.next() as StreamMedia );
		}

		/**
		 * @inheritDoc
		 */
		public function previous() : void
		{
			if( _iterator == null ) return;

			var n : int = _iterator.position - 2;

			_iterator.position = n < 0 && _loop ? _playList.length - 1 : n < 0 ? 0 : n;

			play( _iterator.next() as StreamMedia );
		}

		/**
		 * @inheritDoc
		 */
		public function checkStates( states : uint ) : Boolean
		{
			if( states == MediaPlayerState.CLOSED ) return _states == 0;

			return _states == ( _states | states );
		}

		/**
		 * @private
		 */
		protected override function _createChildren() : void
		{
			_screenTransition = _mediaPlayerSkin.getScreenTransitionAsset();
			_subTitleAsset = _mediaPlayerSkin.getSubTitleTextFieldAsset();

			if( _screenTransition != null ) addChild( _screenTransition as DisplayObject );
			if( _subTitleAsset != null )
			{
				_subTitleAsset.textField.autoSize = TextFieldAutoSize.LEFT;
				addChild( _subTitleAsset as DisplayObject );
			}
		}

		/**
		 * @private
		 */
		protected override function _draw() : void
		{
			if( isInvalidate( InvalidationType.SIZE ) )
			{
				_layout();
			}

			if( _resumeOnDraw && _autoPlay )
			{
				_resumeOnDraw = false;
				resume();
			}
		}
		
		/**
		 * @private
		 */
		protected function _added( e : Event ) : void
		{
			if( ( _stream is VideoStream ) && ( _stream as VideoStream ).isStageVideo ) invalidate( InvalidationType.SIZE );
		}

		/**
		 * @private
		 */
		protected function _removed( e : Event ) : void
		{
			if( _closeOnRemoveFromStage ) close();
			
			if( ( _stream is VideoStream ) && ( _stream as VideoStream ).isStageVideo ) invalidate( InvalidationType.SIZE );
		}

		/**
		 * @private
		 */
		protected function _layout() : void
		{
			// no screen with sound media
			if( _screen != null )
			{
				_adjustForAspectRatio();
				
				switch( _screenAlignment )
				{
					case AlignmentPoint.CENTER :
						_screen.pan = new Point( 0 , 0 );
						break;
					case AlignmentPoint.TOP :
						_screen.pan = new Point( 0 , -1 );
						break;
					case AlignmentPoint.TOP_RIGHT :
						_screen.pan = new Point( 1 , -1 );
						break;
					case AlignmentPoint.RIGHT :
						_screen.pan = new Point( 1 , 0 );
						break;
					case AlignmentPoint.BOTTOM_RIGHT :
						_screen.pan = new Point( 1 , 1 );
						break;
					case AlignmentPoint.BOTTOM :
						_screen.pan = new Point( 0 , 1 );
						break;
					case AlignmentPoint.BOTTOM_LEFT :
						_screen.pan = new Point( -1 , 1 );
						break;
					case AlignmentPoint.LEFT :
						_screen.pan = new Point( -1 , 0 );
						break;
					default :
						_screen.pan = new Point( 0 , 0 );
						break;
				}
			}

			if( _subTitleAsset != null )
				_subTitleAsset.width = _width;

			scrollRect = new Rectangle( 0 , 0 , _width , _height );
		}

		/**
		 * @private
		 */
		protected function _adjustForAutoSize() : void
		{
			if( _currentMedia != null && _currentMedia.metaData != null && _currentMedia.metaData.width && _currentMedia.metaData.height && _screen != null )
			{
				var oldWidth : Number = _width;
				var oldHeight : Number = _height;
				var w : Number = _currentMedia.metaData.width;
				var h : Number = _currentMedia.metaData.height;

				_width = Math.round( Math.max( Math.min( _maxWidth , w ) , _minWidth ) );
				_height = Math.round( Math.max( Math.min( _maxHeight , h ) , _minHeight ) );
				
				_screen.setSize( _width , _height , _getScreenViewport() );

				if( _width == oldWidth && _height == oldHeight ) return;

				invalidate( InvalidationType.SIZE );

				dispatchEvent( new ComponentEvent( ComponentEvent.RESIZE ) );
			}
			else if( _screen != null )
			{
				_screen.setSize( Math.round( _width ) , Math.round( _height ) , _getScreenViewport() );
			}
		}

		/**
		 * @private
		 */
		protected function _adjustForAspectRatio() : void
		{
			if( _screenScaleMode == ScreenScaleMode.NO_BORDER || _screenScaleMode == ScreenScaleMode.SHOW_ALL )
			{
				if( _currentMedia != null && _currentMedia.metaData != null && _currentMedia.metaData.width && _currentMedia.metaData.height && _screen != null )
				{
					var pX : Number;
					var pY : Number;
					var r : Number;

					if( _screenScaleMode == ScreenScaleMode.NO_BORDER )
					{
						pX = ( _currentMedia.metaData.width - _width ) / _currentMedia.metaData.width;
						pY = ( _currentMedia.metaData.height - _height ) / _currentMedia.metaData.height;

						var min : Number = Math.min( pX , pY );

						if( !_allowScreenScaleZoom && min < 0 ) min = 0;

						r = 1 - min;
						if( !isNaN( _maxScreenScale ) ) r = Math.min( _maxScreenScale , r );

						_screen.setSize( Math.round( _currentMedia.metaData.width * r ) , Math.round( _currentMedia.metaData.height * r ) , _getScreenViewport() );
					}
					else
					{
						pX = ( _currentMedia.metaData.width - _width ) / _currentMedia.metaData.width;
						pY = ( _currentMedia.metaData.height - _height ) / _currentMedia.metaData.height;

						var max : Number = Math.max( pX , pY );

						if( !_allowScreenScaleZoom && max < 0 ) max = 0;

						r = 1 - max;
						if( !isNaN( _maxScreenScale ) ) r = Math.min( _maxScreenScale , r );

						_screen.setSize( Math.round( _currentMedia.metaData.width * r ) , Math.round( _currentMedia.metaData.height * r ) , _getScreenViewport() );

						_screenScaleMode = ScreenScaleMode.SHOW_ALL;
					}
				}
				else
				{
					_screen.setSize( Math.round( _width ) , Math.round( _height ) ,_getScreenViewport() );
				}
			}
			else
			{
				var w : Number = _width;
				var h : Number = _height;

				if( _currentMedia != null && _currentMedia.metaData != null && _currentMedia.metaData.width && _currentMedia.metaData.height && _screen != null )
				{
					if( !_allowScreenScaleZoom && w > _currentMedia.metaData.width ) w = _currentMedia.metaData.width;
					if( !_allowScreenScaleZoom && h > _currentMedia.metaData.height ) h = _currentMedia.metaData.height;
				}

				_screen.setSize( Math.round( w ) , Math.round( h ) , _getScreenViewport() );
			}
		}
		
		/**
		 * @private
		 */
		protected function _getScreenViewport(  ) : Rectangle
		{
			if( _screen != null )
			{
				if( stage == null ) return new Rectangle( _x , _y , _width , _height );
				else
				{
					var p : Point = parent.localToGlobal( new Point( _x , _y ) );
					
					return new Rectangle( p.x , p.y , _width , _height );
				}
			}
			
			return null;
		}

		/**
		 * @private
		 */
		protected function _addStates( states : uint ) : void
		{
			_states = _states | states;
		}

		/**
		 * @private
		 */
		protected function _removeState( state : uint ) : void
		{
			if( _states == ( _states | state ) )
				_states = _states ^ state;
		}

		/**
		 * @private
		 */
		protected function _propagateEvent( e : StreamEvent ) : void
		{
			switch( e.type )
			{
				case StreamEvent.BUFFER_EMPTY :
				case StreamEvent.BUFFERING :
					_removeState( MediaPlayerState.BUFFERED );
					_addStates( MediaPlayerState.BUFFERING );
					break;
				case StreamEvent.LOADING :
					_addStates( MediaPlayerState.LOADING );
					break;
				case StreamEvent.LOADING_COMPLETE :
					_removeState( MediaPlayerState.LOADING );
					_addStates( MediaPlayerState.LOADED );
					break;
			}

			dispatchEvent( e );
		}

		/**
		 * @private
		 */
		protected function _mediaMetaData( e : StreamEvent ) : void
		{
			if( _screenScaleMode == ScreenScaleMode.AUTOSIZE ) _adjustForAutoSize();

			validate();

			_propagateEvent( e );
		}

		/**
		 * @private
		 */
		protected function _mediaBufferFull( e : StreamEvent ) : void
		{
			if( _stream.volume != _volume ) _stream.volume = _volume;

			smoothing = _smoothing;

			_removeState( MediaPlayerState.BUFFERING );
			_addStates( MediaPlayerState.BUFFERED );

			_propagateEvent( e );

			if( _autoPlay ) resume();
			else pause();

			if( _screenTransition != null && _screenTransition.currentFrame == 1 )
				_screenTransition.gotoAndPlay( 2 );
		}

		/**
		 * @private
		 */
		protected function _mediaPlayProgress( e : StreamEvent ) : void
		{
			_removeState( MediaPlayerState.STOPPED );
			_removeState( MediaPlayerState.PAUSED );
			_addStates( MediaPlayerState.PLAYING );

			if( _currentMedia.subTitle && _subTitleAsset != null )
			{
				var sub : String = _currentMedia.subTitle.getSubAt( _currentMedia.position );

				if( _subTitleAsset.textField.htmlText != sub )
				{
					_subTitleAsset.textField.htmlText = sub;
					_subTitleAsset.y = _height - _subTitleAsset.height;
				}
			}

			_propagateEvent( e );
		}

		/**
		 * @private
		 */
		protected function _mediaPlayComplete( e : StreamEvent ) : void
		{
			if( _loop && _iterator != null && !_iterator.hasNext() ) _iterator.reset();

			_removeState( MediaPlayerState.PLAYING );
			_addStates( MediaPlayerState.STOPPED );

			switch( true )
			{
				case _repeat :
					_propagateEvent( e );
					resume();
					break;
				case _iterator != null && _iterator.hasNext() :
					_propagateEvent( e );
					if( !e.isDefaultPrevented() ) play( _iterator.next() as StreamMedia );
					break;
				default :
					if( _loop )
					{
						_propagateEvent( e );
						resume();
						return;
					}
					else if( _rewindOnComplete ) _stream.stop();
					else
					{
						// TODO check remove pause has no impact, video should stop itself when complete
						// _stream.pause( );

						_removeState( MediaPlayerState.PLAYING );
						_addStates( MediaPlayerState.PAUSED );
					}
					_propagateEvent( e );
					break;
			}
		}

		/**
		 * @private
		 */
		protected function _mediaResume( e : StreamEvent ) : void
		{
			if( _screen.displayObjectView != null )
				_screen.displayObjectView.visible = true;

			_autoPlay = true;

			_removeState( MediaPlayerState.STOPPED );
			_removeState( MediaPlayerState.PAUSED );
			_addStates( MediaPlayerState.PLAYING );

			if( _screenTransition != null && _screenTransition.currentFrame == 1 )
				_screenTransition.gotoAndPlay( 2 );

			_propagateEvent( e );
		}

		/**
		 * @private
		 */
		protected function _mediaPause( e : StreamEvent ) : void
		{
			_resumeOnDraw = false;
			_autoPlay = false;

			_removeState( MediaPlayerState.PLAYING );
			_removeState( MediaPlayerState.STOPPED );
			_addStates( MediaPlayerState.PAUSED );

			_propagateEvent( e );
		}

		/**
		 * @private
		 */
		protected function _mediaStop( e : StreamEvent ) : void
		{
			_resumeOnDraw = false;
			_autoPlay = false;

			_removeState( MediaPlayerState.PAUSED );
			_removeState( MediaPlayerState.PLAYING );
			_addStates( MediaPlayerState.STOPPED );

			_propagateEvent( e );
		}

		/**
		 * @private
		 */
		protected function _mediaClose( e : StreamEvent ) : void
		{
			if( _screen.displayObjectView != null && _screen.displayObjectView.parent != null )
				_screen.displayObjectView.parent.removeChild( _screen.displayObjectView );

			_screen = null;
			_resumeOnDraw = false;

			_stream.removeEventListener( StreamEvent.PLAY , _propagateEvent );
			_stream.removeEventListener( StreamEvent.LOADING , _propagateEvent );
			_stream.removeEventListener( StreamEvent.BUFFER_EMPTY , _propagateEvent );
			_stream.removeEventListener( StreamEvent.META_DATA , _mediaMetaData );
			_stream.removeEventListener( StreamEvent.BUFFERING , _propagateEvent );
			_stream.removeEventListener( StreamEvent.BUFFER_FULL , _mediaBufferFull );
			_stream.removeEventListener( StreamEvent.PLAY_START , _propagateEvent );
			_stream.removeEventListener( StreamEvent.LOADING_COMPLETE , _propagateEvent );
			_stream.removeEventListener( StreamEvent.PLAY_PROGRESS , _mediaPlayProgress );
			_stream.removeEventListener( StreamEvent.PLAY_COMPLETE , _mediaPlayComplete );
			_stream.removeEventListener( StreamEvent.RESUME , _mediaResume );
			_stream.removeEventListener( StreamEvent.PAUSE , _mediaPause );
			_stream.removeEventListener( StreamEvent.STOP , _mediaStop );
			_stream.removeEventListener( StreamEvent.CLOSE , _mediaClose );
			_stream.removeEventListener( StreamEvent.STREAM_NOT_FOUND , _streamError );
			_stream = null;

			_states = MediaPlayerState.CLOSED;

			_propagateEvent( e );

			if( _currentMedia != null )
			{
				if( _currentMedia.subTitle != null )
					_currentMedia.subTitle.removeEventListener( Event.COMPLETE , _subLoaded );

				_currentMedia.reset();
				_currentMedia = null;
			}
		}

		/**
		 * @private
		 */
		protected function _streamError( e : StreamEvent ) : void
		{
			var mediaURL : String = _currentMedia.request.url;

			close();

			if( willTrigger( StreamEvent.STREAM_NOT_FOUND ) )
				_propagateEvent( e );
			else
				throw new Error( this + " " + mediaURL + " not found" );
		}

		/**
		 * @private
		 */
		protected function _capture() : void
		{
			var mc : MovieClip = _screenTransition.getChildAt( 0 ) as MovieClip;

			while( mc.numChildren > 0 ) mc.removeChildAt( 0 );

			if( _screen.displayObjectView == null ) return;

			var w : Number = _screen.width / _screen.displayObjectView.scaleX;
			var h : Number = _screen.height / _screen.displayObjectView.scaleY;

			if( isNaN( w ) || w == 0 || isNaN( h ) || h == 0 ) return;

			var bd : BitmapData = new BitmapData( w , h , true , 0x00000000 );

			try
			{
				bd.draw( _screen.displayObjectView );
			}
			catch( e : Error )
			{
				bd.fillRect( new Rectangle( 0 , 0 , bd.width , bd.height ) , 0xFF000000 );
			}

			var bitmap : Bitmap = new Bitmap( bd , PixelSnapping.AUTO , _smoothing );

			bitmap.x = _screen.x;
			bitmap.y = _screen.y;
			bitmap.width = _screen.width;
			bitmap.height = _screen.height;

			mc.addChild( bitmap );
		}

		/**
		 * @private
		 */
		protected function _updateIterator( random : Boolean ) : void
		{
			if( _playList == null )
			{
				_iterator = null;
				return;
			}

			var index : int = _playList.getItemIndex( _currentMedia );

			_iterator = random ? new RandomIterator( _playList ) : new SimpleIterator( _playList );
			_iterator.position = index >= 0 ? index + 1 : 0;
		}

		/**
		 * @private
		 */
		protected function _subLoaded( e : Event ) : void
		{
			if( _stream != null )
			{
				_removeState( MediaPlayerState.SUB_LOADING );
				_addStates( MediaPlayerState.BUFFERING | MediaPlayerState.PAUSED | MediaPlayerState.SUB_LOADED );
				_stream.play( _currentMedia );
			}
		}
	}
}
