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
	import myLib.assets.glossy.ArrowDirection;
	import myLib.assets.glossy.ScrollBarThumbBackgroundAsset;
	import myLib.assets.glossy.ShapeAssetProp;
	import myLib.controls.Button;
	import myLib.controls.skins.IScrollBarSkin;


	/**
	 * @author SamYStudiO ( contact@samystudio.net )
	 */
	public class GlossyInnerScrollBarSkin extends AGlossySkin implements IScrollBarSkin
	{
		/**
		 *
		 */
		public function GlossyInnerScrollBarSkin( mainColor : uint , alternativeColor : uint ,  stateColor : uint , cornerRadius : Number , shadowFilter : DropShadowFilter =null , innerShadowFilter : DropShadowFilter = null  ) : void
		{
			super( mainColor , alternativeColor ,  stateColor , cornerRadius , shadowFilter , innerShadowFilter );
		}
		
		/**
		 * @inheritDoc
		 */
		public function getUpAsset() : IAsset
		{
			return new Button( null , { text : "" , height : 40 } , new GlossyScrollBarArrowButtonSkin( null , ArrowDirection.UP , _mainColor , _alternativeColor , _stateColor, _cornerRadius, _shadowFilter ) );
		}

		/**
		 * @inheritDoc
		 */
		public function getDownAsset() : IAsset
		{
			return new Button( null , { text : "" , height : 40 } , new GlossyScrollBarArrowButtonSkin( null , ArrowDirection.DOWN , _mainColor , _alternativeColor , _stateColor, _cornerRadius, _shadowFilter ) );
		}

		/**
		 * @inheritDoc
		 */
		public function getThumbAsset() : IAsset
		{
			return new Button( null , { text : "", disabledDragOutState  : true } , new GlossyScrollBarThumbButtonSkin( _mainColor , _alternativeColor , _stateColor, _cornerRadius, _shadowFilter ) );
		}

		/**
		 * @inheritDoc
		 */
		public function getThumbBackgroundAsset() : IAsset
		{
			return new ScrollBarThumbBackgroundAsset( null , new ShapeAssetProp( _alternativeColor , _alternativeColor , _alternativeColor , 0 , [ _shadowFilter ] ) );
		}

		/**
		 * @inheritDoc
		 */
		public override function getStyle() : Object
		{
			return { width : 40 };
		}
	}
}
