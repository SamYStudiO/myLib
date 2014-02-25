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
package myLib.controls.skins.liquid
{
	import myLib.controls.Button;
	import flash.display.BitmapData;
	import myLib.controls.skins.liquid.ALiquidSkin;
	import myLib.controls.skins.IScrollBarSkin;
	import myLib.assets.IAsset;

	/**
	 * @author SamYStudiO ( contact@samystudio.net )
	 */
	public class LiquidScrollBarSkin extends ALiquidSkin implements IScrollBarSkin
	{
		/**
		 * @private
		 */
		protected var _arrowBitmapSheet : BitmapData;
		
		/**
		 * @private
		 */
		protected var _thumbBitmapSheet : BitmapData;
		
		/**
		 * @private
		 */
		protected var _trackBitmapSheet : BitmapData;
		
		/**
		 * @private
		 */
		protected var _iconsBitmapSheet : BitmapData;
		
		/**
		 * 
		 */
		public function LiquidScrollBarSkin( arrowBitmapSheet : BitmapData , thumbBitmapSheet : BitmapData , trackBitmapSheet : BitmapData , iconsBitmapSheet : BitmapData )
		{
			super();
			
			_arrowBitmapSheet = arrowBitmapSheet;
			_thumbBitmapSheet = thumbBitmapSheet;
			_trackBitmapSheet = trackBitmapSheet;
			_iconsBitmapSheet = iconsBitmapSheet;
		}

		/**
		 * @inheritDoc
		 */
		public function getUpAsset() : IAsset
		{
			return new Button( null , { disabledDragOverState : true } , new LiquidButtonSkin( _arrowBitmapSheet , _iconsBitmapSheet , null , 4 , true ) );
		}

		/**
		 * @inheritDoc
		 */
		public function getDownAsset() : IAsset
		{
			return new Button( null , { disabledDragOverState : true } , new LiquidButtonSkin( _arrowBitmapSheet , _iconsBitmapSheet , null , 8 , true ) );
		}

		/**
		 * @inheritDoc
		 */
		public function getThumbAsset() : IAsset
		{
			return new Button( null , { disabledDragOverState : true , disabledDragOutState : true } , new LiquidButtonSkin( _thumbBitmapSheet , _iconsBitmapSheet , null , 0 , true ) );
		}

		/**
		 * @inheritDoc
		 */
		public function getThumbBackgroundAsset() : IAsset
		{
			return new Button( null , { disabledDragOverState : true , disabledDragOutState : true } , new LiquidButtonSkin( _trackBitmapSheet , null , null , 0 , true ) );
		}
	}
}
