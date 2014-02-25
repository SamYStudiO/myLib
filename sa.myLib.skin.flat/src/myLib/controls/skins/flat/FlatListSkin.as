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
 * Portions created by the Initial Developer are Copyright (C) 2008-2012
 * the Initial Developer. All Rights Reserved.
 *
 */
package myLib.controls.skins.flat
{
	import myLib.assets.IAsset;
	import myLib.assets.flat.BorderStyle;
	import myLib.assets.flat.BoxAsset;
	import myLib.assets.flat.ShapeAssetProp;
	import myLib.controls.ICellRenderer;
	import myLib.controls.ListCell;
	import myLib.controls.skins.IButtonSkin;
	import myLib.controls.skins.IListSkin;
	import myLib.controls.skins.ISkin;
	import myLib.core.IScroll;
	import myLib.utils.ClassUtils;

	/**
	 * @author SamYStudiO ( contact@samystudio.net )
	 */
	public class FlatListSkin extends AFlatSkin implements IListSkin
	{
		/**
		 * @private
		 */
		protected var _scrollSkin : ISkin;
		
		/**
		 * @private
		 */
		protected var _backgroundShapeProp : ShapeAssetProp;
		
		/**
		 * @private
		 */
		protected var _upCellShapeProp : ShapeAssetProp;
		
		/**
		 * @private
		 */
		protected var _overCellShapeProp : ShapeAssetProp;
		
		/**
		 * @private
		 */
		protected var _downCellShapeProp : ShapeAssetProp;
		
		/**
		 * @private
		 */
		protected var _disabledCellShapeProp : ShapeAssetProp;
		
		/**
		 * @private
		 */
		protected var _upSelectedCellShapeProp : ShapeAssetProp;
		
		/**
		 * @private
		 */
		protected var _overSelectedCellShapeProp : ShapeAssetProp;
		
		/**
		 * @private
		 */
		protected var _downSelectedCellShapeProp : ShapeAssetProp;
		
		/**
		 * @private
		 */
		protected var _disabledCellSelectedShapeProp : ShapeAssetProp;
		
		/**
		 * 
		 */
		public function FlatListSkin( 	backgroundShapeProp  : ShapeAssetProp , upCellShapeProp : ShapeAssetProp , overCellShapeProp : ShapeAssetProp , downCellShapeProp : ShapeAssetProp , disabledCellShapeProp : ShapeAssetProp ,
										upSelectedCellShapeProp : ShapeAssetProp , overSelectedCellShapeProp : ShapeAssetProp , downSelectedCellShapeProp : ShapeAssetProp , disabledSelectedCellShapeProp : ShapeAssetProp , focusProp : ShapeAssetProp = null , errorProp : ShapeAssetProp = null , scrollSkin : ISkin = null )
		{
			super( focusProp , errorProp );
			
			_scrollSkin = scrollSkin;
			_backgroundShapeProp = backgroundShapeProp;
			_upCellShapeProp = upCellShapeProp;
			_overCellShapeProp = overCellShapeProp;
			_downCellShapeProp = downCellShapeProp;
			_disabledCellShapeProp = disabledCellShapeProp;
			_upSelectedCellShapeProp = upSelectedCellShapeProp;
			_overSelectedCellShapeProp = overSelectedCellShapeProp;
			_downSelectedCellShapeProp = downSelectedCellShapeProp;
			_disabledCellSelectedShapeProp = disabledSelectedCellShapeProp;
		}

		/**
		 * @inheritDoc
		 */
		public function getBackgroundAsset() : IAsset
		{
			return new BoxAsset( _backgroundShapeProp );
		}

		/**
		 * @inheritDoc
		 */
		public function getBackgroundDisabledAsset() : IAsset
		{
			return new BoxAsset( _backgroundShapeProp );
		}

		/**
		 * @inheritDoc
		 */
		public function getBorderAsset() : IAsset
		{
			return null;
		}

		/**
		 * @inheritDoc
		 */
		public function getBorderDisabledAsset() : IAsset
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
					scroll = ClassUtils.getInstance( ClassUtils.getClassByName( definition , applicationDomain ) , null , null , _scrollSkin ) as IScroll;
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
		public function getCellAsset( definition : * = null , skin : ISkin = null ) : ICellRenderer
		{
			if( definition == null || definition == ListCell || ( definition is String && ClassUtils.getClassByName( definition , applicationDomain ) == ListCell ) )
				return new ListCell( null , null , skin == null ? new FlatButtonSkin( 	_upCellShapeProp , _overCellShapeProp , _downCellShapeProp , _disabledCellShapeProp ,
																						_upSelectedCellShapeProp , _overSelectedCellShapeProp , _downSelectedCellShapeProp , _disabledCellSelectedShapeProp ) : skin as IButtonSkin );
			
			var cell : ICellRenderer;
			
			if( definition is String )
				cell = ClassUtils.getInstance( ClassUtils.getClassByName( definition , applicationDomain ) ) as ICellRenderer;
			else
				cell = ClassUtils.getInstance( definition ) as ICellRenderer;
				
			if( cell == null ) throw new Error( this + " cell definition does not exist or does not implement ICellRenderer" );
			
			return cell;
		}

		/**
		 * @inheritDoc
		 */
		public override function getStyle() : Object
		{
			return { borderThickness : _backgroundShapeProp.borderStyle == BorderStyle.FILL ? _backgroundShapeProp.borderThickness : 0 , contentMaskCornerRadius : _backgroundShapeProp.cornerRadius };
		}
	}
}
