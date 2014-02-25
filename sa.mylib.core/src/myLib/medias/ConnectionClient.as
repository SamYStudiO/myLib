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
 * The Original Code is myLib Framework.
 *
 * The Initial Developer of the Original Code is
 * Samuel EMINET (aka SamYStudiO) contact@samystudio.net.
 * Portions created by the Initial Developer are Copyright (C) 2008-2011
 * the Initial Developer. All Rights Reserved.
 *
 */
package myLib.medias 
{
	import flash.events.EventDispatcher;	
	/**
	 * @private
	 * 
	 * @author SamYStudiO ( contact@samystudio.net )
	 */
	internal class ConnectionClient extends EventDispatcher
	{
		/**
		 * Build a new ConnectionClient instance.
		 */
		public function ConnectionClient(  )
		{
			
		}
		
		/**
		 * 
		 */
		public function onBWCheck( ...args ) : int 
		{
			return 0;
		}
		
		/**
		 * 
		 */
		public function onBWDone( ...args ) : void
		{
			if( args.length > 0 )
			{
				dispatchEvent( new ConnectionEvent( ConnectionEvent.BANDWIDTH_DEFINED , ( args[ 0 ] * 1.5 ) * 1000 / 8 ) );
			}
		}
	}
}
