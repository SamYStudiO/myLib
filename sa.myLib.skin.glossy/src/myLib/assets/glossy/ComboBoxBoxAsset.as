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
	import flash.events.Event;
	import myLib.events.ComboBoxEvent;
	import myLib.controls.ComboBoxOpenDirection;
	import myLib.controls.IComboBox;
	import myLib.utils.NumberUtils;

	import flash.display.BitmapData;
	import flash.display.Graphics;
	/**
	 * @author SamYStudiO ( contact@samystudio.net )
	 */
	public class ComboBoxBoxAsset extends TextureBoxAsset
	{
		/**
		 * @private
		 */
		protected var _boxArrow : BoxAsset;
		
		/**
		 * @private
		 */
		protected var _arrow : LineArrowAsset;
		
		/**
		 * @private
		 */
		protected var _texturePattern : BitmapData;
		
		/**
		 * @private
		 */
		protected var _stateActive : Boolean;
		
		/**
		 * @private
		 */
		protected var _mask : RectangeShape = new RectangeShape( 10 , 10 );
		
		/**
		 * 
		 */
		public function ComboBoxBoxAsset( texturePattern : BitmapData , prop : ShapeAssetProp , stateActive : Boolean )
		{
			super( prop );
			
			_texturePattern = texturePattern;
			_stateActive = stateActive;
			
			var boxProp : ShapeAssetProp = prop.clone();
			boxProp.filters.pop();
			
			_boxArrow = new BoxAsset( boxProp );
			_boxArrow.y = 5;
			_arrow = new LineArrowAsset( 10 , 10 , ArrowDirection.UP , 4 , new ShapeAssetProp( prop.mainColor , prop.alternativeColor , prop.stateColor ) , stateActive );
			
			addChild( _boxArrow );
			addChild( _arrow );
			
			addEventListener( Event.REMOVED_FROM_STAGE , _removed , false , 0 , true );
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
			
			if( comboBoxOwnerOpened )
			{
				_mask.x = -50;
				_mask.y = comboBoxOwnerOpenDirection == ComboBoxOpenDirection.DOWN ? -50 : 0;
				_fill.y = comboBoxOwnerOpenDirection == ComboBoxOpenDirection.DOWN ? 0 : -50;
				mask = _mask;
				addChild( _mask );
			}
			
			else
			{
				if( contains( _mask ) ) removeChild( _mask );
				
				mask = null;
			}
			
			if( !comboBoxOwnerOpened )
			{
				_fill.y = 0;
				super.draw();
			}
			else
			{
				var g : Graphics = _fill.graphics;
				g.clear();
				g.beginFill( _prop.mainColor , 1.0 );
	
				if( _prop.cornerRadius > 0 ) g.drawRoundRect( 0 , 0 , _width , _height + 50  , _prop.cornerRadius , _prop.cornerRadius );
				else g.drawRect( 0 , 0 , _width , _height + 50 );
				
				g.endFill();
				
				g = _fill.graphics;
				g.beginBitmapFill( _texturePattern );
				if( _prop.cornerRadius > 0 ) g.drawRoundRect( 0 , 0 , _width , _height + 50  , _prop.cornerRadius , _prop.cornerRadius );
				else g.drawRect( 0 , 0 , _width , _height + 50 );
				g.endFill();
			}
			
			_boxArrow.setSize( 30 , 30 );
			_boxArrow.x = _width - _boxArrow.width - 5;
			
			var aw : Number = Math.round( _boxArrow.width / 2 );
			aw = NumberUtils.isOdd( aw ) ? aw + 1 : aw;
			
			_arrow.setSize( aw , aw / 2 );
			_arrow.move( _boxArrow.x + Math.round( ( _boxArrow.width - _arrow.width ) / 2 ) , Math.round( ( _height - _arrow.height ) / 2 ) );
			
			_mask.width = _fill.width + 100;
			_mask.height = _height + 50;
		}
		
		/**
		 * @private
		 */
		protected function _drawEvent( e : ComboBoxEvent ) : void
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
			
			comboBoxOwner.removeEventListener( ComboBoxEvent.OPEN , _drawEvent );
			comboBoxOwner.removeEventListener( ComboBoxEvent.OPEN_COMPLETE , _drawEvent );
			comboBoxOwner.removeEventListener( ComboBoxEvent.CLOSE_COMPLETE , _drawEvent );
			comboBoxOwner.removeEventListener( ComboBoxEvent.OPEN_DIRECTION_CHANGE , _drawEvent );
		}
	}
}
