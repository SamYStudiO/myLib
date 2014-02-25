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
package myLib.data {
	import myLib.utils.ObjectUtils;
				/**
	 * DataProvider is a collection which can be initialized with an Array object and a XML or XMLList object.
	 * DataProvider is generally used with List and ComboBox components.
	 * 
	 * @author SamYStudiO ( contact@samystudio.net )
	 */
	public class DataProvider extends SimpleCollection	{
		/**
		 * Build a new DataProvider instance.
		 * @param source The source for this collection, this can be either an Array object or XML/XMLList object.
		 */
		public function DataProvider ( source : * = null )		{
			var a : Array;
			
			switch( true )
			{
				case source is Array : a = _fixArray( source as Array ); break;				case source is XML : a = _getArrayFromXMLList( ( source as XML ).* ); break;				case source is XMLList : a = _getArrayFromXMLList( source as XMLList ); break;				case source is ICollection : a = ( source as ICollection ).data; break;				case source == null : break;
				
				default : break;//throw new Error( this + " source cannot be converted to a valid DataProvider" ); break;
			}
			
			super( a );
		}
		
		/**
		 * @private
		 */
		protected function _fixArray( from : Array ) : Array
		{
			if( ObjectUtils.isSimple( from[ 0 ] ) )
			{
				var a : Array = new Array();
				var i : int = -1;
				var l : uint = from.length;
				
				while( ++i < l )  a.push( { label : String( from[ i ] ) , data : from[ i ] } );	
				
				return a;
			}
			
			return from.concat();
		}
		
		/**
		 * @private
		 */
		protected function _getArrayFromXMLList( list : XMLList ) : Array
		{
			var a : Array = new Array();
			
			for each( var node : XML in list )
			{
				var o : Object = new Object();
				var attributes : XMLList = node.attributes();
				
				for each ( var attribute : XML in attributes )
					o[ attribute.localName() ] = attribute.toString();
				
				if( node.hasSimpleContent() &&  o.label == undefined && node.toString() != "" ) o.label = node.toString();
				else
				{
					var nodes : XMLList = node.*;
					
					for each ( var subNode : XML in nodes )
					{
						if ( subNode.hasSimpleContent() )
							o[ subNode.localName() ] = subNode.toString();
					}
				}
				
				a.push( o );
			}
			
			return a;
		}	}
}
