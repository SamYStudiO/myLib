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
package myLib.controls.skins.liquid
{
	import myLib.assets.IAsset;
	import myLib.controls.Button;
	import myLib.controls.IList;
	import myLib.controls.ITextInput;
	import myLib.controls.List;
	import myLib.controls.TextInput;
	import myLib.controls.skins.IComboBoxSkin;

	import flash.display.BitmapData;
	/**
	 * ComboBoxSkin is the default skin for ComboBox component.
	 * Like all other components, default skin use string definition, BitmapData object or external URL to build assets.
	 * To use other values or for complexe skin make your own IComboBoxSkin implementation.
	 * 
	 * @see myLib.controls.ComboBox
	 * @see myLib.controls.skins.IComboBoxSkin
	 * @author SamYStudiO ( contact@samystudio.net )
	 */
	public class LiquidComboBoxSkin extends ALiquidSkin implements IComboBoxSkin 
	{
		/**
		 * @private
		 */
		protected var _boxBitmapSheet : BitmapData;
		
		/**
		 * @private
		 */
		protected var _listSkin : LiquidListSkin;

		/**
		 * 
		 */
		public function LiquidComboBoxSkin ( boxBitmapSheet : BitmapData , listSkin : LiquidListSkin , focusRectBitmapSheet : BitmapData = null )
		{
			_boxBitmapSheet = boxBitmapSheet;
			_listSkin = listSkin;
			_focusRectBitmapSheet = focusRectBitmapSheet;
		}
		
		/**
		 * @inheritDoc
		 */
		public function getBoxAsset(  ) : IAsset
		{
			var b : Button = new Button( null , null , new LiquidButtonSkin( _boxBitmapSheet , null , _focusRectBitmapSheet , 0 , true ) );
			
			return b;
		}
		
		/**
		 * @inheritDoc
		 */
		public function getArrowButtonAsset(  ) : IAsset
		{
			return null;
		}
		
		/**
		 * @inheritDoc
		 */
		public function getTextInputAsset(  ) : ITextInput
		{
			// HACK : pass box sheet as background so text can retrieve color and then hide TextInput background > background already drawn from ComboBox so textinput one is not required
			var ti : TextInput = new TextInput( null , null , new LiquidTextInputSkin( _boxBitmapSheet ) );
			ti.backgroundAsset.visible = false;
			
			return ti;
		}
		
		/**
		 * @inheritDoc
		 */
		public function getListAsset(  ) : IList
		{
			return new List( null , null , _listSkin );
		}
	}
}
