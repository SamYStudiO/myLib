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
package myLib.controls.skins.flat
{
	import myLib.assets.IAsset;
	import myLib.assets.flat.ArrowAsset;
	import myLib.assets.flat.ArrowDirection;
	import myLib.assets.flat.BorderStyle;
	import myLib.assets.flat.ShapeAssetProp;
	import myLib.controls.Button;
	import myLib.controls.skins.IScrollBarSkin;

	/**
	 * @author SamYStudiO ( contact@samystudio.net )
	 */
	public class FlatScrollBarSkin extends AFlatSkin implements IScrollBarSkin
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
		 * 
		 */
		public function FlatScrollBarSkin( 	upShapeProp : ShapeAssetProp , overShapeProp : ShapeAssetProp , downShapeProp : ShapeAssetProp , disabledProp : ShapeAssetProp )
		{
			super( );

			_upShapeProp = upShapeProp;
			_overShapeProp = overShapeProp;
			_downShapeProp = downShapeProp;
			_disabledProp = disabledProp;
		}

		/**
		 * @inheritDoc
		 */
		public function getUpAsset() : IAsset
		{
			var prop : ShapeAssetProp = _upShapeProp.clone();
			prop.color = prop.borderColor;
			prop.borderStyle = BorderStyle.NONE;
			
			return new Button( null , { text : "" , icon : new ArrowAsset( 4 , 4 , ArrowDirection.UP , prop ) , height : 12 , disabledDragOutState : true } ,
													new FlatButtonSkin( _upShapeProp , _overShapeProp , _downShapeProp , _disabledProp ) );
		}

		/**
		 * @inheritDoc
		 */
		public function getDownAsset() : IAsset
		{
			var prop : ShapeAssetProp = _upShapeProp.clone();
			prop.color = prop.borderColor;
			prop.borderStyle = BorderStyle.NONE;
			
			return new Button( null , { text : "" , icon : new ArrowAsset( 4 , 4 , ArrowDirection.DOWN , prop ) , height : 12 , disabledDragOutState : true } ,
													new FlatButtonSkin( _upShapeProp , _overShapeProp , _downShapeProp , _disabledProp ) );
		}

		/**
		 * @inheritDoc
		 */
		public function getThumbAsset() : IAsset
		{
			return new Button( null , { text : "" , disabledDragOutState : true } , new FlatButtonSkin( 	_upShapeProp , _overShapeProp , _overShapeProp , _disabledProp ) );
		}

		/**
		 * @inheritDoc
		 */
		public function getThumbBackgroundAsset() : IAsset
		{
			var prop : ShapeAssetProp = _upShapeProp.clone();
			prop.color = prop.borderColor;
			prop.borderStyle = BorderStyle.NONE;
			prop.filters = _downShapeProp.filters;
			
			return new Button( null , { text : "" , disabledDragOutState : true } , new FlatButtonSkin( 	prop , prop , prop , prop ,
																			prop , prop , prop , prop ) );
		}

		/**
		 * @inheritDoc
		 */
		public override function getFocusRectAsset() : IAsset
		{
			return null;
		}

		/**
		 * @inheritDoc
		 */
		public override function getStyle() : Object
		{
			return { width : 12 };
		}
	}
}
