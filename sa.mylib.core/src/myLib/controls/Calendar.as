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
	import myLib.assets.IAsset;
	import myLib.controls.skins.ICalendarSkin;
	import myLib.controls.skins.my_skinset;
	import myLib.core.AFieldComponent;
	import myLib.core.InvalidationType;
	import myLib.form.IField;
	import myLib.styles.Padding;

	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	/**
	 * @private
	 * 
	 * @author SamYStudiO
	 */
	public class Calendar extends AFieldComponent implements ICalendar, IField
	{
		/**
		 * @private
		 */
		protected var _calendarSkin : ICalendarSkin;
		
		/**
		 * @private
		 */
		protected var _dayHandler : Sprite = new Sprite();
		
		/**
		 * @private
		 */
		protected var _displayFormat : String = "yyyy/MM/dd";
		
		/**
		 *
		 */
		[Inspectable(defaultValue="yyyy/MM/dd")]
		public function get displayFormat() : String
		{
			return _displayFormat;
		}
		
		public function set displayFormat( format : String ) : void
		{
			if( _displayFormat == format || ( _inspector && !_isLivePreview && _displayFormat != "yyyy/MM/dd" ) ) return;
			
			_displayFormat = format;
		}
		
		/**
		 * @private
		 */
		protected var _date : Date;
		
		/**
		 *
		 */
		public function get date() : Date
		{
			return _date;
		}
		
		public function set date( date : Date ) : void
		{
			_date = date;
		}
		
		/**
		 * @private
		 */
		protected var _dayRenderer : String = "myLib.controls.Button";
		
		[Inspectable(defaultValue="myLib.controls.Button")] 
		/**
		 * @inheritDoc
		 */
		public function get dayRenderer() : String
		{
			return _dayRenderer;
		}
		
		public function set dayRenderer( definition : String ) : void
		{
			if( _dayRenderer == definition || ( _inspector && !_isLivePreview && _dayRenderer != "myLib.controls.Button" ) ) return;
			
			_dayRenderer = definition;
			
			invalidate( InvalidationType.DATA );
		}
		
		/**
		 * @private
		 */
		protected var _dayButtonWidth : Number = 10;
		
		[Inspectable(defaultValue=10)]
		/**
		 * @inheritDoc
		 */
		public function get dayButtonWidth() : Number
		{
			return _dayButtonWidth;
		}
		
		public function set dayButtonWidth( n : Number ) : void
		{
			if( _dayButtonWidth == n || ( _inspector && !_isLivePreview && _dayButtonWidth != 10 ) ) return;
			
			_dayButtonWidth = Math.abs( n );
			
			invalidate( InvalidationType.DATA );
		}
		
		/**
		 * @private
		 */
		protected var _dayButtonHeight : Number = 10;
		
		[Inspectable(defaultValue=10)]
		/**
		 * @inheritDoc
		 */
		public function get dayButtonHeight() : Number
		{
			return _dayButtonHeight;
		}
		
		public function set dayButtonHeight( n : Number ) : void
		{
			if( _dayButtonHeight == n || ( _inspector && !_isLivePreview && _dayButtonHeight != 10 ) ) return;
			
			_dayButtonHeight = Math.abs( n );
			
			invalidate( InvalidationType.DATA );
		}
		
		/**
		 * @private
		 */
		protected var _padding : Padding = new Padding( 5 , 5 , 5 , 5 );
		
		/**
		 * @inheritDoc
		 */
		public function get padding() : Padding
		{
			return _padding == null ? new Padding( 5 , 5 , 5 , 5 ) : _padding;
		}
		
		public function set padding( padding : Padding ) : void
		{
			if( padding == _padding ) return;
			
			_padding = padding;
			
			invalidate( InvalidationType.DATA );
		}
		
		[Inspectable(name="paletteContentPadding",type="Object",defaultValue="left:5,top:5,right:5,bottom:5")]
		/**
		 * @private
		 */
		public function set inspectablePadding( padding : Object ) : void
		{
			if( !_inspector && !_isLivePreview ) throw new Error( this + " inspectablePadding property is internal and used by Flash component inspector panel , use padding property instead" );
			
			if( _inspector && !_isLivePreview && ( _padding.left != 5 || _padding.top != 5 || _padding.right != 5 || _padding.bottom != 5 ) ) return;
			
			padding = new Padding( padding.left , padding.top , padding.right , padding.bottom );
		}
		
		/**
		 * @private
		 */
		protected var _monthYearSelector : ICalendarMonthYearSelector;
		
		/**
		 *
		 */
		public function get monthYearSelector() : ICalendarMonthYearSelector
		{
			return _monthYearSelector;
		}
		
		/**
		 * @private
		 */
		protected var _background : IAsset;
		
		/**
		 *
		 */
		public function get background() : IAsset
		{
			return _background;
		}
		
		/**
		 * 
		 */
		public function Calendar( parentContainer : DisplayObjectContainer = null , initStyle : Object = null , skin : ICalendarSkin = null )
		{
			_calendarSkin = skin == null ? my_skinset[ "Calendar" ] : skin;
			
			super( parentContainer , initStyle , _calendarSkin );
		}
		
		/**
		 *
		 */
		public override function getValue(  ) : *
		{
			return _date;
		}
		
		/**
		 *
		 */
		public override function setValue( value : * ) : void
		{
			//date = value is Date ? value as Date : DateFormatter.getDateFrom( value ,  );
		}
		
		/**
		 * @private
		 */
		protected override function _init(  ) : void
		{
			
		}
		
		/**
		 * @private
		 */
		protected override function _createChildren(  ) : void
		{
			
		}
		
		/**
		 * @private
		 */
		protected override function _draw(  ) : void
		{
			
		}
		
		/**
		 * @private
		 */
		protected function _getMonthLength ( year : Number , month : Number ) : Number
		{
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
		protected function _getFirstWeekDayOfMonth ( year : Number , month : Number ) : Number
		{
			var d : Date = new Date( year , month , 1 );
			
			return d.getDay( );
		}
		
		/**
		 * @private
		 */
		protected function _getMonthGrid ( year : Number , month : Number , firstGridWeekDay : Number ) : Array
		{
			var f : Number = firstGridWeekDay;
			
			f = isNaN( f ) || f < 0 ? 0 : f > 6 ? 6 : f;
			
			var grid : Array = new Array( 6 );
			var firstWeekDay : Number = _getFirstWeekDayOfMonth( year , month );
			var offset : Number = firstWeekDay - f;
			var firstOffset : Number = offset < 0 ? offset + 7 : offset;
			var d : Number = 1;
			var l : Number = _getMonthLength( year , month );
			var i : Number = -1;
			
			while( ++i < 6 )
			{
				grid[i] = new Array( 7 );
				
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
	}
}
