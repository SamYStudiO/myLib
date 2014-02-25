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
	/**
	 * @private
	 * 
	 * @author SamYStudiO ( contact@samystudio.net )
	 */
	internal class ListCellData 
	{
		/**
		 *
		 */
		public var index : uint;
	
		/**
		 * 
		 */
		public var filterIndex : int = -1;
	
		/**
		 *
		 */
		public var cell : ICellRenderer;
		
		/**
		 * @private
		 */
		protected var _cellRenderer : *;
		
		/**
		 * 
		 */
		public function get cellRenderer () : *
		{
			return _cellRenderer == null ? _owner.cellRenderer : _cellRenderer;
		}
		
		public function set cellRenderer ( definition : * ) : void
		{
			_cellRenderer = definition;
		}
		
		/**
		 * @private
		 */
		protected var _style : Object;
	
		/**
		 * 
		 */
		public function get style () : Object
		{
			return _style == null ? _owner.cellStyle : _style;
		}
		
		public function set style ( style : Object ) : void
		{
			_style = style;
		}
		
		/**
		 * @private
		 */
		protected var _owner : IList;
	
		/**
		 *
		 */
		public function get owner () : IList
		{
			return _owner;
		}
		
		/**
		 * @private
		 */
		protected var _data : *;
	
		/**
		 *	
		 */
		public function get data () : *
		{
			return _data;
		}
		
		/**
		 *
		 */
		public function get height() : Number
		{
			return style != null ? ( style.height || _owner.cellHeight ) : _owner.cellHeight;
		}
	
		/**
		 * 
		 */
		public function ListCellData ( ownerList : IList , index : uint , data : * )
		{
			_owner = ownerList;
			_data = data;
			
			this.index = index;
		}
	}
}
