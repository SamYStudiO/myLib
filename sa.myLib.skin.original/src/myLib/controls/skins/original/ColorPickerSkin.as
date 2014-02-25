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
 * The Original Code is myLib.
 *
 * The Initial Developer of the Original Code is
 * Samuel EMINET (aka SamYStudiO) contact@samystudio.net.
 * Portions created by the Initial Developer are Copyright (C) 2008-2011
 * the Initial Developer. All Rights Reserved.
 *
 */
package myLib.controls.skins.original 
{
	import myLib.assets.IAsset;
	import myLib.controls.Button;
	import myLib.controls.ITextInput;
	import myLib.controls.TextInput;
	import myLib.controls.skins.AFieldSkin;
	import myLib.controls.skins.IButtonSkin;
	import myLib.controls.skins.IColorPickerSkin;
	import myLib.controls.skins.ITextInputSkin;
	/**
	 * ColorPickerSkin is the default skin for ColorPicker component.
	 * Like all other components, default skin use string definition, BitmapData object or external URL to build assets.
	 * To use other values or for complexe skin make your own IColorPickerSkin implementation.
	 * 
	 * @see myLib.controls.ColorPicker
	 * @see myLib.controls.skins.IColorPickerSkin
	 * @author SamYStudiO ( contact@samystudio.net )
	 */
	public class ColorPickerSkin extends AFieldSkin implements IColorPickerSkin 
	{
		/**
		 * Get or set the IButtonSkin for box asset.
		 */
		public var buttonSkin : IButtonSkin;
		
		/**
		 * Get or set the initial style for box asset.
		 */
		public var buttonInitStyle : Object;
		
		/**
		 * Get or set the colorwell asset string definition, BitmapData object or external URL.
		 */
		public var colorWell : *;
		
		/**
		 * Get or set the palette background asset string definition, BitmapData object or external URL.
		 */
		public var paletteBackground : *;
		
		/**
		 * Get or set the palette colorwell asset string definition, BitmapData object or external URL.
		 */
		public var paletteColorWell : *;
		
		/**
		 * Get or set the palette colorwell border asset string definition, BitmapData object or external URL.
		 */
		public var paletteColorWellBorder : *;
		
		/**
		 * Get or set the ITextInputSkin for TextInput asset.
		 */
		public var textInputSkin : ITextInputSkin;
		
		/**
		 * Get or set the initial style for TextInput asset.
		 */
		public var textInputInitStyle : Object;

		/**
		 * Build a new ColorPickerSkin instance.
		 * @param buttonSkin The IButtonSkin for box asset.
		 * @param buttonInitStyle The initial style for box asset.
		 * @param colorWell The colorwell asset string definition, BitmapData object or external URL.		 * @param paletteBackground The palette background asset string definition, BitmapData object or external URL.		 * @param paletteColorWell The palette colorwell asset string definition, BitmapData object or external URL.		 * @param paletteColorWellBorder The palette colorwell border asset string definition, BitmapData object or external URL.
		 * @param textInputSkin The ITextInputSkin for TextInput asset.
		 * @param textInputInitStyle The initial style for TextInput asset.
		 * @param focusRect The focus rectangle asset string definition, BitmapData object or external URL.
		 */
		public function ColorPickerSkin( 	buttonSkin : IButtonSkin = null , buttonInitStyle : Object = null , colorWell : * = null , paletteBackground : * = null , 
											paletteColorWell : * = null , paletteColorWellBorder : * = null ,
											textInputSkin : ITextInputSkin = null , textInputInitStyle : Object = null , focusRect : * = null , errorRect : * = null )
		{
			this.buttonSkin = buttonSkin == null ? new ButtonSkin( null , ColorPickerButtonUp , ColorPickerButtonOver , ColorPickerButtonDown , ColorPickerButtonDisabled ) : buttonSkin;
			this.buttonInitStyle = buttonInitStyle;			this.colorWell = colorWell == null ? ColorPickerColorWell : colorWell;			this.paletteBackground = paletteBackground == null ? ColorPickerPaletteBackground : paletteBackground;			this.paletteColorWell = paletteColorWell == null ? ColorPickerPaletteColorWell : paletteColorWell;			this.paletteColorWellBorder = paletteColorWellBorder == null ? ColorPickerPaletteColorWellBorder : paletteColorWellBorder;			this.textInputSkin = textInputSkin == null ? new TextInputSkin( ColorPickerTextInputTextField , null , ColorPickerTextInputBackground ) : textInputSkin;			this.textInputInitStyle = textInputInitStyle;			this.focusRect = focusRect == null ? ColorPickerFocusRect : focusRect;
			this.errorRect = errorRect == null ? null : errorRect;
		}
		
		/**
		 * @inheritDoc
		 */
		public function getButtonAsset(  ) : IAsset
		{
			return new Button( null , buttonInitStyle , buttonSkin );
		}
		
		/**
		 * @inheritDoc
		 */
		public function getColorWellAsset(  ) : IAsset
		{
			return _getAsset( colorWell );
		}
		
		/**
		 * @inheritDoc
		 */
		public function getPaletteBackgroundAsset(  ) : IAsset
		{
			return _getAsset( paletteBackground );
		}
		
		/**
		 * @inheritDoc
		 */
		public function getPaletteColorWellAsset(  ) : IAsset
		{
			return _getAsset( paletteColorWell );
		}
		
		/**
		 * @inheritDoc
		 */
		public function getPaletteColorWellBorderAsset(  ) : IAsset
		{
			return _getAsset( paletteColorWellBorder );
		}
		
		/**
		 * @inheritDoc
		 */
		public function getTextInputAsset (  ) : ITextInput
		{
			return new TextInput( null , textInputInitStyle , textInputSkin );
		}
	}
}
