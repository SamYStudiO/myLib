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
package myLib.assets.flat
{
	/**
	 * @author SamYStudiO ( contact@samystudio.net )
	 */
	public final class ShapeAssetProp
	{
		/**
		 *
		 */
		public var color : uint;
		
		/**
		 *
		 */
		public var alpha : Number;
		
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
		public var borderColor : uint;
		
		/**
		 *
		 */
		public var borderAlpha : Number;
		
		/**
		 *
		 */
		public var borderThickness : Number;
		
		/**
		 *
		 */
		public var borderFilters : Array;
		
		/**
		 *
		 */
		public var borderStyle : String;
		
		/**
		 *
		 */
		public function ShapeAssetProp( color : uint = 0xFFFFFF , alpha : Number = 1.0 , filters : Array = null , cornerRadius : Number = 0 , borderColor : uint = 0x666666 , borderAlpha  : Number = 1.0 , borderThickness : Number = 1 , borderFilters : Array = null , borderStyle : String = "fill" )
		{
			this.color = color;
			this.alpha = alpha;
			this.filters = filters;
			this.cornerRadius = cornerRadius;
			this.borderColor = borderColor;
			this.borderAlpha = borderAlpha;
			this.borderThickness = borderThickness;
			this.borderFilters = borderFilters;
			this.borderStyle = borderStyle;
		}
		
		/**
		 *
		 */
		public function clone(  ) : ShapeAssetProp
		{
			return new ShapeAssetProp( color , alpha , filters , cornerRadius , borderColor , borderAlpha , borderThickness , borderFilters , borderStyle );
		}
	}
}
