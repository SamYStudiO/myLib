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
package myLib.utils 
{
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	import flash.utils.getQualifiedClassName;	
	/**
	 * Utils for Object operations.
	 * 
	 * @author SamYStudiO ( contact@samystudio.net )
	 */
	public final class ObjectUtils 
	{
		/**
		 * @private
		 */
		public function ObjectUtils()
		{
			throw new Error( this + " cannot be instantiated" );
		}
		
		/**
		 * Test if property is defined within an object.
		 * @param o The object where search for property.
		 * @param property The property to search.
		 * @return true if property is found within object.
		 */
		public static function hasProperty( o : * , property : String ) : Boolean
		{
			return o[ "hasOwnProperty" ]( property );
		}
		
		/**
		 * Test if property is defined within an object and if the property is not a function.
		 * @param o The object where search for property.
		 * @param property The property to search.
		 * @return true if property is found within object and is not a function.
		 */
		public static function hasVariable( o : * , variable : String ) : Boolean
		{
			return o[ "hasOwnProperty" ]( variable ) && typeof( o[ variable ] != "function" );
		}
		
		/**
		 * Test if property is defined within an object and if the property is a function.
		 * @param o The object where search for property.
		 * @param property The property to search.
		 * @return true if property is found within object and is a function.
		 */
		public static function hasMethod( o : * , method : String ) : Boolean
		{
			return o[ "hasOwnProperty" ]( method ) && typeof( o[ method ] == "function" );
		}
		
		/**
		 * Test if a object is primitive (Number, String or Boolean).
		 * @param o The object to test.
		 * @return true if object is Number, String or Boolean.
		 */
		public static function isSimple( o : * ) : Boolean
		{
			return o is Number || o is String || o is Boolean;
		}
		
		/**
		 * Do a deep copy of an object.
		 * @param o The object to copy.
		 * @return The deep copy of the object.
		 */
		public static function copy ( o : Object ) : Object
		{
			var buffer : ByteArray = new ByteArray( );
			
			buffer.writeObject( o );
			buffer.position = 0;
			
			return buffer.readObject( );
		}
		
		/**
		 * Merge properties from a object to another one. Only dynamic propeties are merged.
		 * @param fromObject The object from wich copy the properties.
		 * @param toObject The object where copy the properties.
		 * @param overwrite A boolean that indicates if a existing property can be overwritten.
		 * @param excludeProperties An Array or Object of properties to exclude.
		 * @return The object where properties are merged.
		 */
		public static function merge ( fromObject : Object , toObject : Object , overwrite : Boolean = true , excludeProperties : * = null ) : Object
		{
			toObject = toObject == null ? new Object() : toObject;
			
			excludeProperties = excludeProperties == null ? new Object() : excludeProperties;
			
			for( var s : String in fromObject ) 
			{
				if( ( excludeProperties is Array && ( excludeProperties as Array ).indexOf( s ) == -1 ) || ( !( excludeProperties is Array ) && excludeProperties[ s ] == undefined ) )
				{
					if( !overwrite )
					{
						var hasProperty : Boolean;
						
						try
						{
							hasProperty = toObject[ s ] != undefined;
						}
						catch( e : Error )
						{
							hasProperty = false;
						}
						
						if( hasProperty ) continue;
					}
					
					try
					{
						toObject[ s ] = fromObject[ s ];
					}
					catch( e : Error ) {}
				}
			}
			
			return toObject;
		}
		
		/**
		 * Compare two object and return if they are equal.
		 * @param o1 The first object to compare.
		 * @param o2 the second object to compare.
		 * @param strict A Boolean that indicates if strict mode is used (===).
		 * @return A Boolean that indicates if the two objects are equals. 
		 */
		public static function compare( o1 : * , o2 : * , strict : Boolean = false ) : Boolean
		{ 
			if( o1 == null && o2 == null ) return true;			if( o1 == null || o2 == null ) return false;
			if( isSimple( o1 ) || isSimple( o2 ) ) return strict ? o1 === o2 : o1 == o2;
			
			for( var prop1 : String in o1 ) 
			{
				if( strict )
				{
					if( o1[ prop1 ] !== o2[ prop1 ] ) return false;
				}
				else
				{
					if( o1[ prop1 ] != o2[ prop1 ] ) return false;
				}
			}
			
			for( var prop2 : String in o2 ) 
			{
				if( strict )
				{
					if( o1[ prop2 ] !== o2[ prop2 ] ) return false;
				}
				else
				{
					if( o1[ prop2 ] != o2[ prop2 ] ) return false;
				}
			}
			
			return true;
		}
		
		/**
         * Compare two array and return if they are equal.
         * @param o1 The first array to compare.
         * @param o2 the second array to compare.
         * @return A Boolean that indicates if the two array are equals. 
         */
        public static function arrayCompare( o1 : Array , o2 : Array ) : Boolean
        { 
			if( o1 == null && o2 != null ) return false;
			if( o1 != null && o2 == null ) return false;
			if( o1 == null && o2 == null ) return true;
			if( o1.length != o2.length ) return false;
			
			var l : uint = o1.length;
			
			for( var i : uint = 0; i < l; i++ ) 
			{
				if( o1[ i ] != o2[ i ] ) return false;
			}
			
			return true;
		}
		
		/**
		 * Get a string of an object with all its properties.
		 * @return the string representation of the object.
		 */
		public static function toString( o : Object ) : String
		{
			return "[ObjectUtils $toString" + _toString( o ) + "]";
		}
		
		/**
		 *
		 */
		private static function _toString( o : Object , tab : String = "  " , ref : Dictionary = null ) : String
		{
			ref = ref == null ? new Dictionary( true ) : ref;
			
			if( ref[ "_id_" ] == undefined ) ref[ "_id_" ] = 0;
			else ref[ "_id_" ] = uint( ref[ "_id_" ] ) + 1;
			
			if( ref[ o ] == undefined )
				ref[ o ] = "#" + String( ref[ "_id_" ] );
			
			var startTab : String = tab;
			var s : String = "\n" + tab + "{ " + ref[ o ] + "\n";
			var hasProp : Boolean = false;
			
			tab += "  ";
			
			for( var prop : String in o ) 
			{
				hasProp = true;
				
				var value : * = o[ prop ];
				var a : Array = getQualifiedClassName( value ).split( "::" );
				var className : String = a.length > 1 ? a[ 1 ] : a[ 0 ];
				
				switch( true )
				{
					case value is Number :					case value is String :					case value is Date :					case value is Boolean :
						s += tab + "- " + prop + " : " + className + " = " + value.toString() + "\n"; break;
					
					case value is XML :
					case value is XMLList :
						s += tab + "- " + prop + " : " + className + " = " + XMLList( value ).toXMLString().split( "\n" ).join( "" ) + "\n"; break;
						
					default :
						if( ref[ value ] == undefined ) s += tab + "- " + prop + " : " + className + " = " + _toString( value , tab + "  " , ref );
						else s += tab + "- " + prop + " : " + className + " = { " + ref[ value ] + " }\n";
						break;
				}
			}
			
			if( !hasProp ) return StringUtils.trim( s ) + " }\n";
			
			return s + startTab + "}\n";
		}
	}
}
