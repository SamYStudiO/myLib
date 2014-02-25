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
package myLib.controls.skins.liquid
{
	import myLib.controls.skins.IButtonSkin;
	import myLib.controls.skins.ICalendarSkin;
	import myLib.controls.skins.IColorPickerSkin;
	import myLib.controls.skins.IComboBoxSkin;
	import myLib.controls.skins.IComboBoxStepperSkin;
	import myLib.controls.skins.IDateFieldSkin;
	import myLib.controls.skins.ILabelSkin;
	import myLib.controls.skins.IListSkin;
	import myLib.controls.skins.IScrollBarSkin;
	import myLib.controls.skins.ISkinSet;
	import myLib.controls.skins.ISliderSkin;
	import myLib.controls.skins.IStepperSkin;
	import myLib.controls.skins.ITextAreaSkin;
	import myLib.controls.skins.ITextInputSkin;
	import myLib.controls.skins.ITouchScrollSkin;

	import flash.display.BitmapData;
	/**
	 * @author SamYStudiO ( contact@samystudio.net )
	 */
	public final class LiquidSkinSet implements ISkinSet
	{
		/**
		 * @private
		 */
		protected var _buttonSheet : BitmapData;
		
		/**
		 * @private
		 */
		protected var _checkBoxSheet : BitmapData;
		
		/**
		 * @private
		 */
		protected var _colorPickerSheet : BitmapData;
		
		/**
		 * @private
		 */
		protected var _comboBoxSheet : BitmapData;
		
		/**
		 * @private
		 */
		protected var _dateFieldSheet : BitmapData;
		
		/**
		 * @private
		 */
		protected var _labelSheet : BitmapData;
		
		/**
		 * @private
		 */
		protected var _listSheet : BitmapData;
		
		/**
		 * @private
		 */
		protected var _listCellSheet : BitmapData;
		
		/**
		 * @private
		 */
		protected var _radioButtonSheet : BitmapData;
		
		/**
		 * @private
		 */
		protected var _scrollBarArrowSheet : BitmapData;
		
		/**
		 * @private
		 */
		protected var _scrollBarThumbSheet : BitmapData;
		
		/**
		 * @private
		 */
		protected var _scrollBarTrackSheet : BitmapData;
		
		/**
		 * @private
		 */
		protected var _scrollBarIconsSheet : BitmapData;
		
		/**
		 * @private
		 */
		protected var _sliderSheet : BitmapData;
		
		/**
		 * @private
		 */
		protected var _stepperSheet : BitmapData;
		
		/**
		 * @private
		 */
		protected var _textInputSheet : BitmapData;
		
		/**
		 * @private
		 */
		protected var _textAreaSheet : BitmapData;
		
		/**
		 * @private
		 */
		protected var _touchScrollSheet : BitmapData;
		
		/**
		 * @private
		 */
		protected var _focusRectSheet : BitmapData;
		
		/**
		 *
		 */
		public function LiquidSkinSet( 	buttonSheet : BitmapData , checkBoxSheet : BitmapData , comboBoxSheet : BitmapData , 
										listSheet : BitmapData , listCellSheet : BitmapData , radioButtonSheet : BitmapData ,
										scrollBarArrowSheet : BitmapData , scrollBarIconsSheet : BitmapData , scrollBarTrackSheet : BitmapData , scrollBarThumbSheet : BitmapData ,
										textInputSheet : BitmapData , textAreaSheet : BitmapData , touchScrollSheet : BitmapData , focusRectSheet : BitmapData )
		{
			_buttonSheet = buttonSheet;
			_checkBoxSheet = checkBoxSheet;
			_comboBoxSheet = comboBoxSheet;
			_listSheet = listSheet;
			_listCellSheet = listCellSheet;
			_radioButtonSheet = radioButtonSheet;
			_scrollBarArrowSheet = scrollBarArrowSheet;
			_scrollBarIconsSheet = scrollBarIconsSheet;
			_scrollBarTrackSheet = scrollBarTrackSheet;
			_scrollBarThumbSheet = scrollBarThumbSheet;
			_textInputSheet = textInputSheet;
			_textAreaSheet = textAreaSheet;
			_touchScrollSheet = touchScrollSheet;
			_focusRectSheet = focusRectSheet;
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
			return new LiquidButtonSkin( _buttonSheet , null , _focusRectSheet );
		}

		/**
		 * @inheritDoc
		 */
		public function getCalendarSkin() : ICalendarSkin
		{
			return null;
		}

		/**
		 * @inheritDoc
		 */
		public function getCheckBoxSkin() : IButtonSkin
		{
			return new LiquidCheckBoxSkin( _checkBoxSheet , _focusRectSheet );
		}
		
		/**
		 * @inheritDoc
		 */
		public function getColorPickerSkin() : IColorPickerSkin
		{
			return null;
		}

		/**
		 * @inheritDoc
		 */
		public function getComboBoxSkin() : IComboBoxSkin
		{
			return new LiquidComboBoxSkin( _comboBoxSheet , getListSkin() as LiquidListSkin , _focusRectSheet );
		}

		/**
		 * @inheritDoc
		 */
		public function getComboBoxStepperSkin() : IComboBoxStepperSkin
		{
			return null;
		}

		/**
		 * @inheritDoc
		 */
		public function getDateFieldSkin() : IDateFieldSkin
		{
			return null;
		}

		/**
		 * @inheritDoc
		 */
		public function getLabelSkin() : ILabelSkin
		{
			return new LiquidLabelSkin();
		}

		/**
		 * @inheritDoc
		 */
		public function getListSkin() : IListSkin
		{
			return new LiquidListSkin( _listSheet , _listCellSheet , _focusRectSheet );
		}

		/**
		 * @inheritDoc
		 */
		public function getRadioButtonSkin() : IButtonSkin
		{
			return new LiquidRadioButtonSkin( _radioButtonSheet , _focusRectSheet );
		}

		/**
		 * @inheritDoc
		 */
		public function getScrollBarSkin() : IScrollBarSkin
		{
			return new LiquidScrollBarSkin( _scrollBarArrowSheet , _scrollBarThumbSheet , _scrollBarTrackSheet , _scrollBarIconsSheet );
		}

		/**
		 * @inheritDoc
		 */
		public function getSliderSkin() : ISliderSkin
		{
			return null;
		}

		/**
		 * @inheritDoc
		 */
		public function getStepperSkin() : IStepperSkin
		{
			return null;
		}

		/**
		 * @inheritDoc
		 */
		public function getTextAreaSkin() : ITextAreaSkin
		{
			return new LiquidTextAreaSkin( _textAreaSheet , null , _focusRectSheet );
		}

		/**
		 * @inheritDoc
		 */
		public function getTextInputSkin() : ITextInputSkin
		{
			return new LiquidTextInputSkin( _textInputSheet , null , _focusRectSheet );
		}
		
		/**
		 *
		 */
		public function getTouchScrollSkin(  ) : ITouchScrollSkin
		{
			return new LiquidTouchScrollSkin( _touchScrollSheet );
		}
	}
}
