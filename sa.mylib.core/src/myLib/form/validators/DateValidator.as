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
	import myLib.form.FieldErrorCode;
	import myLib.utils.DateFormatter;	
	/**
	 * DateValidator is used to test if a string is a date.
	 * 
	 * @author SamYStudiO
	 */
	public final class DateValidator implements IValidator
	{
		/**
		 * Get or set the date format from wich source string is validate.
		 * 
		 * @see myLib.utils.DateFormatter
		 */
		public var format : String;
		
		/**
		 * Get or set a Boolean that indicates if case is sensitve when using date format to test source.
		 */
		public var caseSensitive : Boolean;
		
		/**
		 * @inheritDoc
		 */
		public function get errorCode() : uint
		{
			return FieldErrorCode.DATE;	
		}
		
		/**
		 * @private
		 */
		protected var _source : String;
		
		/**
		 * @inheritDoc
		 */
		public function get source() : *
		{
			return _source;	
		}
		
		public function set source( source : * ) : void
		{
			if( !( source is String ) ) throw new Error( this + " invalid source type, source must be a String value" );
			
			_source = source;
		}
		
		/**
		 * @private
		 */
		protected var _errorMessage : String;
		
		/**
		 * @inheritDoc
		 */
		public function get errorMessage() : String
		{
			return _errorMessage || "Invalid date format";	
		}
		
		public function set errorMessage( s : String ) : void
		{
			_errorMessage = s;
		}

		/**
		 * Build a new DateValidator instance.
		 * 
		 * @param format The date format from wich source is test.
		 * @param caseSensitive A Boolean that indicates if case is sensitive for validation.
		 */
		public function DateValidator( format : String = null , caseSensitive : Boolean = false )
		{
			this.format = format;
			this.caseSensitive = caseSensitive;
		}
		
		/**
		 * @inheritDoc
		 */
		public function isValid( ...arguments : Array ) : Boolean
		{
			_source = arguments[ 0 ] is String ? arguments[ 0 ] : _source;			format = arguments[ 1 ] is String ? arguments[ 1 ] : format;
			
			return DateFormatter.getDateFrom( _source , format , Boolean( arguments[ 2 ] ) ) != null;
		}
	}
}
