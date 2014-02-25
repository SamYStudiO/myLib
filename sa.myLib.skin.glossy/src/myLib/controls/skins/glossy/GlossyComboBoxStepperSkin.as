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
	import myLib.controls.Button;
	import myLib.controls.skins.IComboBoxStepperSkin;


	/**
	 * @author SamYStudiO ( contact@samystudio.net )
	 */
	public class GlossyComboBoxStepperSkin extends GlossyComboBoxSkin implements IComboBoxStepperSkin
	{
		/**
		 * 
		 */
		public function GlossyComboBoxStepperSkin( mainColor : uint , alternativeColor : uint , stateColor : uint , cornerRadius : Number , shadowFilter : DropShadowFilter , innerShadowFilter : DropShadowFilter )
		{
			super( mainColor , alternativeColor , stateColor , cornerRadius , shadowFilter , innerShadowFilter );
		}
		
		/**
		 * @inheritDoc
		 */
		public override function getBoxAsset() : IAsset
		{
			return new Button( null , null , new GlossyComboBoxStepperBoxButtonSkin( _mainColor , _alternativeColor , _stateColor , _cornerRadius , _shadowFilter , _innerShadowFilter ) );
		}

		/**
		 * @inheritDoc
		 */
		public function getNextAsset() : IAsset
		{
			return new Button( null , { width : 40 } , new GlossyStepperButtonSkin( ArrowDirection.UP , _mainColor , _alternativeColor , _stateColor, _cornerRadius , _shadowFilter , _innerShadowFilter ) );
		}

		/**
		 * @inheritDoc
		 */
		public function getPreviousAsset() : IAsset
		{
			return new Button( null , { width : 40 } , new GlossyStepperButtonSkin( ArrowDirection.DOWN , _mainColor , _alternativeColor , _stateColor, _cornerRadius , _shadowFilter , _innerShadowFilter ) );
		}
	}
}
