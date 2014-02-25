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
package myLib.ui 
{
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	/**
	 * Application is a base class for main application classes,
	 * it make easier initialize stage properties such as frameRate, align, scaleMode, showDefaultContextMenu and stageFocusRect.
	 * It also initialize STAGE and ROOT top-level properties so you can use them whereever you want.
	 * 
	 * @author SamYStudiO ( contact@samystudio.net )
	 */
	public class Application extends Sprite 
	{
		/**
		 * @private
		 */
		protected var _frameRate : Number = 30;
		
		/**
		 * @private
		 */
		protected var _align : String = StageAlign.TOP_LEFT;
		
		/**
		 * @private
		 */
		protected var _scaleMode : String = StageScaleMode.NO_SCALE;
		
		/**
		 * @private
		 */
		protected var _showDefaultContextMenu : Boolean = false;
		
		/**
		 * @private
		 */
		protected var _stageFocusRect : Boolean = false;
		
		/**
		 * Build a new Application instance.
		 * @param frameRate Application frame rate (i/s);
		 * @param align Application alignment.
		 * @param scaleMode Application scale mode.
		 * @param showDefaultContextMenu Whether show default context menu or not.
		 * @param stageFocusRect A Boolean that indicates if default focus rectangle if visible.
		 */
		public function Application ( 	frameRate : Number = 30 , align : String = StageAlign.TOP_LEFT , scaleMode : String = StageScaleMode.NO_SCALE , 
										showDefaultContextMenu : Boolean = false , stageFocusRect : Boolean = false )
		{
			if( STAGE != null )
			{
				APPLICATION_ROOT[ this ] = true;
				
				_run();
			}
			else
			{
				_frameRate = frameRate;
				_align = align;
				_scaleMode = scaleMode;
				_showDefaultContextMenu = showDefaultContextMenu;
				_stageFocusRect = stageFocusRect;
				
				addEventListener( Event.ADDED_TO_STAGE , _addedToStage , false , 0 , true );
			}
		}
		
		/**
		 * @private
		 */
		protected function _run(  ) : void
		{
			
		}
		
		/**
		 * 
		 */
		private function _addedToStage( e : Event ) : void
		{
			STAGE = stage;
			ROOT = this;
			APPLICATION_ROOT[ this ] = true;
			
			stage.frameRate = _frameRate;
			stage.align = _align;
			stage.scaleMode = _scaleMode;
			stage.showDefaultContextMenu = _showDefaultContextMenu;
			stage.stageFocusRect = _stageFocusRect;
			
			removeEventListener( Event.ADDED_TO_STAGE , _addedToStage );
				
			_run();
		}
	}
}
