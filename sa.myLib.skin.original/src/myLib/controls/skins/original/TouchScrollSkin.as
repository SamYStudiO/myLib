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
package myLib.controls.skins.original
{
	import myLib.assets.IAsset;
	import myLib.controls.skins.ASkin;
	import myLib.controls.skins.ITouchScrollSkin;
	/**
	 * ScrollBarSkin is the default skin for ScrollBar component.
	 * Like all other components, default skin use string definition, BitmapData object or external URL to build assets.
	 * To use other values or for complexe skin make your own IScrollBarSkin implementation.
	 * 
	 * @see myLib.controls.ScrollBar
	 * @see myLib.controls.skins.IScrollBarSkin
	 * @author SamYStudiO ( contact@samystudio.net )
	 */
	public class TouchScrollSkin extends ASkin implements ITouchScrollSkin
	{
		/**
		 * Get or set the IButtonSkin for thumb asset.
		 */
		public var thumbSkin : *;
		/**
		 * Build a new ScrollBarSkin instance.
		 * @param upSkin The IButtonSkin for up asset.		 * @param downSkin The IButtonSkin for down asset.		 * @param thumbSkin The IButtonSkin for thumb asset.		 * @param thumbBackgroundSkin The IButtonSkin for thumb background asset.		 * @param upInitStyle The initial style for up asset.		 * @param downInitStyle The initial style for down asset.		 * @param thumbInitStyle The initial style for thumb asset.		 * @param thumbBackgroundInitStyle The initial style for thumb background asset.
		 */
		public function TouchScrollSkin ( thumbSkin : * = null )
		{
			this.thumbSkin = thumbSkin == null ? TouchScrollThumb : null;
		}
		
		/**
		 * @inheritDoc
		 */
		public function getThumbAsset(  ) : IAsset
		{
			return _getAsset( thumbSkin );
		}
	}
}