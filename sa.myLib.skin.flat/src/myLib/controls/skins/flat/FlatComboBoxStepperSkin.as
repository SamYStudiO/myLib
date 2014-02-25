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
	import myLib.controls.skins.IComboBoxStepperSkin;
	import myLib.controls.skins.IListSkin;

	/**
	 * @author SamYStudiO ( contact@samystudio.net )
	 */
	public class FlatComboBoxStepperSkin extends FlatComboBoxSkin implements IComboBoxStepperSkin
	{
		/**
		 * 
		 */
		public function FlatComboBoxStepperSkin(	upShapeProp : ShapeAssetProp , overShapeProp : ShapeAssetProp , downShapeProp : ShapeAssetProp , disabledProp : ShapeAssetProp ,
													focusProp : ShapeAssetProp = null , errorProp : ShapeAssetProp = null , listSkin : IListSkin = null )
		{
			super( upShapeProp , overShapeProp , downShapeProp , disabledProp , focusProp , errorProp , listSkin );
		}

		/**
		 * @inheritDoc
		 */
		public function getNextAsset() : IAsset
		{
			var prop : ShapeAssetProp = _upShapeProp.clone();
			prop.color = prop.borderColor;
			prop.borderStyle = BorderStyle.NONE;
			
			return new Button( null , { text : "" , icon : new ArrowAsset( 4 , 4 , ArrowDirection.UP , prop ) , width : 20 , height : 10 } ,
													new FlatButtonSkin( _upShapeProp , _overShapeProp , _downShapeProp , _disabledProp ) );
		}

		/**
		 * @inheritDoc
		 */
		public function getPreviousAsset() : IAsset
		{
			var prop : ShapeAssetProp = _upShapeProp.clone();
			prop.color = prop.borderColor;
			prop.borderStyle = BorderStyle.NONE;
			
			return new Button( null , { text : "" , icon : new ArrowAsset( 4 , 4 , ArrowDirection.DOWN , prop ) , width : 20 , height : 10 } ,
													new FlatButtonSkin( _upShapeProp , _overShapeProp , _downShapeProp , _disabledProp ) );
		}
	}
}
