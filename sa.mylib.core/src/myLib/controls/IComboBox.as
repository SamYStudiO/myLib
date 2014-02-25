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
	import myLib.styles.TextStyle;

	import flash.display.Shape;
	import flash.text.TextField;
	/**
	 * @author SamYStudiO ( contact@samystudio.net )
	 */
	public interface IComboBox extends IComponent 
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
		 * 
		 * @efault 1
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
		 * 
		 * @default label
		 */
		function get labelField() : String;
		function set labelField( s : String ) : void;
		
		/**
		 * Get or set the data field from data provider used as data with cells.
		 * 
		 * @default data
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
		 * Get or set the List selected item from data provider (this is an alternative to selectedIndex to select a cell).
		 */
		function get selectedItem() : *;
		function set selectedItem( item : * ) : void;
		
		/**
		 * Get or set the List selected data from data provider (this is an alternative to selectedIndex to select a cell).
		 */
		function get selectedData() : *;
		function set selectedData( data : * ) : void;
		
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
		 * Get or set the string definition used to build cells.
		 * 
		 * @default myLib.controls.ListCell
		 */
		function get cellRenderer() : String;
		function set cellRenderer( definition : String ) : void;
		
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
		 * @default true
		 */
		function get scrollBarOverlapCells() : Boolean;
		function set scrollBarOverlapCells( b : Boolean ) : void;
		
		/**
		 * Get or set a Boolean that indicates if scroll position is saved when dropdown list is closed.
		 * 
		 * @default true
		 */
		function get keepScrollPositionOnClose() : Boolean;
		function set keepScrollPositionOnClose( b : Boolean ) : void;
		
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
		 * Get or set the default text display when there is no selected cell.
		 */
		function get defaultText() : String;
		function set defaultText( s : String ) : void;
		
		/**
		 * Get or set the custom open function used when transitionType property is defined as custom.
		 */
		function get openFunction() : Function;
		function set openFunction( f : Function ) : void;
		
		/**
		 * Get or set the custom close function used when transitionType property is defined as custom.
		 */
		function get closeFunction() : Function;
		function set closeFunction( f : Function ) : void;
		
		/**
		 * Get or set the ease function used with transition.
		 */
		function get transitionEasing() : Function;
		function set transitionEasing( f : Function ) : void;
		
		/**
		 * Get or set the transition type when dropdown list is open or close as defined in ComboBoxTransitionType constants.
		 * 
		 * @default ComboBoxTransitionType.TRANSLATE
		 * @see ComboBoxTransitionType
		 */
		function get transitionType() : String;
		function set transitionType( s : String ) : void;
		
		/**
		 * Get or set a Boolean that indicates if an alpha transition is done when opening or closing dropdown list.
		 * 
		 * @default false
		 */
		function get transitionAlpha() : Boolean;
		function set transitionAlpha( b : Boolean ) : void;
		
		/**
		 * Get or set the transition duration.
		 * 
		 * @default 10 (frames)
		 */
		function get transitionDuration() : Number;
		function set transitionDuration( n : Number ) : void;
		
		/**
		 * Get or set a Boolean that indicates if editable textfield when autoCompletion is active can display text that don't match any dataprovider items. 
		 * 
		 * @default true
		 * @see #autoCompletion
		 */
		function get allowCustomEditableText() : Boolean;
		function set allowCustomEditableText( b : Boolean ) : void;
		
		/**
		 * Get or set a Boolean that indicates if autocompletion is active. When autocompletion is active ComboBox is editable,
		 * when type a letter dropdown list cells are filtered to display only cells that match typed text.
		 * 
		 * @default false
		 */
		function get autoCompletion() : Boolean;
		function set autoCompletion( b : Boolean ) : void;
		
		/**
		 * Get or set a Bolean that indicates if box text is editable.
		 * 
		 * @default false
		 */
		function get editable() : Boolean;
		function set editable( b : Boolean ) : void;
		
		/**
		 * Get or set a Boolean that indicates if selected cell in dropdown list is hide.
		 * 
		 * @default false
		 */
		function get hideSelectedCell() : Boolean;
		function set hideSelectedCell( b : Boolean ) : void;
		
		/**
		 * Get or set the arrow button position using ComboBoxArrowButtonPosition constants.
		 * 
		 * @default ComboBoxArrowButtonPosition.LEFT
		 * @see ComboBoxArrowButtonPosition
		 */
		function get arrowButtonPosition() : String;
		function set arrowButtonPosition( position : String ) : void;
		
		/**
		 * Get or set the dropdown list open direction using ComboBoxOpenDirection constants.
		 * 
		 * @default ComboBoxOpenDirection.DOWN
		 * @see ComboBoxOpenDirection
		 */
		function get openDirection() : String;
		function set openDirection( direction : String ) : void;
		
		/**
		 * Specify dropdown list open mouse action (click or roll) using ComboBoxOpenMouseAction constants.
		 * 
		 * @default ComboBoxOpenMouseAction.CLICK
		 * @see ComboBoxOpenMouseAction
		 */
		function get openMouseAction() : String;
		function set openMouseAction( action : String ) : void;
		
		/**
		 * Get or set the dropdown list with according dropdownWidthType property.
		 * 
		 * @see #dropdownWidthType
		 */
		function get dropdownWidth() : Number;
		function set dropdownWidth( n : Number ) : void;
		
		/**
		 * Get or set the dropdown width type as defined in ComboBoxDropdownWidthType constants.
		 * NONE value make dropdown list resized according ComboBox width.
		 * PERCENTAGE value make dropdown list resized in percentage in association with dropdownWidth property.
		 * ARROW_BUTTON value make dropdown list resized according ComboBox width - ComboBox arrow button size.
		 * AUTOSIZE value make dropdown list resized to make completly visible all cells.
		 * 
		 * @default ComboBoxDropdownWidthType.NONE
		 */
		function get dropdownWidthType() : String;
		function set dropdownWidthType( s : String ) : void;
		
		/**
		 * Get TextInput textfield
		 */
		function get textField() : TextField;
		
		/**
		 * Get or set the TextStyle object to use with textInput asset.
		 * 
		 * @see myLib.styles.StyleManager
		 */
		function get textStyle() : TextStyle;
		function set textStyle( style : TextStyle ) : void;
		
		/**
		 * Get or set box text.
		 */
		function get text() : String;
		function set text( s : String ) : void;
		
		
		/**
		 * Get the dropdown List component.
		 */
		function get dropdownList() : IList;
		
		/**
		 * Get the mask used to open and close dropdown list.
		 */
		function get dropdownListMask() : Shape;
		
		/**
		 * Get a Boolean that indicates if dropdown list is opened.
		 */
		function get isOpen() : Boolean;
		
		/**
		 * Get AScroll used to render scroll.
		 */
		function get scroll() : IScroll;
		
		/**
		 * Get Iasset used to render box button.
		 */
		function get boxAsset() : IAsset;
		
		/**
		 * Get Iasset used to render arrow button button.
		 */
		function get arrowButtonAsset() : IAsset;
		
		/**
		 * Get TextInput used to render input textfield.
		 */
		function get textInput() : ITextInput;
		
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
		 * Clear the last filter apply to make all data provider item cells visible.
		 */
		function clearFilter(  ) : void;
		
		/**
		 * Open the dropdown list.
		 */
		function open(  ) : void;
		
		/**
		 * Close the dropdown list.
		 */
		function close(  ) : void;
		
		/**
		 * Select next item within list from current select cell.
		 */
		function next(  ) : void;
		
		/**
		 * Select previous item within list from current select cell.
		 */
		function previous(  ) : void;
	}
}
