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
package myLib.controls 
{
	import myLib.assets.IAsset;
	import myLib.styles.Padding;	
	/**
	 * ICellRenderer definnes properties and methods for a list cell Button.
	 * 
	 * @see ListCell
	 * 
	 * @author SamYStudiO ( contact@samystudio.net )
	 */
	public interface ICellRenderer extends IAsset 
	{
		/**
		 * Get or set the display index from the list owner.
		 */
		function get index() : uint;
		function set index( n : uint ) : void;
		
		/**
		 * Get or set the datas from list provider to merge with cell.
		 */
		function get data() : *;
		function set data( data : * ) : void;
		
		/**
		 * Get or set a Boolean that indicates if cell is resize depending its data.
		 */
		function get autoSize() : Boolean;
		function set autoSize( b : Boolean ) : void;
		
		/**
		 * Get or set a Boolean that indicates if Button cell can recieve interactions.
		 */
		function get selectable() : Boolean;
		function set selectable( b : Boolean ) : void;
		
		/**
		 * Get or set a Boolean that indicates if cell is selected.
		 */
		function get selected() : Boolean;
		function set selected( b : Boolean ) : void;
		
		/**
		 * Get or set cell content padding.
		 */
		function get padding() : Padding;
		function set padding( padding : Padding ) : void;
	}
}
