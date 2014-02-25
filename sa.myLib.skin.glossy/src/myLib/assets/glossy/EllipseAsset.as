package myLib.assets.glossy
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
			var g : Graphics = _fill.graphics;
			g.clear();
			g.beginFill( _prop.mainColor , 1.0 );
			g.drawEllipse( 0 , 0 , _width , _height );
			g.endFill();
		}
	}
}
