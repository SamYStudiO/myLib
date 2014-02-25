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
	import myLib.controls.ICellRenderer;
	import myLib.core.IScroll;
	/**
	 * IListSkin defines all methods to build assets for a List component.
	 * 
	 * @author SamYStudiO ( contact@samystudio.net )
	 */
	public interface IListSkin extends IFieldSkin 
	{
		/**
		 * Get the IAsset used to render list background.
		 * 
		 * @return The IAsset used to render list background.
		 */
		function getBackgroundAsset() : IAsset;
		
		/**
		 * Get the IAsset used to render list background disabled state.
		 * 
		 * @return The IAsset used to render list background disabled state.
		 */
		function getBackgroundDisabledAsset() : IAsset;
		
		/**
		 * Get the IAsset used to render list border.
		 * 
		 * @return The IAsset used to render list border.
		 */
		function getBorderAsset() : IAsset;
		
		/**
		 * Get the IAsset used to render list border disabled state.
		 * 
		 * @return The IAsset used to render list border disabled state.
		 */
		function getBorderDisabledAsset() : IAsset;
		
		/**
		 * Get the IScroll used to render scroll.
		 * 
		 * @param definition the IScroll string definition or class object.
		 * @return The IScroll used to render scroll.
		 */
		function getScrollAsset( definition : * = null ) : IScroll
		
		/**
		 * Get the ICellRenderer used to render list cells.
		 * 
		 * @param definition The cell string definition or class object.
		 * @param skin The skin to apply to cell.
		 * @return The ICellRenderer used to render list cells.
		 */
		function getCellAsset( definition : * = null , skin : ISkin = null ) : ICellRenderer
	}
}
