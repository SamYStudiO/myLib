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
package myLib.core 
{
	import myLib.assets.IAsset;
	import myLib.controls.ITextInput;
	import myLib.form.IField;
	import myLib.styles.Padding;
	import myLib.styles.TextStyle;

	import flash.text.TextField;
	/**
	 * @author SamYStudiO
	 */
	public interface IAStepper extends IComponent, IField 
	{
		/**
		 * Get or set a Boolean that indicates button action are invert. Only action are invert not buttons.
		 * 
		 * @default false
		 */
		function get invertNextPrevious() : Boolean;
		function set invertNextPrevious( b : Boolean ) : void;
		
		/**
		 * Get or set a Boolean that indicates if box text is editable.
		 * 
		 * @default false
		 */
		function get editable() : Boolean;
		function set editable( b : Boolean ) : void;
		
		/**
		 * Get or set a Boolean that indicates if next and previous button are fixed size (false) or are resized to match component size (true).
		 * 
		 * @default true
		 */
		function get resizeButton() : Boolean;
		function set resizeButton( b : Boolean ) : void;
		
		/**
		 * Indicates next and previous button position with TextInput using StepperNextPreviousPosition constants.
		 * 
		 * @default StepperNextPreviousPosition.RIGHT
		 * @see myLb.controls.StepperNextPreviousPosition
		 */
		function get nextPreviousPosition() : String;
		function set nextPreviousPosition( s : String ) : void;
		
		/**
		 * Indicates space between buttons and TextInput.
		 * 
		 * @default 0
		 */
		function get textButtonSpacing() : Number;
		function set textButtonSpacing( n : Number ) : void;
		
		/**
		 * Get or set assets horizontal alignment as defined in LabelAlignment constants.
		 * @default left
		 */
		function get horizontalAlignment() : String;
		function set horizontalAlignment( s : String ) : void;
		
		/**
		 * Get or set assets vertical alignment as defined in LabelAlignment constants.
		 * @default center
		 */
		function get verticalAlignment() : String;
		function set verticalAlignment( s : String ) : void;
		
		/**
		 * Get or set a Boolean that indicates if textfield used embed fonts.
		 */
		function get embedFonts() : Boolean;
		function set embedFonts( b : Boolean ) : void;
		
		/**
		 * Get or set the label placement relative to the icon asset.
		 * 
		 * @default right
		 */
		function get labelPlacement() : String;
		function set labelPlacement( s : String ) : void;
		
		/**
		 * Get or set the icon and textfield spacing, horizontal or vertical depending of labelPlacement property.
		 * 
		 * @default 2
		 */
		function get labelIconSpacing() : Number;
		function set labelIconSpacing( n : Number ) : void;
		
		/**
		 * Get or set the icon and textfield padding within Label are which can be represented by its background asset.
		 */
		function get padding() : Padding;
		function set padding( padding : Padding ) : void;
		
		/**
		 * Get or set the TextStyle object to use with textfield asset.
		 * 
		 * @see myLib.styles.StyleManager
		 */
		function get textStyle() : TextStyle;
		function set textStyle( style : TextStyle ) : void;
		
		/**
		 * Get or set a Boolean that indicates if text property act as htmlText property or not.
		 * If html is true and text property is called, it is equivalent to call htmlText property.
		 * 
		 * @default false
		 */
		function get html() : Boolean;
		function set html( b : Boolean ) : void;
		
		/**
		 * Get or set textfield text.
		 */
		function get text() : String;
		function set text( s : String ) : void;
		
		/**
		 * Get or set textfield html text.
		 */
		function get htmlText() : String;
		function set htmlText( s : String ) : void;
		
		/**
		 * Get or set the disabled text color when component is disabled.
		 */
		function get disabledTextColor() : uint;
		function set disabledTextColor( n : uint ) : void;
		
		/**
		 * Get or set the icon string definition, BitmapData object or external URL use with TextInput.
		 */
		function get icon() : *;
		function set icon( icon : * ) : void;
		
		/**
		 * Get IAsset used to render next button asset.
		 */
		function get nextAsset() : IAsset;
		
		/**
		 * Get IAsset used to render previous button asset.
		 */
		function get previousAsset() : IAsset;
		
		/**
		 * Get TextInput component.
		 */
		function get textInput () : ITextInput;
		
		/**
		 * Get textfield instance used with TextInput.
		 */
		function get textField () : TextField;
		
		/**
		 * Select next item within list from current selection.
		 */
		function next() : void;
		
		/**
		 * Select previous item within list from current selection.
		 */
		function previous() : void;
	}
}
