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
	import flash.events.IEventDispatcher;				
	/**
	 * ICollection defines all properties and methods with used by a collection object.
	 * A collection is a list of object, generally of the same type.
	 * 
	 * @author SamYStudiO
	 */
	public interface ICollection extends IEventDispatcher
	{
		/**
		 * Get collection length.
		 */
		function get length( ) : uint;
		
		/**
		 * Get collection data as an Array object.
		 */
		function get data( ) : Array;
		
		/**
		 * Remove all items within the collection.
		 */
		function clear(  ) : uint;
		
		/**
		 * Get a Boolean that indicates if current collection is empty.
		 */
		function isEmpty( ) : Boolean;
		
		/**
		 * Test if the specified item is within current collection.
		 * 
		 * @param item The item to search within the collection.
		 * @return A Boollean that indicates if item is within the collection.
		 */
		function contains( item : * ) : Boolean;
		
		/**
		 * Get the item at the specified index.
		 * @param index The index from which retrieve the item.
		 * @return The item at the specified index.
		 */
		function getItemAt( index  : uint ) : *;
		
		/**
		 * Get items at the specified indices.
		 * @param indices The indices from which retrieve items.
		 * @return An Array of all items found at the specified indices.
		 */
		function getItemsAt( ...indices  : Array ) : Array;
		
		/**
		 * Add items to the collection.
		 * @param items The items to add.
		 * @return The new collection length.
		 */
		function addItem( ...items : Array ) : uint;
		
		/**
		 * Add a item to the collection at the specified index.
		 * @param items The item to add.		 * @param index The index where item is added.
		 * @return The new collection length.
		 */
		function addItemAt( item : * , index : uint ) : uint;
		
		/**
		 * Remove the specified items within the collection.
		 * @param items The items to remove.
		 * @return The new collection length.
		 */
		function removeItem( ...items : Array ) : uint;
		
		/**
		 * Remove the item at the specified index.
		 * @param index The index where remove item.
		 * @return The new collection length.
		 */
		function removeItemAt( index : uint ) : uint;
		
		/**
		 * Replace the item at the specified index.
		 * @param index The index where item is replaced.
		 * @return The new collection length.
		 */
		function replaceItemAt( item : * , index : uint ) : uint;
		
		/**
		 * Get the specfied item index within the collection.
		 * @param item The item from which retrieve index.
		 * @return The item index or -1 if item is not found within the collection.
		 */
		function getItemIndex( item : * ) : int;
		
		/**
		 * Get the specfied items indices within the collection.
		 * @param onlyValidItem A Boolean value that indicate if not found items are ignore.		 * @param item The items from which retrieve indices.
		 * @return An Array of indices.
		 */
		function getItemsIndex( onlyValidItem : Boolean , ...items : Array ) : Array;
		
		/**
		 * Try to retrieve an item from collection with the specified property and its value.
		 * @param property The item property to search.
		 * @param value The property value.
		 * @return The item with the specified property and value or null if not found.
		 */
		function getItemFrom( property : String , value : * ) : *;
		
		/**
		 * Try to retrieve items from collection with the specified property and the specified values.
		 * @param property The items property to search.
		 * @param values The property values.
		 * @return An Array of all items with the specified property and values.
		 */
		function getItemsFrom( property : String , ...values : Array ) : Array;
		
		/**
		 * Sort collection in the same manner Array does. ( See Array documentation )
		 */
		function sort( ...arguments : Array ) : void;
		
		/**
		 * SortOn collection in the same manner Array does. ( See Array documentation )
		 */
		function sortOn( fieldName : Object, options : Object = null ) : void;
		
		/**
		 * Get an Iterator object for a loop iteration with this collection.
		 */
		function getIterator( ) : Iterator;
	}
}
