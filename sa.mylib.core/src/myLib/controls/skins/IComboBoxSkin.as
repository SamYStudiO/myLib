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
package myLib.controls.skins 
{
	import myLib.assets.IAsset;
	import myLib.controls.IList;
	import myLib.controls.ITextInput;	
	/**
	 * IComboBoxSkin defines all methods to build assets for a ComboBox component.
	 * 
	 * @author SamYStudiO ( contact@samystudio.net )
	 */
	public interface IComboBoxSkin extends IFieldSkin 
	{
		/**
		 * Get the IAsset used to render box.
		 * 
		 * @return The IAsset used to render box.
		 * 
		 * TODO what about disabled asset?
		 */
		function getBoxAsset() : IAsset;
		
		/**
		 * Get the IAsset used to render arrow button.
		 * 
		 * @return The IAsset used to render arrow button.
		 */
		function getArrowButtonAsset() : IAsset;
		
		/**
		 * Get the TextInput used to render box textfield.
		 * 
		 * @return The TextInput used to render box textfield.
		 */
		function getTextInputAsset () : ITextInput;

		/**
		 * Get the List used to render dropdown list.
		 * 
		 * @return The TextInput used to render dropdown list.
		 */
		function getListAsset() : IList;
	}
}
