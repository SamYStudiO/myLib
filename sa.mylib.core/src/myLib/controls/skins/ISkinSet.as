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
package myLib.controls.skins
{
	/**
	 * @author SamYStudiO ( contact@samystudio.net )
	 */
	public interface ISkinSet
	{
		/**
		 * 
		 */
		function getGlobalStyle( ) : Object
		
		/**
		 * 
		 */
		function getButtonSkin( ) : IButtonSkin
		
		/**
		 * 
		 */
		//function getCalendarSkin( ) : ICalendarSkin
		
		/**
		 * 
		 */
		function getCheckBoxSkin( ) : IButtonSkin
		
		/**
		 * 
		 */
		function getColorPickerSkin( ) : IColorPickerSkin
		
		/**
		 * 
		 */
		function getComboBoxSkin( ) : IComboBoxSkin
		
		/**
		 * 
		 */
		function getComboBoxStepperSkin( ) : IComboBoxStepperSkin
		
		/**
		 * 
		 */
		//function getDateGridSkin( ) : IDataGridSkin
		
		/**
		 * 
		 */
		//function getDateFieldSkin( ) : IDateFieldSkin
		
		/**
		 * 
		 */
		function getLabelSkin( ) : ILabelSkin
		
		/**
		 * 
		 */
		function getListSkin( ) : IListSkin
		
		/**
		 * 
		 */
		function getRadioButtonSkin( ) : IButtonSkin
		
		/**
		 * 
		 */
		function getScrollBarSkin( ) : IScrollBarSkin
		
		/**
		 * 
		 */
		function getSliderSkin( ) : ISliderSkin
		
		/**
		 * 
		 */
		function getStepperSkin( ) : IStepperSkin
		
		/**
		 * 
		 */
		function getTextAreaSkin( ) : ITextAreaSkin
		
		/**
		 * 
		 */
		function getTextInputSkin( ) : ITextInputSkin
		
		/**
		 * 
		 */
		function getTouchScrollSkin( ) : ITouchScrollSkin
	}
}
