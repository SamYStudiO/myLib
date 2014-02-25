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
package myLib.assets
{
	import myLib.displayUtils.USE_PIXEL_SNAPPING;

	import flash.display.DisplayObject;

	/**
	 * @author SamYStudiO ( contact@samystudio.net )
	 */
	public class ContainerAsset extends Asset
	{
		/**
		 * @private
		 */
		protected var _content : DisplayObject;
		
		/**
		 *
		 */
		public function get content() : DisplayObject
		{
			return _content;
		}
		
		/**
		 * 
		 */
		public function ContainerAsset( content : DisplayObject = null )
		{
			super();
			
			_content = content || getChildAt( 0 );
			
			if( _content != null )
			{
				if( !contains( _content ) ) addChild( _content );
				_width = _originWidth = _content.width;
				_height = _originHeight = _content.height;
			}
		}
		
		/**
		 * @inheritDoc
		 */
		public override function draw(  ) : void
		{
			if( _content != null )
			{
				_content.width = USE_PIXEL_SNAPPING ? Math.round( _width ) : _width;
				_content.height = USE_PIXEL_SNAPPING ? Math.round( _height ) : _height;
			}
			else super.draw();
		}
	}
}
