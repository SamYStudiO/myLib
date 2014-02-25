﻿/* * The contents of this file are subject to the Mozilla Public License Version * 1.1 (the "License"); you may not use this file except in compliance with * the License. You may obtain a copy of the License at  * *        http://www.mozilla.org/MPL/  * * Software distributed under the License is distributed on an "AS IS" basis, * WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License * for the specific language governing rights and limitations under the License.  * * The Original Code is myLib. * * The Initial Developer of the Original Code is * Samuel EMINET (aka SamYStudiO) contact@samystudio.net. * Portions created by the Initial Developer are Copyright (C) 2008-2011 * the Initial Developer. All Rights Reserved. * */package myLib.events {
	import flash.events.Event;						/**	 * The ComponentEvent class defines the events that are associated with a component. 	 * 	 * @author SamYStudiO ( contact@samystudio.net )	 */
	public class ComponentEvent extends Event 	{		/**		 * Defines the value of the type property of a enabledChanged event object.		 * 		 * @eventType enabledChanged		 */		public static const ENABLED_CHANGED : String = "enabledChanged";				/**		 * Defines the value of the type property of a visibleChanged event object.		 * 		 * @eventType visibleChanged		 */		public static const VISIBLE_CHANGED : String = "visibleChanged";				/**		 * Defines the value of the type property of a resize event object.		 * 		 * @eventType resize		 */		public static const RESIZE : String = "resize";				/**		 * Defines the value of the type property of a move event object.		 * 		 * @eventType move		 */		public static const MOVE : String = "move";				/**		 * Defines the value of the type property of a draw event object.		 * 		 * @eventType draw		 */		public static const DRAW : String = "draw";				/**		 * Defines the value of the type property of a enter event object.		 * 		 * @eventType enter		 */		public static const ENTER : String = "enter";				/**         * Defines the value of the type property of a valueChange event object.         *          * @eventType valueChange         */        public static const VALUE_CHANGE : String = "valueChange";				/**		 * Build a new ComponentEvent instance.		 * @param type The event type as defined in ComponentEvent constants.		 */
		public function ComponentEvent ( type : String , bubbles : Boolean = false , cancelable : Boolean = false )		{
			super( type , bubbles , cancelable );
		}	}
}
