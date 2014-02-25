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
	import flash.display.BlendMode;
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.filters.BevelFilter;
	import flash.filters.DropShadowFilter;

	/**
	 * @author SamYStudiO ( contact@samystudio.net )
	 */
	public class RadioButtonIconAsset extends EllipseAsset
	{
		/**
		 * @private
		 */
		protected var _texture : Shape = new Shape();
		
		/**
		 * @private
		 */
		protected var _selectedFill : Shape;
		
		/**
		 * @private
		 */
		protected var _selectedOverlay : Shape;
		
		/**
		 * @private
		 */
		protected var _selected : Boolean;
		
		/**
		 * @private
		 */
		protected var _selectedShadowFilter : DropShadowFilter;
		
		/**
		 * 
		 */
		public function RadioButtonIconAsset( size : Number , prop : ShapeAssetProp , selected : Boolean = false , selectedShadowFilter : DropShadowFilter = null )
		{
			super( prop );
			
			_selected = selected;
			_selectedShadowFilter = selectedShadowFilter;
			_width = _height = size;
			
			draw();
		}
		
		/**
		 * @inheritDoc
		 */
		public override function draw(  ) : void
		{
			super.draw();
			
			var g : Graphics = _fill.graphics;
			g.beginBitmapFill( getTexturePattern() );
			g.drawEllipse( 0 , 0 , _width , _height );
			g.endFill();
			
			
			if( _selected )
			{
				_selectedFill = new Shape();
				_selectedFill.filters = _selectedShadowFilter != null ? [ _selectedShadowFilter ] : null;
				g = _selectedFill.graphics;
				g.beginFill( prop.stateColor , 1.0 );
				g.drawEllipse( _width / 4 , _height / 4 , _width / 2 , _height / 2 );
				
				var bevelFilter : BevelFilter = new BevelFilter( 4 , 30 , 0xFFFFFF , .75 , 0x000000 , .75 , _width / 4 ,  _height / 4 , 1 , 2 );
				
				_selectedOverlay = new Shape();
				_selectedOverlay.filters = [ bevelFilter ];
				
				g = _selectedOverlay.graphics;
				g.beginFill( prop.stateColor , 1.0 );
				g.drawEllipse( _width / 4 , _height / 4 , _width / 2 , _height / 2 );
				
				_selectedOverlay.blendMode = BlendMode.OVERLAY;
				
				addChild( _selectedFill );
				addChild( _selectedOverlay );
			}
		}
	}
}
