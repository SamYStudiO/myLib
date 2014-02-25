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
	import myLib.controls.Button;
	import myLib.controls.IButton;
	import myLib.controls.skins.AFieldSkin;
	import myLib.controls.skins.IButtonSkin;
	import myLib.controls.skins.ISliderSkin;
	/**
	 * SliderSkin is the default skin for Slider component.
	 * Like all other components, default skin use string definition, BitmapData object or external URL to build assets.
	 * To use other values or for complexe skin make your own ISliderSkin implementation.
	 * 
	 * @see myLib.controls.Slider
	 * @see myLib.controls.skins.ISliderSkin
	 * @author SamYStudiO ( contact@samystudio.net )
	 */
	public class SliderSkin extends AFieldSkin implements ISliderSkin 
	{
		/**
		 * Get or set the IButtonSkin for track asset.
		 */
		public var trackSkin : IButtonSkin;
		
		/**
		 * Get or set the IButtonSkin for thumb asset.
		 */
		public var thumbSkin : IButtonSkin;
		
		/**
		 * Get or set the progress asset string definition, BitmapData object or external URL.
		 */
		public var progress : *;
		
		/**
		 * Get or set the initial style for track asset.
		 */
		public var trackInitStyle : Object;
		
		/**
		 * Get or set the initial style for thumb asset.
		 */
		public var thumbInitStyle : Object;
		
		/**
		 * Build a new SliderSkin instance.
		 * @param trackSkin The IButtonSkin for track asset.		 * @param thumbSkin The IButtonSkin for thumb asset.		 * @param progress The progress asset string definition, BitmapData object or external URL.
		 * @param focusRect The focus rectangle asset string definition, BitmapData object or external URL.		 * @param trackInitStyle The initial style for track asset.		 * @param thumbInitStyle The initial style for thumb asset.
		 */
		public function SliderSkin ( 	trackSkin : IButtonSkin = null , thumbSkin : IButtonSkin  = null , progress : * = null , focusRect : * = null , errorRect : * = null ,
										trackInitStyle : Object = null , thumbInitStyle : Object = null )
		{
			this.trackSkin = trackSkin || new ButtonSkin( null , SliderTrackUp , SliderTrackOver , SliderTrackDown , SliderTrackDisabled , null , null , null , null , null , null , null , null , null , null , null , null , null );			this.thumbSkin = thumbSkin || new ButtonSkin( null , SliderThumbUp , SliderThumbOver , SliderThumbDown , SliderThumbDisabled , null , null , null , null , null , null , null , null , null , null , null , null , null );			this.progress = progress == null ? SliderProgress : progress;			this.focusRect = focusRect == null ? SliderFocusRect : focusRect;
			this.errorRect = errorRect == null ? null : errorRect;
			
			if( thumbInitStyle != null ) thumbInitStyle.disabledDragOutState = true;
			
			this.trackInitStyle = trackInitStyle;			this.thumbInitStyle = thumbInitStyle || { disabledDragOutState : true };
		}
			
		/**
		 * @inheritDoc
		 */
		public function getTrackAsset(  ) : IAsset
		{
			return _getButton( trackSkin , trackInitStyle );
		}
		
		/**
		 * @inheritDoc
		 */
		public function getThumbAsset(  ) : IAsset
		{
			return _getButton( thumbSkin , thumbInitStyle );
		}
		
		/**
		 * @inheritDoc
		 */
		public function getProgressAsset(  ) : IAsset
		{
			return _getAsset( progress );
		}
		
		/**
		 * @private
		 */
		protected function _getButton( skin : IButtonSkin , initStyle : Object ) : IButton
		{
			return new Button( null , initStyle , skin );
		}
	}
}
