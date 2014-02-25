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
	import myLib.assets.glossy.ErrorBoxAsset;
	import myLib.assets.glossy.FocusBoxAsset;
	import myLib.assets.glossy.ShapeAssetProp;
	import myLib.assets.glossy.TextureBoxAsset;
	import myLib.controls.Button;
	import myLib.controls.skins.ISliderSkin;


	/**
	 * @author SamYStudiO ( contact@samystudio.net )
	 */
	public class GlossySliderSkin extends AGlossyFieldSkin implements ISliderSkin
	{
		/**
		 * 
		 */
		public function GlossySliderSkin( mainColor : uint , alternativeColor : uint , stateColor : uint , cornerRadius : Number , shadowFilter : DropShadowFilter = null , innerShadowFilter : DropShadowFilter = null )
		{
			super( mainColor , alternativeColor , stateColor , cornerRadius , shadowFilter , innerShadowFilter );
		}

		/**
		 * @inheritDoc
		 */
		public override function getFocusRectAsset() : IAsset
		{
			return new FocusBoxAsset( new ShapeAssetProp( _mainColor , _alternativeColor , _stateColor , 0 ) );
		}
		
		/**
		 * @inheritDoc
		 */
		public override function getErrorRectAsset() : IAsset
		{
			return new ErrorBoxAsset( new ShapeAssetProp( _mainColor , _alternativeColor , _stateColor , 0 ) );
		}

		/**
		 * @inheritDoc
		 */
		public function getTrackAsset() : IAsset
		{
			var filter : DropShadowFilter = _innerShadowFilter != null ? _innerShadowFilter.clone() as DropShadowFilter : null;
			
			if( filter != null )
			{
				filter.blurX = 4;
				filter.blurY = 4;
			}
			
			return new TextureBoxAsset(new ShapeAssetProp( _mainColor , _alternativeColor , _stateColor , 0 , [ _shadowFilter , filter ] ) );
		}

		/**
		 * @inheritDoc
		 */
		public function getThumbAsset() : IAsset
		{
			return new Button( null , { text : "" , width : 30 , height : 30 } , new GlossySliderButtonSkin( _mainColor , _alternativeColor , _stateColor , _cornerRadius , _shadowFilter ) );
		}

		/**
		 * @inheritDoc
		 */
		public function getProgressAsset() : IAsset
		{
			var filter : DropShadowFilter = _innerShadowFilter != null ? _innerShadowFilter.clone() as DropShadowFilter : null;
			
			if( filter != null )
			{
				filter.blurX = 4;
				filter.blurY = 4;
			}
			
			return new BoxAsset( new ShapeAssetProp( _stateColor , _stateColor , _stateColor , 0 , [ filter] ) );
		}
	}
}
