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
	 * The DynamicEvent class is a event where you can add any variables since it is dynamic. 
	 * 
	 * @author SamYStudiO ( contact@samystudio.net )
	 */
	public dynamic class DynamicEvent extends Event 
	{
		/**
		 * Build a new DynamicEvent instance.
		 * @param type The event type.
		 */
		public function DynamicEvent ( type : String , bubbles : Boolean = false , cancelable : Boolean = false )
		{
			super( type , bubbles , cancelable );
		}
	}
}
