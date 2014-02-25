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
	import flash.display.DisplayObjectContainer;
	import flash.net.URLRequest;
	
	/**
	 * @author SamYStudiO ( contact@samystudio.net )
	 */
	public class ExternalImageContainer extends ImageContainer implements IExternalImageContainer
	{
		/**
		 * @private
		 */
		protected var _stream : LoaderStream;
		
		/**
		 * @private
		 */
		protected var _media : StreamMedia;
		
		/**
		 * 
		 */
		public function ExternalImageContainer( parentContainer : DisplayObjectContainer = null , initStyle : Object = null )
		{
			super( parentContainer , initStyle );
		}
		
		/**
		 * @inheritDoc
		 * 
		 */
		public function load( image : * ) : void
		{
			var media : StreamMedia;
			
			switch( true ) 
			{
				case image is String : media = new StreamMedia( new URLRequest( image ) ); break;
				case image is URLRequest : media = new StreamMedia( image ); break;
				case image is StreamMedia : media = image as StreamMedia; break;
				
				default : throw new Error( this + " invalid image type, valid arguments are String url, URLResquest object or StreamMedia object" );
					
			}
			
			close();
			
			_stream = new LoaderStream( );
			_stream.addEventListener( StreamEvent.LOADING , _propagateEvent , false , 0 , true );
			_stream.addEventListener( StreamEvent.LOADING_COMPLETE , _loaded , false , 0 , true );
			_stream.addEventListener( StreamEvent.CLOSE , _mediaClose , false , 0 , true );
			_stream.addEventListener( StreamEvent.STREAM_NOT_FOUND , _streamError , false , 0 , true );
			
			_stream.play( media );
		}
		
		/**
		 * @inheritDoc
		 */
		public function close(  ) : void
		{
			if( _stream != null ) _stream.close();
			
			_stream = null;
		}
		
		/**
		 * @private
		 */
		protected function _propagateEvent( e : StreamEvent ) : void
		{
			dispatchEvent( e );
		}
		
		/**
		 * @private
		 */
		protected function _loaded( e : StreamEvent ) : void
		{
			source = _stream.handler;
			
			dispatchEvent( e );
		}
		
		/**
		 * @private
		 */
		protected function _mediaClose( e : StreamEvent ) : void
		{
			_stream.removeEventListener( StreamEvent.LOADING , _propagateEvent );
			_stream.removeEventListener( StreamEvent.LOADING_COMPLETE , _propagateEvent );
			_stream.removeEventListener( StreamEvent.CLOSE , _mediaClose );
			_stream.removeEventListener( StreamEvent.STREAM_NOT_FOUND , _streamError );
			_stream = null;
			
			_propagateEvent( e );
			
			if( _media != null )
			{
				_media.reset();
				_media = null;
			}
		}
		
		/**
		 * @private
		 */
		protected function _streamError ( e : StreamEvent ) : void
		{
			var mediaURL : String = _media.request.url;
			
			close();
			
			if( willTrigger( StreamEvent.STREAM_NOT_FOUND ) )
				_propagateEvent( e );
			else
				throw new Error( this + " " + mediaURL + " not found" );
		}
	}
}
