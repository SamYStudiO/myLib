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
	import myLib.data.ICollection;	
	/**
	 * @author SamYStudiO ( contact@samystudio.net )
	 */
	public interface IStepper extends IAStepper 
	{
		/**
		 * Get or set a Boolean that indicates if stepper selction can loop.
		 *  
		 *  @default true
		 */
		function get selectionLoop() : Boolean;
		function set selectionLoop( b : Boolean ) : void;
		
		/**
		 * Get or set the collection object. In most case DataProvider collection is what you need here.
		 * 
		 * @see myLib.data.DataProvider
		 */
		function get dataProvider() : ICollection;
		function set dataProvider( dataProvider : ICollection ) : void;
		
		/**
		 * Get or set the label field from data provider used to display text with selected item.
		 */
		function get labelField() : String;
		function set labelField( s : String ) : void;
		
		/**
		 * Get or set the data field from data provider used as data with selected item.
		 */
		function get dataField() : String;
		function set dataField( s : String ) : void;
		
		/**
		 * Get or set the icon field from data provider used to display icon with selected item.
		 */
		function get iconField() : String;
		function set iconField( s : String ) : void;
		
		/**
		 * Get or set the List selected index.
		 */
		function get selectedIndex() : int;
		function set selectedIndex( index : int ) : void;
		
		/**
		 * Get or set the List selected item from data provider (this is an alternative to selectedIndex to select a cell).
		 */
		function get selectedItem() : *;
		function set selectedItem( item : * ) : void;
		
		/**
		 * Get or set the List selected item from data provider (this is an alternative to selectedIndex to select a cell).
		 */
		function get selectedData() : *;
		function set selectedData( data : * ) : void;
		
		/**
		 * Clear current Stepper selection.
		 */
		function clearSelection() : void;
	}
}
