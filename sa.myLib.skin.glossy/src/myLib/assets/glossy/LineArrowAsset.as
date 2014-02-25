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
	public class LineArrowAsset extends ArrowAsset
	{
		/**
		 * @private
		 */
		protected var _thickness : uint;
				
		/**
		 *
		 */
		public function get direction() : String
		{
			return _direction;
		}
		
		public function set direction( direction : String ) : void
		{
			_direction = direction;
			
			switch( _direction ) 
			{
				case ArrowDirection.DOWN 	: _fill.rotation = 180 ; _fill.x = _width; _fill.y = _height; break;
				case ArrowDirection.LEFT 	: _fill.rotation = -90 ; _fill.y = _height; break;
				case ArrowDirection.RIGHT 	: _fill.rotation = 90 ; _fill.x = _width; break;
				
				default : _fill.rotation = 0; _fill.x = 0; _fill.y = 0; break;
			}
		}
		
		/**
		 * 
		 */
		public function LineArrowAsset( width : uint , height : uint , direction : String , thickness : uint , prop : ShapeAssetProp , selected : Boolean )
		{
			super( width , height , direction , prop , selected );
			
			_thickness = thickness;
		}
		
		/**
		 *
		 */
		public override function draw(  ) : void
		{
			var g : Graphics = _fill.graphics;
			g.clear();
			g.beginFill( _selected ? _prop.stateColor : _prop.alternativeColor , 1.0 );
			
			var cpt : int = -1;
			var thickness : uint; 
			
			while( ++cpt <= _height ) 
			{
				thickness = Math.min( _thickness ,(  _width - ( cpt * 2 ) ) / 2 );
				
				g.drawRect( cpt , _height - ( cpt + 1 ) , thickness, 1 );
				g.drawRect( _width - cpt - thickness , _height - ( cpt + 1 ) , thickness , 1 );
			}
			
			g.endFill();
			
			direction = _direction;
		}
	}
}
