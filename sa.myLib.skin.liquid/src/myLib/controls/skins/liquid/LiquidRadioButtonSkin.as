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
	import myLib.assets.LiquidAsset;

	import flash.display.BitmapData;

	/**
	 * @author SamYStudiO ( contact@samystudio.net )
	 */
	public class LiquidRadioButtonSkin extends LiquidButtonSkin
	{
		/**
		 * 
		 */
		public function LiquidRadioButtonSkin( bitmapSheet : BitmapData , focusRectBitmapSheet : BitmapData = null )
		{
			super( null , bitmapSheet , focusRectBitmapSheet );
		}

		/**
		 * @inheritDoc
		 */
		public override function getUpAsset() : IAsset
		{
			return null;
		}

		/**
		 * @inheritDoc
		 */
		public override function getUpSelectedAsset() : IAsset
		{
			return null;
		}

		/**
		 * @inheritDoc
		 */
		public override function getOverAsset() : IAsset
		{
			return null;
		}

		/**
		 * @inheritDoc
		 */
		public override function getOverSelectedAsset() : IAsset
		{
			return null;
		}

		/**
		 * @inheritDoc
		 */
		public override function getDownAsset() : IAsset
		{
			return null;
		}

		/**
		 * @inheritDoc
		 */
		public override function getDownSelectedAsset() : IAsset
		{
			return null;
		}

		/**
		 * @inheritDoc
		 */
		public override function getDisabledAsset() : IAsset
		{
			return null;
		}

		/**
		 * @inheritDoc
		 */
		public override function getDisabledSelectedAsset() : IAsset
		{
			return null;
		}

		/**
		 * @inheritDoc
		 */
		public override function getIconUpAsset( ) : IAsset
		{
			if( _iconsBitmapSheet == null ) return null;
			
			var asset : LiquidAsset = new LiquidAsset( _iconsBitmapSheet );
			asset.state = 0;
			
			return asset;
		}

		/**
		 * @inheritDoc
		 */
		public override function getIconUpSelectedAsset( ) : IAsset
		{
			if( _iconsBitmapSheet == null ) return null;
			
			var asset : LiquidAsset = new LiquidAsset( _iconsBitmapSheet );
			asset.state = 4;
			
			return asset;
		}

		/**
		 * @inheritDoc
		 */
		public override function getIconOverAsset( ) : IAsset
		{
			if( _iconsBitmapSheet == null ) return null;
			
			var asset : LiquidAsset = new LiquidAsset( _iconsBitmapSheet );
			asset.state = 1;
			
			return asset;
		}

		/**
		 * @inheritDoc
		 */
		public override function getIconOverSelectedAsset( ) : IAsset
		{
			if( _iconsBitmapSheet == null ) return null;
			
			var asset : LiquidAsset = new LiquidAsset( _iconsBitmapSheet );
			asset.state = 5;
			
			return asset;
		}

		/**
		 * @inheritDoc
		 */
		public override function getIconDownAsset( ) : IAsset
		{
			if( _iconsBitmapSheet == null ) return null;
			
			var asset : LiquidAsset = new LiquidAsset( _iconsBitmapSheet );
			asset.state = 2;
			
			return asset;
		}

		/**
		 * @inheritDoc
		 */
		public override function getIconDownSelectedAsset( ) : IAsset
		{
			if( _iconsBitmapSheet == null ) return null;
			
			var asset : LiquidAsset = new LiquidAsset( _iconsBitmapSheet );
			asset.state = 6;
			
			return asset;
		}

		/**
		 * @inheritDoc
		 */
		public override function getIconDisabledAsset( ) : IAsset
		{
			if( _iconsBitmapSheet == null ) return null;
			
			var asset : LiquidAsset = new LiquidAsset(  _iconsBitmapSheet );
			asset.state = 3;
			
			return asset;
		}

		/**
		 * @inheritDoc
		 */
		public override function getIconDisabledSelectedAsset( ) : IAsset
		{
			if( _iconsBitmapSheet == null ) return null;
			
			var asset : LiquidAsset = new LiquidAsset( _iconsBitmapSheet );
			asset.state = 7;
			
			return asset;
		}
	}
}
