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
 * Portions created by the Initial Developer are Copyright (C) 2008-2011
 * the Initial Developer. All Rights Reserved.
 *
 */
package
{
	import myLib.controls.Button;
	import myLib.controls.CheckBox;
	import myLib.controls.ComboBox;
	import myLib.controls.List;
	import myLib.controls.RadioButton;
	import myLib.controls.TextArea;
	import myLib.controls.TextInput;
	import myLib.controls.skins.liquid.LiquidSkinSet;
	import myLib.controls.skins.setDefaultSkinSet;
	import myLib.data.DataProvider;
	import myLib.displayUtils.USE_PIXEL_SNAPPING;

	import flash.display.Sprite;

	[SWF(backgroundColor="#FFFFFF", frameRate="31", width="640", height="480")]
	/**
	 * @author SamYStudiO ( contact@samystudio.net )
	 */
	public class MyLibLiquidSkin extends Sprite
	{
		/**
		 * 
		 */
		public function MyLibLiquidSkin()
		{
			USE_PIXEL_SNAPPING = true;
														
			setDefaultSkinSet( new LiquidSkinSet(	R.skinButtonBitmap ,  R.skinCheckBitmap , R.skinComboBitmap , R.skinListBitmap ,
													R.skinListCellBitmap , R.skinRadioBitmap , R.skinScrollArrowBitmap , R.skinScrollIconsBitmap ,
													R.skinScrollTrackBitmap , R.skinScrollThumbBitmap, R.skinTextInputBitmap, R.skinTextInputBitmap, R.skinTouchScrollBitmap, R.skinFocusRectBitmap ) );
			
			var dp : DataProvider = new DataProvider( [ { label : "hello0" } ,
														{ label : "hello1" } , 
														{ label : "hello2" } ,
														{ label : "hello3" } ,
														{ label : "hello4" } ,
														{ label : "hello5" } ,
														{ label : "hello6" } ,
														{ label : "hello7" } ] );
														
			/*var scrollSkin : LiquidScrollBarSkin = new LiquidScrollBarSkin( R.skinScrollArrowBitmap , R.skinScrollThumbBitmap , R.skinScrollTrackBitmap , R.skinScrollIconsBitmap );
			var listSkin : LiquidListSkin = new LiquidListSkin( R.skinListBitmap , R.skinListCellBitmap , scrollSkin , R.skinFocusRectBitmap );
			
			new Button( this , { x : 10 , y : 10 } , new LiquidButtonSkin( R.skinButtonBitmap , null , R.skinFocusRectBitmap ) );
			new RadioButton( this , { x : 10 , y : 40 } , new LiquidRadioButtonSkin( R.skinRadioBitmap , R.skinFocusRectBitmap ) );
			new RadioButton( this , { x : 10 , y : 70 } , new LiquidRadioButtonSkin( R.skinRadioBitmap , R.skinFocusRectBitmap ) ).enabled = false;
			new CheckBox( this , { x : 10 , y : 100 } , new LiquidCheckBoxSkin( R.skinCheckBitmap ,R.skinFocusRectBitmap ) );
			new TextInput( this , { x : 10 , y : 130 } , new LiquidTextInputSkin( R.skinTextInputBitmap , null , R.skinFocusRectBitmap ) );
			new TextArea( this , { x : 10 , y : 160 , useHorizontalScroll : true } , new LiquidTextAreaSkin( R.skinTextInputBitmap , scrollSkin , null , R.skinFocusRectBitmap ) );
			new List( this , { x : 10 , y : 270 , height : 102 , contentMaskCornerRadius : 0 , dataProvider : dp } , listSkin );
			new ComboBox( this , { x : 10 , y : 380 , width : 200 , contentMaskCornerRadius : 0 , dataProvider : dp , arrowButtonWidth : 22 } , new LiquidComboBoxSkin( R.skinComboBitmap , listSkin , R.skinFocusRectBitmap ) );*/
			
			new Button( this , { x : 10 , y : 10 } );
			new RadioButton( this , { x : 10 , y : 40 } );
			new RadioButton( this , { x : 10 , y : 70 } ).enabled = false;
			var cb : CheckBox = new CheckBox( this , { x : 10 , y : 100 , text : "lfsdh kfjhsdfsdhjf gsdjhfgs djfgsdf sdgfhjsd fkjhsdg fjsdgf jsdfg jsdfg jsdgfjhsgdj" } );
			cb.multiline = true;
			cb.autoSize = true;
			cb.width = 300;
			new TextInput( this , { x : 10 , y : 230 } );
			new TextInput( this , { x : 200 , y : 230 } );
			new TextArea( this , { x : 10 , y : 260 , useHorizontalScroll : true } );
			new List( this , { x : 10 , y : 370 , height : 102 , contentMaskCornerRadius : 0 , dataProvider : dp } );
			new ComboBox( this , { x : 10 , y : 480 , dataProvider : dp } );
		}
	}
}
