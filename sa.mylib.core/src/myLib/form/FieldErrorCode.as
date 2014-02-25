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
	 * FieldErrorCode contains constants to used with FieldError.
	 * 
	 * @author SamYStudiO ( contact@samystudio.net )
	 */
	public final class FieldErrorCode 
	{
		/**
		 * Constant for an empty field error.
		 */
		public static const EMPTY : uint = 1;
	
		/**
		 * Constant for an email field error.
		 */
		public static const EMAIL : uint = 2;
	
		/**
		 * Constant for a date malformed field error.
		 */
		public static const DATE : uint = 4;
	
		/**
		 * Constant for a field which does not match another.
		 */
		public static const MATCH : uint = 8;
	
		/**
		 * Constant for a field length error.
		 */
		public static const LENGTH : uint = 16;
		
		/**
		 * @private
		 */
		public function FieldErrorCode()
		{
			throw new Error( this + " cannot be instantiated" );
		}
	}
}
