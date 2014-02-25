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
package myLib.display 
{
	import flash.accessibility.AccessibilityImplementation;
	/**
	 * @author SamYStudiO ( contact@samystudio.net )
	 */
	public interface IInteractiveObject extends IDisplayObject 
	{
		/**
		 * @see http://help.adobe.com/en_US/AS3LCR/Flash_10.0/flash/display/InteractiveObject.html#accessibilityImplementation flash.display.InteractiveObject.accessibilityImplementation
		 */
		function get accessibilityImplementation () : AccessibilityImplementation;
		function set accessibilityImplementation ( value : AccessibilityImplementation ) : void;
		
		/**
		 * @see http://help.adobe.com/en_US/AS3LCR/Flash_10.0/flash/display/InteractiveObject.html#doubleClickEnabled flash.display.InteractiveObject.doubleClickEnabled
		 */
		function get doubleClickEnabled () : Boolean;
		function set doubleClickEnabled ( enabled : Boolean ) : void;
		
		/**
		 * @see http://help.adobe.com/en_US/AS3LCR/Flash_10.0/flash/display/InteractiveObject.html#focusRect flash.display.InteractiveObject.focusRect
		 */
		function get focusRect () : Object;
		function set focusRect ( focusRect : Object ) : void;
		
		/**
		 * @see http://help.adobe.com/en_US/AS3LCR/Flash_10.0/flash/display/InteractiveObject.html#mouseEnabled flash.display.InteractiveObject.mouseEnabled
		 */
		function get mouseEnabled() : Boolean;
		function set mouseEnabled( enabled : Boolean ) : void;
		
		/**
		 * @see http://help.adobe.com/en_US/AS3LCR/Flash_10.0/flash/display/InteractiveObject.html#tabEnabled flash.display.InteractiveObject.tabEnabled
		 */
		function get tabEnabled () : Boolean;
		function set tabEnabled ( enabled : Boolean ) : void;
		
		/**
		 * @see http://help.adobe.com/en_US/AS3LCR/Flash_10.0/flash/display/InteractiveObject.html#tabIndex flash.display.InteractiveObject.tabIndex
		 */
		function get tabIndex () : int;
		function set tabIndex ( index : int ) : void;
	}
}
