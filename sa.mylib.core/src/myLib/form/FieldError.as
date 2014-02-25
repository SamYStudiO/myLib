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
	/**
	 * FieldError contains informations from a field that failed validation in a Form object.
	 * 
	 * @see Form
	 * 
	 * @author SamYStudiO
	 */
	public class FieldError 
	{
		/**
		 * Get the field from which error occured.
		 */
		public var field : IField;
		
		/**
		 * Get the error codes.
		 * 
		 * @see FieldErrorCode
		 */
		public var codes : uint;
		
		/**
		 * Get the error messages
		 */
		public var messages : Array;
		
		/**
		 * Build a new FieldError instance.
		 * 
		 * @param field The field from wich error occured.
		 * @param codes The error codes.
		 * @param messages The error messages.
		 */
		public function FieldError( field : IField , codes : uint , messages : Array = null )
		{
			this.field = field;			this.codes = codes;			this.messages = messages || new Array();
		}

		/**
		 * Using FieldErrorCode constants this method let you know what kind of error occured with this FieldError.
		 * 
		 * @param code The code to search.
		 * @return A boolean that indicates if the specified code is within this FieldError.
		 * 
		 * @see FieldErrorCode
		 */
		public function containCodeError( code : uint ) : Boolean
		{
			return ( codes | code ) == codes && code != 0;
		}
	}
}
