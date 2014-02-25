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
package myLib.data 
{
	import flash.events.Event;						
	/**
	 * The CollectionEvent class defines the events that are associated with a ICollection object. 
	 * 
	 * @author SamYStudiO ( contact@samystudio.net )
	 */
	public class CollectionEvent extends Event 
	{
		/**
		 * Defines the value of the type property of a add event object.
		 * 
		 * @eventType add
		 */
		public static const ADD : String = "add";
		
		/**
		 * Defines the value of the type property of a remove event object.
		 * 
		 * @eventType remove
		 */
		public static const REMOVE : String = "remove";
		
		/**
		 * Defines the value of the type property of a clear event object.
		 * 
		 * @eventType clear
		 */
		public static const CLEAR : String = "clear";
		
		/**
		 * Defines the value of the type property of a replace event object.
		 * 
		 * @eventType replace
		 */
		public static const REPLACE : String = "replace";
		
		/**
		 * Defines the value of the type property of a sort event object.
		 * 
		 * @eventType sort
		 */
		public static const SORT : String = "sort";
		
		/**
		 * Get the collection index associated with this event.
		 */
		public var fromIndex : int;
		
		/**
		 * Get the collection item associated with this event.
		 */
		public var item : *;
		
		/**
		 * Build a new CollectionEvent instance.
		 * @param type The event type as defined in CollectionEvent constants.
		 * @param fromIndex The collection index where event occured.
		 * @param item The collection item that is affected by this event.
		 */
		public function CollectionEvent ( type : String , fromIndex : int = -1 , item : * = null )
		{
			super( type );
			
			this.fromIndex = fromIndex;
			this.item = item;
		}
		
		/**
		 * Creates a copy of the CollectionEvent object and sets the value of each parameter to match the original.
		 * 
		 * @return The exact copy of CollectionEvent
		 */
		public override function clone(  ) : Event
		{
			return new CollectionEvent( type , fromIndex , item );
		}
		
		/**
		 * Returns a string that contains all the properties of the CollectionEvent object.
		 * 
		 * @return A string that contains all the properties of the CollectionEvent object.
		 */
		public override function toString(  ) : String
		{
			return formatToString( "DataEvent", "type" , "fromIndex" , "item" , "bubbles" , "cancelable" );
		}
	}
}
