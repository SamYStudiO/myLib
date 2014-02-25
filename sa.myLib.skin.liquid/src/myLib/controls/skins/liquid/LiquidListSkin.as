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
package myLib.controls.skins.liquid
{
	import myLib.assets.IAsset;
	import myLib.assets.LiquidAsset;
	import myLib.controls.ICellRenderer;
	import myLib.controls.ListCell;
	import myLib.controls.skins.IButtonSkin;
	import myLib.controls.skins.IListSkin;
	import myLib.controls.skins.ISkin;
	import myLib.core.IScroll;
	import myLib.utils.ClassUtils;

	import flash.display.BitmapData;
	/**
	 * ListSkin is the default skin for List component.
	 * Like all other components, default skin use string definition, BitmapData object or external URL to build assets.
	 * To use other values or for complexe skin make your own IListSkin implementation.
	 * 
	 * @see myLib.controls.List
	 * @see myLib.controls.skins.IListSkin
	 * @author SamYStudiO ( contact@samystudio.net )
	 */
	public class LiquidListSkin extends ALiquidSkin implements IListSkin 
	{
		/**
		 * @private
		 */
		protected var _cellsBitmapSheet : BitmapData;
		
		/**
		 * @private
		 */
		protected var _backgroundBitmapSheet : BitmapData;
		
		/**
		 * @private
		 */
		protected var _scrollSkin : ISkin;

		/**
		 * 
		 */
		public function LiquidListSkin ( backgroundBitmapSheet : BitmapData , cellsBitmapSheet : BitmapData , focusRectBitmapSheet : BitmapData = null , scrollSkin : ISkin = null )
		{
			super( );
			
			_backgroundBitmapSheet = backgroundBitmapSheet;
			_cellsBitmapSheet = cellsBitmapSheet;
			_focusRectBitmapSheet = focusRectBitmapSheet;
		
			_scrollSkin = scrollSkin;
			
		}

		/**
		 * @inheritDoc
		 */
		public function getBackgroundAsset(  ) : IAsset
		{
			return new LiquidAsset( _backgroundBitmapSheet );
		}
		
		/**
		 * @inheritDoc
		 */
		public function getBackgroundDisabledAsset(  ) : IAsset
		{
			return new LiquidAsset( _backgroundBitmapSheet );
		}
		
		/**
		 * @inheritDoc
		 */
		public function getBorderAsset(  ) : IAsset
		{
			return null;
		}
		
		/**
		 * @inheritDoc
		 */
		public function getBorderDisabledAsset(  ) : IAsset
		{
			return null;
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
					scroll = ClassUtils.getInstance( ClassUtils.getClassByName( definition ) , null , null , _scrollSkin ) as IScroll;
				else
					scroll = ClassUtils.getInstance( definition , null , null , _scrollSkin ) as IScroll;
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
				return new ListCell( null , null , skin == null ? new LiquidButtonSkin( _cellsBitmapSheet ) : skin as IButtonSkin );
			
			var cell : ICellRenderer;
			
			if( definition is String )
				cell = ClassUtils.getInstance( ClassUtils.getClassByName( definition ) ) as ICellRenderer;
			else
				cell = ClassUtils.getInstance( definition ) as ICellRenderer;
				
			if( cell == null ) throw new Error( this + " cell definition does not exist or does not implement ICellRenderer" );
			
			return cell;
		}
	}
}
