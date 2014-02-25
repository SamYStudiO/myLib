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
 * Portions created by the Initial Developer are Copyright (C) 2008-2011
 * the Initial Developer. All Rights Reserved.
 *
 */
package myLib.assets
{
	import flash.display.BitmapData;
	import com.liquid.draw.LiquidBitmap;
	import com.liquid.draw.LiquidMapper;
	import com.liquid.grid.LiquidGrid;
	import com.liquid.skin.SkinAsset;

	/**
	 * @author SamYStudiO ( contact@samystudio.net )
	 */
	public class LiquidAsset extends Asset
	{
		/**
		 * @private
		 */
		protected var _grid : LiquidGrid;

		/**
		 * @private
		 */
		protected var _skin : LiquidBitmap;

		/**
		 * @private
		 */
		protected var _colors : Array;
		
		/**
		 *
		 */
		public function get colors() : Array
		{
			return _colors;
		}
		
		/**
		 * @private
		 */
		protected var _state : int = 0;
		
		/**
		 *
		 */
		public function get state() : uint
		{
			return _state;
		}
		
		public function set state( state : uint ) : void
		{
			_state = state;
			
			draw();
		}

		/**
		 * 
		 */
		public function LiquidAsset( bitmap : BitmapData )
		{
			var asset : SkinAsset = new SkinAsset( bitmap );

			_grid = asset.grid.clone();
			_skin = asset.liquidBitmap;
			_colors = asset.colors;

			super();
			
			_width = _grid.width;
			_height = _grid.height;
			
			draw();
		}

		/**
		 * @inheritDoc
		 */
		public override function draw() : void
		{
			graphics.clear();
			
			_grid.setSize( Math.round( _width ) , Math.round( _height ) );
			LiquidMapper.drawShape( _grid , _skin , graphics , _state );
		}
	}
}
