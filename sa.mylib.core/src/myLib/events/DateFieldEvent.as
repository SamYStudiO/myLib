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
	 * @private
	 * 
	 * The DateFieldEvent class defines the events that are associated with a DateField component. 
	 * 
	 * @author SamYStudiO ( contact@samystudio.net )
	 */
	public class DateFieldEvent extends Event 
	{
		/**
		 * Defines the value of the type property of a open event object.
		 * 
		 * @eventType open
		 */
		public static const OPEN : String = "open";
		
		/**
		 * Defines the value of the type property of a close event object.
		 * 
		 * @eventType close
		 */
		public static const CLOSE : String = "close";
		
		/**
		 * Build a new DateFieldEvent instance.
		 * @param type The event type as defined in DateFieldEvent constants.
		 */
		public function DateFieldEvent ( type : String , bubbles : Boolean = false , cancelable : Boolean = false )
		{
			super( type , bubbles , cancelable );
		}
	}
}
