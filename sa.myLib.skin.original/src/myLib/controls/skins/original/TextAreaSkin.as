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
	import myLib.controls.skins.ISkin;
	import myLib.controls.skins.ITextAreaSkin;
	import myLib.core.IScroll;
	import myLib.utils.ClassUtils;
	/**
	 * TextAreaSkin is the default skin for TextArea component.
	 * Like all other components, default skin use string definition, BitmapData object or external URL to build assets.
	 * To use other values or for complexe skin make your own ITextAreaSkin implementation.
	 * 
	 * @see myLib.controls.TextArea
	 * @see myLib.controls.skins.ITextAreaSkin
	 * @author SamYStudiO ( contact@samystudio.net )
	 */
	public class TextAreaSkin extends TextInputSkin implements ITextAreaSkin
	{
		/**
		 * Get or set the IScrollBarSkin for Scroll asset.
		 */
		public var scrollSkin : ISkin;
		
		/**
		 * Get or set the initial style for Scroll asset.
		 */
		public var scrollInitStyle : Object;

		/**
		 * Build a new TextAreaSkin instance.
		 * @param textField The textfield asset string definition.
		 * @param icon The icon asset string definition, BitmapData object or external URL.
		 * @param background The background asset string definition, BitmapData object or external URL.
		 * @param iconDisabled The icon disabled state asset string definition, BitmapData object or external URL.
		 * @param backgroundDisabled The background disabled state asset string definition, BitmapData object or external URL.		 * @param focusRect The focus rectangle asset string definition, BitmapData object or external URL.		 * @param scrollBarSkin The IScrollBarSkin for ScrollBar asset.		 * @param scrollBarInitStyle The initial style for ScrollBar asset.
		 */
		public function TextAreaSkin ( 	textField : * = null , icon : * = null , background : * = null ,
										iconDisabled : * = null , backgroundDisabled : * = null , focusRect : * = null , errorRect : * = null ,
										scrollSkin : ISkin = null , scrollInitStyle : Object = null )
		{
			super(	textField == null ? TextAreaTextField : textField,
					icon == null ? TextAreaIcon : icon ,
					background == null ? TextAreaBackground : background ,
					iconDisabled == null ? TextAreaIconDisabled : iconDisabled ,
					backgroundDisabled == null ? TextAreaBackgroundDisabled : backgroundDisabled ,
					focusRect == null ? TextAreaFocusRect : focusRect ,
					errorRect == null ? null : errorRect );
			
			this.scrollSkin = scrollSkin;			this.scrollInitStyle = scrollInitStyle;
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
					scroll = ClassUtils.getInstance( ClassUtils.getClassByName( definition , applicationDomain ) , null , scrollInitStyle , scrollSkin ) as IScroll;
				else
					scroll = ClassUtils.getInstance( definition , null , scrollInitStyle , scrollSkin ) as IScroll;
			}
			catch( e : Error )
			{
					
			}
			
			return scroll;
		}
	}
}
