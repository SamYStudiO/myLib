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
package myLib.core
{
	import myLib.assets.IAsset;
	import myLib.controls.skins.IFieldSkin;
	import myLib.controls.skins.ISkin;
	import myLib.events.ComponentEvent;
	import myLib.form.IField;
	import myLib.styles.Padding;
	import myLib.utils.NumberUtils;

	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import flash.utils.getQualifiedClassName;

	/**
	 * @author SamYStudiO ( contact@samystudio.net )
	 */
	public class AFieldComponent extends AComponent implements IField
	{
		/**
		 * @private
		 */
		protected var _isErrorDrawn : Boolean;
		
		/**
		 * @private
		 */
		protected var _variableName : String;
		
		/**
		 * @inheritDoc
		 */
		public function get variableName() : String
		{
			return _variableName;
		}
		
		public function set variableName( name : String ) : void
		{
			_variableName = name;
		}

		/**
		 * @private
		 */
		protected var _required : *;
		
		/**
		 * @inheritDoc
		 */
		public function get required() : *
		{
			return _required;
		}
		
		public function set required( b : * ) : void
		{
			_required = b != null ? Boolean( b ) : null;
		}

		/**
		 * @private
		 */
		protected var _validators : *;
		
		/**
		 * @inheritDoc
		 */
		public function get validators() : *
		{
			return _validators;
		}
		
		public function set validators( validators : * ) : void
		{
			_validators = validators;
		}
		
		/**
		 * @private
		 */
		protected var _errorRectPadding : Padding = new Padding( 0 , 0 , 0 , 0 );
		
		/**
		 * @inheritDoc
		 */	
		public function get errorRectPadding() : Padding
		{
			_errorRectPadding = _errorRectPadding == null ? new Padding( 0 , 0 , 0 , 0 ) : _errorRectPadding;
			
			return _errorRectPadding;
		}
		
		public function set errorRectPadding( padding : Padding ) : void
		{
			_errorRectPadding = padding;
			
			if( _isErrorDrawn ) 
			{
				_isErrorDrawn = false;
				drawFocus( true );
			}
		}
		
		/**
		 * @private
		 */
		protected var _errorRectTarget : IAsset;
		
		/**
		 * @inheritDoc
		 */	
		public function get errorRectTarget() : IAsset
		{
			_errorRectTarget = _errorRectTarget == null ? this : _errorRectTarget;
			
			return _errorRectTarget;
		}
		
		public function set errorRectTarget( asset : IAsset ) : void
		{
			_errorRectTarget = asset;
			
			if( _isErrorDrawn ) 
			{
				_isErrorDrawn = false;
				drawError( true );
			}
		}
		
		/**
		 * @private
		 */
		protected var _errorRectDepth : int = -1;
		
		/**
		 * @inheritDoc
		 */
		public function get errorRectDepth() : int
		{
			return _errorRectDepth;
		}
		
		public function set errorRectDepth( n : int ) : void
		{
			_errorRectDepth = NumberUtils.clamp( n , -1 );
			
			if( _isErrorDrawn ) 
			{
				_isErrorDrawn = false;
				drawError( true );
			}
		}
		
		/**
		 * @private
		 */
		protected var _errorRectAsset : IAsset;
		
		/**
		 * @inheritDoc
		 */
		public function get errorRectAsset() : IAsset
		{
			return _errorRectAsset;
		}
		
		/**
		 * 
		 */
		public function AFieldComponent( parentContainer : DisplayObjectContainer = null , initStyle : Object = null , skin : ISkin = null )
		{
			super( parentContainer , initStyle , skin );
			
			if( getQualifiedClassName( this ) == "myLib.core::AFieldComponent" )
				throw new Error( this + " Abstract class cannot be instantiated" );
		}
		
		/**
		 * @inheritDoc
		 */
		public function drawError( b : Boolean ) : void
		{
			if( _isErrorDrawn == b || parent is AComponent ) return;
			
			_isErrorDrawn = b;
			
			if( _errorRectAsset != null && contains( _errorRectAsset as DisplayObject ) )
				removeChild( _errorRectAsset as DisplayObject );
			
			_errorRectAsset = null;
			
			if( b && _skin != null )
			{
				_errorRectAsset = ( _skin as IFieldSkin ).getErrorRectAsset();
				
				if( _errorRectAsset != null )
				{
					var errorPadding : Padding = errorRectPadding;
					var errorTarget : IAsset = errorRectTarget;
					
					_errorRectAsset.x = ( errorTarget == this ? 0 : errorTarget.x ) - errorPadding.left;
					_errorRectAsset.y = ( errorTarget == this ? 0 : errorTarget.y ) - errorPadding.top;
					
					_errorRectAsset.setSize( 	errorTarget.width + errorPadding.left + errorPadding.right ,
												errorTarget.height + errorPadding.top + errorPadding.bottom );
					_errorRectAsset.draw();
					
					if( _errorRectDepth >= 0 ) addChildAt( _errorRectAsset  as DisplayObject , _errorRectDepth );
					else addChild( _errorRectAsset  as DisplayObject );
				}
			}
		}
		
		/**
		 * @inheritDoc
		 */
		public function getValue() : *
		{
		}

		/**
		 * @inheritDoc
		 */
		public function setValue( value : * ) : void
		{
		}
		
		/**
		 *
		 */
		protected override function _render( e : Event = null ) : void
		{
			if( !_invalidation.isActive() ) return;
			
			// TODO cannot remove listener at the moment > stage invalidate issue!
			//removeEventListener( Event.RENDER , _render );
			
			_draw();
			
			if( _isFocused )
			{
				_isFocused = false;
				drawFocus( true );
			}
			
			if( _isErrorDrawn )
			{
				_isErrorDrawn = false;
				drawError( true );
			}
			_invalidation.removeAllTypes();
			_isInitialized = true;
			
			dispatchEvent( new ComponentEvent( ComponentEvent.DRAW ) );
		}
	}
}
