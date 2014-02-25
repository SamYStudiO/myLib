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
	import myLib.assets.ITextFieldAsset;
	import myLib.core.IComponent;
	import myLib.styles.Padding;
	import myLib.styles.TextStyle;
	
	import flash.text.TextField;		
	/**
	 * @author SamYStudiO ( contact@samystudio.net )
	 */
	public interface ILabel extends IComponent 
	{
		/**
		 * Get or set a Boolean that indicates if textfield can display multiline.
		 * 
		 * @default false
		 */
		function get multiline() : Boolean;
		function set multiline( b : Boolean ) : void;
		
		/**
		 * Get or set a Boolean that indicates if Label component is sized to match text size.
		 * 
		 * @default false
		 */
		function get autoSize() : Boolean;
		function set autoSize( b : Boolean ) : void;
		
		/**
		 * Get or set a Boolean that indicates if Label component font size is reduced to fit Label area.
		 * 
		 * @default false
		 */
		function get autoFit() : Boolean;
		function set autoFit( b : Boolean ) : void;
		
		/**
		 * Get or set a the minimum font size to used with autoFit property.
		 * 
		 * @default 8
		 */
		function get autoFitMinSize() : uint;
		function set autoFitMinSize( n : uint ) : void;
		
		/**
		 * Get or set a the overflow text indicator when autoFit is active and minimum size is reached, display specified String at the end of text.
		 * This has no effect with htmlText since it could broke tags.
		 * 
		 * @default ...
		 */
		function get overflowTextIndicator() : String;
		function set overflowTextIndicator( s : String ) : void;
		
		/**
		 * Get or set a Boolean that indicates if textfield size is maximize to match Label size. 
		 * By default textfield is size to match text size.
		 */
		function get maximizeTextWidth() : Boolean;
		function set maximizeTextWidth( b : Boolean ) : void;
		
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
		 * Get or set assets horizontal alignment as defined in LabelAlignment constants.
		 * 
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
		 * Get or set the icon string definition, BitmapData object or external URL.
		 */
		function get icon() : *;
		function set icon( icon : * ) : void;
		
		/**
		 * Get or set the icon width.
		 */
		function get iconWidth() : Number;
		function set iconWidth( w : Number ) : void;
		
		/**
		 * Get or set the icon height.
		 */
		function get iconHeight() : Number;
		function set iconHeight( h : Number ) : void;
		
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
		 * Get or set the textfield text color.
		 */
		function get textColor() : uint;
		function set textColor( color : uint ) : void;
		
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
		 * Get Label TextField instance.
		 */
		function get textField () : TextField;

		/**
		 * Get ITextFieldAsset used to render TextField.
		 */
		function get textFieldAsset() : ITextFieldAsset;
		
		/**
		 * Get IAsset used to render icon.
		 */
		function get iconAsset() : IAsset;
		
		/**
		 * Get IAsset used to render background.
		 */
		function get backgroundAsset() : IAsset;
	}
}
