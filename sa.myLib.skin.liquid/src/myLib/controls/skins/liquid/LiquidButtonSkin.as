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
	import myLib.assets.IAsset;
	import myLib.assets.ITextFieldAsset;
	import myLib.assets.LiquidAsset;
	import myLib.assets.TextFieldAsset;
	import myLib.controls.skins.IButtonSkin;

	import flash.display.BitmapData;

	/**
	 * @author SamYStudiO ( contact@samystudio.net )
	 */
	public class LiquidButtonSkin extends ALiquidSkin implements IButtonSkin
	{
		/**
		 * @private
		 */
		protected var _bitmapSheet : BitmapData;
		
		/**
		 * @private
		 */
		protected var _iconsBitmapSheet : BitmapData;
		
		/**
		 * @private
		 */
		protected var _iconStateOffset : uint;
		
		/**
		 * @private
		 */
		protected var _noTextField : Boolean;
		
		/**
		 * 
		 */
		public function LiquidButtonSkin( bitmapSheet : BitmapData , iconsBitmapSheet : BitmapData = null , focusRectBitmapSheet : BitmapData = null , iconsStateOffset : uint = 0 , noTextFiField : Boolean = false )
		{
			super();
			
			_bitmapSheet = bitmapSheet;
			_iconsBitmapSheet = iconsBitmapSheet;
			_focusRectBitmapSheet = focusRectBitmapSheet;
			
			_iconStateOffset = iconsStateOffset;
			_noTextField = noTextFiField;
		}
		
		/**
		 * @inheritDoc
		 */
		public override function getStyle(  ) : Object
		{
			var colors : Array;
			
			if( _bitmapSheet != null ) colors = new LiquidAsset( _bitmapSheet ).colors;
			else if( _iconsBitmapSheet != null ) colors = new LiquidAsset( _iconsBitmapSheet ).colors;
			
			if( colors == null || colors.length == 0 ) return null;
			
			var o : Object = new Object();
			o.textColor = colors[ 0 ];
            o.overTextColor = colors[ 1 ] == null ? colors[ 0 ] : colors[ 1 ];
            o.downTextColor = colors[ 2 ] == null ? colors[ 0 ] : colors[ 2 ];
            o.disabledTextColor = colors[ 3 ] == null ? colors[ 0 ] : colors[ 3 ];
            o.selectedTextColor = colors[ 4 ] == null ? colors[ 0 ] : colors[ 4 ];
            o.overSelectedTextColor = colors[ 5 ] == null ? colors[ 0 ] : colors[ 5 ];
            o.downSelectedTextColor = colors[ 6 ] == null ? colors[ 0 ] : colors[ 6 ];
            o.disabledSelectedTextColor = colors[ 7 ] == null ? colors[ 0 ] : colors[ 7 ];
			
			return o;
		}

		/**
		 * @inheritDoc
		 */
		public function getTextFieldAsset() : ITextFieldAsset
		{
			return _noTextField ? null : new TextFieldAsset(  );
		}

		/**
		 * @inheritDoc
		 */
		public function getUpAsset() : IAsset
		{
			var asset : LiquidAsset = new LiquidAsset( _bitmapSheet );
			asset.state = 0;
			
			return asset;
		}

		/**
		 * @inheritDoc
		 */
		public function getUpSelectedAsset() : IAsset
		{
			var asset : LiquidAsset = new LiquidAsset( _bitmapSheet );
			asset.state = 4;
			
			return asset;
		}

		/**
		 * @inheritDoc
		 */
		public function getOverAsset() : IAsset
		{
			var asset : LiquidAsset = new LiquidAsset( _bitmapSheet );
			asset.state = 1;
			
			return asset;
		}

		/**
		 * @inheritDoc
		 */
		public function getOverSelectedAsset() : IAsset
		{
			var asset : LiquidAsset = new LiquidAsset( _bitmapSheet );
			asset.state = 5;
			
			return asset;
		}

		/**
		 * @inheritDoc
		 */
		public function getDownAsset() : IAsset
		{
			var asset : LiquidAsset = new LiquidAsset( _bitmapSheet );
			asset.state = 2;
			
			return asset;
		}

		/**
		 * @inheritDoc
		 */
		public function getDownSelectedAsset() : IAsset
		{
			var asset : LiquidAsset = new LiquidAsset( _bitmapSheet );
			asset.state = 6;
			
			return asset;
		}

		/**
		 * @inheritDoc
		 */
		public function getDisabledAsset() : IAsset
		{
			var asset : LiquidAsset = new LiquidAsset( _bitmapSheet );
			asset.state = 3;
			
			return asset;
		}

		/**
		 * @inheritDoc
		 */
		public function getDisabledSelectedAsset() : IAsset
		{
			var asset : LiquidAsset = new LiquidAsset( _bitmapSheet );
			asset.state = 7;
			
			return asset;
		}

		/**
		 * @inheritDoc
		 */
		public function getIconUpAsset( ) : IAsset
		{
			if( _iconsBitmapSheet == null ) return null;
			
			var asset : LiquidAsset = new LiquidAsset( _iconsBitmapSheet );
			asset.state = 0 + _iconStateOffset;
			
			return asset;
		}

		/**
		 * @inheritDoc
		 */
		public function getIconUpSelectedAsset( ) : IAsset
		{
			if( _iconsBitmapSheet == null ) return null;
			
			var asset : LiquidAsset = new LiquidAsset( _iconsBitmapSheet );
			asset.state = 4;
			
			return asset;
		}

		/**
		 * @inheritDoc
		 */
		public function getIconOverAsset( ) : IAsset
		{
			if( _iconsBitmapSheet == null ) return null;
			
			var asset : LiquidAsset = new LiquidAsset( _iconsBitmapSheet );
			asset.state = 1 + _iconStateOffset;
			
			return asset;
		}

		/**
		 * @inheritDoc
		 */
		public function getIconOverSelectedAsset( ) : IAsset
		{
			if( _iconsBitmapSheet == null ) return null;
			
			var asset : LiquidAsset = new LiquidAsset( _iconsBitmapSheet );
			asset.state = 5;
			
			return asset;
		}

		/**
		 * @inheritDoc
		 */
		public function getIconDownAsset( ) : IAsset
		{
			if( _iconsBitmapSheet == null ) return null;
			
			var asset : LiquidAsset = new LiquidAsset( _iconsBitmapSheet );
			asset.state = 2 + _iconStateOffset;
			
			return asset;
		}

		/**
		 * @inheritDoc
		 */
		public function getIconDownSelectedAsset( ) : IAsset
		{
			if( _iconsBitmapSheet == null ) return null;
			
			var asset : LiquidAsset = new LiquidAsset( _iconsBitmapSheet );
			asset.state = 6;
			
			return asset;
		}

		/**
		 * @inheritDoc
		 */
		public function getIconDisabledAsset( ) : IAsset
		{
			if( _iconsBitmapSheet == null ) return null;
			
			var asset : LiquidAsset = new LiquidAsset( _iconsBitmapSheet );
			asset.state = 3 + _iconStateOffset;
			
			return asset;
		}

		/**
		 * @inheritDoc
		 */
		public function getIconDisabledSelectedAsset( ) : IAsset
		{
			if( _iconsBitmapSheet == null ) return null;
			
			var asset : LiquidAsset = new LiquidAsset( _iconsBitmapSheet );
			asset.state = 7;
			
			return asset;
		}
	}
}
