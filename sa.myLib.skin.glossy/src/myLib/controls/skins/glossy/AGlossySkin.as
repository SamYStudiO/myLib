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
	import flash.filters.DropShadowFilter;

	/**
	 * @author SamYStudiO ( contact@samystudio.net )
	 */
	public class AGlossySkin
	{
		/**
		 * @private
		 */
		protected var _mainColor : uint;
		
		/**
		 * @private
		 */
		protected var _alternativeColor : uint;
		
		/**
		 * @private
		 */
		protected var _stateColor : uint;
		
		/**
		 * @private
		 */
		protected var _cornerRadius : Number;
		
		/**
		 * @private
		 */
		protected var _shadowFilter : DropShadowFilter;
		
		/**
		 * @private
		 */
		protected var _innerShadowFilter : DropShadowFilter;
		
		/**
		 *
		 */
		public function AGlossySkin( mainColor : uint , alternativeColor : uint , stateColor : uint , cornerRadius : Number , shadowFilter : DropShadowFilter = null , innerShadowFilter : DropShadowFilter = null )
		{
			_mainColor = mainColor;
			_alternativeColor = alternativeColor;
			_stateColor = stateColor;
			_cornerRadius = cornerRadius;
			_shadowFilter = shadowFilter;
			_innerShadowFilter = innerShadowFilter;
		}
		
		/**
		 * @inheritDoc
		 */
		public function getStyle(  ) : Object
		{
			return null;
		}
	}
}
