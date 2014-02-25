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
package myLib.styles
{
	import myLib.utils.ClassUtils;

	import flash.text.StyleSheet;
	import flash.text.TextField;

	/**
	 * @author SamYStudiO ( contact@samystudio.net )
	 */
	public dynamic class CSSTextStyle extends TextStyle
	{
		/**
		 * 
		 */
		public function CSSTextStyle( styleObject : Object , bitmapFonts : Boolean = false , useEmbedFonts : * = null )
		{
			var css : StyleSheet = new StyleSheet();
			css.setStyle( ".temp" , styleObject );
			
			super( css.transform( styleObject ) , bitmapFonts , useEmbedFonts );
			
			for each( var prop : String in styleObject ) 
			{
				if( ClassUtils.hasWritableVariableOrAccessor( TextField , prop ) )
					this[ prop ] = styleObject[ prop ];
			}
		}
	}
}
