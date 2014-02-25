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
package myLib.display 
{
	import myLib.display.ISprite;
	
	import flash.display.Scene;	
	/**
	 * @author SamYStudiO ( contact@samystudio.net )
	 */
	public interface IMovieClip extends ISprite 
	{
		/**
		 * @see http://help.adobe.com/en_US/AS3LCR/Flash_10.0/flash/display/MovieClip.html#currentFrame flash.display.MovieClip.currentFrame
		 */
		function get currentFrame () : int;
		
		/**
		 * @see http://help.adobe.com/en_US/AS3LCR/Flash_10.0/flash/display/MovieClip.html#currentLabel flash.display.MovieClip.currentLabel
		 */
		function get currentLabel () : String;
		
		/**
		 * @see http://help.adobe.com/en_US/AS3LCR/Flash_10.0/flash/display/MovieClip.html#currentLabels flash.display.MovieClip.currentLabels
		 */
		function get currentLabels () : Array;
		
		/**
		 * @see http://help.adobe.com/en_US/AS3LCR/Flash_10.0/flash/display/MovieClip.html#currentScene flash.display.MovieClip.currentScene
		 */
		function get currentScene () : Scene;
		
		/**
		 * @see http://help.adobe.com/en_US/AS3LCR/Flash_10.0/flash/display/MovieClip.html#scenes flash.display.MovieClip.scenes
		 */
		function get scenes () : Array;

		/**
		 * @see http://help.adobe.com/en_US/AS3LCR/Flash_10.0/flash/display/MovieClip.html#enabled flash.display.MovieClip.enabled
		 */
		function get enabled () : Boolean;
		function set enabled ( value : Boolean ) : void;
		
		/**
		 * @see http://help.adobe.com/en_US/AS3LCR/Flash_10.0/flash/display/MovieClip.html#framesLoaded flash.display.MovieClip.framesLoaded
		 */
		function get framesLoaded () : int;
		
		/**
		 * @see http://help.adobe.com/en_US/AS3LCR/Flash_10.0/flash/display/MovieClip.html#totalFrames flash.display.MovieClip.totalFrames
		 */
		function get totalFrames () : int;
		
		/**
		 * @see http://help.adobe.com/en_US/AS3LCR/Flash_10.0/flash/display/MovieClip.html#trackAsMenu flash.display.MovieClip.trackAsMenu
		 */
		function get trackAsMenu () : Boolean;
		function set trackAsMenu ( value : Boolean ) : void;
		
		/**
		 * @see http://help.adobe.com/en_US/AS3LCR/Flash_10.0/flash/display/MovieClip.html#addFrameScript() flash.display.MovieClip.addFrameScript()
		 */
		function addFrameScript ( ...args ) : void;
		
		/**
		 * @see http://help.adobe.com/en_US/AS3LCR/Flash_10.0/flash/display/MovieClip.html#gotoAndPlay() flash.display.MovieClip.gotoAndPlay()
		 */
		function gotoAndPlay ( frame : Object , scene : String = null ) : void;
		
		/**
		 * @see http://help.adobe.com/en_US/AS3LCR/Flash_10.0/flash/display/MovieClip.html#gotoAndStop() flash.display.MovieClip.gotoAndStop()
		 */
		function gotoAndStop ( frame : Object , scene : String = null ) : void;
		
		/**
		 * @see http://help.adobe.com/en_US/AS3LCR/Flash_10.0/flash/display/MovieClip.html#nextFrame() flash.display.MovieClip.nextFrame()
		 */
		function nextFrame () : void;
		
		/**
		 * @see http://help.adobe.com/en_US/AS3LCR/Flash_10.0/flash/display/MovieClip.html#nextScene() flash.display.MovieClip.nextScene()
		 */
		function nextScene () : void;
		
		/**
		 * @see http://help.adobe.com/en_US/AS3LCR/Flash_10.0/flash/display/MovieClip.html#play() flash.display.MovieClip.play()
		 */
		function play () : void;
		
		/**
		 * @see http://help.adobe.com/en_US/AS3LCR/Flash_10.0/flash/display/MovieClip.html#prevFrame() flash.display.MovieClip.prevFrame()
		 */
		function prevFrame () : void;
		
		/**
		 * @see http://help.adobe.com/en_US/AS3LCR/Flash_10.0/flash/display/MovieClip.html#prevScene() flash.display.MovieClip.prevScene()
		 */
		function prevScene () : void;
		
		/**
		 * @see http://help.adobe.com/en_US/AS3LCR/Flash_10.0/flash/display/MovieClip.html#stop() flash.display.MovieClip.stop()
		 */
		function stop () : void;
	}
}
