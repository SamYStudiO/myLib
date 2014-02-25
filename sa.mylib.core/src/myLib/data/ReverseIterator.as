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
	/**
	 * ReverseIterator loop over a collection starting with last collection item to the first collection item.
	 * 
	 * @author SamYStudiO
	 */
	public class ReverseIterator extends AIterator
	{	
		/**
		 * Build a new ReverseIterator instance.
		 * 
		 * @param collection The ICollection object.
		 */
		public function ReverseIterator( collection : ICollection ) 
		{
			super( collection );
			
			_position = collection.length - 1;
		}

		/**
		 * @inheritDoc
		 */
		public override function hasNext() : Boolean
		{
			return _position >= 0;
		}
		
		/**
		 * @inheritDoc
		 */
		public override function next() : *
		{
			if( _position < 0 ) return null;
			
			return _collection.getItemAt( _position-- );
		}
		
		/**
		 * @inheritDoc
		 */
		public override function reset() : void
		{
			_position = _collection.length - 1;
		}
		
		/**
		 * @inheritDoc
		 */
		public override function getItemPosition( item : * ) : int
		{
			return _collection.length - _collection.getItemIndex( item ) - 1;
		}
	}
}
