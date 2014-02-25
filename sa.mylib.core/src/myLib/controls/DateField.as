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
package myLib.controls 
{
	import myLib.assets.Asset;
	import myLib.assets.IAsset;
	import myLib.controls.skins.IDateFieldSkin;
	import myLib.controls.skins.my_skinset;
	import myLib.displayUtils.AlignmentManager;
	import myLib.displayUtils.AlignmentPoint;
	import myLib.events.ComponentEvent;
	import myLib.events.DateFieldEvent;
	import myLib.form.IField;
	import myLib.styles.Padding;

	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.events.FocusEvent;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.ui.Keyboard;
	/**
	 * @private
	 * 
	 * @author SamYStudiO
	 */
	public class DateField extends TextInput implements IDateField, IField
	{
		/**
		 * @private
		 */
		protected var _dateFieldSkin : IDateFieldSkin;
		
		/**
		 * @private
		 */
		protected var _editable : Boolean = false;
		
		[Inspectable]
		/**
		 * @inheritDoc
		 */
		public function get editable() : Boolean
		{
			return _editable;
		}
		
		public function set editable( b : Boolean ) : void
		{
			if( _editable == b || ( _inspector && !_isLivePreview && _editable ) ) return;
			
			_editable = b;
		}
		
		/**
		 *
		 */
		protected var _openDirection : String = ColorPickerOpenDirection.RIGHT;
		
		[Inspectable(defaultValue="right",enumeration="left,up,right,bottom")]
		/**
		 * @inheritDoc
		 */
		public function get openDirection() : String
		{
			return _openDirection;
		}
		
		public function set openDirection( direction : String ) : void
		{
			if( _inspector && !_isLivePreview && _openDirection != ColorPickerOpenDirection.RIGHT ) return;
			
			_openDirection = direction;
		}
		
		/**
		 *
		 */
		protected var _openPoint : String = AlignmentPoint.TOP_LEFT;

		[Inspectable(defaultValue="TL",enumeration="TL,T,TR,R,BR,B,BL,L,C")]
		/**
		 * @inheritDoc
		 */
		public function get openPoint() : String
		{
			return _openPoint;
		}
		
		public function set openPoint( point : String ) : void
		{
			if( _inspector && !_isLivePreview && _openPoint != AlignmentPoint.TOP_LEFT ) return;
			
			_openPoint = point;
		}
		
		/**
		 * @private
		 */
		protected var _openPadding : Padding = new Padding( 0 , 0 , 0 , 0 );
		
		/**
		 * @inheritDoc
		 */
		public function get openPadding() : Padding
		{
			return _openPadding == null ? new Padding( 0 , 0 , 0 , 0 ) : _openPadding;
		}
		
		public function set openPadding( padding : Padding ) : void
		{
			_openPadding = padding;
		}
		
		[Inspectable(name="openPadding",type="Object",defaultValue="left:0,top:0,right:0,bottom:0")]
		/**
		 * @private
		 */
		public function set inspectableOpenPadding( padding : Object ) : void
		{
			if( !_inspector && !_isLivePreview ) throw new Error( this + " inspectableOpenPadding property is internal and used by Flash component inspector panel , use openPadding property instead" );
			
			if( _inspector && !_isLivePreview && ( _openPadding.left != 0 || _openPadding.top != 0 || _openPadding.right != 0 || _openPadding.bottom != 0 ) ) return;
			
			openPadding = new Padding( padding.left , padding.top , padding.right , padding.bottom );
		}
		
		/**
		 * @private
		 */
		protected var _paletteContentPadding : Padding = new Padding( 5 , 5 , 5 , 5 );
		
		/**
		 * @inheritDoc
		 */
		public function get paletteContentPadding() : Padding
		{
			return _paletteContentPadding == null ? new Padding( 5 , 5 , 5 , 5 ) : _paletteContentPadding;
		}
		
		public function set paletteContentPadding( padding : Padding ) : void
		{
			if( padding == _paletteContentPadding ) return;
			
			_paletteContentPadding = padding;
		}
		
		/**
		 * @private
		 */
		protected var _paletteDaySpacing : Number = 0;
		
		/**
		 * @inheritDoc
		 */
		public function get paletteDaySpacing() : Number
		{
			return _paletteDaySpacing;
		}
		
		public function set paletteDaySpacing( n : Number ) : void
		{
			if( _paletteDaySpacing == n ) return;
			
			_paletteDaySpacing = n;
		}
		
		/**
		 * @private
		 */
		protected var _paletteMonthYearSelectorHeight : Number = 0;
		
		/**
		 * @inheritDoc
		 */
		public function get paletteMonthYearSelectorHeight() : Number
		{
			return _paletteMonthYearSelectorHeight;
		}
		
		public function set paletteMonthYearSelectorHeight( n : Number ) : void
		{
			if( _paletteMonthYearSelectorHeight == n ) return;
			
			_paletteMonthYearSelectorHeight = n;
		}
		
		[Inspectable(name="paletteContentPadding",type="Object",defaultValue="left:5,top:5,right:5,bottom:5")]
		/**
		 * @private
		 */
		public function set inspectablePaletteContentPadding( padding : Object ) : void
		{
			if( !_inspector && !_isLivePreview ) throw new Error( this + " inspectablePaletteContentPadding property is internal and used by Flash component inspector panel , use paletteContentPadding property instead" );
			
			if( _inspector && !_isLivePreview && ( _paletteContentPadding.left != 5 || _paletteContentPadding.top != 5 || _paletteContentPadding.right != 5 || _paletteContentPadding.bottom != 5 ) ) return;
			
			paletteContentPadding = new Padding( padding.left , padding.top , padding.right , padding.bottom );
		}
		
		[Inspectable(defaultValue=true)]
		/**
		 * @inheritDoc
		 */
		public override function get enabled() : Boolean
		{
			return super.enabled;
		}
		
		public override function set enabled( b : Boolean ) : void
		{
			if( _inspector && !_isLivePreview && !_enabled ) return;
			
			super.enabled = b;
			
			if( !b ) close();
		}
		
		/**
		 * @private
		 */
		protected var _isOpen : Boolean;
		
		/**
		 * Get a Boolean that indicates if palette is opened.
		 */
		public function get isOpen() : Boolean
		{
			return _isOpen;
		}
		
		/**
		 * @private
		 */
		protected var _palette : Asset;
		
		/**
		 * @inheritDoc
		 */
		public function get palette() : Asset
		{
			return _palette;
		}
		
		/**
		 * @private
		 */
		protected var _paletteBackground : IAsset;
		
		/**
		 * @inheritDoc
		 */
		public function get paletteBackground() : IAsset
		{
			return _paletteBackground;
		}
		
		/**
		 * @private
		 */
		protected var _paletteMonthYearSelector : ICalendarMonthYearSelector;

		/**
		 * @inheritDoc
		 */
		public function get paletteMonthYearSelector() : ICalendarMonthYearSelector
		{
			return _paletteMonthYearSelector;
		}
		
		/**
		 * 
		 */
		public function DateField( parentContainer : DisplayObjectContainer = null , initStyle : Object = null , skin : IDateFieldSkin = null )
		{
			_dateFieldSkin = skin == null ? my_skinset[ "DateField" ] : skin;
			
			super( parentContainer , initStyle , _dateFieldSkin );
		}
		
		/**
		 * @inheritDoc
		 */
		public function open(  ) : void
		{
			if( _isOpen || stage == null ) return;
			
			var padding : Padding = openPadding;
			var offset : Number;
			var redrawFocus : Boolean = false;
			
			if( _isFocused )
			{
				redrawFocus = true;
				drawFocus( false );
			}
			
			switch( true ) 
			{
				case _openDirection == ColorPickerOpenDirection.LEFT :
				
					offset = _openPoint.indexOf( AlignmentPoint.TOP ) == 0 ? 0 : _openPoint.indexOf( AlignmentPoint.BOTTOM ) >= 0 ? _height : _height / 2;
					
					AlignmentManager.move( _palette , _openPoint , _openPoint == AlignmentPoint.CENTER ? stageX + _width / 2 : stageX - _palette.width - padding.left , stageY + offset , stage );
					
					break;
					
				case _openDirection == ColorPickerOpenDirection.TOP :
				
					offset = _openPoint.indexOf( AlignmentPoint.LEFT ) >= 0 ? 0 : _openPoint.indexOf( AlignmentPoint.RIGHT ) >=0 ? _width : _width / 2;
				
					AlignmentManager.move( _palette , _openPoint , stageX + offset , _openPoint == AlignmentPoint.CENTER ? stageY + _height / 2 : stageY - _palette.height - padding.top , stage );
					break;
					
				case _openDirection == ColorPickerOpenDirection.BOTTOM :
				
					offset = _openPoint.indexOf( AlignmentPoint.LEFT ) >= 0 ? 0 : _openPoint.indexOf( AlignmentPoint.RIGHT ) >= 0 ? _width : _width / 2;
				
					AlignmentManager.move( _palette , _openPoint , stageX + offset , _openPoint == AlignmentPoint.CENTER ? stageY + _height / 2 : stageY + padding.bottom , stage );
					break;
					
				default :
				
					_openDirection = ColorPickerOpenDirection.RIGHT;
					
					offset = _openPoint.indexOf( AlignmentPoint.TOP ) == 0 ? 0 : _openPoint.indexOf( AlignmentPoint.BOTTOM ) >=0 ? _height : _height / 2;
					
					AlignmentManager.move( _palette , _openPoint , _openPoint == AlignmentPoint.CENTER ? stageX + _width / 2 : stageX + _width + padding.right , stageY + offset , stage );
					break;
			}
			
			if( redrawFocus ) drawFocus( true );
			
			_palette.x = Math.max( 0 , Math.min( stage.stageWidth - _palette.width , _palette.x ) );
			_palette.y = Math.max( 0 , Math.min( stage.stageHeight - _palette.height , _palette.y ) );
			
			stage.addChild( _palette );
			
			_isOpen = true;
			
			dispatchEvent( new DateFieldEvent( DateFieldEvent.OPEN ) );
		}
		
		/**
		 * @inheritDoc
		 */
		public function close(  ) : void
		{
			if( !_isOpen ) return;
			
			_palette.stage.removeChild( _palette );
			_isOpen = false;
			
			dispatchEvent( new DateFieldEvent( DateFieldEvent.CLOSE ) );
		}
		
		/**
		 * @inheritDoc
		 */
		public override function setValue( value : * ) : void
		{
			
		}
		
		/**
		 * @private
		 */
		protected override function _createChildren(  ) : void
		{
			super._createChildren();
			
			_paletteBackground = _dateFieldSkin.getPaletteBackgroundAsset( );
			
			_palette = new Asset();
			
			_palette.addChild( _paletteBackground as DisplayObject );
		}
		
		/**
		 * @private
		 */
		protected override function _init(  ) : void
		{
			super._init();
			
			_palette.tabChildren = false;
			_palette.focusEnabled = true;
			_palette.focusDrawTarget = this;
			
			_palette.addEventListener( FocusEvent.FOCUS_OUT , _focusOut , false , 0 , true );
			_iconAsset.addEventListener( MouseEvent.CLICK , _toggleOpen , false , 0 , true );
		}

		/**
		 * @private
		 */
		protected override function _draw(  ) : void
		{
			super._draw();
		}
		
		/**
		 * @private
		 */
		protected override function _focusOut( e : FocusEvent ) : void
		{
			super._focusOut( e );
			
			if( e.relatedObject == null || ( !contains( e.relatedObject ) && !_palette.contains( e.relatedObject ) ) )
			{
				close();
			}
		}
		
		/**
		 * @private
		 */
		protected function _toggleOpen( e : MouseEvent = null ) : void
		{
			if( _isOpen ) close();
			else open();
		}
		
		/**
		 * @private
		 */
		protected function _getMonthLength( month : Number , year : Number = NaN ) : Number
		{
			if( isNaN( year ) ) year = new Date().getFullYear();
			
			var n : Number;

			if ( month == 1 )
			{
				if ( ( ( year % 4 == 0 ) && ( year % 100 != 0 ) ) || ( year % 400 == 0 ) ) n = 29;
				else n = 28;
			}
			else if ( month == 3 || month == 5 || month == 8 || month == 10 ) n = 30;
			else n = 31;
	
			return n;
		}
		
		/**
		 * @private
		 */
		protected function _getMonthGrid( month : Number , year : Number = NaN , firstGridWeekDay : Number = 0 ) : Array
		{
			var f : Number = firstGridWeekDay;
		
			f = isNaN( f ) || f < 0 ? 0 : f > 6 ? 6 : Math.round( f );
			
			var grid : Array = new Array( 6 );
			var firstWeekDay : Number = _getFirstWeekDayOfMonth( year , month );
			var offset : Number = firstWeekDay - f;
			var firstOffset : Number = offset < 0 ? offset + 7 : offset;
			var d : Number = 1;
			var l : Number = _getMonthLength( year , month );
			var i : Number = -1;
			
			while( ++i < 6 )
			{
				grid[ i ] = new Array( 7 );
				
				var j : Number = -1;
				
				while( ++j < 7 )
				{
					if( ( d == 1 && j < firstOffset ) || d > l ) grid[ i ][ j ] = null;
					else
					{
						grid[ i ][ j ] = d;
						d++;
					}
				}
			}
			
			return grid;
		}
		
		/**
		 * @private
		 */
		protected function _drawGrid(  ) : void
		{
			
		}
		
		/**
		 * 
		 */
		protected function _getFirstWeekDayOfMonth ( year : Number , month : Number ) : Number
		{
			var d : Date = new Date( year , month , 1 );
			
			return d.getDay( );
		}
		
		/**
		 * @private
		 */
		protected function _keyDown ( e : KeyboardEvent ) : void
		{
			switch ( e.keyCode )
			{
				case Keyboard.SPACE : _toggleOpen(); break;
				
				case Keyboard.ENTER : 
					
					//_selectSwatchAndClose( _currentSwatchOver , uint( "0x" + _paletteTextInput.text.replace( "#" , "" ) ) );
					
					dispatchEvent( new ComponentEvent( ComponentEvent.ENTER ) );
					
					break;
				
				case Keyboard.ESCAPE : 
				
					close();
					
					break;
					
				case Keyboard.DOWN : 
				case Keyboard.UP : 
				case Keyboard.RIGHT : 
				case Keyboard.LEFT : 
				
					
					
					break;
				
				case Keyboard.HOME :
					
					
					break;
					
				case Keyboard.END :
					
					
					break;
					
				case Keyboard.PAGE_DOWN :
					
					
					break;
					
				case Keyboard.PAGE_UP :
					
					
					break;
				
			}
		}
	}
}
