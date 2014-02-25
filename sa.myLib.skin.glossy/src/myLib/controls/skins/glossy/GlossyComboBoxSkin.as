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
	import myLib.assets.IAsset;
	import myLib.controls.Button;
	import myLib.controls.ComboBoxTransitionType;
	import myLib.controls.IList;
	import myLib.controls.ITextInput;
	import myLib.controls.List;
	import myLib.controls.TextInput;
	import myLib.controls.skins.IComboBoxSkin;

	import flash.filters.DropShadowFilter;

	/**
	 * @author SamYStudiO ( contact@samystudio.net )
	 */
	public class GlossyComboBoxSkin extends AGlossyFieldSkin implements IComboBoxSkin
	{
		/**
		 * 
		 */
		public function GlossyComboBoxSkin( mainColor : uint , alternativeColor : uint , stateColor : uint , cornerRadius : Number , shadowFilter : DropShadowFilter = null , innerShadowFilter : DropShadowFilter = null )
		{
			super( mainColor , alternativeColor , stateColor , cornerRadius , shadowFilter , innerShadowFilter );
		}

		/**
		 * @inheritDoc
		 */
		public function getBoxAsset() : IAsset
		{
			return new Button( null , null , new GlossyComboBoxBoxButtonSkin( _mainColor , _alternativeColor , _stateColor , _cornerRadius , _shadowFilter , _innerShadowFilter ) );
		}

		/**
		 * @inheritDoc
		 */
		public function getArrowButtonAsset() : IAsset
		{
			return null;
		}

		/**
		 * @inheritDoc
		 */
		public function getTextInputAsset() : ITextInput
		{
			var ti : TextInput = new TextInput(  );
			ti.backgroundAsset.visible = false;
			
			return ti;
		}

		/**
		 * @inheritDoc
		 */
		public function getListAsset() : IList
		{
			return new List( null , null , new GlossyComboBoxListSkin(	_mainColor , _alternativeColor , _stateColor , _cornerRadius , _shadowFilter , _innerShadowFilter ) );
		}
		/**
		 * @inheritDoc
		 */
		public override function getStyle() : Object
		{
			return { transitionType : ComboBoxTransitionType.ROLL };
		}
	}
}
