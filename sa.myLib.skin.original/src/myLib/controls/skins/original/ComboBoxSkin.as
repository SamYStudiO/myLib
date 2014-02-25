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
	import myLib.controls.IList;
	import myLib.controls.ITextInput;
	import myLib.controls.List;
	import myLib.controls.TextInput;
	import myLib.controls.skins.AFieldSkin;
	import myLib.controls.skins.IButtonSkin;
	import myLib.controls.skins.IComboBoxSkin;
	import myLib.controls.skins.IListSkin;
	import myLib.controls.skins.ITextInputSkin;
	import myLib.styles.Padding;
	/**
	 * ComboBoxSkin is the default skin for ComboBox component.
	 * Like all other components, default skin use string definition, BitmapData object or external URL to build assets.
	 * To use other values or for complexe skin make your own IComboBoxSkin implementation.
	 * 
	 * @see myLib.controls.ComboBox
	 * @see myLib.controls.skins.IComboBoxSkin
	 * @author SamYStudiO ( contact@samystudio.net )
	 */
	public class ComboBoxSkin extends AFieldSkin implements IComboBoxSkin 
	{
		/**
		 * Get or set the IButtonSkin for box asset.
		 */
		public var boxSkin : IButtonSkin;
		
		/**
		 * Get or set the IButtonSkin for arrow button asset.
		 */
		public var arrowButtonSkin : IButtonSkin;
		
		/**
		 * Get or set the ITextInputSkin for TextInput asset.
		 */
		public var textInputSkin : ITextInputSkin;
		
		/**
		 * Get or set the IListSkin for List asset.
		 */
		public var listSkin : IListSkin;
		
		/**
		 * Get or set the initial style for box asset.
		 */
		public var boxInitStyle : Object;
		
		/**
		 * Get or set the initial style for arow button asset.
		 */
		public var arrowButtonInitStyle : Object;
		
		/**
		 * Get or set the initial style for TextInput asset.
		 */
		public var textInputInitStyle : Object;
		
		/**
		 * Get or set the initial style for List asset.
		 */
		public var listInitStyle : Object;

		/**
		 * Build a new ComboBoxSkin instance.
		 * @param boxSkin The IButtonSkin for box asset.		 * @param arrowButtonSkin The IButtonSkin for arrow button asset.		 * @param textInputSkin The ITextInputSkin for TextInput asset.		 * @param listSkin The IListSkin for List asset.
		 * @param focusRect The focus rectangle asset string definition, BitmapData object or external URL.		 * @param boxInitStyle The initial style for box asset.		 * @param arrowButtonInitStyle The initial style for arrow button asset.		 * @param textInputInitStyle The initial style for TextInput asset.		 * @param listInitStyle The initial style for List asset.
		 */
		public function ComboBoxSkin ( 	boxSkin : IButtonSkin = null , arrowButtonSkin : IButtonSkin = null , textInputSkin : ITextInputSkin = null , listSkin : IListSkin = null , focusRect : * = null , errorRect : * = null ,
										boxInitStyle : Object = null , arrowButtonInitStyle : Object = null , textInputInitStyle : Object = null , listInitStyle : Object = null )
		{
			
			this.boxSkin = boxSkin || new ButtonSkin( null , ComboBoxBoxUp , ComboBoxBoxOver , ComboBoxBoxDown , ComboBoxBoxDisabled );			this.arrowButtonSkin = arrowButtonSkin || new ButtonSkin( null , ComboBoxArrowButtonUp , ComboBoxArrowButtonOver , ComboBoxArrowButtonDown , ComboBoxArrowButtonDisabled , null , null , null , null , null , ComboBoxArrowButtonIconUp , ComboBoxArrowButtonIconOver , ComboBoxArrowButtonIconDown , ComboBoxArrowButtonIconDisabled );			this.textInputSkin = textInputSkin || new TextInputSkin( ComboBoxTextField , null , null , null , null );			this.listSkin = listSkin || new ListSkin();
			
			this.focusRect = focusRect == null ? ComboBoxFocusRect : focusRect;
			this.errorRect = errorRect == null ? null : errorRect;
			
			if( textInputInitStyle != null ) textInputInitStyle.padding = new Padding( 3 , 2 , 2 , 2 );
						this.boxInitStyle = boxInitStyle;			this.arrowButtonInitStyle = arrowButtonInitStyle;			this.textInputInitStyle = textInputInitStyle || { padding : new Padding( 3 , 2 , 2 , 2 ) };			this.listInitStyle = listInitStyle;
		}
		
		/**
		 * @inheritDoc
		 */
		public function getBoxAsset(  ) : IAsset
		{
			return new Button( null , boxInitStyle , boxSkin );
		}
		
		/**
		 * @inheritDoc
		 */
		public function getArrowButtonAsset(  ) : IAsset
		{
			return new Button( null , arrowButtonInitStyle , arrowButtonSkin );
		}
		
		/**
		 * @inheritDoc
		 */
		public function getTextInputAsset(  ) : ITextInput
		{
			return new TextInput( null , textInputInitStyle , textInputSkin );
		}
		
		/**
		 * @inheritDoc
		 */
		public function getListAsset(  ) : IList
		{
			return new List( null , listInitStyle , listSkin );
		}
	}
}
