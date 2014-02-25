﻿/*
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
package myLib.controls 
{
	/**
	 * StepperNextPreviousPosition defines constants to use with Stepper nextPreviousPosition property.
	 * 
	 * @author SamYStudiO
	 */
	public final class StepperNextPreviousPosition 
	{
		/**
		 * Constant for a top/bottom position.
		 */
		public static const TOP_BOTTOM : String = "topBottom";
		
		/**
		 * Constant for a left/right position.
		 */
		public static const LEFT_RIGHT : String = "leftRight";
		
		/**
		 * Constant for a left position.
		 */
		public static const LEFT : String = "left";
		
		/**
		 * Constant for a top position.
		 */
		public static const TOP : String = "top";
	
		/**
		 * Constant for a bottom position.
		 */
		public static const BOTTOM : String = "bottom";
		
		/**
		 * Constant for a right position.
		 */
		public static const RIGHT : String = "right";
		
		/**
		 * @private
		 */
		public function StepperNextPreviousPosition()
		{
			throw new Error( this + " cannot be instantiated" );
		}
	}
}