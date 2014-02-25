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
package myLib.controls.skins.glossy
{
	import flash.filters.DropShadowFilter;
	import myLib.assets.IAsset;
	import myLib.assets.ITextFieldAsset;
	import myLib.assets.TextFieldAsset;
	import myLib.assets.glossy.CheckBoxIconAsset;
	import myLib.assets.glossy.ShapeAssetProp;


	/**
	 * @author SamYStudiO ( contact@samystudio.net )
	 */
	public class GlossyCheckBoxSkin extends GlossyButtonSkin
	{
		/**
		 * @private
		 */
		protected var _iconSize : Number;
		/**
		 * 
		 */
		public function GlossyCheckBoxSkin( iconSize : Number , mainColor : uint , alternativeColor : uint , stateColor : uint , cornerRadius : Number , shadowFilter : DropShadowFilter = null , innerShadowFilter : DropShadowFilter = null )
		{
			super( mainColor , alternativeColor , stateColor , cornerRadius , shadowFilter , innerShadowFilter );
			
			_iconSize = iconSize;
		}
		
		/**
		 * @inheritDoc
		 */
		public override function getUpSelectedAsset() : IAsset
		{
			return null;
		}

		/**
		 * @inheritDoc
		 */
		public override function getOverAsset() : IAsset
		{
			return null;
		}

		/**
		 * @inheritDoc
		 */
		public override function getOverSelectedAsset() : IAsset
		{
			return null;
		}

		/**
		 * @inheritDoc
		 */
		public override function getDownAsset() : IAsset
		{
			return null;
		}

		/**
		 * @inheritDoc
		 */
		public override function getDownSelectedAsset() : IAsset
		{
			return null;
		}

		/**
		 * @inheritDoc
		 */
		public override function getDisabledAsset() : IAsset
		{
			return null;
		}

		/**
		 * @inheritDoc
		 */
		public override function getDisabledSelectedAsset() : IAsset
		{
			return null;
		}

		/**
		 * @inheritDoc
		 */
		public override function getIconUpSelectedAsset( ) : IAsset
		{
			return new CheckBoxIconAsset( _iconSize , new ShapeAssetProp( _mainColor , _alternativeColor , _stateColor , _cornerRadius , [ _shadowFilter , _innerShadowFilter ] ) , true , _shadowFilter );
		}

		/**
		 * @inheritDoc
		 */
		public override function getIconOverAsset( ) : IAsset
		{
			return new CheckBoxIconAsset( _iconSize , new ShapeAssetProp( _mainColor , _alternativeColor , _stateColor , _cornerRadius , [ _shadowFilter , _innerShadowFilter ] ) , false , _shadowFilter );
		}

		/**
		 * @inheritDoc
		 */
		public override function getIconOverSelectedAsset( ) : IAsset
		{
			return new CheckBoxIconAsset( _iconSize , new ShapeAssetProp( _mainColor , _alternativeColor , _stateColor , _cornerRadius , [ _shadowFilter , _innerShadowFilter ] ) , true , _shadowFilter );
		}

		/**
		 * @inheritDoc
		 */
		public override function getIconDownAsset( ) : IAsset
		{
			return new CheckBoxIconAsset( _iconSize , new ShapeAssetProp( _mainColor , _alternativeColor , _stateColor , _cornerRadius , [ _shadowFilter , _innerShadowFilter ] ) , false , _shadowFilter );
		}

		/**
		 * @inheritDoc
		 */
		public override function getIconDownSelectedAsset( ) : IAsset
		{
			return new CheckBoxIconAsset( _iconSize , new ShapeAssetProp( _mainColor , _alternativeColor , _stateColor , _cornerRadius , [ _shadowFilter , _innerShadowFilter ] ) , true , _shadowFilter );
		}

		/**
		 * @inheritDoc
		 */
		public override function getIconDisabledAsset( ) : IAsset
		{
			return new CheckBoxIconAsset( _iconSize , new ShapeAssetProp( _mainColor , _alternativeColor , _stateColor , _cornerRadius , [ _shadowFilter , _innerShadowFilter ] ) , false , _shadowFilter );
		}

		/**
		 * @inheritDoc
		 */
		public override function getIconDisabledSelectedAsset( ) : IAsset
		{
			return new CheckBoxIconAsset( _iconSize , new ShapeAssetProp( _mainColor , _alternativeColor , _stateColor , _cornerRadius , [ _shadowFilter , _innerShadowFilter ] ) , true , _shadowFilter );
		}

		/**
		 * @inheritDoc
		 */
		public override function getTextFieldAsset() : ITextFieldAsset
		{
			return new TextFieldAsset();
		}

		/**
		 * @inheritDoc
		 */
		public override function getIconUpAsset( ) : IAsset
		{
			return new CheckBoxIconAsset( _iconSize , new ShapeAssetProp( _mainColor , _alternativeColor , _stateColor , _cornerRadius , [ _shadowFilter , _innerShadowFilter ] ) , false , _shadowFilter );
		}

		/**
		 * @inheritDoc
		 */
		public override function getUpAsset() : IAsset
		{
			return null;
		}
	}
}
