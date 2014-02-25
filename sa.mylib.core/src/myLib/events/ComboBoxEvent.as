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
	import flash.events.Event;				
	/**
	 * The ComboBoxEvent class defines the events that are associated with a ComboBox component. 
	 * 
	 * @author SamYStudiO ( contact@samystudio.net )
	 */
	public class ComboBoxEvent extends Event 
	{
		/**
		 * Defines the value of the type property of a boxListRollOut event object.
		 * 
		 * @eventType boxListRollOut
		 */
		public static const BOX_LIST_ROLL_OUT : String = "boxListRollOut";
		
		/**
		 * Defines the value of the type property of a open event object.
		 * 
		 * @eventType open
		 */
		public static const OPEN : String = "open";
		
		/**
		 * Defines the value of the type property of a openComplete event object.
		 * 
		 * @eventType openComplete
		 */
		public static const OPEN_COMPLETE : String = "openComplete";
		
		/**
		 * Defines the value of the type property of a close event object.
		 * 
		 * @eventType close
		 */
		public static const CLOSE : String = "close";
		
		/**
		 * Defines the value of the type property of a closeComplete event object.
		 * 
		 * @eventType closeComplete
		 */
		public static const CLOSE_COMPLETE : String = "closeComplete";
		
		/**
		 * Defines the value of the type property of a openDirectionChange event object.
		 * 
		 * @eventType openDirectionChange
		 */
		public static const OPEN_DIRECTION_CHANGE : String = "openDirectionChange";
		
		/**
		 * Build a new ComboBoxEvent instance.
		 * @param type The event type as defined in ComboBoxEvent constants.
		 */
		public function ComboBoxEvent ( type : String , bubbles : Boolean = false , cancelable : Boolean = false )
		{
			super( type , bubbles , cancelable );
		}
	}
}
