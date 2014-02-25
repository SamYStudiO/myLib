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
package myLib.controls.skins.flat
{
	import flash.filters.DropShadowFilter;
	import flash.text.TextFormat;
	import myLib.assets.flat.BorderStyle;
	import myLib.assets.flat.ShapeAssetProp;
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
	import myLib.styles.Padding;
	import myLib.styles.TextStyle;


	/**
	 * @author SamYStudiO ( contact@samystudio.net )
	 */
	public class FlatSkinSet implements ISkinSet
	{
		/**
		 * @private
		 */
		protected var _textColor : uint;
		
		/**
		 * @private
		 */
		protected var _defaultProp : ShapeAssetProp;
		
		/**
		 * @private
		 */
		protected var _stateProp : ShapeAssetProp;
		
		/**
		 * @private
		 */
		protected var _selectedProp : ShapeAssetProp;
		
		/**
		 * @private
		 */
		protected var _inputProp : ShapeAssetProp;
		
		/**
		 * @private
		 */
		protected var _iconSize : Number;
		
		/**
		 * @private
		 */
		protected var _iconProp : ShapeAssetProp;
		
		/**
		 * @private
		 */
		protected var _defaultCellProp : ShapeAssetProp;
		
		/**
		 * @private
		 */
		protected var _stateCellProp : ShapeAssetProp;
		
		/**
		 * @private
		 */
		protected var _iconSelectedProp : ShapeAssetProp;
		
		/**
		 * @private
		 */
		protected var _focusProp : ShapeAssetProp;
		
		/**
		 * @private
		 */
		protected var _errorProp : ShapeAssetProp;
		
		/**
		 *
		 */
		public function FlatSkinSet( iconSize : Number , textColor : uint , mainColor : uint = 0xFFFFFF , stateColor : uint = 0xEEEEEE , borderColor : uint = 0x999999 , errorColor : uint = 0xCC0000 , borderThickness : Number = 1 , cornerRadius : Number = 0 , shadowFilter : DropShadowFilter = null )
		{
			
			_iconSize = iconSize;
			_textColor = textColor;
			
			_defaultProp = new ShapeAssetProp( mainColor , 1.0 , null , cornerRadius , borderColor , 1.0 , borderThickness , null );
			_stateProp = new ShapeAssetProp( stateColor , 1.0 , null , cornerRadius , borderColor , 1.0 , borderThickness , null );
			_selectedProp = new ShapeAssetProp( stateColor , 1.0 , shadowFilter != null ? [ shadowFilter ] : null , cornerRadius , borderColor , 1.0 , borderThickness , null );
			
			_inputProp = new ShapeAssetProp( mainColor , 1.0 , shadowFilter != null ? [ shadowFilter ] : null , cornerRadius , borderColor , 1.0 , borderThickness , null );
			
			var invShadow : DropShadowFilter = shadowFilter != null ? shadowFilter.clone() as DropShadowFilter : null;
			
			if( invShadow != null )  invShadow.inner = false;
			
			_iconProp = new ShapeAssetProp( mainColor , 0 , invShadow != null ? [ invShadow ] : null , cornerRadius , borderColor , 1.0 , 3 , shadowFilter != null ? [ shadowFilter ] : null );
			_iconSelectedProp = new ShapeAssetProp( mainColor , 1.0 , invShadow != null ? [ invShadow ] : null , cornerRadius , borderColor , 1.0 , 3 , shadowFilter != null ? [ shadowFilter ] : null );
			
			_defaultCellProp = new ShapeAssetProp( mainColor , 1.0 , null , 0 , borderColor , 1.0 , borderThickness , null , BorderStyle.NONE );
			_stateCellProp = new ShapeAssetProp( stateColor , 1.0 , null , 0 , borderColor , 1.0 , borderThickness , null , BorderStyle.NONE );
			
			_focusProp = new ShapeAssetProp( mainColor , 1.0 , null , cornerRadius , borderColor , 1.0 , borderThickness , null );
			_errorProp = new ShapeAssetProp( mainColor , 0 , null , cornerRadius , errorColor , 1.0 , borderThickness , null );
			
			
		}
		
		/**
		 * @inheritDoc
		 */
		public function getGlobalStyle() : Object
		{
			return { focusRectPadding : new Padding( 2 , 2 , 2 , 2 ) , textStyle : new TextStyle( new TextFormat( null , null , _textColor ) ) };
		}
		
		/**
		 * @inheritDoc
		 */
		public function getButtonSkin() : IButtonSkin
		{
			return new FlatButtonSkin( _defaultProp , _stateProp , _selectedProp , _stateProp , _selectedProp , _selectedProp , _selectedProp , _selectedProp , _focusProp , _errorProp );
		}

		/**
		 * @inheritDoc
		 */
		public function getCheckBoxSkin() : IButtonSkin
		{
			return new FlatCheckBoxSkin( _iconSize , _iconProp , _iconSelectedProp , _focusProp , _errorProp );
		}

		/**
		 * @inheritDoc
		 */
		public function getColorPickerSkin() : IColorPickerSkin
		{
			var defaultProp : ShapeAssetProp = _defaultProp.clone();
			defaultProp.alpha = 0;
			defaultProp.borderStyle = BorderStyle.FILLED_LINE;
			
			var stateProp : ShapeAssetProp = _stateProp.clone();
			stateProp.alpha = 0;
			stateProp.borderStyle = BorderStyle.FILLED_LINE;
			
			return new FlatColorPickerSkin( defaultProp , stateProp , stateProp , defaultProp , _defaultProp , _inputProp , _focusProp , _errorProp );
		}

		/**
		 * @inheritDoc
		 */
		public function getComboBoxSkin() : IComboBoxSkin
		{
			return new FlatComboBoxSkin( _defaultProp , _stateProp , _selectedProp , _stateProp , _focusProp , _errorProp );
		}

		/**
		 * @inheritDoc
		 */
		public function getComboBoxStepperSkin() : IComboBoxStepperSkin
		{
			return new FlatComboBoxStepperSkin( _defaultProp , _stateProp , _selectedProp , _stateProp , _focusProp , _errorProp );
		}

		/**
		 * @inheritDoc
		 */
		public function getLabelSkin() : ILabelSkin
		{
			return new FlatLabelSkin( _defaultProp );
		}

		/**
		 * @inheritDoc
		 */
		public function getListSkin() : IListSkin
		{
			return new FlatListSkin( _defaultProp , _defaultCellProp , _stateCellProp , _stateCellProp , _defaultCellProp , _stateCellProp , _stateCellProp , _stateCellProp , _stateCellProp , _focusProp , _errorProp );
		}

		/**
		 * @inheritDoc
		 */
		public function getRadioButtonSkin() : IButtonSkin
		{
			return new FlatRadioButtonSkin( _iconSize , _iconProp , _iconSelectedProp , _focusProp , _errorProp );
		}
		
		/**
		 * @inheritDoc
		 */
		public function getScrollBarSkin() : IScrollBarSkin
		{
			return new FlatScrollBarSkin( _defaultProp , _stateProp , _selectedProp , _stateProp );
		}

		/**
		 * @inheritDoc
		 */
		public function getSliderSkin() : ISliderSkin
		{
			var track : ShapeAssetProp = _selectedProp.clone();
			track.borderStyle = BorderStyle.NONE;
			track.color = _selectedProp.borderColor;
			
			return new FlatSliderSkin( track , _defaultProp , _stateProp , _selectedProp , _defaultProp , _focusProp , _errorProp );
		}

		/**
		 * @inheritDoc
		 */
		public function getStepperSkin() : IStepperSkin
		{
			return new FlatStepperSkin( _defaultProp , _stateProp , _selectedProp , _defaultProp , _focusProp , _errorProp );
		}

		/**
		 * @inheritDoc
		 */
		public function getTextAreaSkin() : ITextAreaSkin
		{
			return new FlatTextAreaSkin( _inputProp , _focusProp , _errorProp );
		}

		/**
		 * @inheritDoc
		 */
		public function getTextInputSkin() : ITextInputSkin
		{
			return new FlatTextInputSkin( _inputProp , _focusProp , _errorProp );
		}
		
		/**
		 * @inheritDoc
		 */
		public function getTouchScrollSkin() : ITouchScrollSkin
		{
			return new FlatTouchScrollSkin( _defaultProp );
		}
	}
}
