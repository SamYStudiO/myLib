package myLib.controls.skins.flat
{
	import myLib.assets.IAsset;
	import myLib.assets.ITextFieldAsset;
	import myLib.assets.TextFieldAsset;
	import myLib.assets.flat.BoxAsset;
	import myLib.assets.flat.ShapeAssetProp;
	import myLib.controls.skins.IButtonSkin;

	/**
	 * @author SamYStudiO ( contact@samystudio.net )
	 */
	public class FlatButtonSkin extends AFlatSkin implements IButtonSkin
	{
		/**
		 * @private
		 */
		protected var _upShapeProp : ShapeAssetProp;
		
		/**
		 * @private
		 */
		protected var _overShapeProp : ShapeAssetProp;
		
		/**
		 * @private
		 */
		protected var _downShapeProp : ShapeAssetProp;
		
		/**
		 * @private
		 */
		protected var _disabledProp : ShapeAssetProp;
		
		/**
		 * @private
		 */
		protected var _upSelectedShapeProp : ShapeAssetProp;
		
		/**
		 * @private
		 */
		protected var _overSelectedShapeProp : ShapeAssetProp;
		
		/**
		 * @private
		 */
		protected var _downSelectedShapeProp : ShapeAssetProp;
		
		/**
		 * @private
		 */
		protected var _disabledSelectedProp : ShapeAssetProp;

		/**
		 * 
		 */
		public function FlatButtonSkin( upShapeProp : ShapeAssetProp , overShapeProp : ShapeAssetProp , downShapeProp : ShapeAssetProp , disabledProp : ShapeAssetProp ,
										upSelectedShapeProp : ShapeAssetProp = null , overSelectedShapeProp : ShapeAssetProp = null , downSelectedShapeProp : ShapeAssetProp = null , disabledSelectedProp : ShapeAssetProp = null , focusProp : ShapeAssetProp = null , errorProp : ShapeAssetProp = null )
		{
			super( focusProp , errorProp );

			_upShapeProp = upShapeProp;
			_overShapeProp = overShapeProp;
			_downShapeProp = downShapeProp;
			_disabledProp = disabledProp;
			_upSelectedShapeProp = upSelectedShapeProp;
			_overSelectedShapeProp = overSelectedShapeProp;
			_downSelectedShapeProp = downSelectedShapeProp;
			_disabledSelectedProp = disabledSelectedProp;
		}

		/**
		 * @inheritDoc
		 */
		public function getUpSelectedAsset() : IAsset
		{
			return new BoxAsset( _upSelectedShapeProp );
		}

		/**
		 * @inheritDoc
		 */
		public function getOverAsset() : IAsset
		{
			return new BoxAsset( _overShapeProp );
		}

		/**
		 * @inheritDoc
		 */
		public function getOverSelectedAsset() : IAsset
		{
			return new BoxAsset( _overSelectedShapeProp );
		}

		/**
		 * @inheritDoc
		 */
		public function getDownAsset() : IAsset
		{
			return new BoxAsset( _downShapeProp );
		}

		/**
		 * @inheritDoc
		 */
		public function getDownSelectedAsset() : IAsset
		{
			return new BoxAsset( _downSelectedShapeProp );
		}

		/**
		 * @inheritDoc
		 */
		public function getDisabledAsset() : IAsset
		{
			return new BoxAsset( _disabledProp );
		}

		/**
		 * @inheritDoc
		 */
		public function getDisabledSelectedAsset() : IAsset
		{
			return new BoxAsset( _disabledSelectedProp );
		}

		/**
		 * @inheritDoc
		 */
		public function getIconUpSelectedAsset( ) : IAsset
		{
			return null;
		}

		/**
		 * @inheritDoc
		 */
		public function getIconOverAsset( ) : IAsset
		{
			return null;
		}

		/**
		 * @inheritDoc
		 */
		public function getIconOverSelectedAsset( ) : IAsset
		{
			return null;
		}

		/**
		 * @inheritDoc
		 */
		public function getIconDownAsset( ) : IAsset
		{
			return null;
		}

		/**
		 * @inheritDoc
		 */
		public function getIconDownSelectedAsset( ) : IAsset
		{
			return null;
		}

		/**
		 * @inheritDoc
		 */
		public function getIconDisabledAsset( ) : IAsset
		{
			return null;
		}

		/**
		 * @inheritDoc
		 */
		public function getIconDisabledSelectedAsset( ) : IAsset
		{
			return null;
		}

		/**
		 * @inheritDoc
		 */
		public function getTextFieldAsset() : ITextFieldAsset
		{
			return new TextFieldAsset();
		}

		/**
		 * @inheritDoc
		 */
		public function getIconUpAsset( ) : IAsset
		{
			return null;
		}

		/**
		 * @inheritDoc
		 */
		public function getUpAsset() : IAsset
		{
			return new BoxAsset( _upShapeProp );
		}

		/**
		 * @inheritDoc
		 */
		public override function getStyle() : Object
		{
			return null;
		}
	}
}
