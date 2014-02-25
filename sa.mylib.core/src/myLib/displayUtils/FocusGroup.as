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
package myLib.displayUtils 
{
	import myLib.data.CollectionEvent;
	import myLib.data.SimpleCollection;

	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.InteractiveObject;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.utils.Dictionary;
	/**
	 * FocusGroup limits a tab loop to items of the same group.
	 * 
	 * @author SamYStudiO ( contact@samystudio.net )
	 */
	// TODO add a loop property, if true tab loop over this group, if false when last tabIndex is reached next tab try to get next focusgroup with priority (add a priority property so?)
	public class FocusGroup extends SimpleCollection
	{
		/**
		 * @private
		 */
		protected static const __FOCUSABLE_TO_GROUP : Dictionary = new Dictionary( true );
		
		/**
		 * @private
		 */
		protected static const __GROUPS : Dictionary = new Dictionary( true );
		
		/**
		 * @private
		 */
		protected static var __ID : uint;
		
		/**
		 * @private
		 */
		protected var _updating : Boolean;
		
		/**
		 * @private
		 */
		protected var _container : DisplayObjectContainer;
		
		/**
		 * Get the default focus group used all application stage instance.
		 */
		public static var DEFAULT_FOCUS_GROUP : FocusGroup;
		
		/**
		 * @private
		 */
		protected var _showFocusIndicator : Boolean = true;
		
		/**
		 * Get or set a Boolean that indicates if focus indicator is drawn when a focusable recieve focus.
		 */
		public function get showFocusIndicator() : Boolean
		{
			return _showFocusIndicator;
		}
		
		public function set showFocusIndicator( b : Boolean ) : void
		{
			if( _showFocusIndicator == b ) return;
			
			_showFocusIndicator = b;
		}
		
		/**
		 * @private
		 */
		protected var _name : String;
		
		/**
		 * Get group string name.
		 */
		public function get name() : String
		{
			return _name;
		}
		
		/**
		 * Get or set a Boolean that indicates if tab loop is active with this group.
		 * 
		 * @default true
		 */
		public var tabEnabled : Boolean = true;
		
		/**
		 * Get or set a Boolean that indicates if tab loop over this group (true) or try to reach next group when last group item is reached (false).
		 * 
		 * @private
		 * @default false
		 */
		//public var loop : Boolean;
		
		/**
		 * get an Array with all FocusGroup currently active.
		 */
		public static function getGroups(  ) : Array
		{
			var a : Array = new Array();
			
			for each( var group : FocusGroup in __GROUPS ) 
			{
				if( group != null ) a.push( group );
			}
			
			return a;
		}
		
		/**
		 * Retrieve a FocusGroup from its string name.
		 * 
		 * @param name The group name to retrieve.
		 * @return FocusGroup instance from name or null.
		 */
		public static function getGroupsByName( name : String ) : FocusGroup
		{
			for each( var group : FocusGroup in __GROUPS ) 
			{
				if( group != null &&  group.name == name ) return group;
			}
			
			return null;
		}
		
		/**
		 * Retrieve a FocusGroup with a focusable object.
		 * 
		 * @param focusable The interactive within FocusGroup to retrieve.
		 * @return FocusGroup instance from focusable or null.
		 */
		public static function getGroupFromFocusable( focusable : InteractiveObject ) : FocusGroup
		{
			return __FOCUSABLE_TO_GROUP[ focusable ] as FocusGroup;
		}
		
		/**
		 * Build a new FocusGroup instance.
		 * Only InterctiveObject can be added to FocusGroup.
		 * @name A unique string id to help retrieve group.
		 * @container An optional container where all children will be automatically added to this group.
		 */
		public function FocusGroup( name : String = null , container : DisplayObjectContainer = null )
		{
			super( null , InteractiveObject );
			
			__GROUPS[ this ] = this;
			
			_name = name == "" || name == null ? "FocusGroup" + __ID : name;
			
			__ID++;
			
			_container = container;
			
			if( _container != null )
			{
				_addFocusables( _container );
				_container.addEventListener( Event.ADDED , _addedToContainer , false , 0 , true );
				_container.addEventListener( Event.REMOVED , _removedFromContainer , false , 0 , true );
				
				if( _container is Stage ) FocusManager.getInstance().initStage( _container as Stage );
			}
		}
		
		/**
		 *
		 */
		public function tab( backward : Boolean = false ) : void
		{
			FocusManager.getInstance().tabGroup( this , backward );
		}
		
		/**
		 * @inheritDoc
		 */
		public override function addItem( ...items : Array ) : uint
		{
			for each( var item : * in items ) 
			{
				var io : InteractiveObject = item as InteractiveObject;
				
				addItemAt( item , io.tabIndex >= 0 ? io.tabIndex : _data.length );
			}
			
			return _data.length;
		}
		
		/**
		 * @inheritDoc
		 */
		public override function addItemAt( item : * , index : uint ) : uint
		{
			if( item == null ) return _data.length;
			
			if( _ItemClass != null && !( item is _ItemClass ) )
				throw new Error( this + " item does not match " + _ItemClass );
			
			var io : InteractiveObject = item as InteractiveObject;
			
			if( io.tabIndex != index ) io.tabIndex = index;

			if( !contains( item ) ) _addFocusable( io );
			
			return _data.length;
		}
		
		/**
		 * @inheritDoc
		 */
		public override function removeItemAt( index : uint ) : uint
		{
			var item : InteractiveObject = getItemAt(  index ) as InteractiveObject;
			
			if( item != null ) _removeFocusable( item as InteractiveObject );
			
			return _data.length;
		}
		
		/**
		 * @inheritDoc
		 */
		public override function replaceItemAt( item : * , index : uint ) : uint
		{
			if( item == null || contains( item ) || index > _data.length - 1 ) return _data.length;
			
			if( _ItemClass != null && !( item is _ItemClass ) )
				throw new Error( this + " item does not match " + _ItemClass );
			
			var oldItem : InteractiveObject = getItemAt( index ) as InteractiveObject;
			
			removeItemAt( index );
			addItemAt( item , index );

			dispatchEvent( new CollectionEvent( CollectionEvent.REPLACE , index , oldItem ) );
			
			return _data.length;
		}
		
		/**
		 * @inheritDoc
		 */
		public override function sort( ...arguments : Array ) : void
		{
			_data.sort.apply( _data , arguments );
			
			_updateTabIndex( 0 );
			
			dispatchEvent( new CollectionEvent( CollectionEvent.SORT ) );
		}
		
		/**
		 * @inheritDoc
		 */
		public override function sortOn( fieldName : Object , options : Object = null ) : void
		{
			_data.sortOn( fieldName , options );
			
			_updateTabIndex( 0 );
			
			dispatchEvent( new CollectionEvent( CollectionEvent.SORT ) );
		}
		
		/**
		 * Get the next valid tabenabled focusable from specified focusable.
		 * 
		 * @param focusable The focusable object from which search next focusable.
		 * @return The next focusable from specified focusable.
		 */
		public function getNextFrom( focusable : InteractiveObject ) : InteractiveObject
		{
			var index : int = getItemIndex( focusable );
			var next : InteractiveObject;
			
			while( next == null || next.stage == null || next.tabIndex < 0 ) 
			{
				if( index == _data.length - 1 ) index = -1;
				
				next = getItemAt( ++index );
				
				if( next == focusable ) break;
			}
			
			return next as InteractiveObject;
		}
		
		/**
		 * Get the previous valid tabenabled focusable from specified focusable.
		 * 
		 * @param focusable The focusable object from which search previous focusable.
		 * @return The previous focusable from specified focusable.
		 */
		public function getPreviousFrom( focusable : InteractiveObject ) : InteractiveObject
		{
			var index : int = getItemIndex( focusable );
			var previous : InteractiveObject;
			
			while( previous == null || previous.stage == null || previous.tabIndex < 0 ) 
			{
				if( index <= 0 ) index = _data.length;
				
				previous = getItemAt( --index );
				
				if( previous == focusable ) break;
			}
			
			return previous as InteractiveObject;
		}
		
		/**
		 * Return FocusGroup instance string representation.
		 * 
		 * @return FocusGroup instance string representation.
		 */
		public override function toString(  ) : String
		{
			return "[object FocusGroup " + _name + "]";	
		}
		
		/**
		 * @private
		 */
		protected function _addedToContainer( e : Event ) : void
		{
			var item : DisplayObject = e.target as DisplayObject;
			
			// TODO At the moment adding textfield with tabIndex make problem with ColorPicker palette
			// (lose component draw focus since palette TextInput textfield is valid focusable and so cannot retrieve TextInput wright focusable).
			// Anyway does it make sens to force tabIndex since if we want tab with focusable we should manually set tabIndex?
			// maybe try by checking toptarget with FocusManager
			/*if( item is TextField )
			{
				var tf : TextField = item as TextField;
				
				if( tf.tabIndex >= 0 ) addItemAt( tf , tf.tabIndex );
				else addItem( tf );
			}
			else*/ if( item is InteractiveObject ) _addFocusable( item as InteractiveObject );
			
			if( item is DisplayObjectContainer ) _addFocusables( item as DisplayObjectContainer );
		}
		
		/**
		 * @private
		 */
		protected function _removedFromContainer( e : Event ) : void
		{
			var item : DisplayObject = e.target as DisplayObject;
			
			if( item is InteractiveObject ) _removeFocusable( item as InteractiveObject );
			if( item is DisplayObjectContainer ) _removeFocusables( item as DisplayObjectContainer );
		}
		
		/**
		 * @private
		 */
		protected function _addFocusables( o : DisplayObjectContainer ) : void
		{
			var i : int = -1;
			var l : uint = o.numChildren;
			
			while( ++i < l ) 
			{
				try
				{
					var child : DisplayObject = o.getChildAt( i );
					
					// TODO see upper todo
					/*if( child is TextField )
					{
						var tf : TextField = child as TextField;
						
						if( tf.tabIndex >= 0 ) addItemAt( tf , tf.tabIndex );
						else addItem( tf );
					}
					else */if( child is InteractiveObject ) _addFocusable( child as InteractiveObject );
					
					if( child is DisplayObjectContainer ) _addFocusables( child as DisplayObjectContainer );
				}
				catch( e : Error ) { /*security error*/ }
			}
		}
		
		/**
		 * @private
		 */
		protected function _removeFocusables( o : DisplayObjectContainer ) : void
		{
			var i : int = -1;
			var l : uint = o.numChildren;
			
			while( ++i < l ) 
			{
				try
				{
					var child : DisplayObject = o.getChildAt( i );
					
					if( child is InteractiveObject ) _removeFocusable( child as InteractiveObject );
					if( child is DisplayObjectContainer ) _removeFocusables( child as DisplayObjectContainer );
				}
				catch( e : Error ) { /*security error*/ }
			}
		}
		
		/**
		 * @private
		 */
		protected function _addFocusable( item : InteractiveObject ) : void
		{
			// TODO find a better way to avoid default group overwriten user group
			if( __FOCUSABLE_TO_GROUP[ item ] != null && (  __FOCUSABLE_TO_GROUP[ item ] as FocusGroup ).name != "default" && _name == "default" ) return;
			
			if( __FOCUSABLE_TO_GROUP[ item ] != null ) ( __FOCUSABLE_TO_GROUP[ item ] as FocusGroup ).removeItem( item );
			
			__FOCUSABLE_TO_GROUP[ item ] = this;
			
			item.addEventListener( Event.TAB_INDEX_CHANGE , _objectIndexChange , false , 0 , true );
			
			if( _data.indexOf( item ) == -1 )
			{
				if( item.tabIndex > _data.length ) _data[ item.tabIndex ] = item;
				else _data.splice( item.tabIndex , 0 , item );
			}
			
			dispatchEvent( new CollectionEvent( CollectionEvent.ADD , item.tabIndex , item ) );
		}
		
		/**
		 * @private
		 */
		protected function _removeFocusable( item : InteractiveObject ) : void
		{
			delete __FOCUSABLE_TO_GROUP[ item ];
			
			var index : int = _data.indexOf( item );
			
			if( index < 0 ) return;
			
			_data.splice( index , 1 );
			
			item.removeEventListener( Event.TAB_INDEX_CHANGE , _objectIndexChange );
			
			dispatchEvent( new CollectionEvent( CollectionEvent.REMOVE , index , item ) );
		}
		
		/**
		 *
		 */
		private function _updateTabIndex( fromIndex : uint ) : void
		{
			_updating = true;
			
			var i : int = fromIndex - 1;
			var l : uint = _data.length;
			
			while( ++i < l ) 
			{
				var item : InteractiveObject = getItemAt( i ) as InteractiveObject;
				
				if( item != null && item.tabIndex >= 0 )
					item.tabIndex = i;
			}
			
			_updating = false;
		}
		
		/**
		 *
		 */
		private function _objectIndexChange( e : Event ) : void
		{
			if( _updating ) return;
			
			var item : InteractiveObject = e.currentTarget as InteractiveObject;
			var index : int = _data.indexOf( item );
			
			_data.splice( index , 1 );
			
			if( item.tabIndex >= 0 ) _data.splice( item.tabIndex , 0 , item );
			else _data.push( item );
		}
	}
}
