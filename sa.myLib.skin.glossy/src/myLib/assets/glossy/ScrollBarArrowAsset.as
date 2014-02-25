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

	import flash.display.BitmapData;
	import flash.display.Graphics;

	/**
	 * @author SamYStudiO ( contact@samystudio.net )
	 */
	public class ScrollBarArrowAsset extends BoxAsset
	{
		/**
		 * @private
		 */
		protected var _direction : String;
		
		/**
		 * @private
		 */
		protected var _boxArrow : BoxAsset;
		
		/**
		 * @private
		 */
		protected var _arrow : ArrowAsset;
		
		/**
		 * @private
		 */
		protected var _mask : RectangeShape = new RectangeShape();
		
		/**
		 * @private
		 */
		protected var _texturePattern : BitmapData;
		
		/**
		 * 
		 */
		public function ScrollBarArrowAsset( texturePattern : BitmapData , direction : String , prop : ShapeAssetProp , selected : Boolean )
		{
			super( prop );
			
			_texturePattern = texturePattern;
			_boxArrow = new BoxAsset( prop );
			_boxArrow.x = 5;
			_boxArrow.y = 5;
			_direction = direction;
			_arrow = new ArrowAsset( 10 , 10 , direction , new ShapeAssetProp( prop.mainColor , prop.alternativeColor , prop.stateColor ) , selected );
			
			_mask.x = -50;
			_mask.y = direction == ArrowDirection.UP ? -50 : 0;
			
			_fill.y = direction == ArrowDirection.UP ? 0 : -50;
			mask = _mask;
			
			addChild( _boxArrow );
			addChild( _arrow );
			addChild( _mask );
		}
		
		/**
		 * @inheritDoc
		 */
		public override function draw(  ) : void
		{
			var g : Graphics = _fill.graphics;
			g.clear();
			g.beginFill( _texturePattern == null ?_prop.alternativeColor : _prop.mainColor , 1.0 );

			if( _prop.cornerRadius > 0 ) g.drawRoundRectComplex( 0 , 0 , _width , _height + 50 , _direction == ArrowDirection.UP && _texturePattern != null ? _prop.cornerRadius / 2 : 0 ,
																								_direction == ArrowDirection.UP && _texturePattern != null ? _prop.cornerRadius / 2 : 0 ,
																								_direction == ArrowDirection.DOWN && _texturePattern != null ? _prop.cornerRadius / 2 : 0,
																								_direction == ArrowDirection.DOWN && _texturePattern != null ? _prop.cornerRadius / 2 : 0 );
			else g.drawRect( 0 , 0 , _width , _height+ 50 );
			
			g.endFill();
			
			if( _texturePattern != null )
			{
				g.beginBitmapFill( _texturePattern );
				if( _prop.cornerRadius > 0 )g.drawRoundRectComplex( 0 , 0 , _width , _height + 50 , _direction == ArrowDirection.UP && _texturePattern != null ? _prop.cornerRadius / 2 : 0 ,
																									_direction == ArrowDirection.UP && _texturePattern != null ? _prop.cornerRadius / 2 : 0 ,
																									_direction == ArrowDirection.DOWN && _texturePattern != null ? _prop.cornerRadius / 2 : 0,
																									_direction == ArrowDirection.DOWN && _texturePattern != null ? _prop.cornerRadius / 2 : 0 );
				else g.drawRect( 0 , 0 , _width , _height + 50 );
				g.endFill();
			}
			
			_boxArrow.setSize( _width - 10 , _height - 10 );
			
			var aw : Number = Math.round( _boxArrow.width / 2 );
			aw = NumberUtils.isOdd( aw ) ? aw + 1 : aw;
			
			_arrow.setSize( aw , aw / 2 );
			_arrow.move( Math.round( ( _width - _arrow.width ) / 2 ) , Math.round( ( _height - _arrow.height ) / 2 ) );
			
			_mask.width = _fill.width + 100;
			_mask.height = _height + 50;
		}
	}
}
