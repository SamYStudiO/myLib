﻿/*
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
	 * SimleIterator loop over a collection from its first item to the last item.
	 * 
	 * @author SamYStudiO
	 */
	public class SimpleIterator extends AIterator
	{
		/**
		 * Build a new SimpleIterator instance.
		 * 
		 * @param collection The ICollection object.
		 */
		public function SimpleIterator( collection : ICollection ) 
		{
			super( collection );
		}
		
		/**
		 * @inheritDoc
		 */
		public override function hasNext() : Boolean
		{
			return _position < _collection.length;
		}
		
		/**
		 * @inheritDoc
		 */
		public override function next() : *
		{
			if( _position > _collection.length - 1 ) return null;
			
			return _collection.getItemAt( _position++ );
		}
	}
}