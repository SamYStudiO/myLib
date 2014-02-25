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
	import myLib.core.IScroll;		
	/**
	 * @author SamYStudiO ( contact@samystudio.net )
	 */
	public interface ITextArea extends ITextInput 
	{
		/**
		 * Get or set a Boolean that indicates if horizontal scroll is active. If horizontal scroll is not used
		 * text word wrap automatically.
		 */
		function get useHorizontalScroll() : Boolean;
		function set useHorizontalScroll( b : Boolean ) : void;
		
		/**
		 * Get or set a Boolean that indicates if ScrollBar overlap background or background is resized when ScrollBar is display.
		 * 
		 * @default true
		 */
		function get scrollBarOverlapBackground() : Boolean;
		function set scrollBarOverlapBackground( b : Boolean ) : void;
		
		/**
		 * 
		 * 
		 * @default myLib.controls.ScrollBar
		 */
		function get scrollRenderer() : *;
		function set scrollRenderer( definition : * ) : void;
		
		/**
		 * 
		 * 
		 * @default false
		 */
		function get scrollUseTextFieldContainer() : Boolean;
		function set scrollUseTextFieldContainer( b : Boolean ) : void;
		
		/**
		 * 
		 * 
		 * @default true
		 */
		function get editable() : Boolean;
		function set editable( b : Boolean ) : void;
		
		/**
		 * Get the IScroll asset use to render horizontal scroll.
		 */
		function get horizontalScroll() : IScroll;
		
		/**
		 * Get the IScroll asset use to render vertical scroll.
		 */
		function get verticalScroll() : IScroll;
	}
}
