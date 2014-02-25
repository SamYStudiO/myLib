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

	/**
	 * @author SamYStudiO ( contact@samystudio.net )
	 */
	public class StepperInputBoxAsset extends TextureBoxAsset
	{
		/**
		 * @private
		 */
		protected var _mask : RectangeShape = new RectangeShape( 10 , 10 );
		
		/**
		 * 
		 */
		public function StepperInputBoxAsset( prop : ShapeAssetProp )
		{
			super( prop );
			
			_mask.x = -50;
			_mask.y = -50;
			mask = _mask;
			addChild( _mask );
		}
		
		/**
		 * @inheritDoc
		 */
		public override function draw(  ) : void
		{
			var g : Graphics = _fill.graphics;
			g.clear();
			g.beginFill( _prop.mainColor , 1.0 );

			if( _prop.cornerRadius > 0 ) g.drawRoundRect( 0 , 0 , _width + 50 , _height  , _prop.cornerRadius , _prop.cornerRadius );
			else g.drawRect( 0 , 0 , _width + 50 , _height );
			
			g.endFill();
			
			g.beginBitmapFill( getTexturePattern() );
			if( _prop.cornerRadius > 0 ) g.drawRoundRect( 0 , 0 , _width + 50 , _height  , _prop.cornerRadius , _prop.cornerRadius );
			else g.drawRect( 0 , 0 , _width + 50 , _height );
			g.endFill();
			
			_mask.width = _width + 50;
			_mask.height = _height + 100;
		}
	}
}
