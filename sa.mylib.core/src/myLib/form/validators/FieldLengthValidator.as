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
	 * FieldLengthValidator is used to test if a String source or container Array length match the specified range.
	 * 
	 * @author SamYStudiO
	 */
	public final class FieldLengthValidator implements IValidator
	{
		/**
		 * Get or set the minimum source length.
		 */
		public var minimum : uint = 0;
		
		/**
		 * Get or set the maximum source length.
		 */
		public var maximum : uint = uint.MAX_VALUE;

		/**
		 * @inheritDoc
		 */
		public function get errorCode() : uint
		{
			return FieldErrorCode.LENGTH;	
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
			if( !( source is String ) || !( source is Array ) ) throw new Error( this + " invalid source type, source must be a String or Array value" );
			
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
			return _errorMessage || "Invalid string or Array length";	
		}
		
		public function set errorMessage( s : String ) : void
		{
			_errorMessage = s;
		}

		/**
		 *  build a new FieldLengthValidator instance.
		 *  
		 *  @param minimum The minimum length.
		 *  @param maximum The maximum length.
		 */
		public function FieldLengthValidator( minimum : uint = 0 , maximum : uint = uint.MAX_VALUE )
		{
			this.minimum = minimum;
			this.maximum = maximum;
		}
		
		/**
		 * @inheritDoc
		 */
		public function isValid( ...arguments : Array ) : Boolean
		{
			_source = arguments[ 0 ] is String || arguments[ 0 ] is Array ? arguments[ 0 ] : _source;
			minimum = arguments[ 1 ] is Number ? uint( arguments[ 1 ] ) : minimum;			maximum = arguments[ 2 ] is Number ? uint( arguments[ 2 ] ) : maximum;
			
			return _source != null && _source.length >= minimum && _source.length <= maximum;
		}
	}
}
