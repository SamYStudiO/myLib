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
package myLib.controls 
{
	import myLib.assets.IAsset;
	import myLib.core.IComponent;
	import myLib.styles.Padding;
	/**
	 * @author SamYStudiO ( contact@samystudio.net )
	 */
	public interface IColorPicker extends IComponent 
	{
		/**
		 * Get or set selected color.
		 */
		function get selectedColor() : uint;
		function set selectedColor( n : uint ) : void;
		
		/**
		 * Get or set the color map use to display swatches, this consist of a 2 dimensionnal color uint Array.
		 * If colorMap is null a default 216 web color map is generated.
		 */
		function get colorMap() : Array;
		function set colorMap( map : Array ) : void;
		
		/**
		 * Get or set palette swatch width.
		 * 
		 * @default 10
		 */
		function get swatchWidth() : Number;
		function set swatchWidth( n : Number ) : void;
		
		/**
		 * Get or set palette swatch height.
		 * 
		 * @default 10
		 */
		function get swatchHeight() : Number;
		function set swatchHeight( n : Number ) : void;
		
		/**
		 * Get or set palette swatch border color.
		 * 
		 * @default 0x000000
		 */
		function get swatchBorderColor() : uint;
		function set swatchBorderColor( n : uint ) : void;
		
		/**
		 * Get or set palette selected swatch border color.
		 * 
		 * @default 0xFFFFFF
		 */
		function get swatchBorderSelectedColor() : uint;
		function set swatchBorderSelectedColor( n : uint ) : void;
		
		/**
		 * Get or set palette swatch border thickness.
		 * 
		 * @default 1
		 */
		function get swatchBorderThickness() : Number;
		function set swatchBorderThickness( n : Number ) : void;
		
		/**
		 * Get or set palette padding.
		 * 
		 * @see myLib.styles.Padding 
		 */
		function get paletteContentPadding() : Padding;
		function set paletteContentPadding( padding : Padding ) : void;
		
		/**
		 * Get or set palette open direction using ColorPickerOpenDirection constants.
		 * 
		 * @default ColorPickerOpenDirection.RIGHT
		 * @see myLib.controls.ColorPickerOpenDirection
		 */
		function get openDirection() : String;
		function set openDirection( direction : String ) : void;
		
		/**
		 * Get or set palette point from which palette is open using AlignmentPoint constants.
		 * 
		 * @default AlignmentPoint.TOP_LEFT
		 * @see myLib.displayUtils.AlignmentPoint
		 */
		function get openPoint() : String;
		function set openPoint( point : String ) : void;
		
		/**
		 * Get or set Padding object use to get space between colorwell and palette.
		 */
		function get openPadding() : Padding;
		function set openPadding( padding : Padding ) : void;
		
		/**
		 * get or set a Boolean that indicates if palette colorwell is visible.
		 * 
		 * @default true
		 */
		function get showPaletteColorWell() : Boolean;
		function set showPaletteColorWell( b : Boolean ) : void;
		
		/**
		 * get or set a Boolean that indicates if palette textfield is visible.
		 * 
		 * @default true
		 */
		function get paletteTextFieldEditable() : Boolean;
		function set paletteTextFieldEditable( b : Boolean ) : void;
		
		/**
		 * get or set a Boolean that indicates if all stage area can be used to pick a color.
		 * 
		 * @default false
		 */
		function get captureBackgroundColor() : Boolean;
		function set captureBackgroundColor( b : Boolean ) : void;
		
		/**
		 * Get a Boolean that indicates if palette is opened.
		 */
		function get isOpen() : Boolean;
		
		/**
		 * Get IAsset used to render colorwellButton.
		 */
		function get colorWellButton() : IAsset;
		
		/**
		 * Get IAsset used to render colorwell.
		 */
		function get colorWell() : IAsset;
		
		/**
		 * Get IAsset used to render palette.
		 */
		function get palette() : IAsset;
		
		/**
		 * Get TextInput component used to render palette textfield.
		 */
		function get paletteTextInput () : ITextInput;

		/**
		 * Get IAsset used to render palette colorwell.
		 */
		function get paletteColorWell() : IAsset;
		
		/**
		 * Get IAsset used to render palette background.
		 */
		function get paletteBackground() : IAsset;
		
		/**
		 * Get IAsset used to render palette colorwell border.
		 */
		function get paletteColorWellBorder() : IAsset;
		
		/**
		 * Open palette.
		 */
		function open() : void;
		
		/**
		 * Close palette.
		 */
		function close() : void;
	}
}
