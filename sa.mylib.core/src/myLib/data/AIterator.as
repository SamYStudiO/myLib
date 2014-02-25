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
	import myLib.data.Iterator;
	
	import flash.utils.getQualifiedClassName;	
	/**
	 * AIterator is an abstract implementation of Iterator.
	 * You should inherit this class to make your own iterator.
	 * 
	 * @author SamYStudiO
	 */
	public class AIterator implements Iterator 
	{
		/**
		 * @private
		 */
		protected var _collection : ICollection;
		
		/**
		 * @private
		 */
		protected var _position : int = 0;
		
		/**
		 * @inheritDoc
		 */
		public function get position() : int
		{
			return _position;
		}
		
		public function set position( n : int ) : void
		{
			_position = n;
		}
		
		/**
		 * @private
		 */
		public function AIterator( collection : ICollection ) 
		{
			if( getQualifiedClassName( this ) == "myLib.data::AIterator" )
				throw new Error( this + " Abstract class cannot be instantiated" );
				
			_collection = collection;
		}
		
		/**
		 * @inheritDoc
		 */
		public function hasNext() : Boolean
		{
			return false;
		}
		
		/**
		 * @inheritDoc
		 */
		public function next() : *
		{
			return null;
		}
		
		/**
		 * @inheritDoc
		 */
		public function reset() : void
		{
			_position = 0;
		}
		
		/**
		 * @inheritDoc
		 */
		public function getItemPosition( item : * ) : int
		{
			return _collection.getItemIndex( item );
		}
	}
}
