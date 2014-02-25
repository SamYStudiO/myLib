package myLib.assets.glossy
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
			var g : Graphics = _fill.graphics;
			g.clear();
			g.beginFill( _prop.mainColor , 1.0 );

			if( _prop.cornerRadius > 0 ) g.drawRoundRect( 0 , 0 , _width , _height  , _prop.cornerRadius , _prop.cornerRadius );
			else g.drawRect( 0 , 0 , _width , _height );
			
			g.endFill();
		}
	}
}
