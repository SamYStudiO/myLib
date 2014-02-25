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
	import myLib.controls.skins.ASkin;		
	/**
	 * MediaPlayerSkin is the default skin that defines all assets needed with MediaPlayer component.
	 * 
	 * @author SamYStudiO
	 */
	public class MediaPlayerSkin extends ASkin implements IMediaPlayerSkin
	{
		/**
		 * Get or set the screen transition asset definition.
		 */
		public var screenTransition : String;
		
		/**
		 * Get or set the subtitles textfield asset definition.
		 */
		public var subTitleTextField : String;
		
		/**
		 * Build a new MediaPLayerSkin instance.
		 * 
		 * @param screenTransition The screen transition asset definition
		 */
		public function MediaPlayerSkin( screenTransition : String = "MediaPlayerScreenTransition" , subTitleTextField : String = "MediaPlayerSubTitleTextField" )
		{			this.screenTransition = screenTransition;			this.subTitleTextField = subTitleTextField;
		}
		
		/**
		 * @inheritDoc
		 */
		public function getScreenTransitionAsset(  ) : IMovieAsset
		{
			return _getAsset( screenTransition ) as IMovieAsset;
		}
		
		/**
		 * @inheritDoc
		 */
		public function getSubTitleTextFieldAsset (  ) : ITextFieldAsset
		{
			return _getTextFieldAsset( subTitleTextField );
		}
	}
}
