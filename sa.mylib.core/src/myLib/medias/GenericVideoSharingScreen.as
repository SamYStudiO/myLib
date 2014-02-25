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
package myLib.medias
{
	import myLib.displayUtils.cleanContainer;
	import flash.display.DisplayObject;
	import myLib.assets.Asset;
	import myLib.displayUtils.USE_PIXEL_SNAPPING;

	/**
	 * @author SamYStudiO ( contact@samystudio.net )
	 * 
	 * @private
	 */
	public class GenericVideoSharingScreen extends Asset
	{
		/**
		 * @private
		 */
		protected var _screen : Object;
		
		/**
		 *
		 */
		public function get screen() : Object
		{
			return _screen;
		}
		
		public function set screen( screen : Object ) : void
		{
			_screen = screen;
			
			cleanContainer( this );
			
			if( _screen is  DisplayObject ) addChild( _screen as DisplayObject );
		}
		
		/**
		 * 
		 */
		public function GenericVideoSharingScreen( screen : Object = null )
		{
			this.screen = screen;
		}
		
		/**
		 * @inheritDoc
		 */
		public override function draw(  ) : void
		{
			if( _screen != null && _screen.hasOwnProperty( "setSize" ) )  _screen.setSize( USE_PIXEL_SNAPPING ? Math.round( _width ) : _width , USE_PIXEL_SNAPPING ? Math.round( _height ) : _height );
		}
	}
}
