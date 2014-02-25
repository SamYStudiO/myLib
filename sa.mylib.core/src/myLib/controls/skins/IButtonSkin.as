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
	/**
	 * IButtonSkin defines all methods to build assets for a Button component.
	 * 
	 * @author SamYStudiO ( contact@samystudio.net )
	 */
	public interface IButtonSkin extends ILabelSkin, IFieldSkin 
	{
		/**
		 * Get the IAsset used to render up selected state.
		 * 
		 * @return The IAsset used to render up selected state.
		 */
		function getUpSelectedAsset() : IAsset;
		
		/**
		 * Get the IAsset used to render over state.
		 * 
		 * @return The IAsset used to render over state.
		 */
		function getOverAsset() : IAsset;
		
		/**
		 * Get the IAsset used to render over selected state.
		 * 
		 * @return The IAsset used to render over selected state.
		 */
		function getOverSelectedAsset() : IAsset;
		
		/**
		 * Get the IAsset used to render down state.
		 * 
		 * @return The IAsset used to render down state.
		 */
		function getDownAsset() : IAsset;
		
		/**
		 * Get the IAsset used to render down selected state.
		 * 
		 * @return The IAsset used to render down selected state.
		 */
		function getDownSelectedAsset() : IAsset;
		
		/**
		 * Get the IAsset used to render disabled state.
		 * 
		 * @return The IAsset used to render disabled state.
		 */
		function getDisabledAsset() : IAsset;
		
		/**
		 * Get the IAsset used to render disabled selected state.
		 * 
		 * @return The IAsset used to render disabled selected state.
		 */
		function getDisabledSelectedAsset() : IAsset;
				
		/**
		 * Get the IAsset used to render icon up selected state.
		 * 
		 * @return The IAsset used to render icon up selected state.
		 */
		function getIconUpSelectedAsset() : IAsset;
		
		/**
		 * Get the IAsset used to render icon over state.
		 * 
		 * @return The IAsset used to render icon over state.
		 */
		function getIconOverAsset() : IAsset;
		
		/**
		 * Get the IAsset used to render icon over selected state.
		 * 
		 * @return The IAsset used to render icon over selected state.
		 */
		function getIconOverSelectedAsset() : IAsset;
		
		/**
		 * Get the IAsset used to render icon down state.
		 * 
		 * @return The IAsset used to render icon down state.
		 */
		function getIconDownAsset() : IAsset;
		
		/**
		 * Get the IAsset used to render icon down selected state.
		 * 
		 * @return The IAsset used to render icon down selected state.
		 */
		function getIconDownSelectedAsset() : IAsset;
		
		/**
		 * Get the IAsset used to render icon disabled state.
		 * 
		 * @return The IAsset used to render icon disabled state.
		 */
		function getIconDisabledAsset() : IAsset;
		
		/**
		 * Get the IAsset used to render icon disabled selected state.
		 * 
		 * @return The IAsset used to render icon disabled selected state.
		 */
		function getIconDisabledSelectedAsset() : IAsset;
	}
}
