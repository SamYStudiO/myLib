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
package myLib.medias
{
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.media.StageVideo;
	import flash.media.Video;

	/**
	 * @author SamYStudiO ( contact@samystudio.net )
	 */
	public class VideoScreen
	{
		/**
		 * @private
		 */
		protected var _view : *;

		/**
		 *
		 */
		public function get view() : *
		{
			return _view;
		}

		/**
		 *
		 */
		public function get displayObjectView() : DisplayObject
		{
			return _view as DisplayObject;
		}

		/**
		 *
		 */
		public function get loaderView() : Loader
		{
			return _view as Loader;
		}

		/**
		 *
		 */
		public function get videoView() : Video
		{
			return _view as Video;
		}

		/**
		 *
		 */
		public function get genericVideoSharingView() : GenericVideoSharingScreen
		{
			return _view as GenericVideoSharingScreen;
		}

		/**
		 *
		 */
		public function get stageVideoView() : StageVideo
		{
			return _view as StageVideo;
		}

		/**
		 * @private
		 */
		protected var _x : Number = 0;

		/**
		 *
		 */
		public function get x() : Number
		{
			return _x;
		}

		/**
		 * @private
		 */
		protected var _y : Number = 0;

		/**
		 *
		 */
		public function get y() : Number
		{
			return _y;
		}

		/**
		 * @private
		 */
		protected var _width : Number = 0;

		/**
		 *
		 */
		public function get width() : Number
		{
			return _width;
		}

		/**
		 * @private
		 */
		protected var _height : Number = 0;

		/**
		 *
		 */
		public function get height() : Number
		{
			return _height;
		}

		/**
		 * @private
		 */
		protected var _viewport : Rectangle;

		/**
		 *
		 */
		public function get viewport() : Rectangle
		{
			return _viewport;
		}

		/**
		 * @private
		 */
		protected var _pan : Point = new Point( 0 , 0 );

		/**
		 *
		 */
		public function get pan() : Point
		{
			return _pan;
		}

		public function set pan( p : Point ) : void
		{
			_pan = p;

			var rx : Number = ( viewport.width - width ) / 2;
			var ry : Number = ( viewport.height - height ) / 2;

			_x = rx - rx * _pan.x;
			_y = ry - ry * _pan.y;

			if( displayObjectView != null )
			{
				displayObjectView.x = Math.round( _x );
				displayObjectView.y = Math.round( _y );
			}
			else if( stageVideoView != null ) stageVideoView.pan = p;
		}

		/**
		 *
		 */
		public function VideoScreen( view : * )
		{
			_view = view;
		}

		/**
		 *
		 */
		public function setSize( width : Number , height : Number , viewport : Rectangle = null ) : void
		{
			var rx : Number = ( viewport.width - width ) / 2;
			var ry : Number = ( viewport.height - height ) / 2;
			_x = rx - rx * _pan.x;
			_y = ry - ry * _pan.y;
			_width = width;
			_height = height;
			_viewport = viewport;

			if( _view is DisplayObject )
			{
				displayObjectView.x = Math.round( _x );
				displayObjectView.y = Math.round( _y );
				displayObjectView.width = width;
				displayObjectView.height = height;
			}

			if( _view is StageVideo )
			{
				rx = _width / _viewport.width;
				ry = _height / _viewport.height;

				if( rx < 1 || ry < 1 )
				{
					var r : Rectangle = new Rectangle();
					r.x = _viewport.x + _x;
					r.y = _viewport.y + _y;
					r.width = _width;
					r.height = _height;
					stageVideoView.viewPort = r;
					stageVideoView.zoom = new Point( 1 , 1 );
				}
				else
				{
					stageVideoView.viewPort = viewport;
					stageVideoView.zoom = new Point( rx , ry );
				}
			}
		}
	}
}
