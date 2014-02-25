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
	import myLib.controls.ColorPicker;
	import myLib.controls.ComboBox;
	import myLib.controls.ComboBoxOpenDirection;
	import myLib.controls.ComboBoxStepper;
	import myLib.controls.IComboBox;
	import myLib.controls.IComboBoxStepper;
	import myLib.controls.List;
	import myLib.controls.NumericStepper;
	import myLib.controls.RadioButton;
	import myLib.controls.Slider;
	import myLib.controls.TextArea;
	import myLib.controls.TextInput;
	import myLib.controls.skins.glossy.GlossySkinSet;
	import myLib.controls.skins.setDefaultSkinSet;
	import myLib.data.DataProvider;
	import myLib.displayUtils.USE_PIXEL_SNAPPING;
	import myLib.events.ButtonEvent;
	import myLib.form.IField;

	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	[SWF(backgroundColor="#333333", frameRate="31", width="640", height="800")]
	/**
	 * @author SamYStudiO ( contact@samystudio.net )
	 */
	public class MyLibGlossySkin extends Sprite
	{
		/**
		 * @private
		 */
		protected var _comboBox : IComboBox;
		protected var _comboBoxStepper : IComboBoxStepper;
		
		/**
		 * 
		 */
		public function MyLibGlossySkin()
		{
			USE_PIXEL_SNAPPING = true;
			
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;

			//setDefaultSkinSet( new GlossySkinSet( 40 , 200 , 40 , 0x333333 , 0xFFFFFF , 0xa0c7ef , 0x0773e2 , 0x000000) );
			setDefaultSkinSet( new GlossySkinSet( ) );
			
			var dp : DataProvider = new DataProvider( [ { label : "hello0" } ,
														{ label : "hello1" } , 
														{ label : "hello2" } ,
														{ label : "hello3" } ,
														{ label : "hello4" } ,
														{ label : "hello5" } ,
														{ label : "hello6" } ,
														{ label : "hello7" } ] );
														
			new Button( this , { x : 10 , y : 10 , width : 200 , height : 40 } ).drawError( true );
			new RadioButton( this , { x : 10 , y : 60 , width : 200 , height : 40 } ).drawError( true );
			new RadioButton( this , { x : 60 , y : 60 , width : 200 , height : 40 } ).drawError( true );
			var c : CheckBox = new CheckBox( this , { x : 110 , y : 60 , width : 200 , height : 40 } );
			c.addEventListener( ButtonEvent.TOGGLE , _toggle , false , 0 , true );
			c.drawError( true );
			new TextInput( this , { x : 10 , y : 110 , width : 200 , height : 40 } ).drawError( true );
			new TextArea( this , { x : 10 , y : 160 , useHorizontalScroll : true , width : 200 , height : 200 , text : "sdkfh\nsdfsd\nsdf\sdf\nsdfsdkfh\nsdfsd\nsdf\sdf\nsdfsdkfh\nsdfsd\nsdf\sdf\nsdfsdkfh\nsdfsd\nsdf\sdf\nsdfsdkfh\nsdfsd\nsdf\sdf\nsdfsdkfh\nsdfsd\nsdf\sdf\nsdfsdkfh\nsdfsd\nsdf\sdf\nsdf" } ).drawError( true );
			new List( this , { x : 10 , y : 370 , width : 200 , height : 200 , dataProvider : dp } ).drawError( true );
			_comboBox = new ComboBox( this , { x : 220 , y : 370 , dataProvider : dp , width : 200 , height : 40 , openDirection : ComboBoxOpenDirection.UP } );
			( _comboBox as IField ).drawError( true );
			_comboBoxStepper = new ComboBoxStepper( this , { x : 220 , y : 420 , dataProvider : dp , width : 200 , height : 40 } );
			( _comboBoxStepper as IField ).drawError( true );
			new ColorPicker( this , { x : 10 , y : 580 , width : 40 , height : 40 } ).drawError( true );
			new Slider( this , { x : 10 , y : 650 , width : 200 , height : 6 } ).drawError( true );
			new NumericStepper( this , { x : 10 , y : 680 , width : 199 , height : 40 } ).drawError( true );
			//_comboBoxStepper.nextPreviousPosition = StepperNextPreviousPosition.LEFT;
			
		}
		
		/**
		 * @private
		 */
		protected function _toggle( e :ButtonEvent ) : void
		{
			_comboBox.openDirection = _comboBox.openDirection == ComboBoxOpenDirection.DOWN ? ComboBoxOpenDirection.UP : ComboBoxOpenDirection.DOWN;
			_comboBoxStepper.openDirection = _comboBoxStepper.openDirection == ComboBoxOpenDirection.DOWN ? ComboBoxOpenDirection.UP : ComboBoxOpenDirection.DOWN;
		}
	}
}
