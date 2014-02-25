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
	import myLib.controls.skins.IButtonSkin;
	
	import flash.display.DisplayObjectContainer;	
	/**
	 * ListCell is the default cell renderer for List and ComboBox components. You can extend it or make your own ICellRenderer implementation for complex cells.
	 * 
	 * @author SamYStudiO ( contact@samystudio.net )
	 */
	public class ListCell extends Button implements ICellRenderer 
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
		 * @inheritDoc
		 */
		public override function get data() : *
		{
			return _data;
		}
		
		public override function set data( data : * ) : void
		{
			if( _data == data ) return;
			
			// TODO try to merge all data as style?			text = data[ ( _owner as IList ).labelField ];
			
			icon = data[ ( _owner as IList ).iconField ];
			
			_data = data;
		}
		
		/**
		 * Build a new ListCell instance. Default size is 100*20.
		 * @param parentContainer The parent DisplayObjectContainer where add this ListCell.
		 * @param initStyle The initial style object for ListCell initialization.
		 * @param skin The IButtonSkin to use instead of default skin.
		 * 
		 * @see myLib.styles.StyleManager
		 */
		public function ListCell ( parentContainer : DisplayObjectContainer = null , initStyle : Object = null , skin : IButtonSkin = null )
		{
			super( parentContainer , initStyle , skin );
		}
		
		/**
		 * @private
		 */
		protected override function _init(  ) : void
		{
			super._init();
			
			focusEnabled = false;
			
			_horizontalAlignment = LabelAlignment.LEFT;
		}
	}
}
