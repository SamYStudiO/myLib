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
	import myLib.core.IAStepper;
	/**
	 * @author SamYStudiO ( contact@samystudio.net )
	 */
	public interface INumericStepper extends IAStepper 
	{
		/**
		 * Indicates minimum value.
		 */
		function get minimum() : Number;
		function set minimum( n : Number ) : void;
		
		/**
		 * Indicates maximum value.
		 */
		function get maximum() : Number;
		function set maximum( n : Number ) : void;
		
		/**
		 * Indicates step size. For example with minim value 0, maximum value 10 and stepSize 2 only 0, 2, 4, 6, 8, 10 values can be typed or returned.
		 */
		function get stepSize() : Number;
		function set stepSize( n : Number ) : void;
		
		/**
		 * Get or set Stepper value.
		 */
		function get value() : Number;
		function set value( n : Number ) : void;
	}
}
