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
	import myLib.controls.skins.ITextInputSkin;
	/**
	 * TextInputSkin is the default skin for TextInput component.
	 * Like all other components, default skin use string definition, BitmapData object or external URL to build assets.
	 * To use other values or for complexe skin make your own ITextInputSkin implementation.
	 * 
	 * @see myLib.controls.TextInput
	 * @see myLib.controls.skins.ITextInputSkin
	 * @author SamYStudiO ( contact@samystudio.net )
	 */
	public class TextInputSkin extends LabelSkin implements ITextInputSkin
	{
		/**
		 * Get or set the focus rectangle asset string definition, BitmapData object or external URL.
		 */
		public var focusRect : *;
		
		/**
		 * Get or set the error rectangle asset string definition, BitmapData object or external URL.
		 */
		public var errorRect : *;
		
		/**
		 * Get or set the icon disabled state asset string definition, BitmapData object or external URL.
		 */
		public var iconDisabled : *;
		
		/**
		 * Get or set the background disabled state asset string definition, BitmapData object or external URL.
		 */
		public var backgroundDisabled : *;
		
		/**
		 * Build a new TextInputSkin instance.
		 * @param textField The textfield asset string definition.
		 * @param icon The icon asset string definition, BitmapData object or external URL.
		 * @param background The background asset string definition, BitmapData object or external URL.		 * @param iconDisabled The icon disabled state asset string definition, BitmapData object or external URL.		 * @param backgroundDisabled The background disabled state asset string definition, BitmapData object or external URL.		 * @param focusRect The focus rectangle asset string definition, BitmapData object or external URL.
		 */
		public function TextInputSkin ( textField : * = null , icon : * = null , background : * = null ,
										iconDisabled : * = null , backgroundDisabled : * = null , focusRect : * = null , errorRect : * = null )
		{
			super( 	textField == null ? TextInputTextField : textField,
					icon == null ? TextInputIcon : icon ,
					background == null ? TextInputBackground : background );
			
			this.iconDisabled = iconDisabled == null ? TextInputIconDisabled : iconDisabled;			this.backgroundDisabled = backgroundDisabled == null ? TextInputBackgroundDisabled : backgroundDisabled;			this.focusRect = focusRect == null ? TextInputFocusRect : focusRect;
			this.errorRect = errorRect == null ? null : errorRect;
		}

		/**
		 * @inheritDoc
		 */
		public function getDisabledAsset(  ) : IAsset
		{
			return _getAsset( backgroundDisabled );
		}
		
		/**
		 * @inheritDoc
		 */
		public function getIconDisabledAsset( ) : IAsset
		{
			return _getAsset( iconDisabled );
		}
		
		/**
		 * @inheritDoc
		 */
		public function getFocusRectAsset(  ) : IAsset
		{
			return _getAsset( focusRect );
		}
		
		/**
		 * @inheritDoc
		 */
		public function getErrorRectAsset(  ) : IAsset
		{
			return _getAsset( errorRect );
		}
	}
}
