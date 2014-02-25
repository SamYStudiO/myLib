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
package myLib.core {
	import myLib.core.AScroll;	import myLib.displayUtils.SizeManager;		import flash.display.DisplayObject;	import flash.display.DisplayObjectContainer;	import flash.events.MouseEvent;	import flash.filters.BlurFilter;	import flash.geom.Rectangle;	import flash.text.TextField;	import flash.utils.getQualifiedClassName;	
	/**
	 * AMouseScroll is the abstract base class for MouseScroll and PanoramaScroll component.
	 * 
	 * @author SamYStudiO ( contact@samystudio.net )
	 */
	public class AMouseScroll extends AScroll implements IAMouseScroll	{
		/**
		 *
		 */
		private var _tf : TextField;
		
		/**
		 * @private
		 */
		protected override function get _defaultHeight() : Number
		{
			return 100;	
		}
		
		/**
		 * @private
		 */
		public function AMouseScroll ( parentContainer : DisplayObjectContainer = null , initStyle : Object = null )		{
			super( parentContainer , initStyle );
			
			if( getQualifiedClassName( this ) == "myLib.core::AMouseScroll" )
				throw new Error( this + " Abstract class cannot be instantiated" );
		}
		
		/**
		 * @private
		 */
		protected override function _createChildren(  ) : void
		{
			if( _isLivePreview )
			{
				_tf = MyTextField.build();
				_tf.multiline = true;
				_tf.wordWrap = true;
				_tf.text = getQualifiedClassName( this ).split( "::" )[ 1 ] + "\nComponent";
				_tf.border = true;
				_tf.background = true;
				_tf.filters = [ new BlurFilter( 1 , 1 ) ];
				
				addChild( _tf );
			}
		}
		
		/**
		 * @private
		 */
		protected override function _draw(  ) : void
		{
			if( _isLivePreview )
			{
				if( _tf == null ) _createChildren();
				
				_tf.width = _horizontal ? _height - 1 : _width - 1;
				_tf.height = _horizontal ? _width - 1 : _height - 1;
			}
			else super._draw( );
		}
		
		/**
		 * @private
		 */
		protected override function _setScrollProperties () : void
		{	
			if( _scrollTarget == null ) return;
			
			if( _isScrollableTextField ) super._setScrollProperties();
			else
			{
				var targetSize : Rectangle = SizeManager.getScrollTargetContentSize( _scrollTarget );
				
				_newWidth = isNaN( _newWidth ) ? _horizontal ? targetSize.width : _width : _newWidth;
				_newHeight = isNaN( _newHeight ) ? _horizontal ? _width : targetSize.height : _newHeight;
				
				var size : Number = _horizontal ? _newWidth : _newHeight;
				
				_scrollTargetSize = isNaN( size ) ? _scrollTarget[ _propSize ] : size;
				_maxScroll = _scrollTargetSize - pageSize;
			}
		}
		
		/**
		 * @private
		 */
		protected override function _registerTarget( o : DisplayObject ) : void
		{
			super._registerTarget( o );
			
			o.addEventListener( MouseEvent.ROLL_OVER , _startTimer , false , 0 , true );			o.addEventListener( MouseEvent.ROLL_OUT , _stopTimer , false , 0 , true );
		}
		
		/**
		 * @private
		 */
		protected override function _removeRegisteredTarget( o : DisplayObject ) : void
		{
			super._removeRegisteredTarget( o );
			
			o.removeEventListener( MouseEvent.ROLL_OVER , _startTimer );			o.removeEventListener( MouseEvent.ROLL_OUT , _stopTimer );
		}
		
		/**
		 * @private
		 */
		protected function _startTimer ( e : MouseEvent ) : void
		{
			if( pageSize < _scrollTargetSize && _enabled ) _timer.start( );
		}
		
		/**
		 * @private
		 */
		protected function _stopTimer ( e : MouseEvent ) : void
		{
			_timer.stop( );
		}	}
}
