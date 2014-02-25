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
package myLib.controls.skins.glossy
{
	import myLib.assets.IAsset;
	import myLib.assets.glossy.BoxAsset;
	import myLib.assets.glossy.ShapeAssetProp;
	import myLib.controls.ICellRenderer;
	import myLib.controls.ListCell;
	import myLib.controls.ScrollBar;
	import myLib.controls.skins.IButtonSkin;
	import myLib.controls.skins.IListSkin;
	import myLib.controls.skins.ISkin;
	import myLib.core.IScroll;
	import myLib.styles.Padding;
	import myLib.utils.ClassUtils;

	import flash.filters.DropShadowFilter;


	/**
	 * @author SamYStudiO ( contact@samystudio.net )
	 */
	public class GlossyListSkin extends AGlossyFieldSkin implements IListSkin
	{
		/**
		 * 
		 */
		public function GlossyListSkin( mainColor : uint , alternativeColor : uint , stateColor : uint , cornerRadius : Number , shadowFilter : DropShadowFilter = null , innerShadowFilter : DropShadowFilter = null )
		{
			super( mainColor , alternativeColor , stateColor , cornerRadius , shadowFilter , innerShadowFilter );
		}

		/**
		 * @inheritDoc
		 */
		public function getBackgroundAsset() : IAsset
		{
			return new BoxAsset( new ShapeAssetProp( _mainColor , _alternativeColor , _stateColor , _cornerRadius , null ) );
		}

		/**
		 * @inheritDoc
		 */
		public function getBackgroundDisabledAsset() : IAsset
		{
			return new BoxAsset( new ShapeAssetProp( _mainColor , _alternativeColor , _stateColor , _cornerRadius , null ) );
		}

		/**
		 * @inheritDoc
		 */
		public function getBorderAsset() : IAsset
		{
			var filter1 : DropShadowFilter = _shadowFilter.clone() as DropShadowFilter;
			var filter2 : DropShadowFilter = _innerShadowFilter.clone() as DropShadowFilter;
			filter2.knockout = true;
			
			return new BoxAsset( new ShapeAssetProp( _mainColor , _alternativeColor , _stateColor , _cornerRadius , [ filter1 , filter2 ] ) );
		}

		/**
		 * @inheritDoc
		 */
		public function getBorderDisabledAsset() : IAsset
		{
			var filter : DropShadowFilter = _innerShadowFilter.clone() as DropShadowFilter;
			filter.knockout = true;
			
			return new BoxAsset( new ShapeAssetProp( _mainColor , _alternativeColor , _stateColor , _cornerRadius , [ filter ] ) );
		}
		
		/**
		 * @inheritDoc
		 */
		public function getScrollAsset( definition : * = null ) : IScroll
		{
			if( definition == null || definition == ScrollBar || ( definition is String && ClassUtils.getClassByName( definition ) ) == ScrollBar )
				return new ScrollBar( null , null , new GlossyInnerScrollBarSkin( _mainColor , _alternativeColor , _stateColor , _cornerRadius , _shadowFilter ) );
			
			var scroll : IScroll;
			
			try
			{
				if( definition is String )
					scroll = ClassUtils.getInstance( ClassUtils.getClassByName( definition ) ) as IScroll;
				else
					scroll = ClassUtils.getInstance( definition ) as IScroll;
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
			if( definition == null || definition == ListCell || ( definition is String && ClassUtils.getClassByName( definition ) == ListCell ) )
				return new ListCell( null , null , skin == null ? new GlossyListCellSkin( _mainColor , _alternativeColor , _stateColor , 0 , null ) : skin as IButtonSkin );
			
			var cell : ICellRenderer;
			
			if( definition is String )
				cell = ClassUtils.getInstance( ClassUtils.getClassByName( definition ) ) as ICellRenderer;
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
			return { contentPadding : new Padding( 0 , 0 , 0 , 0 ) , borderThickness : 0 , contentMaskCornerRadius : _cornerRadius / 2 , cellHeight : 40 };
		}
	}
}
