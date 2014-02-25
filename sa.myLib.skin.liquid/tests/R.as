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
package
{
	import flash.display.BitmapData;
	/**
	 * @author SamYStudiO ( contact@samystudio.net )
	 */
	public final class R
	{
		[Embed(source="Liquid_focusRect.png")]
		/**
		 * 
		 */
		private static const _SkinFocusRectBitmap : Class;
		public static const skinFocusRectBitmap : BitmapData = new _SkinFocusRectBitmap( ).bitmapData;
		
		[Embed(source="LiquidButton_back.png")]
		/**
		 * 
		 */
		private static const _SkinButtonBitmap : Class;
		public static const skinButtonBitmap : BitmapData = new _SkinButtonBitmap( ).bitmapData;
		
		[Embed(source="LiquidCheckBox_icon.png")]
		/**
		 * 
		 */
		private static const _SkinCheckBitmap : Class;
		public static const skinCheckBitmap : BitmapData = new _SkinCheckBitmap( ).bitmapData;
		
		[Embed(source="LiquidComboBox_back.png")]
		/**
		 * 
		 */
		private static const _SkinComboBitmap : Class;
		public static const skinComboBitmap : BitmapData = new _SkinComboBitmap( ).bitmapData;
		
		[Embed(source="LiquidList_back.png")]
		/**
		 * 
		 */
		private static const _SkinListBitmap : Class;
		public static const skinListBitmap : BitmapData = new _SkinListBitmap( ).bitmapData;
		
		[Embed(source="LiquidList_cell.png")]
		/**
		 * 
		 */
		private static const _SkinListCellBitmap : Class;
		public static const skinListCellBitmap : BitmapData = new _SkinListCellBitmap( ).bitmapData;
		
		[Embed(source="LiquidRadioButton_icon.png")]
		/**
		 * 
		 */
		private static const _SkinRadioBitmap : Class;
		public static const skinRadioBitmap : BitmapData = new _SkinRadioBitmap( ).bitmapData;
		
		[Embed(source="LiquidScrollBar_arrow.png")]
		/**
		 * 
		 */
		private static const _SkinScrollArrowBitmap : Class;
		public static const skinScrollArrowBitmap : BitmapData = new _SkinScrollArrowBitmap( ).bitmapData;
		
		[Embed(source="LiquidScrollBar_icons.png")]
		/**
		 * 
		 */
		private static const _SkinScrollIconsBitmap : Class;
		public static const skinScrollIconsBitmap : BitmapData = new _SkinScrollIconsBitmap( ).bitmapData;
		
		[Embed(source="LiquidScrollBar_thumb.png")]
		/**
		 * 
		 */
		private static const _SkinScrollThumbBitmap : Class;
		public static const skinScrollThumbBitmap : BitmapData = new _SkinScrollThumbBitmap( ).bitmapData;
		
		[Embed(source="LiquidScrollBar_track.png")]
		/**
		 * 
		 */
		private static const _SkinScrollTrackBitmap : Class;
		public static const skinScrollTrackBitmap : BitmapData = new _SkinScrollTrackBitmap( ).bitmapData;
		
		[Embed(source="LiquidTextInput_back.png")]
		/**
		 * 
		 */
		private static const _SkinTextInputBitmap : Class;
		public static const skinTextInputBitmap : BitmapData = new _SkinTextInputBitmap( ).bitmapData;
		
		[Embed(source="LiquidTouchScroll_thumb.png")]
		/**
		 * 
		 */
		private static const _SkinTouchScrollBitmap : Class;
		public static const skinTouchScrollBitmap : BitmapData = new _SkinTouchScrollBitmap( ).bitmapData;
		
		/**
		 * @private
		 */
		public function R()
		{
			throw new Error( this + " cannot be instantiated" );
		}
	}
}
