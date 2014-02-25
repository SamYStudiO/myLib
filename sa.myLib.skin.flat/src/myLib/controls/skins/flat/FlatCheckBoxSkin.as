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
package myLib.controls.skins.flat
{
	import myLib.assets.IAsset;
	import myLib.assets.flat.CheckBoxIconAsset;
	import myLib.assets.flat.ShapeAssetProp;

	/**
	 * @author SamYStudiO ( contact@samystudio.net )
	 */
	public class FlatCheckBoxSkin extends FlatButtonSkin
	{
		/**
		 * @private
		 */
		protected var _iconSize : Number;
		
		/**
		 * @private
		 */
		protected var _iconProp : ShapeAssetProp;
		
		/**
		 * @private
		 */
		protected var _iconSelectedProp : ShapeAssetProp;
		
		/**
		 * 
		 */
		public function FlatCheckBoxSkin( iconSize : Number , iconProp : ShapeAssetProp , iconSelectedProp : ShapeAssetProp , focusProp : ShapeAssetProp = null , errorProp : ShapeAssetProp = null )
		{
			super( null , null , null , null , null , null , null , null , focusProp , errorProp );
		
			_iconSize = iconSize;
			_iconProp = iconProp;
			_iconSelectedProp = iconSelectedProp;
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
			return new CheckBoxIconAsset( _iconSize , _iconProp );
		}

		/**
		 * @inheritDoc
		 */
		public override function getIconUpSelectedAsset( ) : IAsset
		{
			return new CheckBoxIconAsset( _iconSize , _iconSelectedProp );
		}

		/**
		 * @inheritDoc
		 */
		public override function getIconOverAsset( ) : IAsset
		{
			return new CheckBoxIconAsset( _iconSize , _iconProp );
		}

		/**
		 * @inheritDoc
		 */
		public override function getIconOverSelectedAsset( ) : IAsset
		{
			return new CheckBoxIconAsset( _iconSize , _iconSelectedProp );
		}

		/**
		 * @inheritDoc
		 */
		public override function getIconDownAsset( ) : IAsset
		{
			return new CheckBoxIconAsset( _iconSize , _iconProp );
		}

		/**
		 * @inheritDoc
		 */
		public override function getIconDownSelectedAsset( ) : IAsset
		{
			return new CheckBoxIconAsset( _iconSize , _iconSelectedProp );
		}

		/**
		 * @inheritDoc
		 */
		public override function getIconDisabledAsset( ) : IAsset
		{
			return new CheckBoxIconAsset( _iconSize , _iconProp );
		}

		/**
		 * @inheritDoc
		 */
		public override function getIconDisabledSelectedAsset( ) : IAsset
		{
			return new CheckBoxIconAsset( _iconSize , _iconSelectedProp );
		}
	}
}
