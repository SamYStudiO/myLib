package myLib.assets.flat
{
	import flash.display.Graphics;

	/**
	 * @author SamYStudiO ( contact@samystudio.net )
	 */
	public class EllipseAsset extends AShapeAsset
	{
		/**
		 * 
		 */
		public function EllipseAsset( prop : ShapeAssetProp )
		{
			super( prop );
			
		}
		
		/**
		 * @inheritDoc
		 */
		public override function draw(  ) : void
		{
			var g : Graphics = _border.graphics;
			g.clear();
			if( _prop.borderStyle == BorderStyle.LINE ) g.lineStyle( _prop.borderThickness , _prop.borderColor , _prop.borderAlpha , true );
			else if( _prop.borderStyle == BorderStyle.FILL || _prop.borderStyle == BorderStyle.FILLED_LINE ) g.beginFill( _prop.borderColor , _prop.borderAlpha );
			if( _prop.borderStyle != BorderStyle.NONE )
			{
				if( _prop.borderStyle == BorderStyle.FILL ) g.drawEllipse( 0 , 0 , _width , _height );
				else
				{
					g.drawEllipse( 0 , 0 , _width , _height );
					g.drawEllipse( _prop.borderThickness , _prop.borderThickness , _width - _prop.borderThickness * 2  , _height - _prop.borderThickness * 2 );
				}
			}
			
			g = _fill.graphics;
			g.clear();
			g.beginFill( _prop.color , _prop.alpha );
			if( _prop.borderStyle != BorderStyle.NONE ) g.drawEllipse( _prop.borderThickness , _prop.borderThickness , _width - _prop.borderThickness * 2 , _height - _prop.borderThickness * 2 );
			else g.drawEllipse( 0 , 0 , _width , _height );
		}
	}
}
