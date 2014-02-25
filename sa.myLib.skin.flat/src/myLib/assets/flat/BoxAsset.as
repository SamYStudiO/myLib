package myLib.assets.flat
{
	import flash.display.Graphics;

	/**
	 * @author SamYStudiO ( contact@samystudio.net )
	 */
	public class BoxAsset extends AShapeAsset
	{
		/**
		 * 
		 */
		public function BoxAsset( prop : ShapeAssetProp )
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
				if( _prop.borderStyle == BorderStyle.FILL )
				{
					if( _prop.cornerRadius > 0 ) g.drawRoundRect( 0 , 0 , _width , _height , _prop.cornerRadius , _prop.cornerRadius );
					else g.drawRect( 0 , 0 , _width , _height );
				}
				else
				{
					if( _prop.cornerRadius > 0 ) 
					{
						g.drawRoundRect( 0 , 0 , _width , _height , _prop.cornerRadius , _prop.cornerRadius );
						g.drawRoundRect( _prop.borderThickness , _prop.borderThickness , _width - _prop.borderThickness * 2  , _height - _prop.borderThickness * 2 , _prop.cornerRadius - _prop.borderThickness , _prop.cornerRadius - _prop.borderThickness );
					}
					else
					{
						g.drawRect( 0 , 0 , _width , _height );
						g.drawRect( _prop.borderThickness , _prop.borderThickness , _width - _prop.borderThickness * 2  , _height - _prop.borderThickness * 2 );
					}
				}
			}
			
			g.endFill();
			
			g = _fill.graphics;
			g.clear();
			g.beginFill( _prop.color , _prop.alpha );
			if( _prop.borderStyle != BorderStyle.NONE )
			{
				if( _prop.cornerRadius > 0 ) g.drawRoundRect( _prop.borderThickness , _prop.borderThickness , _width - _prop.borderThickness * 2 , _height - _prop.borderThickness * 2  , _prop.cornerRadius - _prop.borderThickness , _prop.cornerRadius - _prop.borderThickness );
				else g.drawRect( _prop.borderThickness , _prop.borderThickness , _width - _prop.borderThickness * 2 , _height - _prop.borderThickness * 2 );
			}
			else
			{
				if( _prop.cornerRadius > 0 ) g.drawRoundRect( 0 , 0 , _width , _height  , _prop.cornerRadius , _prop.cornerRadius );
				else g.drawRect( 0 , 0 , _width , _height );
			}
			
			g.endFill();
		}
	}
}
