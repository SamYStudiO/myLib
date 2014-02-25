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
	public class ArrowAsset extends AShapeAsset
	{
		/**
		 * @private
		 */
		protected var _direction : String;
		
		/**
		 * @private
		 */
		protected var _selected : Boolean;
		
		/**
		 * 
		 */
		public function ArrowAsset( width : uint , height : uint , direction : String , prop : ShapeAssetProp , selected : Boolean )
		{
			super( prop );
			
			_selected = selected;
			
			_width = width;
			_height = height;
			_direction = direction;
			
			draw();
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
			while( ++cpt <= _height ) 
			{
				g.drawRect( cpt , _height - ( cpt + 1 ) , _width - ( cpt * 2 ) , 1 );
			}
			
			g.endFill();
			
			switch( _direction ) 
			{
				case ArrowDirection.DOWN 	: _fill.rotation = _fill.rotation = 180 ; _fill.x = _fill.x = _width; _fill.y = _fill.y = _height; break;
				case ArrowDirection.LEFT 	: _fill.rotation = _fill.rotation = -90 ; _fill.y = _fill.y = _height; break;
				case ArrowDirection.RIGHT 	: _fill.rotation = _fill.rotation = 90 ; _fill.x = _fill.x = _width; break;
			}
		}
	}
}
