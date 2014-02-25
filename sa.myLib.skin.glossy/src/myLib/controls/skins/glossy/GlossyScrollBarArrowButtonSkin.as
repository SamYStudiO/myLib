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
	import flash.display.BitmapData;
	import flash.filters.DropShadowFilter;
	import myLib.assets.IAsset;
	import myLib.assets.ITextFieldAsset;
	import myLib.assets.glossy.ScrollBarArrowAsset;
	import myLib.assets.glossy.ShapeAssetProp;


	/**
	 * @author SamYStudiO ( contact@samystudio.net )
	 */
	public class GlossyScrollBarArrowButtonSkin extends GlossyButtonSkin
	{
		/**
		 * @private
		 */
		protected var _texturePattern : BitmapData;
		
		/**
		 * @private
		 */
		protected var _direction : String;
		
		/**
		 * 
		 */
		public function GlossyScrollBarArrowButtonSkin( texturePattern : BitmapData , direction : String , mainColor : uint , alternativeColor : uint , stateColor : uint , cornerRadius : Number , shadowFilter : DropShadowFilter = null , innerShadowFilter : DropShadowFilter = null )
		{
			super( mainColor , alternativeColor , stateColor , cornerRadius , shadowFilter , innerShadowFilter );
			
			_texturePattern = texturePattern;
			_direction = direction;
		}
		
		/**
		 * @inheritDoc
		 */
		public override function getTextFieldAsset() : ITextFieldAsset
		{
			return null;
		}
		
		/**
		 * @inheritDoc
		 */
		public override function getOverAsset() : IAsset
		{
			return new ScrollBarArrowAsset( _texturePattern , _direction , new ShapeAssetProp( _mainColor , _alternativeColor , _stateColor , _cornerRadius, [ _shadowFilter ] ) , true );
		}
		
		/**
		 * @inheritDoc
		 */
		public override function getDownAsset() : IAsset
		{
			return new ScrollBarArrowAsset( _texturePattern , _direction , new ShapeAssetProp( _mainColor , _alternativeColor , _stateColor , _cornerRadius, [ _shadowFilter ] ) , true );
		}
		
		/**
		 * @inheritDoc
		 */
		public override function getUpAsset() : IAsset
		{
			return new ScrollBarArrowAsset( _texturePattern , _direction , new ShapeAssetProp( _mainColor , _alternativeColor , _alternativeColor , _cornerRadius, [ _shadowFilter ] ) , false );
		}
	}
}
