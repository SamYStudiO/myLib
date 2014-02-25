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
package myLib.events 
{
	import myLib.controls.ICellRenderer;
	
	import flash.events.Event;	
	/**
	 * The ListEvent class defines the events that are associated with a List component. 
	 * 
	 * @author SamYStudiO ( contact@samystudio.net )
	 */
	public class ListEvent extends Event 
	{
		/**
         * Defines the value of the type property of a selectionChange event object.
         * 
         * @eventType selectionChange
         */
        public static const SELECTION_CHANGE : String = "selectionChange";
		
		/**
		 * Defines the value of the type property of a cellAdded event object.
		 * 
		 * @eventType cellAdded
		 */
		public static const CELL_ADDED : String = "cellAdded";
		
		/**
		 * Defines the value of the type property of a cellAdded event object.
		 * 
		 * @eventType cellAdded
		 */
		public static const CELL_REMOVED : String = "cellRemoved";
		
		/**
		 * Defines the value of the type property of a cellOver event object.
		 * 
		 * @eventType cellOver
		 */
		public static const CELL_OVER : String = "cellOver";
		
		/**
		 * Defines the value of the type property of a cellOut event object.
		 * 
		 * @eventType cellOut
		 */
		public static const CELL_OUT : String = "cellOut";
		
		/**
		 * Defines the value of the type property of a cellClick event object.
		 * 
		 * @eventType cellClick
		 */
		public static const CELL_CLICK : String = "cellClick";
		
		/**
		 * Get or set the ICellRenderer object affected by this event.
		 */
		public var cell : ICellRenderer;

		/**
		 * Build a new ListEvent instance.
		 * @param type The event type as defined in ListEvent constants.
		 * @param cell The ICellRender object that is affected by this event.
		 */
		public function ListEvent ( type : String , cell : ICellRenderer = null , bubbles : Boolean = false , cancelable : Boolean = false )
		{
			super( type , bubbles , cancelable );
			
			this.cell = cell;
		}
		
		/**
		 * Creates a copy of the ListEvent object and sets the value of each parameter to match the original.
		 */
		public override function clone(  ) : Event
		{
			return new ListEvent( type , cell , bubbles , cancelable );
		}
		
		/**
		 * Returns a string that contains all the properties of the ListEvent object.
		 * 
		 * @return A string that contains all the properties of the ListEvent object.
		 */
		public override function toString(  ) : String
		{
			return formatToString( "ListEvent", "type" , "cell" , "bubbles" , "cancelable" );
		}
	}
}
