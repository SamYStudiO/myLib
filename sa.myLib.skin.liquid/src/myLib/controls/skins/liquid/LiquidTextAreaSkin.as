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
	import myLib.controls.skins.ISkin;
	import myLib.controls.skins.ITextAreaSkin;
	import myLib.core.IScroll;
	import myLib.utils.ClassUtils;

	import flash.display.BitmapData;
	/**
	 * TextInputSkin is the default skin for TextInput component.
	 * Like all other components, default skin use string definition, BitmapData object or external URL to build assets.
	 * To use other values or for complexe skin make your own ITextInputSkin implementation.
	 * 
	 * @see myLib.controls.TextInput
	 * @see myLib.controls.skins.ITextInputSkin
	 * @author SamYStudiO ( contact@samystudio.net )
	 */
	public class LiquidTextAreaSkin extends LiquidTextInputSkin implements ITextAreaSkin
	{
		/**
		 * @private
		 */
		protected var _scrollSkin : ISkin;
		
		/**
		 * 
		 */
		public function LiquidTextAreaSkin ( bitmapSheet : BitmapData , iconBitmapSheet : BitmapData = null , focusRectBitmapSheet : BitmapData = null , scrollSkin : ISkin = null )
		{
			super( bitmapSheet , iconBitmapSheet , focusRectBitmapSheet );
			
			_scrollSkin = scrollSkin;
		}
		
		/**
		 * @inheritDoc
		 */
		public function getScrollAsset( definition : * = null ) : IScroll
		{
			var scroll : IScroll;
			
			try
			{
				if( definition is String )
					scroll = ClassUtils.getInstance( ClassUtils.getClassByName( definition ) , null , null , _scrollSkin ) as IScroll;
				else
					scroll = ClassUtils.getInstance( definition , null , null , _scrollSkin ) as IScroll;
			}
			catch( e : Error )
			{
					
			}
			
			return scroll;
		}
	}
}
