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
package myLib.medias
{
	import myLib.core.AComponent;
	import myLib.core.InvalidationType;
	import myLib.displayUtils.AlignmentPoint;

	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.IBitmapDrawable;
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	/**
	 * @author SamYStudiO ( contact@samystudio.net )
	 */
	public class ImageContainer extends AComponent implements IImageContainer
	{
		/**
		 * @private
		 */
		protected override function get _defaultWidth() : Number
		{
			return 160;	
		}
		
		/**
		 * @private
		 */
		protected override function get _defaultHeight() : Number
		{
			return 120;	
		}
		
		/**
		 * @private
		 */
		protected var _handler : Sprite = new Sprite();
		
		/**
		 * @private
		 */
		protected var _bitmap : DisplayObject = new Sprite();
		
		/**
		 * @private
		 */
		protected var _smoothing : Boolean = true;
		
		[Inspectable(defaultValue=true)]
		/**
		 * @inheritDoc
		 */
		public function get smoothing() : Boolean
		{
			return _smoothing;
		}
		
		public function set smoothing( b : Boolean ) : void
		{
			if( _inspector && !_isLivePreview && !_smoothing ) return;
			
			_smoothing = !( _bitmap is Bitmap ) ? false : b;
			
			try
			{
				( _bitmap as Bitmap ).smoothing = b;
			}
			catch( e : SecurityError )
			{
				_smoothing = false;
			}
			catch( e : Error )
			{
				
			}
		}
		
		/**
		 * @private
		 */
		protected var _scaleMode : String = ScreenScaleMode.NO_BORDER;
		
		[Inspectable(defaultValue="noBorder",enumeration="autoSize,exactFit,noBorder,showAll")]
		/**
		 * @inheritDoc
		 */
		public function get scaleMode() : String
		{
			return _scaleMode;
		}
		
		public function set scaleMode( scaleMode : String ) : void
		{
			if( _inspector && !_isLivePreview && _scaleMode != ScreenScaleMode.NO_BORDER ) return;
			
			_scaleMode = scaleMode;
			
			invalidate( InvalidationType.SIZE );
		}
		
		/**
		 * @private
		 */
		protected var _allowScaleZoom : Boolean = true;
		
		[Inspectable(defaultValue=true)]
		/**
		 * @inheritDoc
		 */
		public function get allowScaleZoom() : Boolean
		{
			return _allowScaleZoom;
		}
		
		public function set allowScaleZoom( scaleZoom : Boolean ) : void
		{
			if( _inspector && !_isLivePreview && !_allowScaleZoom ) return;
			
			_allowScaleZoom = scaleZoom;
			
			invalidate( InvalidationType.SIZE );
		}
		
		/**
		 * @private
		 */
		protected var _maxScale : Number;
        
		/**
		 *
		 */
		public function get maxScale() : Number
		{
			return _maxScale;
		}
		
		public function set maxScale( scale : Number ) : void
		{
			_maxScale = Math.abs( scale );
			
			invalidate( InvalidationType.SIZE );
		}
		
		/**
		 * @private
		 */
		protected var _alignment : String = AlignmentPoint.CENTER;

		[Inspectable(defaultValue="C",enumeration="C,TL,T,TR,R,BR,B,BL,L")]
		/**
		 * @inheritDoc
		 */
		public function get alignment() : String
		{
			return _alignment;
		}
		
		public function set alignment( align : String ) : void
		{
			if( _inspector && !_isLivePreview && _alignment != AlignmentPoint.CENTER ) return;
			
			_alignment = align;
			
			invalidate( InvalidationType.SIZE ); 
		}
		
		/**
		 *
		 */
		public function get ratio() : Number
		{
			return _bitmap == null || _bitmapData == null ? 1 : _bitmap.width / _bitmapData.width;
		}
		
		/**
		 *
		 */
		public function get offset() : Point
		{
			return _bitmap == null ? new Point() : new Point( _bitmap.x , _bitmap.y );
		}
		
		/**
		 * @private
		 */
		protected var _bitmapData : BitmapData;
		
		/**
		 *
		 */
		public function get bitmapData() : BitmapData
		{
			return _bitmapData;
		}
		
		/**
		 * @private
		 */
		protected var _source : IBitmapDrawable;
		
		/**
		 *
		 */
		public function get source() : IBitmapDrawable
		{
			return _source;
		}
		
		public function set source( b : IBitmapDrawable ) : void
		{
			_source = b;
			_bitmapData = null;
			if( _bitmap != null && contains( _bitmap ) ) removeChild( _bitmap );
			
			if( b is BitmapData ) _bitmapData = b as BitmapData;
			else if( b is Bitmap ) _bitmapData = ( b as Bitmap ).bitmapData;
			else
			{
				try
				{
					_bitmapData = new BitmapData( ( b as Object ).width , ( b as Object ).height , true , 0x000000 );
					_bitmapData.draw( b );
				}
				catch( e : Error )
				{
					_bitmapData = null;
				}
			}
			
			if( _bitmapData != null ) _bitmap = addChild( new Bitmap( _bitmapData ) );
			else _bitmap = addChild( b as DisplayObject );
			
			invalidate( InvalidationType.SIZE ); 
		}
		
		/**
		 * 
		 */
		public function ImageContainer( parentContainer : DisplayObjectContainer = null , initStyle : Object = null )
		{
			super( parentContainer , initStyle );
		}
		
		/**
		 * @private
		 */
		protected override function _createChildren( ) : void
		{
			
		}
		
		/**
		 * @private
		 */
		protected override function _draw( ) : void
		{
			if( isInvalidate( InvalidationType.SIZE ) ) _layout();
		}
		
		/**
		 * @private
		 */
		protected function _layout(  ) : void
		{
			_adjustForAspectRatio();
			
			switch( _alignment ) 
			{
				case AlignmentPoint.CENTER :
				
					_bitmap.x = Math.round( ( _width - _bitmap.width ) / 2 );
					_bitmap.y = Math.round( ( _height - _bitmap.height ) / 2 );
					
					break;
					
				case AlignmentPoint.TOP :
				
					_bitmap.x = Math.round( ( _width - _bitmap.width ) / 2 );
					_bitmap.y = 0;
					
					break;
					
				case AlignmentPoint.TOP_RIGHT :
				
					_bitmap.x = Math.round( _width - _bitmap.width );
					_bitmap.y = 0;
					
					break;
					
				case AlignmentPoint.RIGHT :
				
					_bitmap.x = Math.round( _width - _bitmap.width );
					_bitmap.y = Math.round( ( _height - _bitmap.height ) / 2 );
					
					break;
					
				case AlignmentPoint.BOTTOM_RIGHT :
				
					_bitmap.x = Math.round( _width - _bitmap.width );
					_bitmap.y = Math.round( _height - _bitmap.height );
					
					break;
					
				case AlignmentPoint.BOTTOM :
				
					_bitmap.x = Math.round( ( _width - _bitmap.width ) / 2 );
					_bitmap.y = Math.round( _height - _bitmap.height );
					
					break;
					
				case AlignmentPoint.BOTTOM_LEFT :
				
					_bitmap.x = 0;
					_bitmap.y = Math.round( _height - _bitmap.height );
					
					break;
					
				case AlignmentPoint.LEFT :
				
					_bitmap.x = 0;
					_bitmap.y = Math.round( ( _height - _bitmap.height ) / 2 );
					
					break;
					
				default :
					
					_bitmap.x = 0;
					_bitmap.y = 0;
					
			}
			
			scrollRect = new Rectangle( 0 , 0 , _width , _height );
		}
		
		/**
		 * @private
		 */
		protected function _adjustForAspectRatio( ) : void
		{
			_bitmap.scaleX = _bitmap.scaleY = 1.0;
			
			if( _scaleMode == ScreenScaleMode.NO_BORDER || _scaleMode == ScreenScaleMode.SHOW_ALL )
			{
				var pX : Number;
				var pY : Number;
				var r : Number;
				
				if( _scaleMode == ScreenScaleMode.NO_BORDER )
				{
					pX = ( _bitmap.width - _width ) / _bitmap.width;
					pY = ( _bitmap.height - _height ) / _bitmap.height;
					
					var min : Number = Math.min( pX , pY );
					
					if( !_allowScaleZoom && min < 0 ) min = 0;
					r = 1 - min;
					if( !isNaN( _maxScale ) ) r = Math.min( _maxScale , r );
					
					_bitmap.width = Math.round( _bitmap.width * r );
					_bitmap.height = Math.round( _bitmap.height * r );
				}
				else
				{
					pX = ( _bitmap.width - _width ) / _bitmap.width;
					pY = ( _bitmap.height - _height ) / _bitmap.height;
					
					var max : Number = Math.max( pX , pY );
					
					if( !_allowScaleZoom && max < 0 ) max = 0;
					r = 1 - max;
					if( !isNaN( _maxScale ) ) r = Math.min( _maxScale , r );
					
					_bitmap.width = Math.round( _bitmap.width * r );
					_bitmap.height = Math.round( _bitmap.height * r );
					
					_scaleMode = ScreenScaleMode.SHOW_ALL;
				}
			}
			else
			{
				var w : Number = _width;
				var h : Number = _height;
				
				if( !_allowScaleZoom && w > _bitmap.width ) w = _bitmap.width;
				if( !_allowScaleZoom && h > _bitmap.height ) h = _bitmap.height;
				
				_bitmap.width = Math.round( w );
				_bitmap.height = Math.round( h );
				
				if( !isNaN( _maxScale ) )
				{
					_bitmap.scaleX = Math.min ( _bitmap.scaleX , _maxScale );
					_bitmap.scaleY = Math.min ( _bitmap.scaleY , _maxScale );
				}
			}
		}
	}
}
