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
	import myLib.controls.ComboBoxStepper;
	import myLib.controls.List;
	import myLib.controls.NumericStepper;
	import myLib.controls.RadioButton;
	import myLib.controls.Slider;
	import myLib.controls.TextArea;
	import myLib.controls.TextInput;
	import myLib.controls.skins.flat.FlatSkinSet;
	import myLib.controls.skins.setDefaultSkinSet;
	import myLib.data.DataProvider;
	import myLib.displayUtils.USE_PIXEL_SNAPPING;
	import myLib.displayUtils.cleanContainer;

	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.DropShadowFilter;

	[SWF(backgroundColor="#FFFFFFF", frameRate="31", width="640", height="800")]
	/**
	 * @author SamYStudiO ( contact@samystudio.net )
	 */
	public class MyLibFlatSkin extends Sprite
	{
		/**
		 * @private
		 */
		protected var _handler : Sprite = new Sprite();
		
		/**
		 * @private
		 */
		protected var _textColor : ColorPicker;
		protected var _mainColor : ColorPicker;
		protected var _stateColor : ColorPicker;
		protected var _borderColor : ColorPicker;
		
		/**
		 * @private
		 */
		protected var _shadow : Button;
		
		/**
		 * @private
		 */
		protected var _iconSize : Slider;
		
		/**
		 * @private
		 */
		protected var _borderThickness : NumericStepper;
		
		/**
		 * @private
		 */
		protected var _cornerRadius : NumericStepper;
		
		/**
		 * 
		 */
		public function MyLibFlatSkin()
		{
			USE_PIXEL_SNAPPING = true;
			
			addChild( _handler );
													
			_clickReset();						
		}
		
		/**
		 * @private
		 */
		protected function _update( iconSize : Number , textColor : uint , mainColor : uint = 0xFFFFFF , stateColor : uint = 0xDDDDDD , borderColor : uint = 0x666666 , errorColor : uint = 0xCC0000 , borderThickness : Number = 1 , cornerRadius : Number = 0 , shadowFilter : Boolean = true ) : void
		{
			setDefaultSkinSet( new FlatSkinSet(	iconSize , textColor , mainColor , stateColor , borderColor , errorColor , borderThickness , cornerRadius , shadowFilter ? new DropShadowFilter( 1 , 45 , 0x000000 , .4 , 2 , 2 , 2 , 2 , true ) : null ) );
		
			cleanContainer( _handler );
			
			var dp : DataProvider = new DataProvider( [ { label : "hello0" } ,
														{ label : "hello1" } , 
														{ label : "hello2" } ,
														{ label : "hello3" } ,
														{ label : "hello4" } ,
														{ label : "hello5" } ,
														{ label : "hello6" } ,
														{ label : "hello7" } ] );
			
			new Button( _handler , { x : 10 , y : 10 , text : "Reset" } ).addEventListener( MouseEvent.CLICK , _clickReset , false , 0 , true );
			_shadow = new Button( _handler , { x : 10 , y : 40 , text : "Shadow" } );
			_shadow.selectable = true;
			_shadow.selected = shadowFilter;
			_shadow.addEventListener( MouseEvent.CLICK , _change , false , 0 , true );
			new RadioButton( _handler , { x : 10 , y : 70 , text : "RadioButton1" } );
			new RadioButton( _handler , { x : 10 , y : 100 , text : "RadioButton2" } );
			new CheckBox( _handler , { x : 10 , y : 130 , text : "CheckBox" } );
			new TextInput( _handler , { x : 10 , y : 160 } );
			new TextArea( _handler , { x : 10 , y : 190 , useHorizontalScroll : true } );
			new List( _handler , { x : 10 , y : 300 , height : 102 , dataProvider : dp } );
			new ComboBox( _handler , { x : 10 , y : 410 , dataProvider : dp } );
			new ComboBoxStepper( _handler , { x : 10 , y : 440 , dataProvider : dp } );
			_textColor = new ColorPicker( _handler , { x : 10 , y : 470 , selectedColor : textColor } );
			_textColor.addEventListener( Event.CHANGE , _change , false , 0 , true );
			_mainColor = new ColorPicker( _handler , { x : 40 , y : 470 , selectedColor : mainColor } );
			_mainColor.addEventListener( Event.CHANGE , _change , false , 0 , true );
			_stateColor = new ColorPicker( _handler , { x : 70 , y : 470 , selectedColor : stateColor } );
			_stateColor.addEventListener( Event.CHANGE , _change , false , 0 , true );
			_borderColor = new ColorPicker( _handler , { x : 100 , y : 470 , selectedColor : borderColor } );
			_borderColor.addEventListener( Event.CHANGE , _change , false , 0 , true );
			_iconSize = new Slider( _handler , { x : 10 , y : 500 , height : 10 } );
			_iconSize.minimum = 10;
			_iconSize.maximum = 20;
			_iconSize.value = iconSize;
			_iconSize.addEventListener( MouseEvent.MOUSE_UP , _change , false , 0 , true );
			_borderThickness = new NumericStepper( _handler , { x : 10 , y : 520 } );
			_borderThickness.minimum = 0;
			_borderThickness.maximum = 3;
			_borderThickness.value = borderThickness;
			_borderThickness.addEventListener( Event.CHANGE , _change , false , 0 , true );
			_cornerRadius = new NumericStepper( _handler , { x : 10 , y : 550 } );
			_cornerRadius.minimum = 0;
			_cornerRadius.maximum = 10;
			_cornerRadius.value = cornerRadius;
			_cornerRadius.addEventListener( Event.CHANGE , _change , false , 0 , true );
		}
		
		/**
		 * @private
		 */
		protected function _clickReset( e : MouseEvent = null ) : void
		{
			_update( 12 , 0x333333 , 0xFFFFFF , 0xDDDDDD , 0x666666 , 0xCC0000 , 1 , 0 , true );		
		}
		
		/**
		 * @private
		 */
		protected function _change( e : Event = null ) : void
		{
			_update( _iconSize.value , _textColor.selectedColor , _mainColor.selectedColor , _stateColor.selectedColor , _borderColor.selectedColor , 0xCC0000 , _borderThickness.value , _cornerRadius.value , _shadow.selected );
		}
	}
}
