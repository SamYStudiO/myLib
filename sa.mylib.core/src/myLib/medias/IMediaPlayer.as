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
	import myLib.assets.IMovieAsset;
	import myLib.assets.ITextFieldAsset;
	import myLib.core.IComponent;

	import flash.geom.Point;
	/**
	 * @author SamYStudiO ( contact@samystudio.net )
	 */
	public interface IMediaPlayer extends IComponent 
	{
		/**
		 * Get or set a Boolean that indicates if play list loops from last file to first file when play list is complete.
		 * 
		 * @default false
		 */
		function get loop () : Boolean;
		function set loop ( b : Boolean ) : void;
		
		/**
		 * Get or set a Boolean that indicates if current media will be repeat when it is complete.
		 * 
		 * @default false
		 */
		function get repeat () : Boolean;
		function set repeat ( b : Boolean ) : void;
		
		/**
		 * Get or set a Boolean that indicates medias from a play list will be read randomly.
		 * 
		 * @default false
		 */
		function get random () : Boolean;
		function set random ( b : Boolean ) : void;
		
		/**
		 * Get or set a Boolean that indicates if current media will be rewind to first frame when it is compeleted,
		 * useful with video media to display its first frame or not when it is completed.
		 * If a play list is currently associated with MediaPlayer this affect only last media.
		 * 
		 * @default false
		 */
		function get rewindOnComplete () : Boolean;
		function set rewindOnComplete ( b : Boolean ) : void;
		
		/**
		 * Get or set the PlayList associated with MediaPLayer.
		 * 
		 * @see PlayList
		 */
		function get playList () : PlayList;
		function set playList ( pl : PlayList ) : void;
		
		/**
		 * Get or set volume value between 0 and 1.
		 */
		function get volume () : Number;
		function set volume ( n : Number ) : void;
		
		/**
		 * Get or set a Boolean that indicates if video screen are smoothed.
		 * 
		 * @default true
		 */
		function get smoothing () : Boolean;
		function set smoothing ( b : Boolean ) : void;
		
		/**
		 * <p>Get or set the video scale mode using MediaScaleMode constants.</p>
		 * <p>MediaScaleMode.AUTOSIZE : MediaPlayer and video cannot resized, size from video metadata is used.</p>		 * <p>MediaScaleMode.EXACT_FIT : video is resized according MediaPlayer size (original aspect ration is not preserved).</p>		 * <p>MediaScaleMode.NO_BORDER : video is resized according MediaPlayer size maintaining aspect ratio but certainly cropped.</p>		 * <p>MediaScaleMode.SHOW_ALL : video is resized according MediaPlayer size maintaining aspect ratio width borders visible (all video area is visible).</p>
		 * 
		 * @see MediaScaleMode
		 * @default noBorder
		 */
		function get screenScaleMode () : String;
		function set screenScaleMode ( scaleMode : String ) : void;
		
		/**
		 * Get or set a Boolean that indicates if video zoom is enabled. If false video size may be reduced only. 
		 * 
		 * @default true
		 */
		function get allowScreenScaleZoom () : Boolean;
		function set allowScreenScaleZoom ( scaleZoom : Boolean ) : void;
		
		/**
         * Maximum scale if allowScreenScaleZoom is true. 
         * 
         * @default NaN
         */
        function get maxScreenScale () : Number;
        function set maxScreenScale ( scale : Number ) : void;
		
		/**
		 * Specify video screen alignment within player (this as no effect if videoScaleMode is autoSize or exactFit).
		 * 
		 * @see myLib.displayUtils.AlignmentPoint
		 * @default C
		 */
		function get screenAlignment () : String;
		function set screenAlignment ( align : String ) : void;
		
		/**
		 * Get or set a Boolean that indicates if video is automatically closed when removed from stage.
		 * 
		 * @default true
		 */
		function get closeOnRemoveFromStage () : Boolean;
		function set closeOnRemoveFromStage ( b : Boolean ) : void;
		
		/**
		 * Get or set The IMediaControler object that is associated with MediaPlayer.
		 * 
		 * @see IMediaController
		 * @see SimpleMediaControler
		 */
		function get controller () : IMediaController;
		function set controller ( controller : IMediaController ) : void;
		
		/**
		 * Get or set a Boolean that indicates if subtitles are visible.
		 * 
		 * @default true
		 */
		function get showSubTitle () : Boolean;
		function set showSubTitle ( b : Boolean ) : void;
		
		/**
		 * Get the StreamMedia object currently playing.
		 * 
		 * @see StreamMedia
		 */
		function get currentMedia () : StreamMedia;
		
		/**
		 * 
		 */
		function get screenRatio() : Number
		
		/**
		 * 
		 */
		function get screenOffset() : Point
		
		/**
		 * Get stram core object used with current media.
		 * 
		 * With video media stream is a NetStream object.
		 * With sound media stream is a Sound object.
		 * With image media or swf media stream is a Loader object.
		 */
		function get stream () : *;
		
		/**
		 * Get screen used to display current video media.
		 */
		function get screen () : VideoScreen;
		
		/**
		 * Get the screen transition asset used for video transitons.
		 */
		function get screenTransition () : IMovieAsset;
		
		/**
		 * Get the subtitle textfield asset used with videos.
		 */
		function get subTitleAsset () : ITextFieldAsset;
		
		/**
		 * Start to play a new media with this MediaPlayer.
		 * 
		 * @param media The StreamMedia object wich contains all informations to start playing media. If media is null this will resume last opened media if it is not closed.
		 * 
		 * @see StreamMedia
		 */
		function play( media : StreamMedia = null , autoPlay : Boolean = true ) : void;
		
		/**
		 * Resume current media when it is stopped or paused.
		 */
		function resume(  ) : void;
		
		/**
		 * Stop current playing media.
		 */
		function stop(  ) : void;
		
		/**
		 * Close current playing media. This will stop current media and close all netStream connections if exist.
		 */
		function close(  ) : void;
		
		/**
		 * Pause current playing media.
		 */
		function pause(  ) : void;
		
		/**
		 * Reach the specified position with current media in milliseconds.
		 * 
		 * @param n The number of milliseconds where playhead position must be set.
		 */
		function seek( milliSeconds : uint ) : void;
		
		/**
		 * Reach the specified position with current media in percentage.
		 * 
		 * @param n The percentage value between 0 and 100 where playhead position must be set.
		 */
		function seekPercentage( n : Number ) : void;
		
		/**
		 * Reach the specified position with current media in milliseconds.
		 * 
		 * @param n The number of milliseconds where playhead position must be set.
		 */
		function timelineSeek( milliSeconds : uint ) : void;
		
		/**
		 * Reach the specified position with current media in percentage.
		 * 
		 * @param n The percentage value between 0 and 100 where playhead position must be set.
		 */
		function timelineSeekPercentage( n : Number ) : void;
		
		/**
		 * Play next media from play list if a PlayList object is associated with MediaPlayer.
		 * 
		 * @see PlayList
		 */
		function next(  ) : void;
		
		/**
		 * Play previous media from play list if a PlayList object is associated with MediaPlayer.
		 * 
		 * @see PlayList
		 */
		function previous(  ) : void;
				
		/**
		 * Get a Boolean that indicates if specified status (playing, stopped, paused, buffering, etc...) are currently progressing.
		 * Use MediaPlayerState constants to check state. To check multiple states use "|" to separate each states, it will return true only if ALL passed states are progressing.
		 * 
		 * @see MediaPlayerState
		 */
		function checkStates( states : uint ) : Boolean;
	}
}
