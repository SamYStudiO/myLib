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
	import myLib.assets.flat.BoxAsset;
	import myLib.assets.flat.ShapeAssetProp;
	import myLib.controls.Button;
	import myLib.controls.IList;
	import myLib.controls.ITextInput;
	import myLib.controls.List;
	import myLib.controls.TextInput;
	import myLib.controls.skins.IComboBoxSkin;
	import myLib.controls.skins.IListSkin;

	/**
	 * @author SamYStudiO ( contact@samystudio.net )
	 */
	public class FlatComboBoxSkin extends AFlatSkin implements IComboBoxSkin
	{
		/**
		 * @private
		 */
		protected var _listSkin : IListSkin;
		
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
		public function FlatComboBoxSkin(	upShapeProp : ShapeAssetProp , overShapeProp : ShapeAssetProp , downShapeProp : ShapeAssetProp , disabledProp : ShapeAssetProp ,
											focusProp : ShapeAssetProp = null , errorProp : ShapeAssetProp = null , listSkin : IListSkin = null )
		{
			super( focusProp , errorProp );
			
			_listSkin = listSkin;
			_upShapeProp = upShapeProp;
			_overShapeProp = overShapeProp;
			_downShapeProp = downShapeProp;
			_disabledProp = disabledProp;
		}

		/**
		 * @inheritDoc
		 */
		public function getBoxAsset() : IAsset
		{
			return new BoxAsset( _upShapeProp );
		}

		/**
		 * @inheritDoc
		 */
		public function getArrowButtonAsset() : IAsset
		{
			var prop : ShapeAssetProp = _upShapeProp.clone();
			prop.color = prop.borderColor;
			prop.borderStyle = BorderStyle.NONE;
			
			return new Button( null , { text : "" , icon : new ArrowAsset( 6 , 6 , ArrowDirection.DOWN , prop ) , width : 20 } ,
													new FlatButtonSkin( _upShapeProp , _overShapeProp , _downShapeProp , _disabledProp ) );
		}

		/**
		 * @inheritDoc
		 */
		public function getTextInputAsset() : ITextInput
		{
			var ti : TextInput = new TextInput(  );
			ti.backgroundAsset.visible = false;
			
			return ti;
		}

		/**
		 * @inheritDoc
		 */
		public function getListAsset() : IList
		{
			return new List( null , null , _listSkin );
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
