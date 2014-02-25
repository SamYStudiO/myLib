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
package myLib.controls 
{
	import myLib.data.Iterator;
	import myLib.data.SimpleCollection;
	import myLib.events.ButtonEvent;
	import myLib.form.IField;
	import myLib.utils.NumberUtils;

	import flash.events.Event;
	import flash.utils.Dictionary;
	
	/**
	 * Defines the value of the type property of a change event object.
	 * 
	 * @eventType change
	 */
    [Event(name="change", type="flash.events.Event")]
    
	/**
	 * ButtonGroup handles severals Button instance where only one Button can be selected.
	 * 
	 * @see ButtonGroupManager
	 * @author SamYStudiO ( contact@samystudio.net )
	 */
	public final class ButtonGroup extends SimpleCollection implements IField
	{
		/**
		 *
		 */
		private static var __instanceToGroup : Dictionary = new Dictionary( true );
		
		/**
		 *
		 */
		private static var __groups : Dictionary = new Dictionary( true );

		/**
		 *
		 */
		private var _name : String;
		
		/**
		 * Get group name.
		 */
		public function get name() : String
		{
			return _name;
		}
		
		/**
		 *
		 */
		private var _selected : IButton;
		
		/**
		 * Get or set the selected Button in this group.
		 */
		public function get selected() : IButton
		{
			return _selected;
		}
		
		public function set selected( button : IButton ) : void
		{
			if( contains( button ) ) button.selected = true;
		}
		
		/**
		 * @inheritDoc
		 */	
		public function get enabled () : Boolean
		{
			var iterator : Iterator = getIterator();
			
			while( iterator.hasNext() )
			{
				if( ( iterator.next( ) as IButton ).enabled ) return true;	
			}
			
			return false;
		}
		
		/**
		 * @inheritDoc
		 */
		public function get tabIndex () : int
		{
			var field : IButton = getItemAt( 0 ) as IButton;
			
			return field != null ? field.tabIndex : -1;
		}
		
		public function set tabIndex ( index : int ) : void
		{
			var iterator : Iterator = getIterator();
			
			while( iterator.hasNext() )
			{
				( iterator.next( ) as IButton ).tabIndex  = index + iterator.position - 1;	
			}
		}
		
		/**
		 * @private
		 */
		protected var _variableName : String;
		
		/**
		 * @inheritDoc
		 */
		public function get variableName() : String
		{
			return _variableName;
		}
		
		public function set variableName( name : String ) : void
		{
			_variableName = name;
		}
		
		/**
		 * @private
		 */
		protected var _required : *;
		
		/**
		 * @inheritDoc
		 */
		public function get required() : *
		{
			return _required;
		}
		
		public function set required( b : * ) : void
		{
			_required = b != null ? Boolean( b ) : null;
		}
		
		/**
		 * @private
		 */
		protected var _validators : *;
		
		/**
		 * @inheritDoc
		 */
		public function get validators() : *
		{
			return _validators;
		}
		
		public function set validators( validators : * ) : void
		{
			_validators = validators;
		}
		
		/**
		 * Build a new ButtonGroup instance.
		 * @param name group name.
		 * @param buttons The list of Button to add to this group.
		 */
		public function ButtonGroup( name : String , ...buttons : Array )
		{
			super( buttons , IButton );
			
			if( name == "" || name == null ) throw new Error( this + " group name cannot be null or empty" );
			
			if( getGroup( name ) != null ) throw new Error( this + " group " + name + " already exist" );
			
			_name = name;
			
			__groups[ name ] = this;
		}

		/**
		 * @inheritDoc
		 */
		public override function addItemAt( item : * , index : uint ) : uint
		{
			var button : IButton = item as IButton;
			
			if( button == null ) throw new Error( this + " item does not match " + _ItemClass );
			
			var buttonGroup : ButtonGroup = button.getGroup();
			
			if( buttonGroup != null )
			{
				var l : uint = _data.length;
				
				if( button.getGroup().removeItem( button ) != l ) index--;
			}
			
			__instanceToGroup[ button ] = this;
			
			if( button.selected )
			{
				if( _selected != null )
					_selected.selected = false;	
				
				_selected = button;
			}
			
			super.addItemAt( button , index ); 
			
			button.addEventListener( ButtonEvent.TOGGLE , _buttonToggle , false , 0 , true );
		
			return _data.length;
		}

		/**
		 * @inheritDoc
		 */
		public override function removeItemAt( index : uint ) : uint
		{
			NumberUtils.clamp( index , 0 , _data.length - 1 , true );
			
			var button : IButton = getItemAt( index ) as IButton;
			
			if( contains( button ) )
			{
				button.removeEventListener( ButtonEvent.TOGGLE , _buttonToggle );
				
				if( _selected == button ) _selected = null;
				
				delete __instanceToGroup[ button ];
				
				super.removeItemAt( index );
				
				if( isEmpty() ) delete __groups[ _name ];
			}
			
			return _data.length;
		}
		
		/**
		 * Replace the item at the specified index. Replacement in ButtonGroup is equivalent to a remove and a add action.
		 * @param index The index where item is replaced.
		 * @return The new collection length.
		 */
		public override function replaceItemAt( item : * , index : uint ) : uint
		{
			removeItemAt( index );
			
			return addItemAt( item , index );
		}
		
		/**
		 * @inheritDoc
		 */
		public function drawError( b : Boolean ) : void
		{
			var iterator : Iterator = getIterator();
			
			while( iterator.hasNext() ) 
			{
				var field : IField = iterator.next() as IField;
				
				if( field != null ) field.drawError( b );
			}
		}
		
		/**
		 * @inheritDoc
		 */
		public function getValue(  ) : *
		{
			return _selected != null ? _selected.data : null;
		}
		
		/**
		 * @inheritDoc
		 */
		public function setValue( value : * ) : void
		{
			var button : IButton = _findButtonFromData( value );
			
			if( button != null ) button.selected = true;	
			else if( _selected != null ) _selected.selected = false;
		}
		
		/**
		 * Get the ButtonGroup which this button belong. Return null if button belong to none group.
		 * @param button The button from whicj retrieve group.
		 * @return The ButtonGroup instance from which button belong or null.
		 */
		public static function getButtonGroup( button : IButton ) : ButtonGroup
		{
			return __instanceToGroup[ button ] as ButtonGroup;
		}
		
		/**
		 * Get a ButtonGroup instance using group name.
		 * @param name The group name to get.
		 * @param create A Boolean that indicates if group must be created if group name is not defined.
		 * @return The ButtonGroup with the specified name.
		 */
		public static function getGroup( name : String , create : Boolean = false ) : ButtonGroup
		{
			var group : ButtonGroup = __groups[ name ] as ButtonGroup;
			
			return group == null && name != null && name != "" && create ? new ButtonGroup( name ) : group;
		}
		
		/**
		 *
		 */
		private function _buttonToggle ( e : ButtonEvent ) : void
		{
			var button : IButton = e.target as Button;
			
			if( _selected != null && _selected != button && button.selected ) _selected.selected = false;
			
			_selected = button.selected ? button : null;
		
			dispatchEvent( new Event( Event.CHANGE ) );
		}
		
		/**
		 *
		 */
		private function _findButtonFromData( data : * ) : IButton
		{
			var iterator : Iterator = getIterator();
			
			while( iterator.hasNext() ) 
			{
				var button : IButton = iterator.next() as IButton;
				
				if( button != null && button.data == data && button.data != null ) return button;
			}
			
			return null;
		}
	}
}
