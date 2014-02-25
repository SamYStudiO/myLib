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
 * The Original Code is myLib.
 *
 * The Initial Developer of the Original Code is
 * Samuel EMINET (aka SamYStudiO) contact@samystudio.net.
 * Portions created by the Initial Developer are Copyright (C) 2008-2011
 * the Initial Developer. All Rights Reserved.
 *
 */
package myLib.assets 
{
	import myLib.display.IFocusable;
	import myLib.displayUtils.AlignmentManager;
	import myLib.displayUtils.AlignmentPoint;
	import myLib.displayUtils.USE_PIXEL_SNAPPING;

	import flash.display.DisplayObjectContainer;
	import flash.display.InteractiveObject;
	import flash.display.Sprite;
	import flash.geom.Point;
	/**
	 * Asset is the base class for all components and its children.
	 * Inherit it to build complex asset with components since all IAsset properties and methods are implemented here.
	 * Asset inherit from Sprite, for animated assets use MovieAsset class instead.
	 * 
	 * <p>When creating assets in flash library using auto generation class add this class to base class field.</p>
	 * 
	 * @author SamYStudiO
	 */
	public class Asset extends Sprite implements IAsset
	{	
		/**
		 * @private
		 * 
		 * used to scale asset width  
		 */
		protected var _originWidth : Number;
		
		/**
		 * @private
		 * 
		 * used to scale asset height  
		 */
		protected var _originHeight : Number;
		
		/**
		 * @private
		 */
		protected var _x : Number = 0;
		
		/**
		 * @inheritDoc
		 */	 
		public override function get x() : Number
		{
			return _x;
		}
			
		public override function set x( x : Number ) : void
		{
			move( x , _y );
		}
		
		/**
		 * 
		 */
		core final function get x() : Number
		{
			return super.x;
		}
		
		core final function set x( x : Number ) : void
		{
			super.x = x;
		}
		
		/**
		 * @private
		 */
		protected var _y : Number = 0;

		/**
		 * @inheritDoc 
		 */	 
		public override function get y() : Number
		{
			return _y;
		}
		
		public override function set y( y : Number ) : void
		{
			move( _x , y );
		}
		
		/**
		 * 
		 */
		core final function get y() : Number
		{
			return super.y;
		}
		
		core final function set y( y : Number ) : void
		{
			super.y = y;
		}
		
		/**
		 * @private
		 */
		protected var _width : Number = 0;
		
		/**
		 * @inheritDoc
		 */	 
		public override function get width() : Number
		{
			return _width;
		}
		
		public override function set width( w : Number ) : void
		{
			setSize( w , NaN );
		}
		
		/**
		 * 
		 */
		core final function get width() : Number
		{
			return super.width;
		}
		
		core final function set width( w : Number ) : void
		{
			super.width = w;
		}
		
		/**
		 * @private
		 */
		protected var _height : Number = 0;

		/**
		 * @inheritDoc
		 */
		public override function get height() : Number
		{
			return _height;
		}
		
		public override function set height( h : Number ) : void
		{
			setSize( NaN , h );
		}
		
		/**
		 * 
		 */
		core final function get height() : Number
		{
			return super.height;
		}
		
		core final function set height( h : Number ) : void
		{
			super.height = h;
		}
		
		/**
		 * @inheritDoc
		 */
		public override function get scaleX() : Number
		{
			return _width / _originWidth;
		}
		
		public override function set scaleX( scale : Number ) : void
		{
			setSize( _originWidth * scale , _height );
		}
		
		/**
		 * 
		 */
		core final function get scaleX() : Number
		{
			return super.scaleX;
		}
		
		core final function set scaleX( scale : Number ) : void
		{
			super.scaleX = scale;
		}

		/**
		 * @inheritDoc
		 */	 
		public override function get scaleY() : Number
		{
			return _height / _originHeight;
		}
		
		public override function set scaleY( scale : Number ) : void
		{
			setSize( _width , _originHeight * scale );
		}
		
		/**
		 * 
		 */
		core final function get scaleY() : Number
		{
			return super.scaleY;
		}
		
		core final function set scaleY( scale : Number ) : void
		{
			super.scaleY = scale;
		}
		
		/**
		 * @private
		 */
		protected var _enabled : Boolean = true;
		
		/**
		 * @inheritDoc
		 */	 
		public function get enabled() : Boolean
		{
			return _enabled;
		}
		
		public function set enabled( b : Boolean ) : void
		{
			_enabled = b;
		}
		
		/**
		 * @private
		 */
		protected var _focusEnabled : Boolean;
		
		/**
		 * @inheritDoc
		 */
		public function get focusEnabled() : Boolean
		{
			return _focusEnabled;
		}
		
		public function set focusEnabled( b : Boolean ) : void
		{
			_focusEnabled = b;
		}
		
		/**
		 * @private
		 */
		protected var _focusTarget : InteractiveObject;

		/**
		 * @inheritDoc
		 */
		public function get focusTarget() : InteractiveObject
		{
			return _focusTarget == null ? this : _focusTarget;
		}
		
		public function set focusTarget( object : InteractiveObject ) : void
		{
			if( _focusTarget == object ) return;
			
			_focusTarget = object;
		}
		
		/**
		 * @private
		 */
		protected var _focusDrawTarget : IFocusable;

		/**
		 * @inheritDoc
		 */
		public function get focusDrawTarget() : IFocusable
		{
			return _focusDrawTarget == null ? this : _focusDrawTarget;
		}
		
		public function set focusDrawTarget( object : IFocusable ) : void
		{
			if( _focusDrawTarget == object ) return;
			
			_focusDrawTarget = object;
		}
		
		/**
		 * @private
		 */
		protected var _showTabFocusChangeIndicator : Boolean = true;

		/**
		 * @inheritDoc
		 */
		public function get showTabFocusChangeIndicator() : Boolean
		{
			return _showTabFocusChangeIndicator;
		}
		
		public function set showTabFocusChangeIndicator( b : Boolean ) : void
		{
			_showTabFocusChangeIndicator = b;
		}
		
		/**
		 * @private
		 */
		protected var _showMouseFocusChangeIndicator : Boolean;

		/**
		 * @inheritDoc
		 */
		public function get showMouseFocusChangeIndicator() : Boolean
		{
			return _showMouseFocusChangeIndicator;
		}
		
		public function set showMouseFocusChangeIndicator( b : Boolean ) : void
		{
			_showMouseFocusChangeIndicator = b;
		}
		
		/**
		 * @private
		 */
		protected var _owner : IAsset;

		/**
		 * @inheritDoc
		 */
		public function get owner() : IAsset
		{
			return _owner;
		}
		
		public function set owner( owner : IAsset ) : void
		{
			_owner = owner;
		}

		/**
		 * 
		 */
		public function Asset ()
		{
			_width = _originWidth = super.width;
			_height = _originHeight = super.height;
		}
		
		/**
		 * @inheritDoc
		 */
		public function move( x : Number , y : Number , alignmentPoint : String = "TL" , targetCoordinateSpace : DisplayObjectContainer = null ) : void
		{
			var p : Point = new Point( isNaN( x ) ? _x : x , isNaN( y ) ? _y : y );
			
			if( ( alignmentPoint != null && alignmentPoint != AlignmentPoint.TOP_LEFT ) || 
					( targetCoordinateSpace != null && targetCoordinateSpace != parent ) )
			{
				p = AlignmentManager.getAlignmentPoint( this , alignmentPoint == null ? AlignmentPoint.TOP_LEFT : alignmentPoint , targetCoordinateSpace , p.x , p.y );
			}
			
			if( p.x == _x && p.y == _y ) return;

			_x = p.x;
			_y = p.y;
			
			super.x = USE_PIXEL_SNAPPING ? Math.round( _x ) : _x;			super.y = USE_PIXEL_SNAPPING ? Math.round( _y ) : _y;
		}
		
		/**
		 * @inheritDoc
		 */
		public function setSize( w : Number , h : Number ) : void
		{
			w = isNaN( w ) ? _width : w;
			h = isNaN( h ) ? _height : h;
				
			_width = w;
			_height = h;
		}

		/**
		 * @inheritDoc
		 * 
		 * @internal This is a basic way to draw asset, to do something better and avoid scaling with complex assets you should override this.
		 */
		public function draw(  ) : void
		{
			super.width = USE_PIXEL_SNAPPING ? Math.round( _width ) : _width;
			super.height = USE_PIXEL_SNAPPING ? Math.round( _height ) : _height;
		}
		
		/**
		 * @inheritDoc
		 */
		public function setFocus(  ) : void
		{
			if( _focusTarget != null && stage != null && stage.focus != _focusTarget )
			{
				if( _focusTarget is IFocusable ) ( _focusTarget as IFocusable ).setFocus();
				else stage.focus = _focusTarget;
			}
			else if( _focusTarget == null && stage != null && stage.focus != this ) stage.focus = this;
		}
		
		/**
		 * @inheritDoc
		 */
		public function drawFocus( b : Boolean ) : void
		{
			
		}
	}
}
	
