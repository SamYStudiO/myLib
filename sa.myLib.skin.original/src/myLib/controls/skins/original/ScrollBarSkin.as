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
	import myLib.controls.skins.ASkin;
	import myLib.controls.skins.IButtonSkin;
	import myLib.controls.skins.IScrollBarSkin;
	/**
	 * ScrollBarSkin is the default skin for ScrollBar component.
	 * Like all other components, default skin use string definition, BitmapData object or external URL to build assets.
	 * To use other values or for complexe skin make your own IScrollBarSkin implementation.
	 * 
	 * @see myLib.controls.ScrollBar
	 * @see myLib.controls.skins.IScrollBarSkin
	 * @author SamYStudiO ( contact@samystudio.net )
	 */
	public class ScrollBarSkin extends ASkin implements IScrollBarSkin
	{
		/**
		 * Get or set the IButtonSkin for up asset.
		 */
		public var upSkin : IButtonSkin;

		/**
		 * Get or set the IButtonSkin for down asset.
		 */
		public var downSkin : IButtonSkin;
		
		/**
		 * Get or set the IButtonSkin for thumb asset.
		 */
		public var thumbSkin : IButtonSkin;
		
		/**
		 * Get or set the IButtonSkin for thumb background asset.
		 */
		public var thumbBackgroundSkin : IButtonSkin;
		
		/**
		 * Get or set the initial style for up asset.
		 */
		public var upInitStyle : Object;

		/**
		 * Get or set the initial style for down asset.
		 */
		public var downInitStyle : Object;
		
		/**
		 * Get or set the initial style for thumb asset.
		 */
		public var thumbInitStyle : Object;
		
		/**
		 * Get or set the initial style for thumb background asset.
		 */
		public var thumbBackgroundInitStyle : Object;
		
		/**
		 * Build a new ScrollBarSkin instance.
		 * @param upSkin The IButtonSkin for up asset.		 * @param downSkin The IButtonSkin for down asset.		 * @param thumbSkin The IButtonSkin for thumb asset.		 * @param thumbBackgroundSkin The IButtonSkin for thumb background asset.		 * @param upInitStyle The initial style for up asset.		 * @param downInitStyle The initial style for down asset.		 * @param thumbInitStyle The initial style for thumb asset.		 * @param thumbBackgroundInitStyle The initial style for thumb background asset.
		 */
		public function ScrollBarSkin (	upSkin : IButtonSkin = null , downSkin : IButtonSkin = null , thumbSkin : IButtonSkin = null , thumbBackgroundSkin : IButtonSkin = null ,
										upInitStyle : Object = null , downInitStyle : Object = null , thumbInitStyle : Object = null , thumbBackgroundInitStyle : Object = null )
		{
			this.upSkin = upSkin || new ButtonSkin( null , 	ScrollBarUpUp , ScrollBarUpOver , ScrollBarUpDown , ScrollBarUpDisabled , null , null , null , null , null ,
															ScrollBarUpIconUp , ScrollBarUpIconOver , ScrollBarUpIconDown , ScrollBarUpIconDisabled , null , null , null , null );			this.downSkin = downSkin || new ButtonSkin( null , 	ScrollBarDownUp , ScrollBarDownOver , ScrollBarDownDown , ScrollBarDownDisabled , null , null , null , null , null ,
																ScrollBarDownIconUp , ScrollBarDownIconOver , ScrollBarDownIconDown , ScrollBarDownIconDisabled , null , null , null , null );			this.thumbSkin = thumbSkin || new ButtonSkin( 	null , 	ScrollBarThumbUp , ScrollBarThumbOver , ScrollBarThumbDown , null , null , null , null , null , null ,
																	ScrollBarThumbIconUp , ScrollBarThumbIconOver , ScrollBarThumbIconDown , null , null , null , null , null );			this.thumbBackgroundSkin = thumbBackgroundSkin || new ButtonSkin( 	null , ScrollBarThumbBackgroundUp , ScrollBarThumbBackgroundOver , ScrollBarThumbBackgroundDown , ScrollBarThumbBackgroundDisabled , null , null , null , null , null , null , null , null , null , null , null , null , null );
			
			if( thumbInitStyle != null ) thumbInitStyle.disabledDragOverState = true;
			if( upInitStyle != null ) upInitStyle.disabledDragOverState = true;			if( downInitStyle != null )
			{
				downInitStyle.disabledDragOverState = true;
				downInitStyle.disabledDragOutState = true;			}
			if( thumbBackgroundInitStyle != null )
			{
				thumbBackgroundInitStyle.disabledDragOverState = true;
				thumbBackgroundInitStyle.disabledDragOutState = true;
			}
			
			this.upInitStyle = upInitStyle || { disabledDragOverState : true };
			this.downInitStyle = downInitStyle || { disabledDragOverState : true };
			this.thumbInitStyle = thumbInitStyle || { disabledDragOverState : true , disabledDragOutState : true };
			this.thumbBackgroundInitStyle = thumbBackgroundInitStyle || { disabledDragOverState : true , disabledDragOutState : true };
		}
		
		/**
		 * @inheritDoc
		 */
		public function getUpAsset(  ) : IAsset
		{
			return _getButton( upSkin , upInitStyle );
		}
		
		/**
		 * @inheritDoc
		 */
		public function getDownAsset(  ) : IAsset
		{
			return _getButton( downSkin , downInitStyle );
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
		public function getThumbBackgroundAsset(  ) : IAsset
		{
			return _getButton( thumbBackgroundSkin , thumbBackgroundInitStyle );
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