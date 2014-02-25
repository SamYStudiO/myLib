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
package myLib.assets.glossy
{
	import myLib.controls.ComboBoxOpenDirection;
	import myLib.controls.IComboBox;
	import myLib.events.ComboBoxEvent;

	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.events.Event;

	/**
	 * @author SamYStudiO ( contact@samystudio.net )
	 */
	public class ComboBoxListBoxAsset extends BoxAsset
	{
		/**
		 * @private
		 */
		protected var _mask : RectangeShape = new RectangeShape();
		
		/**
		 * @private
		 */
		protected var _handler : Sprite = new Sprite();
		
		/**
		 * 
		 */
		public function ComboBoxListBoxAsset( prop : ShapeAssetProp )
		{
			super( prop );
			
			_mask.x = -50;
			mask = _mask;
			
			addChild( _mask );
		}
		
		/**
		 * @inheritDoc
		 */
		public override function draw(  ) : void
		{
			var comboBoxOwner : IComboBox = _owner.owner as IComboBox;
			
			if( comboBoxOwner == null ) return;
			
			comboBoxOwner.addEventListener( ComboBoxEvent.OPEN , _boxEvent , false , 0 , true );
			
			var comboBoxOwnerOpenDirection : String = comboBoxOwner.openDirection;
			
			_fill.y = comboBoxOwnerOpenDirection == ComboBoxOpenDirection.UP ? 0 : -50;
			_mask.y = comboBoxOwnerOpenDirection == ComboBoxOpenDirection.UP ? -50 : 0;
			
			comboBoxOwner.contentMaskCornerRadiusTopLeft = comboBoxOwnerOpenDirection == ComboBoxOpenDirection.DOWN ? 0 : _prop.cornerRadius / 2 + 1;
			comboBoxOwner.contentMaskCornerRadiusTopRight = comboBoxOwnerOpenDirection == ComboBoxOpenDirection.DOWN ? 0 : _prop.cornerRadius / 2 + 1;
			comboBoxOwner.contentMaskCornerRadiusBottomRight = comboBoxOwnerOpenDirection == ComboBoxOpenDirection.UP ? 0 : _prop.cornerRadius / 2 + 1;
			comboBoxOwner.contentMaskCornerRadiusBottomLeft = comboBoxOwnerOpenDirection == ComboBoxOpenDirection.UP ? 0 : _prop.cornerRadius / 2 + 1;
			
			var g : Graphics = _fill.graphics;
			g.clear();
			g.beginFill( _prop.mainColor , 1.0 );

			if( _prop.cornerRadius > 0 ) g.drawRoundRect( 0 , 0 , _width , _height + 50  , _prop.cornerRadius , _prop.cornerRadius );
			else g.drawRect( 0 , 0 , _width , _height + 50 );
			
			g.endFill();
			
			_mask.width = _fill.width + 100;
			_mask.height = _height + 50;
		}
		
		/**
		 * @private
		 */
		protected function _boxEvent( e : ComboBoxEvent ) : void
		{
			draw();
		}
		
		/**
		 * @private
		 */
		protected function _removed( e : Event ) : void
		{
			var comboBoxOwner : IComboBox = _owner.owner as IComboBox;

			if( comboBoxOwner == null ) return;
			
			comboBoxOwner.removeEventListener( ComboBoxEvent.OPEN , _boxEvent );
		}
	}
}
