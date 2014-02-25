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
	 * The ButtonEvent class defines the events that are associated with a Button component. 
	 * 
	 * @author SamYStudiO ( contact@samystudio.net )
	 */
	public class ButtonEvent extends Event 
	{
		/**
		 * Defines the value of the type property of a toggle event object.
		 * 
		 * @eventType toggle
		 */
		public static const TOGGLE : String = "toggle";
		
		/**
		 * Defines the value of the type property of a mouseUpOutside event object.
		 * 
		 * @eventType mouseUpOutside
		 */
		public static const MOUSE_UP_OUTSIDE : String = "mouseUpOutside";
		
		/**
		 * Defines the value of the type property of a repeatMouseDown event object.
		 * 
		 * @eventType repeatMouseDown
		 */
		public static const REPEAT_MOUSE_DOWN : String = "repeatMouseDown";
		
		/**
		 * Defines the value of the type property of a stateChanged event object.
		 * 
		 * @eventType stateChanged
		 */
		public static const STATE_CHANGED : String = "stateChanged";
		
		/**
		 * Build a new ButtonEvent instance.
		 * @param type The event type as defined in ButtonEvent constants.
		 */
		public function ButtonEvent ( type : String , bubbles : Boolean = false , cancelable : Boolean = false )
		{
			super( type , bubbles , cancelable );
		}
	}
}
