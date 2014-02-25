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
	import myLib.controls.skins.IFieldSkin;
	import myLib.assets.IAsset;
	import myLib.assets.flat.BoxAsset;
	import myLib.assets.flat.ShapeAssetProp;
	import myLib.controls.skins.ASkin;

	/**
	 * @author SamYStudiO ( contact@samystudio.net )
	 */
	public class AFlatSkin extends ASkin implements IFieldSkin
	{
		/**
		 * @private
		 */
		protected var _focusProp : ShapeAssetProp;
		
		/**
		 * @private
		 */
		protected var _errorProp : ShapeAssetProp;
		
		/**
		 * 
		 */
		public function AFlatSkin( focusProp : ShapeAssetProp = null , errorProp : ShapeAssetProp = null )
		{
			super();
			
			_focusProp = focusProp;
			_errorProp = errorProp;
		}
		
		/**
		 * @inheritDoc
		 */
		public function getFocusRectAsset() : IAsset
		{
			return _focusProp == null ? null : new BoxAsset( _focusProp );
		}

		/**
		 * @inheritDoc
		 */
		public function getErrorRectAsset() : IAsset
		{
			return _errorProp == null ? null : new BoxAsset( _errorProp );
		}
		
		/**
		 * @inheritDoc
		 */
		public override function getStyle() : Object
		{
			return null;
		}
	}
}
