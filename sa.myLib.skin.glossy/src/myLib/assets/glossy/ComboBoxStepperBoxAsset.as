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
	import myLib.utils.NumberUtils;

	import flash.display.BitmapData;
	import flash.display.Graphics;
	/**
	 * @author SamYStudiO ( contact@samystudio.net )
	 */
	public class ComboBoxStepperBoxAsset extends ComboBoxBoxAsset
	{
		/**
		 * 
		 */
		public function ComboBoxStepperBoxAsset( texturePattern : BitmapData , prop : ShapeAssetProp , stateActive : Boolean )
		{
			super( texturePattern , prop , stateActive );
			
			_mask.x = -50;
			_mask.y = -50;
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
			
			comboBoxOwner.addEventListener( ComboBoxEvent.OPEN , _drawEvent , false , 0 , true );
			comboBoxOwner.addEventListener( ComboBoxEvent.OPEN_COMPLETE , _drawEvent , false , 0 , true );
			comboBoxOwner.addEventListener( ComboBoxEvent.CLOSE_COMPLETE , _drawEvent , false , 0 , true );
			comboBoxOwner.addEventListener( ComboBoxEvent.OPEN_DIRECTION_CHANGE , _drawEvent , false , 0 , true );
			
			var comboBoxOwnerOpened : Boolean = comboBoxOwner.isOpen;
			var comboBoxOwnerOpenDirection : String = comboBoxOwner.openDirection;
			
			_arrow.direction = 	( comboBoxOwnerOpened && comboBoxOwnerOpenDirection == ComboBoxOpenDirection.DOWN ) ||
								( !comboBoxOwnerOpened && comboBoxOwnerOpenDirection != ComboBoxOpenDirection.DOWN ) ? ArrowDirection.UP : ArrowDirection.DOWN;
			
			_mask.x = -50;
			_mask.y = comboBoxOwnerOpened ? comboBoxOwnerOpenDirection == ComboBoxOpenDirection.DOWN ? -50 : 0 : -50;
			_fill.y = comboBoxOwnerOpened ? comboBoxOwnerOpenDirection == ComboBoxOpenDirection.DOWN ? 0 : -50 : 0;
			
			var offsetHeight : Number = comboBoxOwnerOpened ? 50 : 0;
			
			//if( !_opened ) super.draw();
			//else
			//{
				var g : Graphics = _fill.graphics;
				g.clear();
				g.beginFill( _prop.mainColor , 1.0 );
	
				if( _prop.cornerRadius > 0 ) g.drawRoundRect( 0 , 0 , _width + 50 , _height + offsetHeight  , _prop.cornerRadius , _prop.cornerRadius );
				else g.drawRect( 0 , 0 , _width + 50 , _height + offsetHeight );
				
				g.endFill();
				
				//trace( this , "draw>>>" , _texturePattern.width , _width + 50 , ( _width + 50 ) % _texturePattern.width );
				
				g = _fill.graphics;
				g.beginBitmapFill( _texturePattern );
				if( _prop.cornerRadius > 0 ) g.drawRoundRect( 0 , 0 , _width + 50 , _height + offsetHeight  , _prop.cornerRadius , _prop.cornerRadius );
				else g.drawRect( 0 , 0 , _width + 50 , _height + offsetHeight  );
				g.endFill();
			//}
			
			_boxArrow.setSize( 30 , 30 );
			_boxArrow.x = _width - _boxArrow.width - 3;
			
			var aw : Number = Math.round( _boxArrow.width / 2 );
			aw = NumberUtils.isOdd( aw ) ? aw + 1 : aw;
			
			_arrow.setSize( aw , aw / 2 );
			_arrow.move( _boxArrow.x + Math.round( ( _boxArrow.width - _arrow.width ) / 2 ) , Math.round( ( _height - _arrow.height ) / 2 ) );
			
			_mask.width = _width + 50;
			_mask.height = _height + 50 + ( comboBoxOwnerOpened ? 0 : 50 );
		}
	}
}
