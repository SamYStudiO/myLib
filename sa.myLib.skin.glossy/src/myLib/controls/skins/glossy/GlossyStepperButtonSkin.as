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
	import myLib.assets.glossy.ShapeAssetProp;
	import myLib.assets.glossy.StepperButtonAsset;
	import myLib.assets.glossy.getTexturePattern;


	/**
	 * @author SamYStudiO ( contact@samystudio.net )
	 */
	public class GlossyStepperButtonSkin extends GlossyButtonSkin
	{
		/**
		 * @private
		 */
		protected var _direction : String;
		/**
		 * 
		 */
		public function GlossyStepperButtonSkin(  direction : String , mainColor : uint , alternativeColor : uint , stateColor : uint , cornerRadius : Number , shadowFilter : DropShadowFilter = null , innerShadowFilter : DropShadowFilter = null )
		{
			super( mainColor , alternativeColor , stateColor , cornerRadius , shadowFilter , innerShadowFilter );
			
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
			return new StepperButtonAsset( getTexturePattern() , _direction , new ShapeAssetProp( _mainColor , _alternativeColor , _stateColor , _cornerRadius , [ _shadowFilter , _innerShadowFilter ] ) , true );
		}

		/**
		 * @inheritDoc
		 */
		public override function getDownAsset() : IAsset
		{
			return new StepperButtonAsset( getTexturePattern() , _direction , new ShapeAssetProp( _mainColor , _alternativeColor , _stateColor , _cornerRadius , [ _shadowFilter , _innerShadowFilter ] ) , true );
		}

		/**
		 * @inheritDoc
		 */
		public override function getDisabledAsset() : IAsset
		{
			return new StepperButtonAsset( getTexturePattern() , _direction , new ShapeAssetProp( _mainColor , _alternativeColor , _stateColor , _cornerRadius , [ _shadowFilter , _innerShadowFilter ] ) , false );
		}
		
		/**
		 * @inheritDoc
		 */
		public override function getUpAsset() : IAsset
		{
			return new StepperButtonAsset( getTexturePattern() , _direction , new ShapeAssetProp( _mainColor , _alternativeColor , _stateColor , _cornerRadius , [ _shadowFilter , _innerShadowFilter ] ) , false );
		}
	}
}
