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
package myLib.form.validators 
{
	/**
	 * IValidator defines all properties and methods for a validator Object.
	 * 
	 * @author SamYStudiO
	 */
	public interface IValidator 
	{
		/**
		 * Get or set the source to validate.
		 */
		function get source( ) : *;
		function set source( source : * ) : void;
		
		/**
		 * Get the error code associated with this validator.
		 */
		function get errorCode( ) : uint;
		
		/**
		 * Get or set the error message associated with this validator.
		 */
		function get errorMessage( ) : String;
		function set errorMessage( s : String ) : void;
		
		/**
		 * Test if source match this validator
		 * @param arguments The source and arguments need for validation, if null this validator source is used.
		 * 
		 * @return A Boolean that indicates if source match this validator.
		 */
		function isValid( ...arguments : Array ) : Boolean;
	}
}
