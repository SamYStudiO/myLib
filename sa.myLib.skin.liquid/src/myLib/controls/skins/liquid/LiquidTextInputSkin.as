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
package myLib.controls.skins.liquid
{
	import myLib.assets.IAsset;
	import myLib.assets.ITextFieldAsset;
	import myLib.assets.LiquidAsset;
	import myLib.assets.TextFieldAsset;
	import myLib.controls.skins.ITextInputSkin;

	import flash.display.BitmapData;
	/**
	 * TextInputSkin is the default skin for TextInput component.
	 * Like all other components, default skin use string definition, BitmapData object or external URL to build assets.
	 * To use other values or for complexe skin make your own ITextInputSkin implementation.
	 * 
	 * @see myLib.controls.TextInput
	 * @see myLib.controls.skins.ITextInputSkin
	 * @author SamYStudiO ( contact@samystudio.net )
	 */
	public class LiquidTextInputSkin extends ALiquidSkin implements ITextInputSkin
	{
		/**
		 * @private
		 */
		protected var _backgroundBitmapSheet : BitmapData;
		
		/**
		 * @private
		 */
		protected var _iconBitmapSheet : BitmapData;
		
		/**
		 * 
		 */
		public function LiquidTextInputSkin ( bitmapSheet : BitmapData = null , iconBitmapSheet : BitmapData = null , focusRectBitmapSheet : BitmapData = null )
		{
			_backgroundBitmapSheet = bitmapSheet;
			_iconBitmapSheet = iconBitmapSheet;
			_focusRectBitmapSheet = focusRectBitmapSheet;
		}
		
		/**
		 * @inheritDoc
		 */
		public override function getStyle(  ) : Object
		{
			var colors : Array;
			var asset : LiquidAsset = _backgroundBitmapSheet != null ? new LiquidAsset( _backgroundBitmapSheet ) : null;
			
			if( asset != null ) colors = asset.colors;
			if( colors == null || colors.length == 0 ) return null;
			
			var o : Object = new Object();
			o.textColor = colors[ 0 ];
			o.disabledTextColor = colors[ 1 ] == null ? colors[ 0 ] : colors[ 1 ];
			
			return o;
		}
		

		/**
		 * @inheritDoc
		 */
		public function getTextFieldAsset() : ITextFieldAsset
		{
			return new TextFieldAsset(  );
		}

		/**
		 * @inheritDoc
		 */
		public function getUpAsset(  ) : IAsset
		{
			var asset : LiquidAsset = _backgroundBitmapSheet != null ? new LiquidAsset( _backgroundBitmapSheet ) : null;
			
			if( asset != null ) asset.state = 0;
			
			return asset;
		}

		/**
		 * @inheritDoc
		 */
		public function getDisabledAsset(  ) : IAsset
		{
			var asset : LiquidAsset = _backgroundBitmapSheet != null ? new LiquidAsset( _backgroundBitmapSheet ) : null;
			
			if( asset != null ) asset.state = 1;
			
			return asset;
		}
		
		/**
		 * @inheritDoc
		 */
		public function getIconUpAsset( ) : IAsset
		{
			var asset : LiquidAsset = _iconBitmapSheet != null ? new LiquidAsset( _iconBitmapSheet ) : null;
			
			if( asset != null ) asset.state = 0;
			
			return asset;
		}
		
		/**
		 * @inheritDoc
		 */
		public function getIconDisabledAsset( ) : IAsset
		{
			var asset : LiquidAsset = _iconBitmapSheet != null ? new LiquidAsset( _iconBitmapSheet ) : null;
			
			if( asset != null ) asset.state = 0;
			
			return asset;
		}
	}
}
