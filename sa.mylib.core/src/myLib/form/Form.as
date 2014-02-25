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
	import myLib.data.CollectionEvent;
	import myLib.data.ICollection;
	import myLib.data.Iterator;
	import myLib.data.SimpleCollection;
	import myLib.displayUtils.FocusGroup;
	import myLib.events.ComponentEvent;
	import myLib.form.validators.IValidator;

	import flash.display.DisplayObjectContainer;
	import flash.display.InteractiveObject;
	import flash.events.FocusEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLVariables;
	import flash.utils.Dictionary;
	/**
	 * Form class make easier validate and send forms.
	 * 
	 * @author SamYStudiO ( contact@samystudio.net )
	 */
	public class Form extends URLLoader
	{
		/**
		 * @private
		 */
		protected var _instances : Dictionary = new Dictionary( true );
		protected var _instancesDefaultValue : Dictionary = new Dictionary( true );
		
		/**
		 * Get or set URLRequest used by default with load and validateAndLoad method.
		 * 
		 * @see #load()
		 * @see #validateAndLoad()
		 */
		public var url : URLRequest;

		/**
		 * Get or set the string used to replace null or undefined values.
		 * Special flag "remove" can be used to specify that a null or undefined values will not be send with form script url.
		 * 
		 * @default remove
		 */
		public var nullReplace : String = "remove";
	
		/**
		 * Get or set the Class type use to cast Boolean values. Valid values are Number to convert true/false to 1/0
		 * or String to convert true/false boolean to true/false string representation.
		 * 
		 * @default Number
		 */
		public var BooleanCasting : Class = Number;
	
		/**
		 * Get or set the char used to concat Array values like multiple selection List for example.
		 */
		public var dataJoinDelimiter : String;
		
		/**
		 * variables property is a reference to The URLVariable object that will be send with this form.
		 * Use it also to add additional variables with field values.
		 */
		public var variables : URLVariables = new URLVariables();
		
		/**
		 * 
		 */
		public var autoRemoveErrorRectOnFocus : Boolean = true;
		
		/**
		 * @private
		 */
		protected var _fields : SimpleCollection = new SimpleCollection( null , FormItem );

		/**
		 * Get an Array of all fields within this Form object.
		 */
		public function get fields () : Array
		{
			var iterator : Iterator = _fields.getIterator();
			var a : Array = new Array();
			
			while( iterator.hasNext() )
			{
				a.push( ( iterator.next( ) as FormItem ).field );
			}
			
			return a;
		}
		
		/**
		 * @private
		 */
		protected var _focusGroup : FocusGroup;
		
		/**
		 * Get the FocusGroup reference used for focus management with this Form object.
		 * 
		 * @see myLib.displayUtils.FocusGroup
		 */
		public function get focusGroup() : FocusGroup
		{
			return _focusGroup;
		}

		/**
		 *  Build a new Form instance.
		 *  @param URLRequest used by default with load and validateAndLoad method. If no url is passed optional request with load and validateAndLoad will be required.
		 *  @param nullReplace The string used to replace null or undefined values. Use "remove" flag to specify that null or undefined valures are ignored.
		 *  @param BooleanCasting Number or String Class type used to cast Boolean values.
		 *  @param arrayJoinDelimiter The char used to concat Array values.
		 */
		public function Form ( url : URLRequest = null , container : DisplayObjectContainer = null , nullReplace : String = "remove" , BooleanCasting : Class = null , arrayJoinDelimiter : String = "-" )
		{
			this.nullReplace = nullReplace;
			this.BooleanCasting = BooleanCasting || Number;
			this.dataJoinDelimiter = arrayJoinDelimiter;
			this.url = url;
			
			_focusGroup = new FocusGroup( "" , container );
			
			if( container != null )
			{
				_focusGroup.addEventListener( CollectionEvent.ADD , _addedToGroup , false , 0 , true );				_focusGroup.addEventListener( CollectionEvent.REMOVE , _removedFromGroup , false , 0 , true );
				
				var it : Iterator = _focusGroup.getIterator();
				
				while( it.hasNext() ) 
				{
					var field : IField = it.next() as IField;
					
					if( field != null ) addField( field );
				}
			}
		}
	
		/**
		 * Add a field with this Form object.
		 * @param field The IField object to add. Optionaly you can overwrite or set field Form properties with next arguments.
		 * @param variableName The name of the variable used with the field value when form is send to its script URL.
		 * @param required A Boolean value that indicates if field is required and must be filled.
		 * @param validators A IValidator or Array of IValidator used to validate the input field.
		 * @param defaultValue The field default value that will be used if a Form.reset occured.
		 * 
		 * @see IField
		 */
		public function addField ( field : IField , variableName : String = null , required : Boolean = false ,
									validators : * = null , defaultValue : * = null , defaultValueIsValid : Boolean = true ) : void
		{
			addFieldAt( field , _fields.length , variableName , required , validators , defaultValue , defaultValueIsValid );
		}
	
		/**
		 * Add a field at the specified tabIndex with this Form object.
		 * @param field The IField object to add.		 * @param index The IField object index in the tab loop.
		 * @param variableName The name of the variable used with the field value when form is send to its script URL.
		 * @param required A Boolean value that indicates if field is required and must be filled.
		 * @param validators A IValidator or Array of IValidator used to validate the input field.
		 * @param defaultValue The field default value that will be used if a Form.reset occured.
		 * 
		 * @see IField
		 */
		public function addFieldAt ( field : IField , index : uint , variableName : String = null , required : Boolean = false ,
									validators : * = null , defaultValue : * = null , defaultValueIsValid : Boolean = true ) : void
		{
			if( _instances[ field ] ) return;
			
			field.variableName = field.variableName || variableName;			field.required = field.required || required;			field.validators = field.validators || validators;
			
			_fields.addItemAt( new FormItem( field , defaultValue , defaultValueIsValid ) , index );
			
			var previousField : IField = index == 0 ? null : ( _fields.getItemAt( index - 1 ) as FormItem ).field;
			
			var tabIndex : uint = 0;
			
			if( previousField != null )
			{
				if( previousField is ICollection )
				{
					var group : ICollection = previousField as ICollection;
					
					tabIndex = ( group.getItemAt( group.length - 1 ) as InteractiveObject ).tabIndex + 1;
				}
				else tabIndex = previousField.tabIndex + 1;
			}
			
			if( field is ICollection )
			{
				var g : ICollection = field as ICollection;
				var it : Iterator = g.getIterator();
				
				while( it.hasNext() ) 
				{
					var i : uint = tabIndex + it.position;
					var item : InteractiveObject = it.next() as InteractiveObject;
					
					_instances[ item ] = true;
					_focusGroup.addItemAt( item , i );
					item.addEventListener( ComponentEvent.ENTER , _send , false , 0 , true );
					item.addEventListener( FocusEvent.FOCUS_IN , _focusIn , false , 0 , true );
				}
			}
			else
			{
				_instances[ field ] = true;
				_focusGroup.addItemAt( field as InteractiveObject , tabIndex );
				field.addEventListener( ComponentEvent.ENTER , _send , false , 0 , true );
				field.addEventListener( FocusEvent.FOCUS_IN , _focusIn , false , 0 , true );
			}
		}

		/**
		 * Remove a field in this Form object.
		 * @param field The field to remove.
		 * @throws A Error if specified field cannot be found.
		 */
		public function removeField ( field : IField ) : void
		{
			if( _instances[ field ] == undefined ) return;
			
			_fields.removeItemAt( _getFieldIndex( field ) );
			
			if( field is FieldGroup )
			{
				var g : FieldGroup = field as FieldGroup;
				var iterator : Iterator = g.getIterator();
				
				while( iterator.hasNext() ) 
				{
					var item : InteractiveObject = iterator.next() as InteractiveObject;
					
					delete _instances[ item ];
					_focusGroup.removeItem( item );

					item.removeEventListener( ComponentEvent.ENTER , _send );
					item.removeEventListener( FocusEvent.FOCUS_IN , _focusIn );
				}	
			}
			else
			{
				delete _instances[ field ];
				_focusGroup.removeItem( field as InteractiveObject );
			}
		}
	
		/**
		 * Remove all fields with this Form object.
		 */
		public function removeFields () : void
		{
			_fields = new SimpleCollection( );
			_focusGroup.clear( );
			_instances = new Dictionary( true );
		}

		/**
		 * Send all Form variables to the specified script URL without checking fields.
		 * @param request The URLRequest object used for send operation.
		 */
		public override function load ( request : URLRequest ) : void
		{
			mergeFields();
			
			request = request != null ? request : url;
			
			if( request == null ) return;
			
			request.data = variables;
			
			super.load( request );
		}
		
		/**
		 * Send all Form variables to the specified script URL.
		 * Before sending operation all Form fields are checked, if validation failed the send operation is abort.
		 * @param request The URLRequest object used for send operation.
		 * @param returnErrors A Boolean that indicates if the return value is a Boolean or an Array of FieldError.
		 * @return A Boolean or an Array of FieldError depending of returnErrors argument that indicates if send operation is successful.
		 */
		public function validateAndLoad ( request : URLRequest = null , returnErrors : Boolean = true ) : *
		{
			var errors : Array = isValid();
			
			if( !errors.length ) load( request );
			
			return returnErrors ? errors : errors.length == 0;	
		}
		
		/**
		 * Check if the specified field is valid.
		 * @param field The field to check.
		 * @param returnError A Boolean that indicates if the return value is a Boolean or a FieldError object.
		 * @return A Boolean or a FieldError depending of returnError argument that indicates if field is valid.
		 */
		public function isFieldValid ( field : IField , returnError : Boolean = true ) : *
		{
			if( field == null ) return false;
			
			var index : int = _getFieldIndex( field );
			
			if( index < 0 ) return false;
			
			var item : FormItem = _fields.getItemAt( index );
			var value : * = field.getValue( );
			var empty : Boolean = !value;

			if( ( empty && field.required ) || ( !empty && !item.defaultValueIsValid && value == item.defaultValue ) )
			{
				return returnError ? new FieldError( field , FieldErrorCode.EMPTY ) : false;
			}
			else if( !empty )
			{
				var codes : uint = 0;
				var messages : Array = new Array();
				var validators : Array = field.validators is IValidator ? [ field.validators ] : field.validators == null ? new Array() : field.validators;
				var validatorsLength : uint = validators.length;
				
				for( var j : uint = 0; j < validatorsLength; j++ )
				{
					var validator : IValidator = validators[ j ] as IValidator;
					var b : Boolean = validator != null ? validator.isValid( value ) : true;
					
					if( !b && validator != null )
					{
						codes = ( codes | validator.errorCode );
						messages.push( validator.errorMessage );
					}
				}
				
				if( codes != 0 ) return returnError ? new FieldError( field , codes , messages ) : false;
			}
			
			return returnError ? null : true;
		}
	
		/**
		 * Check if Form is valid.
		 * @param returnErrors A Boolean that indicates if the return value is a Boolean or an Array of FieldError.
		 * @return A Boolean or an Array of FieldError depending of returnErrors argument that indicates if Form is valid.
		 */
		public function isValid ( returnErrors : Boolean = true ) : *
		{
			var iterator : Iterator = _fields.getIterator();
			var errors : Array = new Array();
			
			while( iterator.hasNext() )
			{
				var field : IField = ( iterator.next() as FormItem ) .field;
				
				if( !field.enabled ) continue;
				
				var error : FieldError = isFieldValid( field );
				
				if( error != null ) errors.push( error );
			}
			
			return returnErrors ? errors : errors.length == 0;
		}
		
		/**
		 * 
		 * @param 
		 * @return 
		 */
		public function drawErrors ( returnErrors : Boolean = true ) : *
		{
			var errors : Array = isValid();
			var l : uint = errors.length;
			
			for ( var i : int = 0; i < l; i++ )
			{
				var field : FieldError = errors[ i ] as FieldError;
				
				field.field.drawError( true );
			}
			
			return returnErrors ? errors : errors.length == 0;
		}
		
		/**
		 * 
		 * @param 
		 * @return 
		 */
		public function cleanErrors (  ) : void
		{
			var iterator : Iterator = _fields.getIterator();
			
			while( iterator.hasNext() )
			{
				var field : IField = ( iterator.next() as FormItem ).field;
				
				field.drawError( false );
			}
		}
	
		/**
		 * Reset all fiels to theirs default value specified when they were added to Form.
		 */
		public function resetFields () : void
		{
			var iterator : Iterator = _fields.getIterator();
			
			while( iterator.hasNext() )
			{
				var item : FormItem = iterator.next() as FormItem;
				var field : IField = item.field;
				
				if( field != null ) field.setValue( item.defaultValue );
			}
		}
	
		/**
		 * Concat all fields values to the variables properties that will be send with script URL.
		 * 
		 * This operation is done automatically when validateAndLoad or load is called.
		 */
		public function mergeFields ( ) : void
		{
			var iterator : Iterator = _fields.getIterator();
			
			while( iterator.hasNext() ) 
			{
				var field : IField = ( iterator.next() as FormItem ).field;
				
				if( !field.enabled ) continue;
				
				var variableName : String = field.variableName;
				
				if( variableName == null || variableName == "" ) continue;
				
				var value : * = field.getValue( );
				
				if( nullReplace == "remove" && ( value == null || value == undefined ) ) continue;
				
				variables[ variableName ] = _castValue( value );
			}
		}
		
		/**
		 * @private
		 */
		protected function _addedToGroup( e : CollectionEvent ) : void
		{
			var field : IField = e.item as IField;
					
			if( field != null && _getFieldIndex( field ) >= 0 ) addField( field );
		}
		
		/**
		 * @private
		 */
		protected function _removedFromGroup( e : CollectionEvent ) : void
		{
			var field : IField = e.item as IField;
					
			if( field != null && _getFieldIndex( field ) >= 0  ) removeField( field );
		}
		
		/**
		 * @private
		 */
		protected function _getFieldIndex( field : IField ) : int
		{
			var iterator : Iterator = _fields.getIterator();
			
			while( iterator.hasNext() ) 
			{
				var f : IField = ( iterator.next() as FormItem ).field;
				
				if( f == field ) return iterator.position - 1;
			}
			
			return -1;
		}
	
		/**
		 * @private
		 */
		protected function _castValue ( value : * ) : *
		{
			var isBoolean : Boolean = value is Boolean;
			var isArray : Boolean = value is Array;
			
			if( isArray && ( nullReplace != null || BooleanCasting != null ) )
			{
				var a : Array = value as Array;
				var i : int = -1;
				var l : uint = a.length;
	
				while( ++i < l ) 
				{
					var indexIsBoolean : Boolean = a[ i ] is Boolean;
					
					a[ i ] = nullReplace != null && ( a[ i ] == null || a[ i ] == undefined ) ? nullReplace : a[ i ];
					a[ i ] = BooleanCasting != null && indexIsBoolean ? BooleanCasting( a[ i ] ) : a[ i ];
				}	
			}
			else if( !isArray )
			{
				value = BooleanCasting != null && isBoolean ? BooleanCasting( value ) : value;
			}
					
			value = dataJoinDelimiter != null && isArray ? ( value as Array ).join( dataJoinDelimiter ) : value;
			
			return value;
		}
		
		/**
		 * @private
		 */
		protected function _send( e : ComponentEvent ) : void
		{
			if( url != null ) validateAndLoad( url , false );
		}
		
		/**
		 * @private
		 */
		protected function _focusIn( e : FocusEvent ) : void
		{
			if( !autoRemoveErrorRectOnFocus ) return;
			
			var focused : IField = e.currentTarget as IField;
			var iterator : Iterator = _fields.getIterator();
			
			while( iterator.hasNext() ) 
			{
				var field : IField = ( iterator.next() as FormItem ).field;
				
				if( !field.enabled ) continue;

				var g : FieldGroup = field as FieldGroup;
				
				if( g != null )
				{
					var it : Iterator = g.getIterator();
					
					while( it.hasNext() ) 
					{
						if( ( it.next() as IField ) == focused )
						{
							g.drawError( false );
							return;
						}
					}
				}
				else
				{
					focused.drawError( false );
				}
			}
		}
	}
}