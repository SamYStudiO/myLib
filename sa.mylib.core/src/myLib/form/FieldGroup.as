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
package myLib.form 
{
	import myLib.controls.IButton;
	import myLib.data.Iterator;
	import myLib.data.SimpleCollection;
	import myLib.form.IField;
	import myLib.utils.ClassUtils;	
	/**
	 * FieldGroup lets you create special fields which contains multiple fields ( CheckBox group or date using day/month/year ComboBox for example).
	 * 
	 * @author SamYStudiO ( contact@samystudio.net )
	 */
	public class FieldGroup extends SimpleCollection implements IField 
	{
		/**
		 * Get or set the char that will be used to concat field values.
		 */
		public var dataJoinDelimiter : String;
		
		/**
		 * @inheritDoc
		 */	
		public function get enabled () : Boolean
		{
			var iterator : Iterator = getIterator();
			
			while( iterator.hasNext() )
			{
				if( ( iterator.next( ) as IField ).enabled ) return true;	
			}
			
			return false;
		}
		
		/**
		 * @inheritDoc
		 */
		public function get tabIndex () : int
		{
			var field : IField = getItemAt( 0 ) as IField;
			
			return field != null ? field.tabIndex : -1;
		}
		
		public function set tabIndex ( index : int ) : void
		{
			var iterator : Iterator = getIterator();
			
			while( iterator.hasNext() )
			{
				( iterator.next( ) as IField ).tabIndex  = index + iterator.position - 1;	
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
		 * Build a new FieldGroup instance.
		 * 
		 * @param dataJoinDelimiter The char used to concat field values.
		 * @param fields The field to add in this group.
		 */
		public function FieldGroup ( dataJoinDelimiter : String = "-" , ...fields : Array )
		{
			this.dataJoinDelimiter = dataJoinDelimiter;
			
			super( fields , IField );
		}
		
		/**
		 * @inheritDoc
		 */
		public function drawError( b : Boolean ) : void
		{
			var iterator : Iterator = getIterator();
			
			while( iterator.hasNext() )
			{
				( iterator.next() as IField ).drawError( b );
			}
		}

		/**
		 * @inheritDoc
		 */
		public function getValue(  ) : *
		{
			var iterator : Iterator = getIterator();
			var allEmpty : Boolean = true;
			var a : Array = new Array( );
			
			while( iterator.hasNext() )
			{
				var field : IField = iterator.next() as IField;
				var value : * = field.getValue( );
				var isButton : Boolean = field is IButton;
				
				if( allEmpty ) allEmpty = value === false || value == "" || value == null || ( ClassUtils.hasVariableOrAccessor(  value , "length" ) && value.length == 0 );
				
				if( isButton && ( field as IButton ).selected ) a.push( value );
				else if( !isButton ) a.push( value );
			}
		
			return allEmpty || !a.length ? null : dataJoinDelimiter != null ? a.join( dataJoinDelimiter ) : a;
		}
		
		/**
		 * @inheritDoc
		 */
		public function setValue( value : * ) : void
		{
			var a : Array = value == null ? new Array() : value is Array ? value as Array : value.toString().split( dataJoinDelimiter );
			var iterator : Iterator = getIterator();
			// TODO check this since set defaultvalue with radio/check group seems break (this work fine with ButtonGroup class).
			
			while( iterator.hasNext() )
			{
				var index : int = iterator.position;
				var field : IField = iterator.next() as IField;
				var button : IButton = index < a.length ? _findButtonFromData( a[ index ] ) : null;
				
				if( button != null ) button.selected = true;
				else if( field != null ) field.setValue( a[ index ] );
				
				if ( index >= a.length - 1 ) break;
			}
		}
		
		/**
		 * @private
		 */
		protected function _findButtonFromData( data : * ) : IButton
		{
			var iterator : Iterator = getIterator();
			
			while( iterator.hasNext() )
			{
				var field : IButton = iterator.next() as IButton;
				
				if( field != null && field.data == data && field.data != null ) return field;
			}
			
			return null;
		}
	}
}
