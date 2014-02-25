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
	import myLib.assets.glossy.ComboBoxListBoxAsset;
	import myLib.assets.glossy.ShapeAssetProp;
	import myLib.styles.Padding;


	/**
	 * @author SamYStudiO ( contact@samystudio.net )
	 */
	public class GlossyComboBoxListSkin extends GlossyListSkin
	{
		/**
		 * 
		 */
		public function GlossyComboBoxListSkin( mainColor : uint , alternativeColor : uint , stateColor : uint , cornerRadius : Number , shadowFilter : DropShadowFilter = null , innerShadowFilter : DropShadowFilter = null )
		{
			super( mainColor , alternativeColor , stateColor , cornerRadius , shadowFilter , innerShadowFilter );
		}
		
		/**
		 * @inheritDoc
		 */
		public override function getBackgroundAsset() : IAsset
		{
			return new ComboBoxListBoxAsset( new ShapeAssetProp( _mainColor , _alternativeColor , _stateColor , _cornerRadius , [ _shadowFilter ] ) );
		}

		/**
		 * @inheritDoc
		 */
		public override function getBackgroundDisabledAsset() : IAsset
		{
			return new ComboBoxListBoxAsset( new ShapeAssetProp( _mainColor , _alternativeColor , _stateColor , _cornerRadius , [ _shadowFilter ] ) );
		}

		/**
		 * @inheritDoc
		 */
		public override function getBorderAsset() : IAsset
		{
			var filter : DropShadowFilter = _innerShadowFilter.clone() as DropShadowFilter;
			filter.knockout = true;
			
			return new ComboBoxListBoxAsset( new ShapeAssetProp( _mainColor , _alternativeColor , _stateColor , _cornerRadius , [ filter ] ) );
		}

		/**
		 * @inheritDoc
		 */
		public override function getBorderDisabledAsset() : IAsset
		{
			var filter : DropShadowFilter = _innerShadowFilter.clone() as DropShadowFilter;
			filter.knockout = true;
			
			return new ComboBoxListBoxAsset( new ShapeAssetProp( _mainColor , _alternativeColor , _stateColor , _cornerRadius , [ filter ] ) );
		}
		
		/**
		 * @inheritDoc
		 */
		public override function getStyle() : Object
		{
			return { contentPadding : new Padding( 0 , 0 , 0 , 0 ) , borderThickness : 0 , cellHeight : 40 };
		}
	}
}
