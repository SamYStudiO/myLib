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
package myLib.controls.skins.glossy
{
	import flash.filters.DropShadowFilter;
	import myLib.assets.IAsset;
	import myLib.assets.glossy.BoxAsset;
	import myLib.assets.glossy.ShapeAssetProp;
	import myLib.controls.Button;
	import myLib.controls.ITextInput;
	import myLib.controls.TextInput;
	import myLib.controls.skins.IColorPickerSkin;


	/**
	 * @author SamYStudiO ( contact@samystudio.net )
	 */
	public class GlossyColorPickerSkin extends AGlossyFieldSkin implements IColorPickerSkin
	{
		/**
		 * 
		 */
		public function GlossyColorPickerSkin( mainColor : uint , alternativeColor : uint , stateColor : uint , cornerRadius : Number , shadowFilter : DropShadowFilter = null , innerShadowFilter : DropShadowFilter = null )
		{
			super( mainColor , alternativeColor , stateColor , cornerRadius , shadowFilter , innerShadowFilter );
		}
		
		/**
		 * @inheritDoc
		 */
		public function getButtonAsset() : IAsset
		{
			return new Button( null , { text : "" } , new GlossyColorPickerButtonSkin( _mainColor , _alternativeColor , _stateColor , _cornerRadius , _shadowFilter ) );
		}

		/**
		 * @inheritDoc
		 */
		public function getColorWellAsset() : IAsset
		{
			return new BoxAsset( new ShapeAssetProp( _mainColor , _alternativeColor , _stateColor , _cornerRadius , null ) );
		}

		/**
		 * @inheritDoc
		 */
		public function getPaletteBackgroundAsset() : IAsset
		{
			return new BoxAsset( new ShapeAssetProp( _mainColor , _alternativeColor , _stateColor , _cornerRadius , [ _shadowFilter ] ) );
		}

		/**
		 * @inheritDoc
		 */
		public function getPaletteColorWellAsset() : IAsset
		{
			var asset : IAsset = getColorWellAsset();
			
			asset.setSize( 60 , 30 ); 
			
			return asset;
		}

		/**
		 * @inheritDoc
		 */
		public function getPaletteColorWellBorderAsset() : IAsset
		{
			var filter : DropShadowFilter = _shadowFilter.clone() as DropShadowFilter;
			filter.inner = true;
			filter.knockout = true;
			var asset : BoxAsset = new BoxAsset( new ShapeAssetProp( _mainColor , _alternativeColor , _stateColor , _cornerRadius , [ filter ] ) );
			asset.setSize( 60 , 30 );
			
			return asset;
		}

		/**
		 * @inheritDoc
		 */
		public function getTextInputAsset() : ITextInput
		{
			return new TextInput( null , null , new GlossyTextInputSkin( _mainColor , _alternativeColor , _stateColor, _cornerRadius , null , _innerShadowFilter ) );
		}
	}
}
