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
	import myLib.assets.flat.BorderStyle;
	import myLib.assets.flat.BoxAsset;
	import myLib.assets.flat.ShapeAssetProp;
	import myLib.controls.Button;
	import myLib.controls.ITextInput;
	import myLib.controls.TextInput;
	import myLib.controls.skins.IColorPickerSkin;

	/**
	 * @author SamYStudiO ( contact@samystudio.net )
	 */
	public class FlatColorPickerSkin extends AFlatSkin implements IColorPickerSkin
	{
		/**
		 * @private
		 */
		protected var _upShapeProp : ShapeAssetProp;
		
		/**
		 * @private
		 */
		protected var _overShapeProp : ShapeAssetProp;
		
		/**
		 * @private
		 */
		protected var _downShapeProp : ShapeAssetProp;
		
		/**
		 * @private
		 */
		protected var _disabledProp : ShapeAssetProp;
		
		/**
		 * @private
		 */
		protected var _backgroundProp : ShapeAssetProp;
		
		/**
		 * @private
		 */
		protected var _inputProp : ShapeAssetProp;
		
		/**
		 * 
		 */
		public function FlatColorPickerSkin(  	upShapeProp : ShapeAssetProp , overShapeProp : ShapeAssetProp , downShapeProp : ShapeAssetProp , disabledProp : ShapeAssetProp ,
												backgroundProp : ShapeAssetProp , inputProp : ShapeAssetProp , focusProp : ShapeAssetProp , errorProp : ShapeAssetProp )
		{
			super( focusProp , errorProp );
			
			_upShapeProp = upShapeProp;
			_overShapeProp = overShapeProp;
			_downShapeProp = downShapeProp;
			_disabledProp = disabledProp;
			_backgroundProp = backgroundProp;
			_inputProp = inputProp;
		}
		
		/**
		 * @inheritDoc
		 */
		public override function getStyle() : Object
		{
			return { swatchBorderColor : _backgroundProp.borderColor };
		}

		/**
		 * @inheritDoc
		 */
		public function getButtonAsset() : IAsset
		{
			return new Button( null , { text : "" } , new FlatButtonSkin( 	_upShapeProp , _overShapeProp , _downShapeProp , _disabledProp ) );
		}

		/**
		 * @inheritDoc
		 */
		public function getColorWellAsset() : IAsset
		{
			var prop : ShapeAssetProp = _upShapeProp.clone();
			prop.color = 0x000000;
			prop.alpha = 1.0;
			prop.borderStyle = BorderStyle.NONE;
			
			return new BoxAsset( prop );
		}

		/**
		 * @inheritDoc
		 */
		public function getPaletteBackgroundAsset() : IAsset
		{
			return new BoxAsset( _backgroundProp );
		}

		/**
		 * @inheritDoc
		 */
		public function getPaletteColorWellAsset() : IAsset
		{
			var asset : IAsset = getColorWellAsset();
			asset.width = 20;
			asset.height = 20;
			
			return asset;
		}

		/**
		 * @inheritDoc
		 */
		public function getPaletteColorWellBorderAsset() : IAsset
		{
			var asset : IAsset = new BoxAsset( _upShapeProp );
			asset.width = 20;
			asset.height = 20;
			
			return asset;
		}

		/**
		 * @inheritDoc
		 */
		public function getTextInputAsset() : ITextInput
		{
			return new TextInput(  );
		}
	}
}
