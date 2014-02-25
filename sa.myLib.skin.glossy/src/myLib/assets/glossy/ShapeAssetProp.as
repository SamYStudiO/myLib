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
	import flash.filters.BitmapFilter;
	/**
	 * @author SamYStudiO ( contact@samystudio.net )
	 */
	public final class ShapeAssetProp
	{
		/**
		 *
		 */
		public var mainColor : uint;
		
		/**
		 *
		 */
		public var alternativeColor : uint;
		
		/**
		 *
		 */
		public var stateColor : uint;
		
		/**
		 *
		 */
		public var filters : Array;
		
		/**
		 *
		 */
		public var cornerRadius : Number;
		
		/**
		 *
		 */
		public function ShapeAssetProp( mainColor : uint = 0xFFFFFF , alternativeColor : uint = 0xFFFFFF , stateColor : uint = 0xFF9000 , cornerRadius : Number = 0 , filters : Array = null )
		{
			this.mainColor = mainColor;
			this.alternativeColor = alternativeColor;
			this.stateColor = stateColor;
			this.filters = filters != null ? _cleanFilters( filters ) : null;
			this.cornerRadius = cornerRadius;
		}
		
		/**
		 *
		 */
		public function clone(  ) : ShapeAssetProp
		{
			return new ShapeAssetProp( mainColor , alternativeColor , stateColor , cornerRadius , filters );
		}
		
		/**
		 * @private
		 */
		protected function _cleanFilters( filters : Array ) : Array
		{
			var a : Array = new Array();
			
			var i : int = -1;
			var l : uint = filters.length;
			
			while( ++i < l ) 
			{
				if( filters[ i ] is BitmapFilter ) a.push( filters[ i ] );
			}
			
			
			return a.length > 0 ? a : null;
		}
	}
}
