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
 * Portions created by the Initial Developer are Copyright (C) 2008-2011
 * the Initial Developer. All Rights Reserved.
 *
 */
package myLib.controls.skins.original
{
	import myLib.controls.skins.IButtonSkin;
	import myLib.controls.skins.IColorPickerSkin;
	import myLib.controls.skins.IComboBoxSkin;
	import myLib.controls.skins.IComboBoxStepperSkin;
	import myLib.controls.skins.ILabelSkin;
	import myLib.controls.skins.IListSkin;
	import myLib.controls.skins.IScrollBarSkin;
	import myLib.controls.skins.ISkinSet;
	import myLib.controls.skins.ISliderSkin;
	import myLib.controls.skins.IStepperSkin;
	import myLib.controls.skins.ITextAreaSkin;
	import myLib.controls.skins.ITextInputSkin;
	import myLib.controls.skins.ITouchScrollSkin;

	/**
	 * @author SamYStudiO ( contact@samystudio.net )
	 */
	public class OriginalSkinSet implements ISkinSet
	{
		/**
		 *
		 */
		public function OriginalSkinSet(  )
		{
			
		}
		
		/**
		 * @inheritDoc
		 */
		public function getGlobalStyle() : Object
		{
			return null;
		}
		
		/**
		 * @inheritDoc
		 */
		public function getButtonSkin() : IButtonSkin
		{
			return new ButtonSkin( );
		}

		/**
		 * @inheritDoc
		 */
		public function getCheckBoxSkin() : IButtonSkin
		{
			return new CheckBoxSkin( );
		}

		/**
		 * @inheritDoc
		 */
		public function getColorPickerSkin() : IColorPickerSkin
		{
			return new ColorPickerSkin( );
		}

		/**
		 * @inheritDoc
		 */
		public function getComboBoxSkin() : IComboBoxSkin
		{
			return new ComboBoxSkin( );
		}

		/**
		 * @inheritDoc
		 */
		public function getComboBoxStepperSkin() : IComboBoxStepperSkin
		{
			return new ComboBoxStepperSkin( );
		}

		/**
		 * @inheritDoc
		 */
		public function getLabelSkin() : ILabelSkin
		{
			return new LabelSkin( );
		}

		/**
		 * @inheritDoc
		 */
		public function getListSkin() : IListSkin
		{
			return new ListSkin( );
		}

		/**
		 * @inheritDoc
		 */
		public function getRadioButtonSkin() : IButtonSkin
		{
			return new RadioButtonSkin( );
		}
		
		/**
		 * @inheritDoc
		 */
		public function getScrollBarSkin() : IScrollBarSkin
		{
			return new ScrollBarSkin(  );
		}

		/**
		 * @inheritDoc
		 */
		public function getSliderSkin() : ISliderSkin
		{
			return new SliderSkin( );
		}

		/**
		 * @inheritDoc
		 */
		public function getStepperSkin() : IStepperSkin
		{
			return new StepperSkin(  );
		}

		/**
		 * @inheritDoc
		 */
		public function getTextAreaSkin() : ITextAreaSkin
		{
			return new TextAreaSkin( );
		}

		/**
		 * @inheritDoc
		 */
		public function getTextInputSkin() : ITextInputSkin
		{
			return new TextInputSkin(  );
		}
		
		/**
		 * @inheritDoc
		 */
		public function getTouchScrollSkin() : ITouchScrollSkin
		{
			return new TouchScrollSkin(  );
		}
	}
}
