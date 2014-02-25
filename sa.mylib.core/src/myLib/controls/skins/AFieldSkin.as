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
package myLib.controls.skins 
{
	import myLib.assets.IAsset;

	import flash.utils.getQualifiedClassName;
	/**
	 * ASkin is the abstract base class for all default component skins.
	 * You should inherit it to make your own skin.
	 * 
	 * @author SamYStudiO ( contact@samystudio.net )
	 */
	public class AFieldSkin extends ASkin
	{
		/**
		 * Get or set the focus rectangle asset string definition, BitmapData object or external URL.
		 */
		public var focusRect : *;
		
		
		/**
		 * Get or set the error rectangle asset string definition, BitmapData object or external URL.
		 */
		public var errorRect : *;

		/**
		 * @private
		 */
		public function AFieldSkin()
		{
			if( getQualifiedClassName( this ) == "myLib.controls.skins::AFieldSkin" )
				throw new Error( this + " Abstract class cannot be instantiated" );
		}
		
		/**
		 * @inheritDoc
		 */
		public function getFocusRectAsset(  ) : IAsset
		{
			return _getAsset( focusRect );
		}
		
		/**
		 * @inheritDoc
		 */
		public function getErrorRectAsset(  ) : IAsset
		{
			return _getAsset( errorRect );
		}
	}
}