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
package myLib.transitions 
{
	import flash.events.Event;					
	/**
	 * @private
	 * The TweenEvent class defines the tween events that are associated with the Tween class. 
	 * @see myLib.transitions.Tween
	 * @author SamYStudiO ( contact@samystudio.net )
	 */
	public class TweenEvent extends Event 
	{
		/**
		 * Defines the value of the type property of a tweenStart event object.
		 * 
		 * @eventType tweenStart
		 */
		public static const TWEEN_START : String = "tweenStart";
	
		/**
		 * Defines the value of the type property of a tweenStop event object.
		 * 
		 * @eventType tweenStop
		 */
		public static const TWEEN_STOP : String = "tweenStop";
	
		/**
		 * Defines the value of the type property of a tweenResume event object.
		 * 
		 * @eventType tweenResume
		 */
		public static const TWEEN_RESUME : String = "tweenResume";
	
		/**
		 * Defines the value of the type property of a tweenProgress event object.
		 * 
		 * @eventType tweenProgress
		 */
		public static const TWEEN_PROGRESS : String = "tweenProgress";
	
		/**
		 * Defines the value of the type property of a tweenComplete event object.
		 * 
		 * @eventType tweenComplete
		 */
		public static const TWEEN_COMPLETE : String = "tweenComplete";
	
		/**
		 * Defines the value of the type property of a tweenReverse event object.
		 * 
		 * @eventType tweenReverse
		 */
		public static const TWEEN_REVERSE : String = "tweenReverse";
	
		/**
		 * Defines the value of the type property of a tweenLoop event object.
		 * 
		 * @eventType tweenLoop
		 */
		public static const TWEEN_LOOP : String = "tweenLoop";
	
		/**
		 * Get the current Tween progression between 0 and 1.
		 */
		public var progress : Number;
	
		/**
		 * Build a new TweenEvent instance.
		 * @param type The event type as defined in TweenEvent constants.
		 * @param progress the current Tween progression.
		 */
		public function TweenEvent ( type : String , progress : Number , bubbles : Boolean = false , cancelable : Boolean = false )
		{
			super( type , bubbles , cancelable );
			
			this.progress = progress;
		}
		
		/**
		 * Creates a copy of the TweenEvent object and sets the value of each parameter to match the original.
		 * 
		 * @return The exact copy of TweenEvent
		 */
		public override function clone(  ) : Event
		{
			return new TweenEvent( type , progress , bubbles , cancelable );
		}
		
		/**
		 * Returns a string that contains all the properties of the TweenEvent object.
		 * 
		 * @return A string that contains all the properties of the TweenEvent object.
		 */
		public override function toString(  ) : String
		{
			return formatToString( "TweenEvent", "type" , "progress" , "bubbles" , "cancelable" );
		}
	}
}
