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
package myLib.displayUtils
{
	import myLib.assets.IAsset;
	import myLib.display.IFocusable;

	import flash.display.DisplayObjectContainer;
	import flash.display.InteractiveObject;
	import flash.display.SimpleButton;
	import flash.display.Stage;
	import flash.display.StageDisplayState;
	import flash.events.FocusEvent;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.ui.Keyboard;
	/**
	 * @author SamYStudiO
	 */
	public final class FocusManager
	{
		/**
		 *
		 */
		private static var __instance : FocusManager = new FocusManager();
		
		/**
		 *
		 */
		private var _oldFocusRect : Boolean;
		
		/**
		 *
		 */
		private var _initialized : Boolean;
		
		/**
		 *
		 */
		private var _stage : Stage;
		
		/**
		 *
		 */
		private var _lastFocusChangeType : String;
		
		/**
		 * get or set a boolean that indicates if fullscreen is removed automatically when user enter an editable textfield. This can be useful since editable textfield cannot be edit in fullscreen mode.
		 * 
		 * @default true
		 */
		public static var AUTO_MANAGE_FULLSCREEN : Boolean = true;

		/**
		 *
		 */
		private var _currentFocusedGroup : FocusGroup;
		
		/**
		 * Get the current active FocusGroup.
		 */
		public function get currentFocusedGroup (  ) : FocusGroup
		{
			return _currentFocusedGroup;
		}
		
		/**
		 *
		 */
		private var _currentFocusedObject : InteractiveObject;
		
		/**
		 * Get the current focuses object.
		 */
		public function get currentFocusedObject(  ) : InteractiveObject
		{
			return _currentFocusedObject;
		}
		
		/**
		 * @private
		 */
		protected var _enabled : Boolean = true;
		
		/**
		 * Get or set a Boolean that indicates if FocusManager is active.
		 * Although this is not recommended, you may disabled FocusManager.
		 * 
		 * @default true
		 */
		public function get enabled() : Boolean
		{
			return _enabled;
		}
		
		public function set enabled( b : Boolean ) : void
		{
			_enabled = b;
			
			if( _stage )
			{
				if( b ) _addListeners();
				else _removeListeners();
			}
		}

		/**
		 * @private
		 */
		public function FocusManager()
		{
			if( __instance != null ) throw new Error( this + " Singleton instance can only be accessed through getInstance method" );
		}
		
		/**
		 * Get the unique FocusManager instance.
		 * 
		 * @return The FocusManager singleton instance.
		 */
		public static function getInstance() : FocusManager
		{
			return __instance;
		}
		
		/**
		 *
		 */
		public function tabGroup( group : FocusGroup , backward : Boolean = false ) : void
		{
			var current : InteractiveObject = group.contains( _currentFocusedObject ) ? _currentFocusedObject : null;
			
			var o : InteractiveObject = _getNextValidFocusableFromGroup( group , current , backward );
			
			if( o is IFocusable ) ( o as IFocusable ).setFocus();
			else _stage.focus = o;
		}

		/**
		 * @private
		 */
		internal function initStage( stage : Stage ) : void
		{
			if( _initialized ) return;
			
			_oldFocusRect = stage.stageFocusRect;
			_stage = stage;
			
			_initialized = true;
			
			if( _enabled ) _addListeners();
		}
		
		/**
		 *
		 */
		private function _addListeners(  ) : void
		{
			_stage.addEventListener( FocusEvent.MOUSE_FOCUS_CHANGE , _mouseFocusChanged , false , 9999 , true );
			_stage.addEventListener( FocusEvent.KEY_FOCUS_CHANGE , _keyFocusChanged , false , 9999 , true );
			_stage.addEventListener( MouseEvent.MOUSE_DOWN , _mouseDown , false , 9999 , true );
			_stage.addEventListener( FocusEvent.FOCUS_IN , _focusIn , false , 9999 , true );
			_stage.addEventListener( FocusEvent.FOCUS_OUT , _focusOut , false , 9999 , true );
			
			_stage.stageFocusRect = false;
		}
		
		/**
		 *
		 */
		private function _removeListeners(  ) : void
		{
			_stage.removeEventListener( FocusEvent.MOUSE_FOCUS_CHANGE , _mouseFocusChanged );
			_stage.removeEventListener( FocusEvent.KEY_FOCUS_CHANGE , _keyFocusChanged );
			_stage.removeEventListener( MouseEvent.MOUSE_DOWN , _mouseDown );
			_stage.removeEventListener( FocusEvent.FOCUS_IN , _focusIn );
			_stage.removeEventListener( FocusEvent.FOCUS_OUT , _focusOut );
			
			_stage.stageFocusRect = _oldFocusRect;
		}
		
		/**
		 *
		 */
		private function _focusIn ( e : FocusEvent ) : void
		{
			var object : InteractiveObject = _getTopTarget( e.target  as InteractiveObject );
			var focusable : IFocusable = object as IFocusable;
			
			_currentFocusedObject = focusable != null ? focusable.focusDrawTarget as InteractiveObject : object; 
			
			var focusGroup : FocusGroup = FocusGroup.getGroupFromFocusable( _currentFocusedObject );
			
			if( focusGroup != null ) _currentFocusedGroup = focusGroup;
			
			if( focusable != null && ( _currentFocusedGroup == null || _currentFocusedGroup.showFocusIndicator ) &&
				( 	( _lastFocusChangeType == FocusEvent.KEY_FOCUS_CHANGE && focusable.showTabFocusChangeIndicator ) ||
					( _lastFocusChangeType == FocusEvent.MOUSE_FOCUS_CHANGE && focusable.showMouseFocusChangeIndicator ) ) )
			{
				focusable.focusDrawTarget.drawFocus( true );
			}
			
			if( _stage.focus is TextField && ( _stage.focus as TextField ).type == TextFieldType.INPUT
				&& AUTO_MANAGE_FULLSCREEN && _stage.displayState == StageDisplayState.FULL_SCREEN )
			{
				_stage.displayState = StageDisplayState.NORMAL;
			}
		} 
		
		/**
		 *
		 */
		private function _focusOut ( e : FocusEvent ) : void
		{
			var object : InteractiveObject = _getTopTarget( e.target  as InteractiveObject );
			var focusable : IFocusable = object as IFocusable;
			var relatedObject : InteractiveObject = _getTopTarget( e.relatedObject  as InteractiveObject );
			var relatedFocusabled : IFocusable = relatedObject as IFocusable;
			
			if( focusable == relatedObject ) return;
			
			if( focusable != null && ( relatedFocusabled == null || ( relatedFocusabled != focusable.focusDrawTarget && relatedFocusabled.focusDrawTarget != focusable ) ) )
			{
				focusable.focusDrawTarget.drawFocus( false );
				
				_currentFocusedObject = null;
			}
		} 
		
		/**
		 *
		 */
		private function _mouseFocusChanged( e : FocusEvent ) : void
		{
			_lastFocusChangeType = FocusEvent.MOUSE_FOCUS_CHANGE;
			
			if( !( e.relatedObject is TextField ) ) e.preventDefault();
		}
		
		/**
		 *
		 */
		private function _mouseDown( e : MouseEvent ) : void
		{
			var object : InteractiveObject = _getTopTarget( e.target as InteractiveObject );
			var focusable : IFocusable = object as IFocusable;
			
			if( focusable != null ) focusable.setFocus();
			else _stage.focus = object;
		}

		/**
		 *
		 */
		private function _keyFocusChanged( e : FocusEvent ) : void
		{
			var object : InteractiveObject = _getTopTarget( e.relatedObject as InteractiveObject );
			
			_lastFocusChangeType = FocusEvent.KEY_FOCUS_CHANGE;
			
			_currentFocusedGroup = _getCurrentFocusedGroup();
			
			if( e.keyCode == Keyboard.TAB && _currentFocusedGroup != null )
			{
				object = _getTopTarget( _getNextValidFocusableFromGroup( _currentFocusedGroup , _currentFocusedObject , e.shiftKey ) );
				
				if( object is IFocusable ) ( object as IFocusable ).setFocus();
				else _stage.focus = object;
				
				e.preventDefault();
				
				return;
			}
			
			if( object.tabIndex == -1 )
			{
				e.preventDefault();
			}
		}
		
		/**
		 *
		 */
		private function _getCurrentFocusedGroup (  ) : FocusGroup
		{
			if( _currentFocusedGroup != null && _currentFocusedGroup.tabEnabled ) return _currentFocusedGroup;
			
			var a : Array = FocusGroup.getGroups();
			var i : int = a.length;
			
			while( --i >= 0 ) 
			{
				var group : FocusGroup = a[ i ] as FocusGroup;
				
				if( group.tabEnabled ) return group;
			}
			
			return null;
		}
		
		/**
		 *
		 */
		private function _getTopTarget ( object : InteractiveObject ) : InteractiveObject
		{
			var focusable : InteractiveObject = object;
			
			while( focusable != null && !_isValidFocusable( focusable ) && focusable != _stage )
			{
				focusable = focusable.parent;
			}
			
			return focusable == null || focusable == _stage ? object : focusable;
		}

		/**
		 *
		 */
		private function _getNextValidFocusableFromGroup( group : FocusGroup , currentFocusable : InteractiveObject , shiftKey : Boolean ) : InteractiveObject
		{
			currentFocusable = currentFocusable == null ? shiftKey ? group.getItemAt( group.length - 1 ) : group.getItemAt( 0 ) : currentFocusable;
			var focusable : InteractiveObject = shiftKey ? 	group.getPreviousFrom( currentFocusable ) : group.getNextFrom( currentFocusable );

			while( !_isValidTabFocusable( focusable ) )
			{
				focusable = shiftKey ? group.getPreviousFrom( focusable ) : group.getNextFrom( focusable );
				
				if( focusable == currentFocusable ) break;
			}
			
			return focusable;
		}
		
		/**
		 *
		 */
		private function _isFocusEnabled ( o : InteractiveObject ) : Boolean
		{
			return !( o is IFocusable ) || ( ( o is IFocusable ) && ( o as IFocusable ).focusEnabled );
		}
		
		/**
		 *
		 */
		private function _isEnabled ( o : InteractiveObject ) : Boolean
		{
			return !( ( o is IAsset ) && !( o as IAsset ).enabled ) && !( ( o is SimpleButton ) && !( o as SimpleButton ).enabled );
		}
		
		/**
		 *
		 */
		private function _isValidFocusable ( o : InteractiveObject ) : Boolean
		{
			return o != null && _isFocusEnabled( o ) && _isEnabled( o ) && o.visible && o.tabIndex != -1;
		}
		
		/**
		 *
		 */
		private function _isValidTabFocusable ( o : InteractiveObject ) : Boolean
		{
			if( o == null || !o.tabEnabled ) return false;
			if( ( o is TextField ) && ( o as TextField ).type != TextFieldType.INPUT ) return false;
			
			var parent : DisplayObjectContainer = o.parent;
			
			while( parent && parent != _stage )
			{
				if( !parent.tabChildren ) return false;
				
				parent = parent.parent;	
			}
			
			return _isValidFocusable( o );
		}
	}
}
