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
package myLib.medias 
{
	import flash.events.EventDispatcher;
	/**
	 * StreamClient class is useful with media which use a netStream object to specified all callback within this netStream.
	 * Generaly only onMetaData callback is necessary so you do not need to do anything.
	 * If you have specific callback with your netStream media inherit this class to add your own and add an instance to your StreamMedia object
	 * with streamClient property.
	 * 
	 * @see StreamMedia#streamClient
	 * @author SamYStudiO
	 */
	public class StreamClient extends EventDispatcher implements IStreamClient
	{
		/**
		 * Build a new StreamClient instance.
		 */
		public function StreamClient(  )
		{
			
		}
		
		/**
		 * @inheritDoc
		 */
		public function onMetaData( infos : Object = null ) : void
		{
			dispatchEvent( new StreamClientEvent( StreamClientEvent.META_DATA , infos ) );
		}
		
		/**
		 * @inheritDoc
		 */
		public function onXMPData( infos : Object = null ) : void
		{
			dispatchEvent( new StreamClientEvent( StreamClientEvent.XMP_DATA , infos ) );
		}
		
		/**
		 * @inheritDoc
		 */
		public function onCuePoint( infos : Object = null ) : void
		{
			dispatchEvent( new StreamClientEvent( StreamClientEvent.CUE_POINT , infos ) );
		}
		
		/**
		 * @inheritDoc
		 */
		public function onImageData( infos : Object = null ) : void
		{
			dispatchEvent( new StreamClientEvent( StreamClientEvent.IMAGE_DATA , infos ) );
		}
		
		/**
		 * @inheritDoc
		 */
		public function onPlayStatus( infos : Object = null ) : void
		{
			dispatchEvent( new StreamClientEvent( StreamClientEvent.PLAY_STATUS , infos ) );
		}
		
		/**
		 * @inheritDoc
		 */
		public function onTextData( infos : Object = null ) : void
		{
			dispatchEvent( new StreamClientEvent( StreamClientEvent.TEXT_DATA , infos ) );
		}
		
		/**
		 * @inheritDoc
		 */
		public function onLastSecond( infos : Object = null ) : void
		{
			dispatchEvent( new StreamClientEvent( StreamClientEvent.LAST_SECOND , infos ) );
		}
	}
}
