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
	public class ScrollBarThumbAsset extends BoxAsset
	{
		/**
		 * @private
		 */
		protected var _box : BoxAsset;
		
		/**
		 * 
		 */
		public function ScrollBarThumbAsset( prop : ShapeAssetProp )
		{
			super( prop );
			
			_fill.filters = null;
			_box = new BoxAsset( prop );
			_box.x = 5;
			
			addChild( _box );
		}
		
		/**
		 * @inheritDoc
		 */
		public override function draw(  ) : void
		{
			var g : Graphics = _fill.graphics;
			g.clear();
			g.beginFill( _prop.mainColor , 0 );
			g.drawRect( 0 , 0 , _width , _height );
			g.endFill();
			
			_box.setSize( _width - 10 , _height );
		}
	}
}
