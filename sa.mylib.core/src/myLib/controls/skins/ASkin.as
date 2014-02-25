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
	import myLib.assets.ITextFieldAsset;
	import myLib.assets.getAsset;
	import myLib.assets.getTextFieldAsset;

	import flash.events.EventDispatcher;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	import flash.utils.getQualifiedClassName;
	/**
	 * ASkin is the abstract base class for all default component skins.
	 * You should inherit it to make your own skin.
	 * 
	 * @author SamYStudiO ( contact@samystudio.net )
	 */
	public class ASkin extends EventDispatcher
	{
		/**
		 * Get or set the applicationDomain where assets string definition can be retrieve.
		 */
		public var applicationDomain : ApplicationDomain;
		
		/**
		 * Get or set the LoaderContext object used with external assets which need load operation.
		 */
		public var loaderContext : LoaderContext;
		
		/**
		 * @private
		 */
		public function ASkin()
		{
			if( getQualifiedClassName( this ) == "myLib.controls.skins::ASkin" )
				throw new Error( this + " Abstract class cannot be instantiated" );
		}
		
		/**
		 * @inheritDoc
		 */
		public function getStyle(  ) : Object
		{
			return null;
		}
		
		/**
		 * @private
		 */
		protected function _getAsset( id : * ) : IAsset
		{
			return getAsset( id , applicationDomain , loaderContext );
		}
		
		/**
		 * @private
		 */
		protected function _getTextFieldAsset( id : * ) : ITextFieldAsset
		{
			return getTextFieldAsset( id , applicationDomain );
		}
	}
}
