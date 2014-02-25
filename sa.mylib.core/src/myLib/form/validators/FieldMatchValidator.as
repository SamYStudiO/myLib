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
	import myLib.form.IField;
	import myLib.utils.ObjectUtils;	
	/**
	 * FieldMatchValidator is used to test if 2 input fields have the same value.
	 * Really useful to test if 2 input password field match together for example.
	 * 
	 * @author SamYStudiO
	 */
	public final class FieldMatchValidator implements IValidator
	{
		/**
		 * The field to compare.
		 * 
		 * @see myLib.form.IField
		 */
		public var matchField : IField;
		
		/**
		 * @inheritDoc
		 */
		public function get errorCode() : uint
		{
			return FieldErrorCode.MATCH;	
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
			return _errorMessage || "Invalid match string";	
		}
		
		public function set errorMessage( s : String ) : void
		{
			_errorMessage = s;
		}

		/**
		 * build a new FieldMatchValidator instance.
		 * 
		 * @param matchField The field that source field must match.
		 */
		public function FieldMatchValidator( matchField : IField = null )
		{			this.matchField = matchField;
		}
		
		/**
		 * @inheritDoc
		 */
		public function isValid( ...arguments : Array ) : Boolean
		{
			_source = arguments[ 0 ] != null ? arguments[ 0 ] : _source;			matchField = arguments[ 1 ] is IField ? arguments[ 1 ] as IField : matchField;
			
			var matchFieldValue : * = matchField != null ? matchField.getValue() : null;
			
			return ObjectUtils.compare( _source , matchFieldValue );
		}
	}
}
