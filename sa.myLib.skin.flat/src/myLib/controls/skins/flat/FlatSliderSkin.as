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
	import myLib.assets.flat.BorderStyle;
	import myLib.assets.flat.BoxAsset;
	import myLib.assets.flat.ShapeAssetProp;
	import myLib.controls.Button;
	import myLib.controls.SliderThumbAlignment;
	import myLib.controls.skins.ISliderSkin;

	/**
	 * @author SamYStudiO ( contact@samystudio.net )
	 */
	public class FlatSliderSkin extends AFlatSkin implements ISliderSkin
	{
		/**
		 * @private
		 */
		protected var _trackShapeProp : ShapeAssetProp;
		
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
		public function FlatSliderSkin( trackShapeProp : ShapeAssetProp , upShapeProp : ShapeAssetProp , overShapeProp : ShapeAssetProp , downShapeProp : ShapeAssetProp , disabledProp : ShapeAssetProp ,
										focusProp : ShapeAssetProp = null , errorProp : ShapeAssetProp = null )
		{
			super( focusProp , errorProp );
			
			_trackShapeProp = trackShapeProp;
			_upShapeProp = upShapeProp;
			_overShapeProp = overShapeProp;
			_downShapeProp = downShapeProp;
			_disabledProp = disabledProp;
		}

		/**
		 * @inheritDoc
		 */
		public override function getStyle() : Object
		{
			return { thumbVerticalAlignment : SliderThumbAlignment.TOP };
		}

		/**
		 * @inheritDoc
		 */
		public function getTrackAsset() : IAsset
		{
			return new Button( null , { text : "" , width : 20 , height : 10 } ,
													new FlatButtonSkin( _trackShapeProp , _trackShapeProp , _trackShapeProp , _trackShapeProp ,
																		_trackShapeProp , _trackShapeProp , _trackShapeProp , _trackShapeProp ) );
		}

		/**
		 * @inheritDoc
		 */
		public function getThumbAsset() : IAsset
		{
			return new Button( null , { text : "" , width : 20 , height : 10 } ,
													new FlatButtonSkin( _upShapeProp , _overShapeProp , _downShapeProp , _disabledProp ,
																		_upShapeProp , _overShapeProp , _downShapeProp , _disabledProp ) );
		}

		/**
		 * @inheritDoc
		 */
		public function getProgressAsset() : IAsset
		{
			var prop : ShapeAssetProp = _overShapeProp.clone();
			prop.borderStyle = BorderStyle.NONE;
			prop.alpha = .5;
			
			return new BoxAsset( prop );
		}
	}
}
