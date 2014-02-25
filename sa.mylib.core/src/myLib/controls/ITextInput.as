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
 * The Original Code is myLib Framework.
 *
 * The Initial Developer of the Original Code is
 * Samuel EMINET (aka SamYStudiO) contact@samystudio.net.
 * Portions created by the Initial Developer are Copyright (C) 2008-2011
 * the Initial Developer. All Rights Reserved.
 *
 */
package myLib.controls 
{
	/**
	 * @author SamYStudiO ( contact@samystudio.net )
	 */
	public interface ITextInput extends ILabel 
	{
		/**
		 * Get or set a Boolean that indicates if text is display replace by star for password for example.
		 * 
		 * @default false
		 */
		function get displayAsPassword() : Boolean;
		function set displayAsPassword( b : Boolean ) : void;
		
		/**
		 * Get or set the restrict chars with this TextInput.
		 */
		function get restrict() : String;
		function set restrict( s : String ) : void;
		
		/**
		 * Get or set the maximum chars this TextInput can display.
		 */
		function get maxChars() : int;
		function set maxChars( n : int ) : void;
		
		/**
		 * Get or set the disabled text color when component is disabled.
		 */
		function get disabledTextColor() : uint;
		function set disabledTextColor( n : uint ) : void;
		
		/**
		 * Get or set the default text display when user have not yet enter text. When component recieve focus default text is removed,
		 * if user leave component without typing anything default text is display.
		 */
		function get defaultText() : String;
		function set defaultText( s : String ) : void;
	}
}
