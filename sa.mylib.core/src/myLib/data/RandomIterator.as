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
	import myLib.data.ICollection;
	import myLib.data.SimpleIterator;
	import myLib.utils.ArrayUtils;	
	/**
	 * RandomIterator allow random iteration over a collection.
	 * 
	 * @author SamYStudiO ( contact@samystudio.net )
	 */
	public class RandomIterator extends SimpleIterator
	{
		/**
		 * @private
		 */
		protected var _indicesArray : Array = new Array();
		
		/**
		 * Build a new RandomIteration instance.
		 * 
		 * @param collection The ICollection object.
		 */
		public function RandomIterator( collection : ICollection )
		{
			super( collection );
			
			var l : uint = collection.length;
			
			for( var i : uint = 0; i < l; i++ ) 
			{
				_indicesArray.push( i );
			}
			
			reset();
		}
		
		/**
		 * @inheritDoc
		 */
		public override function next () : *
		{
			if( _position > _collection.length - 1 ) return null;
			
			var o : * = _collection.getItemAt( _indicesArray[ _position ] );
			
			_position++;
			
			return o;
		}
		
		/**
		 * @inheritDoc
		 */
		public override function reset () : void
		{
			ArrayUtils.shuffle( _indicesArray );
			
			super.reset();
		}
		
		/**
		 * @inheritDoc
		 */
		public override function getItemPosition( item : * ) : int
		{
			return _indicesArray.indexOf( item );
		}
	}
}
