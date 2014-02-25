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
	import myLib.styles.Padding;

	import flash.utils.getQualifiedClassName;
	/**
	 * ACellRenderer is the abstract ICellRenderer implementation. You should override this to make your custom list cells.
	 * 
	 * @author SamYStudiO
	 */
	public class ACellRenderer extends Asset implements ICellRenderer 
	{
		/**
		 * @private
		 */
		protected var _index : uint;
		
		/**
		 * @inheritDoc
		 */
		public function get index() : uint
		{
			return _index;
		}
		
		public function set index( n : uint ) : void
		{
			_index = n;
		}
		
		/**
		 * @private
		 */
		protected var _data : *;
		
		/**
		 * @inheritDoc
		 */
		public function get data() : *
		{
			return _data;
		}
		
		public function set data( data : * ) : void
		{
			_data = data;
		}
		
		/**
		 * @private
		 */
		protected var _autoSize : Boolean;
		
		/**
		 * @inheritDoc
		 */
		public function get autoSize() : Boolean
		{
			return _autoSize;
		}
		
		public function set autoSize( b : Boolean ) : void
		{
			_autoSize = b;
		}
		
		/**
		 * @private
		 */
		protected var _selectable : Boolean;
		
		/**
		 * @inheritDoc
		 */
		public function get selectable() : Boolean
		{
			return _selectable;
		}
		
		public function set selectable( b : Boolean ) : void
		{
			_selectable = b;
		}
		
		/**
		 * @private
		 */
		protected var _selected : Boolean;
		
		/**
		 * @inheritDoc
		 */
		public function get selected() : Boolean
		{
			return _selected;
		}
		
		public function set selected( b : Boolean ) : void
		{
			_selected = b;
		}
		
		/**
		 * @private
		 */
		protected var _groupOwner : String;
		
		/**
		 * @inheritDoc
		 */
		public function get groupOwner() : String
		{
			return _groupOwner;
		}
		
		public function set groupOwner( name : String ) : void
		{
			_groupOwner = name;
		}
		
		/**
		 * @private
		 */
		protected var _padding : Padding;
		
		/**
		 * @inheritDoc
		 */
		public function get padding() : Padding
		{
			return _padding;
		}
		
		public function set padding( padding : Padding ) : void
		{
			_padding = padding;
		}
		
		/**
		 * @private
		 */
		public function ACellRenderer()
		{
			if( getQualifiedClassName( this ) == "myLib.controls::ACellRenderer" )
				throw new Error( this + " Abstract class cannot be instantiated" );
		}
	}
}
