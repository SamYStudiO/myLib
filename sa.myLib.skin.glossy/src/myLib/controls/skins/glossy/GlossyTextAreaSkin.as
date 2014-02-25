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
package myLib.controls.skins.glossy
{
	import myLib.controls.skins.ITextAreaSkin;
	import myLib.core.IScroll;
	import myLib.utils.ClassUtils;

	import flash.filters.DropShadowFilter;
	/**
	 * @author SamYStudiO ( contact@samystudio.net )
	 */
	public class GlossyTextAreaSkin extends GlossyTextInputSkin implements ITextAreaSkin
	{
		/**
		 *
		 */
		public function GlossyTextAreaSkin( mainColor : uint , alternativeColor : uint , stateColor : uint , cornerRadius : Number , shadowFilter : DropShadowFilter = null , innerShadowFilter : DropShadowFilter = null )
		{
			super( mainColor , alternativeColor , stateColor , cornerRadius , shadowFilter , innerShadowFilter );
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
					scroll = ClassUtils.getInstance( ClassUtils.getClassByName( definition ) ) as IScroll;
				else
					scroll = ClassUtils.getInstance( definition ) as IScroll;
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
			return null;
		}
	}
}
