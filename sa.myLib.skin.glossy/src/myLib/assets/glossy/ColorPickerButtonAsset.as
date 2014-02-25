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
	import myLib.utils.NumberUtils;
	import flash.display.Graphics;
	import flash.display.Shape;

	/**
	 * @author SamYStudiO ( contact@samystudio.net )
	 */
	public class ColorPickerButtonAsset extends TextureBoxAsset
	{
		/**
		 * @private
		 */
		protected var _arrow : ArrowAsset;
		
		/**
		 * @private
		 */
		protected var _circle : Shape = new Shape();
		
		/**
		 * 
		 */
		public function ColorPickerButtonAsset( prop : ShapeAssetProp , selected : Boolean )
		{
			super( prop );
			
			_arrow = new ArrowAsset( 6 , 3 , ArrowDirection.DOWN , new ShapeAssetProp( prop.mainColor , prop.alternativeColor , prop.stateColor ) , selected );
			_circle.filters = _prop.filters[ 0 ] != null ? [ _prop.filters[ 0 ]] : null;
		
		
			addChild( _circle );
			addChild( _arrow );
		}
		
		/**
		 * @inheritDoc
		 */
		public override function draw(  ) : void
		{
			var offsetW : Number = Math.round( _width / 8 );
			var offsetH : Number = Math.round( _height / 8 );
			var g : Graphics = _fill.graphics;
			g.clear();
			g.beginFill( _prop.mainColor , 1.0 );

			if( _prop.cornerRadius > 0 ) g.drawRoundRect( 0 , 0 , _width , _height  , _prop.cornerRadius , _prop.cornerRadius );
			else g.drawRect( 0 , 0 , _width , _height );
			
			g.drawRect( offsetW , offsetH , _width - 2 * offsetW , _height - 2 * offsetH );
			
			g.endFill();
			
			g.beginBitmapFill( getTexturePattern() );
			if( _prop.cornerRadius > 0 ) g.drawRoundRect( 0 , 0 , _width , _height  , _prop.cornerRadius , _prop.cornerRadius );
			else g.drawRect( 0 , 0 , _width , _height );
			
			g.drawRect( offsetW , offsetH , _width - 2 * offsetW , _height - 2 * offsetH );
			g.endFill();
			
			g.beginFill( _prop.mainColor , 0 );

			if( _prop.cornerRadius > 0 ) g.drawRoundRect( 0 , 0 , _width , _height  , _prop.cornerRadius , _prop.cornerRadius );
			else g.drawRect( 0 , 0 , _width , _height );
			
			g.endFill();
			
			g = _circle.graphics;
			g.clear();
			g.beginFill( _prop.mainColor , 1.0 );
			g.drawEllipse( 0 , 0 , Math.round( _width / 4 ) , Math.round( _height / 4 ) );
			
			_circle.x = Math.round( _width - _circle.width - 2);
			_circle.y = Math.round( _height - _circle.height - 2 );
			
			var aw : Number = _circle.width / 2;
			aw = NumberUtils.isOdd( aw ) ? aw + 1 : aw;
			
			_arrow.width = aw;
			_arrow.height = _arrow.width / 2;
			
			_arrow.x = Math.round( _circle.x + ( _circle.width - _arrow.width ) / 2 );
			_arrow.y = Math.round( _circle.y + ( _circle.height - _arrow.height ) / 2 );
			
		}
	}
}
