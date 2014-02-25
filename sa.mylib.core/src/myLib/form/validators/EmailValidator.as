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
	/**
	 * EmailValidator is used to test if a String is format as an email.
	 * 
	 * @author SamYStudiO
	 */
	public final class EmailValidator implements IValidator
	{
		/**
		 * @inheritDoc
		 */
		public function get errorCode() : uint
		{
			return FieldErrorCode.EMAIL;	
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
			return _errorMessage || "Invalid email format";	
		}
		
		public function set errorMessage( s : String ) : void
		{
			_errorMessage = s;
		}

		/**
		 * Build a new EmailValidator instance.
		 */
		public function EmailValidator(  )
		{
			
		}
		
		/**
		 * @inheritDoc
		 */
		public function isValid( ...arguments : Array ) : Boolean
		{
			_source = arguments[ 0 ] is String ? arguments[ 0 ] as String : _source;
			
			return /^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,6}$/i.test( _source );
		}
	}
}
