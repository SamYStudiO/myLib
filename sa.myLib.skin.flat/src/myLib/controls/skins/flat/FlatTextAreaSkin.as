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
 * Portions created by the Initial Developer are Copyright (C) 2008-2012
 * the Initial Developer. All Rights Reserved.
 *
 */
package myLib.controls.skins.flat
{
	import myLib.assets.flat.ShapeAssetProp;
	import myLib.controls.skins.ISkin;
	import myLib.controls.skins.ITextAreaSkin;
	import myLib.core.AScroll;
	import myLib.core.IScroll;
	import myLib.styles.Padding;
	import myLib.utils.ClassUtils;

	/**
	 * @author SamYStudiO ( contact@samystudio.net )
	 */
	public class FlatTextAreaSkin extends FlatTextInputSkin implements ITextAreaSkin
	{
		/**
		 * @private
		 */
		protected var _scrollSkin : ISkin;
		
		/**
		 * 
		 */
		public function FlatTextAreaSkin( inputProp : ShapeAssetProp , focusProp : ShapeAssetProp = null , errorProp : ShapeAssetProp = null , scrollSkin : ISkin = null  )
		{
			super( inputProp , focusProp , errorProp );
			
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
					scroll = ClassUtils.getInstance( ClassUtils.getClassByName( definition , applicationDomain ) , null , null , _scrollSkin ) as AScroll;
				else
					scroll = ClassUtils.getInstance( definition , null , null , _scrollSkin ) as AScroll;
			}
			catch( e : Error )
			{
					
			}
			
			return scroll;
		}
		
		/**
		 * @inheritDoc
		 */
		public override function getStyle() : Object
		{
			return { padding : new Padding( 1 , 1 , 1 , 1 ) };
		}
	}
}
