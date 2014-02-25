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
	import myLib.controls.skins.ISkin;
	/**
	 * IMediaPlayerSkin defines all methods to build assets for a Mediaplayer component.
	 * 
	 * @author SamYStudiO
	 */
	public interface IMediaPlayerSkin extends ISkin
	{
		/**
		 * Get the IMovieAsset used to render screen transition.
		 * 
		 * @return The IMovieAsset used to render screen transition.
		 */
		function getScreenTransitionAsset() : IMovieAsset;
		
		/**
		 * Get the ITextFieldAsset used to render subtitle.
		 * 
		 * @return The ITextFieldAsset used to render subtitle TextField.
		 */
		function getSubTitleTextFieldAsset () : ITextFieldAsset;
	}
}
