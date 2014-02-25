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
	import myLib.assets.ITextFieldAsset;
	import myLib.controls.skins.ASkin;
	import myLib.controls.skins.ILabelSkin;
	/**
	 * LabelSkin is the default skin for Label component.
	 * Like all other components, default skin use string definition, BitmapData object or external URL to build assets.
	 * To use other values or for complexe skin make your own ILabelSkin implementation.
	 * 
	 * @see myLib.controls.Label
	 * @see myLib.controls.skins.ILabelSkin
	 * @author SamYStudiO ( contact@samystudio.net )
	 */
	public class LabelSkin extends ASkin implements ILabelSkin 
	{
		/**
		 * Get or set the textfield asset string definition.
		 */
		public var textField : *;
			
		/**
		 * Get or set the icon asset string definition, BitmapData object or external URL.
		 */
		public var icon : *;
		
		/**
		 * Get or set the background asset string definition, BitmapData object or external URL.
		 */
		public var background : *;
		
		/**
		 * Build a new LabelSkin instance.
		 * @param textField The textfield asset string definition.		 * @param icon The icon asset string definition, BitmapData object or external URL.		 * @param background The background asset string definition, BitmapData object or external URL.
		 */
		public function LabelSkin( textField : * = null , icon : * = null , background : * = null )
		{
			this.textField = textField == null ? LabelTextField : textField;
			this.icon = icon == null ? LabelIcon : icon;
			this.background = background == null ? LabelBackground : background;
		}
		
		/**
		 * @inheritDoc
		 */
		public function getTextFieldAsset (  ) : ITextFieldAsset
		{
			return _getTextFieldAsset( textField );
		}
		
		/**
		 * @inheritDoc
		 */
		public function getIconUpAsset (  ) : IAsset
		{
			return _getAsset( icon );
		}
		
		/**
		 * @inheritDoc
		 */
		public function getUpAsset (  ) : IAsset
		{
			return _getAsset( background );
		}
	}
}
