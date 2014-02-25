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
	import myLib.data.ICollection;	import myLib.utils.NumberUtils;	import myLib.utils.ObjectUtils;		import flash.events.EventDispatcher;	
	/**
	 * Dispatched when an item is added to collection.
	 * 
	 * @eventType myLib.data.CollectionEvent.ADD
     */
    [Event(name="add", type="myLib.data.CollectionEvent")]
    
    /**
	 * Dispatched when an item is removed from collection.
	 * 
	 * @eventType myLib.data.CollectionEvent.REMOVE
     */
    [Event(name="remove", type="myLib.data.CollectionEvent")]
    
    /**
	 * Dispatched when an item is replaced in collection.
	 * 
	 * @eventType myLib.data.CollectionEvent.REPLACE
     */
    [Event(name="replace", type="myLib.data.CollectionEvent")]
    
    /**
	 * Dispatched when collection is sorted.
	 * 
	 * @eventType myLib.data.CollectionEvent.SORT
     */
    [Event(name="sort", type="myLib.data.CollectionEvent")]
    
    /**
	 * Dispatched when collection is cleared.
	 * 
	 * @eventType myLib.data.CollectionEvent.CLEAR
     */
    [Event(name="clear", type="myLib.data.CollectionEvent")]
    
	/**
	 * SimpleCollection make easier manipulate Array and typed Array.
	 * SimpleCollection should be used as a base class for custom collection.
	 * 
	 * @author SamYStudiO
	 */
	public class SimpleCollection extends EventDispatcher implements ICollection 
	{
		/**
		 * @private
		 */
		protected var _data : Array = new Array();
		
		/**
		 * @private
		 */
		protected var _ItemClass : Class;
		
		/**
		 * @inheritDoc
		 */
		public function get data() : Array
		{
			return _data.concat();
		}
		
		/**
		 * @inheritDoc
		 */
		public function get length() : uint
		{
			return _data.length;
		}
		
		/**
		 * @inheritDoc
		 */
		public function isEmpty() : Boolean
		{
			return _data.length == 0;
		}
		
		/**
		 * Build a new SimpleCollection instance.
		 * @param source The source Array.
		 * @param ItemClass The class type for all items in the collection.
		 * @throws An Error if ItemClass arguments is defined and an item in source does not match ItemClass.
		 */
		public function SimpleCollection( source : Array = null , ItemClass : Class = null )
		{
			if( ItemClass != null )
			{
				for each( var item : * in source ) 
				{
					if( !( item is ItemClass ) ) throw new Error( this + " invalid source, a item does not match " + ItemClass );
				}	
			}
			
			_data = source || new Array();
			_ItemClass = ItemClass;
		}
		
		/**
		 * @inheritDoc
		 */
		public function clear(  ) : uint
		{
			_data = new Array();
			
			dispatchEvent( new CollectionEvent( CollectionEvent.CLEAR ) );
			
			return 0;
		}
		
		/**
		 * @inheritDoc
		 */
		public function contains( item : * ) : Boolean
		{
			return _data.indexOf( item ) >=0 ;
		}
		
		/**
		 * @inheritDoc
		 */
		public function getItemAt( index : uint ) : *
		{
			return _data[ index ];
		}
		
		/**
		 * @inheritDoc
		 */
		public function getItemsAt( ...indices : Array ) : Array
		{
			var a : Array = new Array();
			
			var l : uint = indices.length;
			
			for( var i : uint = 0; i < l; i++ ) 
			{
				NumberUtils.clamp( Number( indices[ i ] ) , 0 , _data.length - 1 , true );
				
				a.push( _data[ indices[ i ] ] );
			}
			
			return a;
		}
		
		/**
		 * @inheritDoc
		 */
		public function addItem( ...items : Array ) : uint
		{
			for each( var item : * in items ) 
			{
				addItemAt( item , _data.length );
			}
			
			return _data.length;
		}
		
		/**
		 * @inheritDoc
		 */
		public function addItemAt( item : * , index : uint ) : uint
		{
			NumberUtils.clamp( index , 0 , _data.length , true );
			
			if( _ItemClass != null && !( item is _ItemClass ) )
				throw new Error( this + " item does not match " + _ItemClass );
			
			_data.splice( index , 0 , item );
			
			dispatchEvent( new CollectionEvent( CollectionEvent.ADD , index , item ) );
			
			return _data.length;
		}
		
		/**
		 * @inheritDoc
		 */
		public function removeItem( ...items : Array ) : uint
		{
			for each( var item : * in items ) 
			{
				var index : int = getItemIndex( item );
				
				if( index >= 0 ) removeItemAt( index );
			}
			
			return _data.length;
		}
		
		/**
		 * @inheritDoc
		 */
		public function removeItemAt( index : uint ) : uint
		{
			NumberUtils.clamp( index , 0 , _data.length - 1 , true );
			
			var item : * = _data.splice( index , 1 )[ 0 ];
			
			if( item != null )
				dispatchEvent( new CollectionEvent( CollectionEvent.REMOVE , index , item ) );
			
			return _data.length;
		}
		
		/**
		 * @inheritDoc
		 */
		public function replaceItemAt( item : * , index : uint ) : uint
		{
			NumberUtils.clamp( index , 0 , _data.length - 1 , true );
			
			if( _ItemClass != null && !( item is _ItemClass ) )
				throw new Error( this + " item does not match " + _ItemClass );
				
			var oldItem : * = getItemAt( index );
			
			if( oldItem != null )
			{
				_data[ index ] = item;
				
				dispatchEvent( new CollectionEvent( CollectionEvent.REPLACE , index , oldItem ) );
			}
			
			return _data.length;
		}
		
		/**
		 * @inheritDoc
		 */
		public function getItemIndex( item : * ) : int
		{
			return _data.indexOf( item );
		}
		
		/**
		 * @inheritDoc
		 */
		public function getItemsIndex( onlyValidItem : Boolean , ...items : Array ) : Array
		{
			var a : Array = new Array();
			
			for each( var item : * in items ) 
			{
				var index : int = _data.indexOf( item );
				
				if( !onlyValidItem || ( onlyValidItem && index >= 0 ) )
					a.push( _data.indexOf( item ) );
			}
			
			return a;
		}
		
		/**
		 * @inheritDoc
		 */
		public function getItemFrom( property : String , value : * ) : *
		{
			var i : int = -1;
			var l : uint = _data.length;
			
			while( ++i < l ) 
			{
				var item : * = _data[ i ];
				
				if( ObjectUtils.hasProperty( item , property ) && item[ property ] == value )
					return item; 
			}
			
			return null;
		}
		
		/**
		 * @inheritDoc
		 */
		public function getItemsFrom( property : String , ...values : Array ) : Array
		{
			var a : Array = new Array();
			var l : uint = values.length;
			
			for( var i : uint = 0; i < l; i++ ) 
			{
				var item : * = getItemFrom( property , values[ i ] );
				
				if( item != null  ) a.push( item );
			}
			
			return a;
		}
		
		/**
		 * @inheritDoc
		 */
		public function sort( ...arguments : Array ) : void
		{
			_data.sort.apply( _data , arguments );
			
			dispatchEvent( new CollectionEvent( CollectionEvent.SORT ) );
		}

		/**
		 * @inheritDoc
		 */
		public function sortOn( fieldName : Object , options : Object = null ) : void
		{
			_data.sortOn( fieldName , options );
			
			dispatchEvent( new CollectionEvent( CollectionEvent.SORT ) );
		}
		
		/**
		 * @inheritDoc
		 */
		public function getIterator(  ) : Iterator
		{
			return new SimpleIterator( this );
		}
	}
}
