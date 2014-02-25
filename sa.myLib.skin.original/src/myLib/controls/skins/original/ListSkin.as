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
package myLib.controls.skins.original 
{
	import myLib.assets.IAsset;
	import myLib.controls.ICellRenderer;
	import myLib.controls.ListCell;
	import myLib.controls.skins.AFieldSkin;
	import myLib.controls.skins.IButtonSkin;
	import myLib.controls.skins.IListSkin;
	import myLib.controls.skins.ISkin;
	import myLib.core.IScroll;
	import myLib.utils.ClassUtils;
	/**
	 * ListSkin is the default skin for List component.
	 * Like all other components, default skin use string definition, BitmapData object or external URL to build assets.
	 * To use other values or for complexe skin make your own IListSkin implementation.
	 * 
	 * @see myLib.controls.List
	 * @see myLib.controls.skins.IListSkin
	 * @author SamYStudiO ( contact@samystudio.net )
	 */
	public class ListSkin extends AFieldSkin implements IListSkin 
	{
		/**
		 * Get or set the background asset string definition, BitmapData object or external URL.
		 */
		public var background : *;
		
		/**
		 * Get or set the background disabled state asset string definition, BitmapData object or external URL.
		 */
		public var backgroundDisabled : *;
		
		/**
		 * Get or set the border asset string definition, BitmapData object or external URL.
		 */
		public var border : *;
		
		/**
		 * Get or set the border disable state asset string definition, BitmapData object or external URL.
		 */
		public var borderDisabled : *;
		
		/**
		 * Get or set the ISkin for Scroll asset.
		 */
		public var scrollSkin : ISkin;
		
		/**
		 * Get or set the initial style for ScrollBar asset.
		 */
		public var scrollInitStyle : Object;
		
		/**
		 * Get or set the ISkin for cell assets.
		 */
		public var cellSkin : ISkin;

		/**
		 * Get or set the initial style for cell assets.
		 */
		public var cellInitStyle : Object;

		/**
		 * Build a new ListSkin instance.
		 * @param background The background asset string definition, BitmapData object or external URL.		 * @param backgroundDisabled The background disabled state asset string definition, BitmapData object or external URL.		 * @param border The border asset string definition, BitmapData object or external URL.
		 * @param focusRect The focus rectangle asset string definition, BitmapData object or external URL.		 * @param borderDisabled The border disable state asset string definition, BitmapData object or external URL.		 * @param scrollBarSkin The IScrollBarSkin for ScrollBar asset.		 * @param cellSkin The IButtonSkin for cell assets.		 * @param scrollInitStyle The initial style for ScrollBar asset.		 * @param cellInitStyle The initial style for cell assets.
		 */
		public function ListSkin (	background : * = null , backgroundDisabled : * = null ,
									border : * = null , borderDisabled : * = null , focusRect : * = null , errorRect : * = null ,
									scrollSkin : ISkin = null , cellSkin : ISkin = null ,
									scrollInitStyle : Object = null , cellInitStyle : Object = null )
		{
			super( );
			
			this.background = background == null ? ListBackground : background;			this.backgroundDisabled = backgroundDisabled == null ? ListBackgroundDisabled : backgroundDisabled;			this.border = border == null ? ListBorder : border;			this.borderDisabled = borderDisabled == null ? ListBorderDisabled : borderDisabled;
						this.focusRect = focusRect == null ? ListFocusRect : focusRect;
			this.errorRect = errorRect == null ? null : errorRect;
			
			this.scrollSkin = scrollSkin;
			this.scrollInitStyle = scrollInitStyle;
			
			this.cellSkin = cellSkin == null ? new ButtonSkin( ListCellTextField ,
																	ListCellUp ,
																	ListCellOver ,
																	ListCellDown ,
																	ListCellDisabled ,																	ListCellUpSelected ,																	ListCellOverSelected ,
																	ListCellDownSelected ,
																	ListCellDisabledSelected ) : cellSkin;
			this.cellInitStyle = cellInitStyle;
		}
		
		/**
		 * @inheritDoc
		 */
		public override function getStyle(  ) : Object
		{
			return { contentMaskCornerRadius : 2 };
		}

		/**
		 * @inheritDoc
		 */
		public function getBackgroundAsset(  ) : IAsset
		{
			return _getAsset( background );
		}
		
		/**
		 * @inheritDoc
		 */
		public function getBackgroundDisabledAsset(  ) : IAsset
		{
			return _getAsset( backgroundDisabled );
		}
		
		/**
		 * @inheritDoc
		 */
		public function getBorderAsset(  ) : IAsset
		{
			return _getAsset( border );
		}
		
		/**
		 * @inheritDoc
		 */
		public function getBorderDisabledAsset(  ) : IAsset
		{
			return _getAsset( borderDisabled );
		}
		
		/**
		 * @inheritDoc
		 */
		public function getScrollAsset( definition : * = null ) : IScroll
		{
			var scroll : IScroll;
			
			try
			{
				if( definition is String )
					scroll = ClassUtils.getInstance( ClassUtils.getClassByName( definition , applicationDomain ) , null , scrollInitStyle , scrollSkin ) as IScroll;
				else
					scroll = ClassUtils.getInstance( definition , null , scrollInitStyle , scrollSkin ) as IScroll;
			}
			catch( e : Error )
			{
					
			}
			
			return scroll;
		}
		
		/**
		 * @inheritDoc
		 */
		public function getCellAsset ( definition : * = null , skin : ISkin = null ) : ICellRenderer
		{
			if( definition == null || definition == ListCell || ( definition is String && ClassUtils.getClassByName( definition ) == ListCell ) )
				return new ListCell( null , cellInitStyle , skin == null ? cellSkin as IButtonSkin : skin as IButtonSkin );
			
			var cell : ICellRenderer;
			
			if( definition is String )
				cell = ClassUtils.getInstance( ClassUtils.getClassByName( definition , applicationDomain ) , null , cellInitStyle , skin == null ? cellSkin : skin ) as ICellRenderer;
			else
				cell = ClassUtils.getInstance( definition , null , cellInitStyle , skin == null ? cellSkin : skin ) as ICellRenderer;
				
			if( cell == null ) throw new Error( this + " cell definition does not exist or does not implement ICellRenderer" );
			
			return cell;
		}
	}
}
