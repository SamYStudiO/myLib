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
package myLib.display 
{
	import flash.display.InteractiveObject;
	import flash.events.IEventDispatcher;		
	/**
	 * IFocusable defines all properties and methods for a focusable object, all components assets and components themself are IFocusable.
	 * 
	 * @author SamYStudiO
	 */
	public interface IFocusable extends IEventDispatcher
	{
		/**
		 * Get or set a Boolean that indicates if asset can recieve focus.
		 */
		function get focusEnabled() : Boolean;
		function set focusEnabled( b : Boolean ) : void;
		
		/**
		 * Get or set focusable child that recieve focus instead of focusable itself.
		 */
		function get focusTarget() : InteractiveObject;
		function set focusTarget(  object : InteractiveObject ) : void;
		
		/**
		 * Get or set focusable child that recieve focus rectangle instead of focusable itself.
		 */
		function get focusDrawTarget() : IFocusable;
		function set focusDrawTarget(  object : IFocusable ) : void;
		
		/**
		 * Get or set a Boolean that indicates if focus rectangle is drawn when a focus change from a key tab.
		 * 
		 * @default true
		 */
		function get showTabFocusChangeIndicator() : Boolean;
		function set showTabFocusChangeIndicator(  b : Boolean ) : void;
		
		/**
		 * Get or set a Boolean that indicates if focus rectangle is drawn when a focus change from a click action.
		 * 
		 * @default false
		 */
		function get showMouseFocusChangeIndicator() : Boolean;
		function set showMouseFocusChangeIndicator(  b : Boolean ) : void;
		
		/**
		 * Set focus to this focusable, focus is not always apply to focusable itself, it can also be a child or any interactive object if focusTarget is defined.
		 */
		function setFocus( ) : void;
		
		/**
		 * Draw or remove the focus indicator.
		 * 
		 * @param A Boolean that indicates if focus indicator is drawn (true) or removed (false).
		 */
		function drawFocus( b : Boolean ) : void;
	}
}
