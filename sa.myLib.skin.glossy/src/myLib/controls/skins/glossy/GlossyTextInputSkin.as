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
	import myLib.assets.ITextFieldAsset;
	import myLib.assets.TextFieldAsset;
	import myLib.assets.glossy.FocusBoxAsset;
	import myLib.assets.glossy.ShapeAssetProp;
	import myLib.assets.glossy.TextureBoxAsset;
	import myLib.controls.skins.ITextInputSkin;


	/**
	 * @author SamYStudiO ( contact@samystudio.net )
	 */
	public class GlossyTextInputSkin extends AGlossyFieldSkin implements ITextInputSkin
	{
		/**
		 * 
		 */
		public function GlossyTextInputSkin( mainColor : uint , alternativeColor : uint , stateColor : uint , cornerRadius : Number , shadowFilter : DropShadowFilter = null , innerShadowFilter : DropShadowFilter = null )
		{
			super( mainColor , alternativeColor , stateColor , cornerRadius , shadowFilter , innerShadowFilter );
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
			return new TextureBoxAsset( new ShapeAssetProp( _mainColor , _mainColor , _mainColor , _cornerRadius , [ _shadowFilter , _innerShadowFilter ] ) );
		}

		/**
		 * @inheritDoc
		 */
		public function getDisabledAsset() : IAsset
		{
			return new TextureBoxAsset( new ShapeAssetProp( _mainColor , _mainColor , _mainColor , _cornerRadius , [  _shadowFilter , _innerShadowFilter ] ) );
		}

		/**
		 * @inheritDoc
		 */
		public function getIconDisabledAsset( ) : IAsset
		{
			return null;
		}

		/**
		 * @inheritDoc
		 */
		public override function getFocusRectAsset() : IAsset
		{
			return new FocusBoxAsset( new ShapeAssetProp( _mainColor , _mainColor , _stateColor , _cornerRadius ) );
		}
	}
}
