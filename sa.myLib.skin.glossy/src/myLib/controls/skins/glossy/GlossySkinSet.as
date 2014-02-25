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
package myLib.controls.skins.glossy
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
	import myLib.styles.Padding;
	import myLib.styles.TextStyle;

	import flash.filters.DropShadowFilter;
	import flash.text.TextFormat;

	/**
	 * @author SamYStudiO ( contact@samystudio.net )
	 */
	public class GlossySkinSet implements ISkinSet
	{
		/**
		 * @private
		 */
		protected var _iconSize : Number;
		
		/**
		 * @private
		 */
		protected var _defaultLargeSize : Number;
		
		/**
		 * @private
		 */
		protected var _defaultShortSize : Number;
		
		/**
		 * @private
		 */
		protected var _textColor : uint;
		
		/**
		 * @private
		 */
		protected var _mainColor : uint;
		
		/**
		 * @private
		 */
		protected var _alternativeColor : uint;
		
		/**
		 * @private
		 */
		protected var _stateColor : uint;
		
		/**
		 * @private
		 */
		protected var _errorColor : uint;
		
		/**
		 * @private
		 */
		protected var _cornerRadius : Number;
		
		/**
		 * @private
		 */
		protected var _shadowFilter : DropShadowFilter;
		
		/**
		 * @private
		 */
		protected var _innerShadowFilter : DropShadowFilter;
		
		/**
		 *
		 */
		public function GlossySkinSet( 	iconSize : Number = 40 , defaultLargeSize : Number = 200 , defaultShortSize : Number = 40 , textColor : uint = 0x333333 ,
										mainColor : uint = 0xFFFFFF , alternativeColor : uint = 0xC8C8C8 , stateColor : uint = 0xFF9000 , errorColor : uint = 0xCC0000 ,
										cornerRadius : Number = 10 , shadowFilter : DropShadowFilter = null , innerShadowFilter : DropShadowFilter = null )
		{
			
			_iconSize = iconSize;
			_defaultLargeSize = defaultLargeSize;
			_defaultShortSize = defaultShortSize;
			_textColor = textColor;
			_mainColor = mainColor;
			_alternativeColor = alternativeColor;
			_stateColor = stateColor;
			_errorColor = errorColor;
			_cornerRadius = cornerRadius;
			_shadowFilter = shadowFilter == null ? new DropShadowFilter( 0 ,  0 , 0x000000 , .7 , 4 , 4 , 1 , 2 ) : shadowFilter.blurX > 0 || shadowFilter.blurY > 0 ? shadowFilter : null;
			_innerShadowFilter = innerShadowFilter == null ? new DropShadowFilter( 5 ,  45 , 0x000000 , .7 , 8 , 8 , 1 , 2 , true ) : innerShadowFilter.blurX > 0 || innerShadowFilter.blurY > 0 ? innerShadowFilter : null;
		}
		
		/**
		 * @inheritDoc
		 */
		public function getGlobalStyle() : Object
		{
			return { padding : new Padding( 5 , 5 , 5 , 5 ) , focusRectPadding : new Padding( 0 , 0 , 0 , 0 ) , textStyle : new TextStyle( new TextFormat( null , 15 , _textColor, true ) ) };
		}
		
		/**
		 * @inheritDoc
		 */
		public function getButtonSkin() : IButtonSkin
		{
			return new GlossyButtonSkin( _mainColor , _alternativeColor , _stateColor  , _cornerRadius , _shadowFilter );
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
			return new GlossyCheckBoxSkin( _iconSize , _mainColor , _alternativeColor , _stateColor, _cornerRadius , _shadowFilter , _innerShadowFilter );
		}

		/**
		 * @inheritDoc
		 */
		public function getColorPickerSkin() : IColorPickerSkin
		{
			return new GlossyColorPickerSkin( _mainColor , _alternativeColor , _stateColor, _cornerRadius , _shadowFilter , _innerShadowFilter );
		}

		/**
		 * @inheritDoc
		 */
		public function getComboBoxSkin() : IComboBoxSkin
		{
			return new GlossyComboBoxSkin( _mainColor , _alternativeColor , _stateColor , _cornerRadius , _shadowFilter, _innerShadowFilter );
		}

		/**
		 * @inheritDoc
		 */
		public function getComboBoxStepperSkin() : IComboBoxStepperSkin
		{
			return new GlossyComboBoxStepperSkin( _mainColor , _alternativeColor , _stateColor , _cornerRadius , _shadowFilter, _innerShadowFilter );
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
			return new GlossyLabelSkin( _mainColor , _alternativeColor , _stateColor , _cornerRadius , _shadowFilter, _innerShadowFilter );
		}

		/**
		 * @inheritDoc
		 */
		public function getListSkin() : IListSkin
		{
			return new GlossyListSkin( _mainColor , _alternativeColor , _stateColor , _cornerRadius , _shadowFilter, _innerShadowFilter );
		}

		/**
		 * @inheritDoc
		 */
		public function getRadioButtonSkin() : IButtonSkin
		{
			return new GlossyRadioButtonSkin( _iconSize , _mainColor , _alternativeColor , _stateColor, _shadowFilter , _innerShadowFilter );
		}
		
		/**
		 * @inheritDoc
		 */
		public function getScrollBarSkin() : IScrollBarSkin
		{
			return new GlossyScrollBarSkin( _mainColor , _alternativeColor , _stateColor , _cornerRadius, _shadowFilter );
		}

		/**
		 * @inheritDoc
		 */
		public function getSliderSkin() : ISliderSkin
		{
			return new GlossySliderSkin( _mainColor , _alternativeColor , _stateColor , _cornerRadius, _shadowFilter , _innerShadowFilter );
		}

		/**
		 * @inheritDoc
		 */
		public function getStepperSkin() : IStepperSkin
		{
			return new GlossyStepperSkin( _mainColor , _alternativeColor , _stateColor , _cornerRadius, _shadowFilter , _innerShadowFilter );
		}

		/**
		 * @inheritDoc
		 */
		public function getTextAreaSkin() : ITextAreaSkin
		{
			return new GlossyTextAreaSkin( _mainColor , _alternativeColor , _stateColor , _cornerRadius , _shadowFilter , _innerShadowFilter );
		}

		/**
		 * @inheritDoc
		 */
		public function getTextInputSkin() : ITextInputSkin
		{
			return new GlossyTextInputSkin( _mainColor , _alternativeColor , _stateColor , _cornerRadius , _shadowFilter , _innerShadowFilter );
		}
		
		/**
		 * @inheritDoc
		 */
		public function getTouchScrollSkin() : ITouchScrollSkin
		{
			return new GlossyTouchScrollSkin( _mainColor , _alternativeColor , _stateColor , _cornerRadius , _shadowFilter , _innerShadowFilter );
		}
	}
}
