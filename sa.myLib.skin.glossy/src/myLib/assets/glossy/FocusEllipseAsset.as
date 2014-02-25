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
	import flash.display.Graphics;
	import flash.filters.BlurFilter;

	/**
	 * @author SamYStudiO ( contact@samystudio.net )
	 */
	public class FocusEllipseAsset extends AShapeAsset
	{
		/**
		 * 
		 */
		public function FocusEllipseAsset( prop : ShapeAssetProp )
		{
			super( prop );
			
			_fill.filters = [ new BlurFilter( 5 , 5 , 2 ) ];
		}
		
		/**
		 *
		 */
		public override function draw(  ) : void
		{
			trace( this , "draw<<<<<<<<<<<<<<<<<<<" );
			
			var g : Graphics = _fill.graphics;
			g.clear();
			g.lineStyle( 3 , _prop.stateColor );
			g.drawEllipse( 0 , 0 , _width , _height );
		}
	}
}
