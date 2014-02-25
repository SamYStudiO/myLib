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
	import myLib.assets.IAsset;
	import myLib.core.IComponent;
	import myLib.core.IScroll;
	import myLib.data.ICollection;
	import myLib.styles.Padding;

	import flash.events.KeyboardEvent;
	/**
	 * @author SamYStudiO ( contact@samystudio.net )
	 */
	public interface IList extends IComponent 
	{
		/**
		 * Get or set a Boolean that indicates if a key selection using up or down loop from last item to first item.
		 * 
		 * @default true
		 */
		function get keySelectionLoop() : Boolean;
		function set keySelectionLoop( b : Boolean ) : void;
		
		/**
		 * Get or set the border thickness for layout.
		 */
		function get borderThickness() : Number;
		function set borderThickness( n : Number ) : void;
		
		/**
		 * Get or set the collection object used to build List cells. In most case DataProvider collection is what you need here.
		 * 
		 * @see myLib.data.DataProvider
		 */
		function get dataProvider() : ICollection;
		function set dataProvider( dataProvider : ICollection ) : void;
		
		/**
		 * Get or set the label field from data provider used to display text with cells.
		 */
		function get labelField() : String;
		function set labelField( s : String ) : void;
		
		/**
		 * Get or set the data field from data provider used as data with cells.
		 */
		function get dataField() : String;
		function set dataField( s : String ) : void;
		
		/**
		 * Get or set the icon field from data provider used to display icon with cells.
		 */
		function get iconField() : String;
		function set iconField( s : String ) : void;
		
		/**
		 * Get or set the List selected index.
		 */
		function get selectedIndex() : int;
		function set selectedIndex( index : int ) : void;
		
		/**
		 * Get or set the List selected indices for multiple selection List.
		 */
		function get selectedIndices() : Array;
		function set selectedIndices( indices : Array ) : void;
		
		/**
		 * Get or set the List selected item from data provider (this is an alternative to selectedIndex to select a cell).
		 */
		function get selectedItem() : *;
		function set selectedItem( item : * ) : void;
		
		/**
		 * Get or set the List selected items from data provider (this is an alternative to selectedIndices to select cells in multiple selection List).
		 */
		function get selectedItems() : Array;
		function set selectedItems( items : Array ) : void;
		
		/**
		 * Get or set the List selected data from data provider (this is an alternative to selectedIndex to select a cell).
		 */
		function get selectedData() : *;
		function set selectedData( data : * ) : void;
		
		/**
		 * Get or set the List selected datas from data provider (this is an alternative to selectedIndices to select cells in multiple selection List).
		 */
		function get selectedDatas() : Array;
		function set selectedDatas( datas : Array ) : void;
		
		/**
		 * Get or set the number of cells display before scroll is used. This modify layout, using height property when cellCount is used have no effect.
		 * 
		 * @default 0 (use height property for layout)
		 */
		function get cellCount() : uint;
		function set cellCount( n : uint ) : void;
		
		/**
		 * get or set the default height size for List cells.
		 * 
		 * @default 20
		 */
		function get cellHeight() : Number;
		function set cellHeight( n : Number ) : void;
		
		/**
		 * get or set the default height size for List cells.
		 * 
		 * @default 20
		 */
		function get cellSpacing() : Number;
		function set cellSpacing( n : Number ) : void;
		
		/**
		 * Get or set the string definition or Class object used to build cells.
		 * 
		 * @default myLib.controls.ListCell
		 */
		function get cellRenderer() : *;
		function set cellRenderer( definition : * ) : void;
		
		/**
		 * Get or set the style object merge with each cell build with this List.
		 * 
		 * @see myLib.styles.StyleManager
		 */
		function get cellStyle() : Object;
		function set cellStyle( style : Object ) : void;
		
		/**
		 * Get or set an Array of skin object to alternate cell skins.
		 */
		function get alternateCellSkin() : Array;
		function set alternateCellSkin( a : Array ) : void;
		
		/**
		 * Get or set a Bollean that indicates if cells can be selected.
		 * 
		 * @default true
		 */
		function get selectable() : Boolean;
		function set selectable( b : Boolean ) : void;
		
		/**
		 * get or set a Boolean that indicates if multiple selection is alow.
		 * 
		 * @default false
		 */
		function get multipleSelection() : Boolean;
		function set multipleSelection( b : Boolean ) : void;
		
		/**
		 * Get or set the scroll string defintion or class object used to render scroll as defined in ScrollRenderer.
		 * 
		 * @default ScrollRenderer.SCROLLBAR
		 * @see ScrollRenderer
		 */
		function get scrollRenderer() : *;
		function set scrollRenderer( definition : * ) : void;
		
		/**
		 * Get or set the style object that will be merged with scroll instance.
		 * 
		 * @see myLib.styles.StyleManager
		 */
		function get scrollStyle() : Object;
		function set scrollStyle( style : Object ) : void;
		
		/**
		 * Get or set a Boolean that indicates if ScrollBar overlap cells or cells are resized when ScrollBar is display.
		 * 
		 * @default false
		 */
		function get scrollBarPosition() : String;
		function set scrollBarPosition( position : String ) : void;
		
		/**
		 * Get or set a Boolean that indicates if ScrollBar overlap cells or cells are resized when ScrollBar is display.
		 * 
		 * @default false
		 */
		function get scrollBarOverlapCells() : Boolean;
		function set scrollBarOverlapCells( b : Boolean ) : void;
		
		/**
         * Get or set a Boolean that indicates if Scroll position use border thickness information for its position.
         * 
         * @default true
         */
        function get scrollLayoutUseBorderThickness() : Boolean;
        function set scrollLayoutUseBorderThickness( b : Boolean ) : void;
		
		/**
		 * Get or set a Boolean that indicates if List is sized automatically to make all cells content visible.
		 * 
		 * @default false
		 */
		function get autoSize() : Boolean;
		function set autoSize( b : Boolean ) : void;
		
		/**
		 * Get or set the Padding object used with cells handler.
		 */
		function get contentPadding() : Padding;
		function set contentPadding( padding : Padding ) : void;
		
		/**
		 * Get or set cells mask corner radius.
		 * 
		 * @default 2
		 */
		function get contentMaskCornerRadius() : Number;
		function set contentMaskCornerRadius( radius : Number ) : void;
		
		/**
		 * Get or set cells mask top left corner radius.
		 * 
		 * @default 2
		 */
		function get contentMaskCornerRadiusTopLeft() : Number;
		function set contentMaskCornerRadiusTopLeft( radius : Number ) : void;
		
		/**
		 * Get or set cells mask top rightcorner radius.
		 * 
		 * @default 2 
		 */
		function get contentMaskCornerRadiusTopRight() : Number;
		function set contentMaskCornerRadiusTopRight( radius : Number ) : void;
		
		/**
		 * Get or set cells mask bottom right corner radius.
		 * 
		 * @default 2
		 */
		function get contentMaskCornerRadiusBottomRight() : Number;
		function set contentMaskCornerRadiusBottomRight( radius : Number ) : void;
		
		/**
		 * Get or set cells mask nottom left corner radius.
		 * 
		 * @default 2
		 */
		function get contentMaskCornerRadiusBottomLeft() : Number;
		function set contentMaskCornerRadiusBottomLeft( radius : Number ) : void;
		
		/**
		 * Get IAsset used to render background.
		 */
		function get backgroundAsset() : IAsset;
		
		/**
		 * Get IAsset used to render border.
		 */
		function get borderAsset() : IAsset;
		
		/**
		 * Get AScroll used to render scroll.
		 */
		function get scroll() : IScroll;
		
		/**
		 * Get the ICellRender asset render at the specified index.
		 * 
		 * @param index The index where retrieve the cell.
		 * @return The ICellRender asset render at the specified index.
		 */
		function getCellAt( index : uint ) : ICellRenderer;
		
		/**
		 * Get an Array of all currently visible cells.
		 * 
		 * @return An Array of all currently visible cells.
		 */
		function getVisibleCells( ) : Array;
		
		/**
		 * Set the string definition use to build cell at the specified index.
		 * 
		 * @param index The index where used the specified defintion.
		 * @param definition The string defintion to use.
		 */
		function setCellRendererAt( index : uint , definition : String ) : void;
		
		/**
		 * Get the style object associate with the cell at the specified index.
		 * 
		 * @param index The index where retrieve style object.
		 * @return The style object associate with the cell at the specified index.
		 * @see myLib.styles.StyleManager
		 */
		function getCellStyleAt( index : uint ) : Object;
		
		/**
		 * Set the style object to merge with the cell at the specified index.
		 * 
		 * @param index The style object to merge.
		 * @param index The index where apply this style.
		 * @see myLib.styles.StyleManager
		 */
		function setCellStyleAt( index : uint , style : Object ) : void;
		
		/**
		 * Get a Boolean that indicates if the specified item from data provider is currently selected.
		 * 
		 * @param item The item from data provider to test.
		 * @return true if item cell is selected.
		 */
		function isItemSelected ( item : * ) : Boolean;
		
		/**
		 * Get a Boolean that indicates if the specified item from data provider is currently visible.
		 * 
		 * @param item The item from data provider to test.
		 * @return true if item cell is visible.
		 */
		function isItemVisible ( item : * ) : Boolean;
		
		/**
		 * Get a Boolean that indicates if the specified index is selected.
		 * 
		 * @param index The index from data provider to test.
		 * @return true if index cell is selected.
		 */
		function isIndexSelected ( index : uint ) : Boolean;
		
		/**
		 * Get a Boolean that indicates if the specified index is visible.
		 * 
		 * @param index The index from data provider to test.
		 * @return true if index cell is visible.
		 */
		function isIndexVisible ( index : uint ) : Boolean;
		
		/**
		 * Do a scroll operation to make the cell at the specified index visible.
		 * 
		 * @param index The index cell to display.
		 * @param alignmentPoint An alignment point that defines the cell position in the visible area as defined in AlignmentPoint
		 * @see myLib.displayUtils.AlignmentPoint
		 */
		function scrollToIndex( index : uint , alignmentPoint : String = null ) : void;
		
		/**
		 * Do a scroll operation to make the cell at the specified index visible.
		 * 
		 * @param index The index cell to display.
		 * @param alignmentPoint An alignment point that defines the cell position in the visible area as defined in AlignmentPoint
		 * @param ease The ease function to use with tween engine.
		 * @param duration The tween duration.
		 * @param durationAsMilliseconds Use milliseconds (default true) or frame for duration.
		 * @see myLib.displayUtils.AlignmentPoint
		 */
		function tweenToIndex( index : uint , alignmentPoint : String = null , ease : Function = null , duration : Number = 500 , durationAsMilliseconds : Boolean = true ) : void;
		
		/**
		 * Unselect all currently selected cells.
		 */
		function clearSelection(  ) : void;
		
		/**
		 * Apply a filter to data provider to display only the cells that match the specified callback.
		 * This works like Array.filter property.
		 * 
		 * @param The filter function which test each item of data provider.
		 * @return An Array of all items that match the specified callback.
		 */
		function filter( callback : Function ) : Array;
		
		/**
		 * Select next item within list from current select cell.
		 */
		function next(  ) : void;
		
		/**
		 * Select previous item within list from current select cell.
		 */
		function previous(  ) : void;
		
		/**
		 * Clear the last filter apply to make all data provider item cells visible.
		 */
		function clearFilter(  ) : void;
		
		/**
		 * @private
		 */
		function keyDown ( e : KeyboardEvent ) : void;
	}
}
