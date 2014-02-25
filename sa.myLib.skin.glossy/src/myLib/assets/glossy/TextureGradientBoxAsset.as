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
	import flash.display.GradientType;
	import flash.display.Graphics;
	import flash.geom.Matrix;

	/**
	 * @author SamYStudiO ( contact@samystudio.net )
	 */
	public class TextureGradientBoxAsset extends TextureBoxAsset
	{
		/**
		 * 
		 */
		public function TextureGradientBoxAsset( prop : ShapeAssetProp )
		{
			super( prop );
		}
		
		/**
		 * @inheritDoc
		 */
		public override function draw(  ) : void
		{
			super.draw();
			
			var g : Graphics = _fill.graphics;
			var colors : Array = [ _prop.mainColor , _prop.mainColor , _prop.stateColor , _prop.stateColor ];
			var alphas : Array = [ .5 , 0 , 0 , .1 ];
			var ratios : Array = [ 0x00 , 0x64 , 0x9B , 0xFF ];
			var matrix : Matrix = new Matrix();
			matrix.createGradientBox( _width , _height , Math.PI / 2 );
			
			g.beginGradientFill( GradientType.LINEAR , colors , alphas , ratios , matrix );
			if( _prop.cornerRadius > 0 ) g.drawRoundRect( 0 , 0 , _width , _height  , _prop.cornerRadius , _prop.cornerRadius );
			else g.drawRect( 0 , 0 , _width , _height );
			g.endFill();
		}
	}
}
