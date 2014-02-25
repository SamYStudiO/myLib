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
	import flash.display.Graphics;

	/**
	 * @author SamYStudiO ( contact@samystudio.net )
	 */
	public class ArrowAsset extends AShapeAsset
	{
		/**
		 * @private
		 */
		protected var _direction : String;
		
		/**
		 * 
		 */
		public function ArrowAsset( width : Number , height : Number , direction : String , prop : ShapeAssetProp )
		{
			super( prop );
			
			_width = width;
			_height = height;
			_direction = direction;
			
			draw();
		}
		
		/**
		 * @inheritDoc
		 */
		public override function draw(  ) : void
		{
			var g : Graphics = _border.graphics;
			g.clear();
			if( _prop.borderStyle == BorderStyle.LINE ) g.lineStyle( _prop.borderThickness , _prop.borderColor , _prop.borderAlpha , true );
			else if( _prop.borderStyle == BorderStyle.FILL ) g.beginFill( _prop.borderColor , _prop.borderAlpha );
			if( _prop.borderStyle != BorderStyle.NONE )
			{
				g.moveTo( 0 , 0 );
				g.lineTo( _width , 0 );
				g.lineTo( _width / 2 , _height );
				g.lineTo( 0 , 0 );
			}
			
			g = _fill.graphics;
			g.clear();
			g.beginFill( _prop.color , _prop.alpha );
			if( _prop.borderStyle != BorderStyle.NONE )
			{
				g.moveTo( _prop.borderThickness , _prop.borderThickness );
				g.lineTo( _width - _prop.borderThickness * 2 , _prop.borderThickness );
				g.lineTo( _width / 2 , _height - _prop.borderThickness * 2 );
				g.lineTo( _prop.borderThickness , _prop.borderThickness );
			}
			else
			{
				g.moveTo( 0 , 0 );
				g.lineTo( _width , 0 );
				g.lineTo( _width / 2 , _height );
				g.lineTo( 0 , 0 );
			}
			
			switch( _direction ) 
			{
				case ArrowDirection.UP 		: _border.rotation = _fill.rotation = 180 ; _border.x = _fill.x = _width; _border.y = _fill.y = _height; break;
				case ArrowDirection.RIGHT 	: _border.rotation = _fill.rotation = -90 ; _border.y = _fill.y = _height; break;
				case ArrowDirection.LEFT 	: _border.rotation = _fill.rotation = 90 ; _border.x = _fill.x = _width; break;
			}
		}
	}
}
