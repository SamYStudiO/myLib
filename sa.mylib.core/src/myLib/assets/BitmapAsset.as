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
package myLib.assets 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;	
	/**
	 * The BitmapAsset class is a simple Asset object with only one children create with a BitmapData.
	 * All components object can recieve skin with BitmapData references.
	 * 
	 * @author SamYStudiO ( contact@samystudio.net )
	 */
	public class BitmapAsset extends Asset 
	{
		/**
		 * @private
		 */
		protected var _bitmap : Bitmap;
		
		/**
		 * @private
		 */
		protected var _bitmapData : BitmapData;
		
		/**
		 *
		 */
		public function get bitmapData() : BitmapData
		{
			return _bitmap.bitmapData;
		}
		
		/**
		 *
		 */
		public function get smoothing() : Boolean
		{
			return _bitmap.smoothing;
		}
		
		public function set smoothing( b : Boolean ) : void
		{
			_bitmap.smoothing = b;
		}
		
		/**
		 * Build a new BitmapAsset instance.
		 * 
		 * @param bitmapData The BitmapData added as a children Bitmap object with this BitmapAsset instance.
		 */
		public function BitmapAsset( bitmapData : BitmapData )
		{
			_bitmap = new Bitmap( bitmapData );
			
			addChild( _bitmap );
			
			super();
		}
	}
}
