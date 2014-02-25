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
	import myLib.data.SimpleCollection;
	import myLib.data.SimpleIterator;
	import myLib.utils.StringUtils;
	import myLib.utils.TimeFormatter;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.net.URLLoader;
	import flash.net.URLRequest;	

	/**
	 * Dispatched when subtitle file is loaded.
     */
    [Event(name="complete", type="flash.events.Event")]
    
	/**
	 * SubTitle is a SRT file reader. Valid formats are :
	 * 
	 * <listing>1
	 * 00:00:00,901 --> 00:00:02,723
	 * Hello World!!!
	 *	
	 * 2
	 * 00:00:03,408 --> 00:00:04,507
	 * I am a subtitle.
	 * 
	 * OR
	 * 
	 * 00:00:00,901 --> 00:00:02,723
	 * Hello
	 * world!!!
	 *	
	 * 00:00:03,408 --> 00:00:04,507
	 * I am a <b>subtitle</b>.</listing>
	 * 
	 * Subtitle index is optional, at least one blank line between each subtitle, multiline text and html tag are allowed.
	 * 
	 * @see StreamMedia#subTitle
	 * @see MediaPlayer
	 * 
	 * @author SamYStudiO ( contact@samystudio.net )
	 */
	public class SubTitle extends EventDispatcher implements ISubTitle
	{
		/**
		 * @private
		 */
		protected var _xml : XML = <root></root>;
		
		/**
		 * @private
		 */
		protected var _loader : URLLoader = new URLLoader();
		
		/**
		 * @private
		 */
		protected var _request : URLRequest;
		
		/**
		 * Get or set the URLRequest used to load subtitle.
		 */
		public function get request() : URLRequest
		{
			return _request;
		}
		
		public function set request( request : URLRequest ) : void
		{
			_request = request;
		}

		/**
		 * Build a new SubTitle instance.
		 * @param request The URLRequest used to load subtitle.
		 */
		public function SubTitle ( request : URLRequest = null )
		{
			_request = request;
			_loader.addEventListener( Event.COMPLETE , _parse , false , 0 , true );
		}
		
		/**
		 * Load the specified subtitle request. If no request is provided request property value is used for load operation.
		 * @param request A optional URLRequest used to load subtitle.
		 */
		public function load( request : URLRequest = null ) : void
		{
			_loader.load( request != null ? request : _request );
		}
		
		/**
		 * Get the subtitle text to display at the specified time in millisecond.
		 * @param time The time in milliseconds from which retrieve the subtitle.
		 * @return The text to display at the specified time.
		 */
		public function getSubAt( time : uint ) : String
		{
			var list : XMLList = _xml.child( "sub" ).( child( "start" ) <= time && child( "end" ) >= time );
			
			return list.length() > 0 ? list[ 0 ].text.toString() : "";
		}
		
		/**
		 * @private
		 */
		protected function _parse( e : Event ) : void
		{
			var subs : Array = String( e.target.data ).split( /\n\r?\n/ );
			var iterator : SimpleIterator = new SimpleIterator( new SimpleCollection( subs ) );
			
			while( iterator.hasNext() ) 
			{
				var item : * = iterator.next();
				
				if( item is String ) item = StringUtils.trim( item );
				
				if( item == null || item == "" ) continue;
				
				var sub : Array = item.split( /\r?\n/ );
				var hasIndex : Boolean = !isNaN( sub[ 0 ] ); 
				var i : uint = hasIndex ? 2 : 1;
				var times : Array = sub[ i - 1 ].split( " --> " );
				var startTime : Number = TimeFormatter.getTimeFrom( times[ 0 ] , "hh:mm:SS,ss" );
				var endTime : Number = TimeFormatter.getTimeFrom( times[ 1 ] , "hh:mm:SS,ss" );				var aText : Array = new Array( );
				var subText : String = sub[ i ];
				
				while( subText != null  ) 
				{
					aText.push( subText.split( /\r/ ).join( "" ) );
					subText = sub[ ++i ];
				}

				_xml.appendChild( new XML( "<sub><start>" + startTime + "</start><end>" + endTime + "</end><text><![CDATA[" + aText.join( "<br/>" ) + "]]></text></sub>" ) );
			}
			
			dispatchEvent( new Event( Event.COMPLETE ) );
		}
	}
}
