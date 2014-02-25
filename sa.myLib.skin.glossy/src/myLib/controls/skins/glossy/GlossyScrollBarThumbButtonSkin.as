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
	import myLib.assets.glossy.ScrollBarThumbAsset;
	import myLib.assets.glossy.ShapeAssetProp;


	/**
	 * @author SamYStudiO ( contact@samystudio.net )
	 */
	public class GlossyScrollBarThumbButtonSkin extends GlossyButtonSkin
	{
		/**
		 * 
		 */
		public function GlossyScrollBarThumbButtonSkin( mainColor : uint , alternativeColor : uint , stateColor : uint , cornerRadius : Number , shadowFilter : DropShadowFilter = null , innerShadowFilter : DropShadowFilter = null )
		{
			super( mainColor , alternativeColor , stateColor , cornerRadius , shadowFilter , innerShadowFilter );
		}
		
		/**
		 * @inheritDoc
		 */
		public override function getOverAsset() : IAsset
		{
			return new ScrollBarThumbAsset( new ShapeAssetProp( _stateColor , _stateColor , _stateColor , _cornerRadius, [ _shadowFilter ] ) );
		}
		
		/**
		 * @inheritDoc
		 */
		public override function getDownAsset() : IAsset
		{
			return new ScrollBarThumbAsset( new ShapeAssetProp( _stateColor , _stateColor , _stateColor , _cornerRadius, [ _shadowFilter ] ) );
		}
		
		/**
		 * @inheritDoc
		 */
		public override function getUpAsset() : IAsset
		{
			return new ScrollBarThumbAsset( new ShapeAssetProp( _mainColor , _mainColor , _mainColor , _cornerRadius, [ _shadowFilter ] ) );
		}
	}
}