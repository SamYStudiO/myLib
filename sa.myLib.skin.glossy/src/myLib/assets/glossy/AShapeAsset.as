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
package myLib.assets.glossy
{
	import flash.display.Sprite;
	import myLib.assets.Asset;
	/**
	 * @author SamYStudiO ( contact@samystudio.net )
	 */
	public class AShapeAsset extends Asset
	{
		/**
		 * @private
		 */
		protected var _prop : ShapeAssetProp;
		
		
		/**
		 * @private
		 */
		protected var _fill : Sprite = new Sprite();
		
		
		/**
		 *
		 */
		public function get prop() : ShapeAssetProp
		{
			return _prop;
		}
		
		/**
		 * 
		 */
		public function AShapeAsset( prop : ShapeAssetProp )
		{
			super();
			
			_prop = prop;
			
			if( prop != null ) _fill.filters = prop.filters;
			
			addChild( _fill );
		}
	}
}
