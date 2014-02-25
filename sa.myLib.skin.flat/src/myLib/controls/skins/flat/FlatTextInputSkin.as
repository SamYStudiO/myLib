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
	import myLib.assets.ITextFieldAsset;
	import myLib.assets.TextFieldAsset;
	import myLib.assets.flat.BoxAsset;
	import myLib.assets.flat.ShapeAssetProp;
	import myLib.controls.skins.ITextInputSkin;

	/**
	 * @author SamYStudiO ( contact@samystudio.net )
	 */
	public class FlatTextInputSkin extends AFlatSkin implements ITextInputSkin
	{
		/**
		 * @private
		 */
		protected var _inputProp : ShapeAssetProp;
		
		/**
		 * 
		 */
		public function FlatTextInputSkin( inputProp : ShapeAssetProp , focusProp : ShapeAssetProp = null , errorProp : ShapeAssetProp = null )
		{
			super( focusProp , errorProp );
			
			_inputProp = inputProp;
		}

		/**
		 * @inheritDoc
		 */
		public function getTextFieldAsset() : ITextFieldAsset
		{
			return new TextFieldAsset();
		}

		/**
		 * @inheritDoc
		 */
		public function getIconUpAsset( ) : IAsset
		{
			return null;
		}

		/**
		 * @inheritDoc
		 */
		public function getUpAsset() : IAsset
		{
			return new BoxAsset( _inputProp );
		}

		/**
		 * @inheritDoc
		 */
		public function getDisabledAsset() : IAsset
		{
			return new BoxAsset( _inputProp );
		}

		/**
		 * @inheritDoc
		 */
		public function getIconDisabledAsset( ) : IAsset
		{
			return null;
		}
	}
}
