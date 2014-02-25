﻿/*
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
	import myLib.assets.ITextFieldAsset;	
	/**
	 * ILabelSkin defines all methods to build assets for a Label component.
	 * 
	 * @author SamYStudiO
	 */
	public interface ILabelSkin extends ISkin
	{
		/**
		 * Get the ITextFieldAsset used to render TextField.
		 * 
		 * @return The ITextFieldAsset used to render TextField.
		 */
		function getTextFieldAsset() : ITextFieldAsset;
		
		/**
		 * Get the IAsset used to render icon.
		 * 
		 * @return The IAsset used to render icon.
		 */
		function getIconUpAsset() : IAsset;
		
		/**
		 * Get the IAsset used to render background, with Button this is the up state.
		 * 
		 * @return The IAsset used to render background.
		 */
		function getUpAsset() : IAsset;
	}
}