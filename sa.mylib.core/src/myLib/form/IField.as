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
	import flash.events.IEventDispatcher;		
	/**
	 * IField defines all properties and methods necessary with an input field.
	 * All input component (TextInput, TextArea, ComboBox,...) implement IField.
	 * 
	 * @author SamYStudiO ( contact@samystudio.net )
	 */
	public interface IField extends IEventDispatcher
	{
		/**
		 * Get a Boolean that indicates if field is enabled.
		 */
		function get enabled() : Boolean;
		
		/**
		 * Get or set the field tab index.
		 */
		function get tabIndex() : int;
		function set tabIndex( index : int ) : void;
		
		/**
		 * Get or set the field variable name used when field value is send with request.
		 */
		function get variableName() : String;
		function set variableName( name : String ) : void;
		
		/**
		 * Get or set a Boolean that indicates if field is required when used with Form class.
		 * Property is not typed as Boolean so it may be null and use Form.addField required argument instead.
		 */
		function get required() : *;
		function set required( b : * ) : void;
		
		/**
		 * Get or set one or multiple IValidator (using Array with multiple) used to check field with Form class.
		 */
		function get validators() : *;
		function set validators( validators : * ) : void;
		
		/**
		 * Get the field input value.
		 */
		function drawError( b : Boolean ) : void;
		
		/**
		 * Get the field input value.
		 */
		function getValue() : *;
		
		/**
		 * Set the field input value.
		 */
		function setValue( value : * ) : void;
	}
}
