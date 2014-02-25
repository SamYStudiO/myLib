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
 * Portions created by the Initial Developer are Copyright (C) 2008-2012
 * the Initial Developer. All Rights Reserved.
 *
 */
package myLib.controls.skins.flat
{
	import myLib.assets.IAsset;
	import myLib.assets.flat.BoxAsset;
	import myLib.assets.flat.ShapeAssetProp;
	import myLib.controls.skins.ITouchScrollSkin;

	/**
	 * @author SamYStudiO ( contact@samystudio.net )
	 */
	public class FlatTouchScrollSkin extends AFlatSkin implements ITouchScrollSkin
	{
		/**
		 * @private
		 */
		protected var _prop : ShapeAssetProp;
		
		/**
		 * 
		 */
		public function FlatTouchScrollSkin( prop : ShapeAssetProp )
		{
			super( );
			
			_prop = prop;
		}

		/**
		 * @inheritDoc
		 */
		public function getThumbAsset() : IAsset
		{
			var asset : IAsset = new BoxAsset( _prop );
			asset.width = 5;
			
			return asset;
		}
	}
}
