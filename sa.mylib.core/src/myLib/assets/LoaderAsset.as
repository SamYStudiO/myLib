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
	import myLib.core.IComponent;
	import myLib.core.InvalidationType;

	import flash.display.Loader;
	import flash.events.Event;
	import flash.net.URLRequest;
	import flash.system.LoaderContext;
	/**
	 * The LoaderAsset class is used to build asset using external files such bitmap files or swf movies.
	 * 
	 * @author SamYStudiO ( contact@samystudio.net )
	 */
	public class LoaderAsset extends Asset 
	{
		/**
		 * @private
		 */
		protected var _loader : Loader = new Loader();
		
		/**
		 * @inheritDoc
		 */
		public override function get scaleX() : Number
		{
			return _loader.content == null ? 1 : _width / _originWidth;
		}
		
		public override function set scaleX( scale : Number ) : void
		{
			if( _loader.content != null )
				setSize( _originWidth * scale , _height );
		}

		/**
		 * @inheritDoc
		 */	 
		public override function get scaleY() : Number
		{
			return _loader.content == null ? 1 : _height / _originHeight;
		}
		
		public override function set scaleY( scale : Number ) : void
		{
			if( _loader.content != null )
				setSize( _width , _originHeight * scale );
		}
		
		/**
		 * Build new LoaderAsset instance.
		 * 
		 * @param url Asset url.
		 * @param context The optional LoaderContext to use with load operation.
		 */
		public function LoaderAsset ( url : String , context : LoaderContext = null )
		{
			_loader.contentLoaderInfo.addEventListener( Event.COMPLETE , _loaded , false , 0 , true );
			_loader.load( new URLRequest( url ) , context );
		}
		
		/**
		 * @inheritDoc
		 */
		public override function draw(  ) : void
		{
			if( _loader.content == null ) return;
			
			super.draw();
		}
		
		/**
		 * @private
		 */
		protected function _loaded( e : Event ) : void
		{
			_originWidth = _loader.width;
			_originHeight = _loader.height;
			
			if( _width == 0 )
			{
				_width = _originWidth;				_height = _originHeight;
			}
			
			addChild( _loader );
			
			draw();
			
			if( parent is IComponent ) ( parent as IComponent ).validate( InvalidationType.SIZE );
		}
	}
}
