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
	import myLib.controls.IComboBoxStepper;
	import myLib.core.IAStepper;
	import myLib.events.ComboBoxEvent;
	import myLib.utils.NumberUtils;

	import flash.display.BitmapData;
	import flash.display.Graphics;
	import flash.events.Event;
	import flash.geom.Matrix;
	/**
	 * @author SamYStudiO ( contact@samystudio.net )
	 */
	public class StepperButtonAsset extends BoxAsset
	{
		/**
		 * @private
		 */
		protected var _direction : String;
		
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
		protected var _mask : RectangeShape = new RectangeShape();
		
		/**
		 * @private
		 */
		protected var _texturePattern : BitmapData;
		
		/**
		 * 
		 */
		public function StepperButtonAsset( texturePattern : BitmapData , direction : String , prop : ShapeAssetProp , activeState : Boolean )
		{
			super( prop );
			
			_texturePattern = texturePattern;
			
			var boxProp :ShapeAssetProp = prop.clone();
			boxProp.filters = boxProp.filters != null ? [ boxProp.filters[ 0 ] ] : null;
			
			_boxArrow = new BoxAsset( boxProp );
			_boxArrow.x = 5;
			_boxArrow.y = direction == ArrowDirection.UP ? 5 : 2;
			_direction = direction;
			
			trace( this , "StepperButtonAsset" , activeState );
			
			_arrow = new LineArrowAsset( 10 , 10 , direction , 4 , new ShapeAssetProp( prop.mainColor , prop.alternativeColor , prop.stateColor ) , activeState );
			
			_fill.x = -50;
			mask = _mask;
			
			addChild( _boxArrow );
			addChild( _arrow );
			addChild( _mask );
			
			addEventListener( Event.REMOVED_FROM_STAGE , _removed , false , 0 , true );
		}
		
		/**
		 * @inheritDoc
		 */
		public override function draw(  ) : void
		{
			var comboBoxOwner : IComboBox = _owner.owner as IComboBox;
			var stepperOwner : IAStepper = _owner.owner as IAStepper;
			
			if( comboBoxOwner == null && stepperOwner == null ) return;
			
			if( comboBoxOwner != null ) _drawFromComboBox();
			else if( stepperOwner != null ) _drawFromStepper();
		}
		
		/**
		 * @private
		 */
		protected function _drawFromComboBox(  ) : void
		{
			var comboBoxOwner : IComboBoxStepper = _owner.owner as IComboBoxStepper;
			
			comboBoxOwner.addEventListener( ComboBoxEvent.OPEN , _drawEvent , false , 0 , true );
			comboBoxOwner.addEventListener( ComboBoxEvent.OPEN_COMPLETE , _drawEvent , false , 0 , true );
			comboBoxOwner.addEventListener( ComboBoxEvent.CLOSE_COMPLETE , _drawEvent , false , 0 , true );
			
			var comboBoxOwnerOpened : Boolean = comboBoxOwner.isOpen;
			var comboBoxOwnerOpenDirection : String = comboBoxOwner.openDirection;
			
			var g : Graphics = _fill.graphics;
			g.clear();
			g.beginFill( _texturePattern == null ? _prop.alternativeColor : _prop.mainColor , 1.0 );

			trace( this , "draw" , comboBoxOwnerOpened , _direction );
			
			if( _direction == ArrowDirection.DOWN )
			{
				_mask.y = 0;
			}
			else
			{
				_mask.y = comboBoxOwnerOpenDirection == ComboBoxOpenDirection.UP && comboBoxOwnerOpened ? 0 : -50;
			}
			
			_fill.y = _direction == ArrowDirection.DOWN || ( _direction == ArrowDirection.UP && comboBoxOwnerOpenDirection == ComboBoxOpenDirection.UP && comboBoxOwnerOpened ) ? -50 : 0;

			var offsetH : Number = ( comboBoxOwnerOpened && _direction == ArrowDirection.DOWN && comboBoxOwnerOpenDirection == ComboBoxOpenDirection.DOWN ) || 
									( comboBoxOwnerOpened && _direction == ArrowDirection.UP && comboBoxOwnerOpenDirection == ComboBoxOpenDirection.UP ) ? 100 : 50;

			if( _prop.cornerRadius > 0 ) g.drawRoundRectComplex( 0 , 0 , _width + 50 , _height + offsetH , 	0 ,
																											_direction == ArrowDirection.UP ? _prop.cornerRadius / 2 : 0 ,
																											0,
																											_direction == ArrowDirection.DOWN ? _prop.cornerRadius / 2 : 0 );
			else g.drawRect( 0 , 0 , _width + 50 , _height + offsetH );
			
			g.endFill();
			
			if( _texturePattern != null )
			{
				g.beginBitmapFill( _texturePattern , new Matrix( 1 , 0 , 0 , 1 , -50  ) );
				if( _prop.cornerRadius > 0 )g.drawRoundRectComplex( 0 , 0 , _width + 50 , _height + offsetH , 	0 ,
																												_direction == ArrowDirection.UP ? _prop.cornerRadius / 2 : 0 ,
																												0,
																												_direction == ArrowDirection.DOWN ? _prop.cornerRadius / 2 : 0 );
				else g.drawRect( 0 , 0 , _width + 50 , _height + offsetH );
				g.endFill();
			}
			
			_boxArrow.setSize( _width - 10 , _height - 7 );
			
			var aw : Number = Math.round( _boxArrow.width / 2 );
			aw = NumberUtils.isOdd( aw ) ? aw + 1 : aw;
			
			_arrow.setSize( aw , aw / 2 );
			_arrow.move( Math.round( ( _width - _arrow.width ) / 2 ) , Math.round( _boxArrow.y + ( _boxArrow.height - _arrow.height ) / 2 ) );
			
			trace( this , "draw" , _width + 50 );
			
			_mask.width = _width + 50;
			_mask.height = _height + ( 	( comboBoxOwnerOpened && _direction == ArrowDirection.DOWN && comboBoxOwnerOpenDirection == ComboBoxOpenDirection.DOWN ) ||
										( comboBoxOwnerOpened && _direction == ArrowDirection.UP && comboBoxOwnerOpenDirection == ComboBoxOpenDirection.UP ) ? 0 : 50 );
		}
		
		/**
		 * @private
		 */
		protected function _drawFromStepper(  ) : void
		{
			trace( this , "_drawFromStepper" );
			
			var g : Graphics = _fill.graphics;
			g.clear();
			g.beginFill( _texturePattern == null ? _prop.alternativeColor : _prop.mainColor , 1.0 );

			_mask.y = _direction == ArrowDirection.DOWN ? 0 : -50;
			
			_fill.y = _direction == ArrowDirection.DOWN ? -50 : 0;

			if( _prop.cornerRadius > 0 ) g.drawRoundRectComplex( 0 , 0 , _width + 50 , _height + 50 , 	0 ,
																										_direction == ArrowDirection.UP ? _prop.cornerRadius / 2 : 0 ,
																										0,
																										_direction == ArrowDirection.DOWN ? _prop.cornerRadius / 2 : 0 );
			else g.drawRect( 0 , 0 , _width + 50 , _height + 50 );
			
			g.endFill();
			
			if( _texturePattern != null )
			{
				g.beginBitmapFill( _texturePattern , new Matrix( 1 , 0 , 0 , 1 , -50  ) );
				if( _prop.cornerRadius > 0 )g.drawRoundRectComplex( 0 , 0 , _width + 50 , _height + 50 , 	0 ,
																											_direction == ArrowDirection.UP ? _prop.cornerRadius / 2 : 0 ,
																											0,
																											_direction == ArrowDirection.DOWN ? _prop.cornerRadius / 2 : 0 );
				else g.drawRect( 0 , 0 , _width + 50 , _height + 50 );
				g.endFill();
			}
			
			_boxArrow.setSize( _width - 10 , _height - 7 );
			
			var aw : Number = Math.round( _boxArrow.width / 2 );
			aw = NumberUtils.isOdd( aw ) ? aw + 1 : aw;
			
			_arrow.setSize( aw , aw / 2 );
			_arrow.move( Math.round( ( _width - _arrow.width ) / 2 ) , Math.round( _boxArrow.y + ( _boxArrow.height - _arrow.height ) / 2 ) );
			
			trace( this , "draw" , _width + 50 );
			
			_mask.width = _width + 50;
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
			var comboBoxOwner : IComboBoxStepper = _owner.owner as IComboBoxStepper;

			if( comboBoxOwner != null )
			{
				comboBoxOwner.removeEventListener( ComboBoxEvent.OPEN , _drawEvent );
				comboBoxOwner.removeEventListener( ComboBoxEvent.OPEN_COMPLETE , _drawEvent );
				comboBoxOwner.removeEventListener( ComboBoxEvent.CLOSE_COMPLETE , _drawEvent );
			}
		}
	}
}
