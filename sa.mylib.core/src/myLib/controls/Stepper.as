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
package myLib.controls 
{
	import myLib.controls.skins.IStepperSkin;
	import myLib.core.AStepper;
	import myLib.core.InvalidationType;
	import myLib.data.CollectionEvent;
	import myLib.data.DataProvider;
	import myLib.data.ICollection;
	import myLib.events.ComponentEvent;

	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	
	/**
     * Defines the value of the type property of a valueChange event object.
     * 
     * @eventType valueChange
     */
    [Event(name="valueChange", type="myLib.events.ComponentEvent")]
	
	/**
	 * @author SamYStudiO
	 */
	public class Stepper extends AStepper implements IStepper
	{
		/**
		 * @private
		 */
		protected var _selectionLoop : Boolean;
		
		[Inspectable]
		/**
		 * @inheritDoc
		 */
		public function get selectionLoop() : Boolean
		{
			return _selectionLoop;
		}
		
		public function set selectionLoop( b : Boolean ) : void
		{
			if( _inspector && !_isLivePreview && _selectionLoop ) return;
			
			_selectionLoop = b;
		}
		
		/**
		 * @private
		 */
		protected var _dataProvider : ICollection;

		[Collection(collectionClass="myLib.data.DataProvider",collectionItem="myLib.data.DataProviderItem")]
		/**
		 * @inheritDoc
		 */
		public function get dataProvider () : ICollection
		{
			return _dataProvider;
		}
		
		public function set dataProvider ( dataProvider : ICollection ) : void
		{
			if( dataProvider == _dataProvider || ( _inspector && !_isLivePreview && !_dataProvider.isEmpty() ) ) return;	
			
			if( _dataProvider != null ) 
			{
				_dataProvider.removeEventListener( CollectionEvent.ADD , _modelChange );	
				_dataProvider.removeEventListener( CollectionEvent.REMOVE , _modelChange );	
				_dataProvider.removeEventListener( CollectionEvent.REPLACE , _modelChange );	
				_dataProvider.removeEventListener( CollectionEvent.CLEAR , _modelChange );	
				_dataProvider.removeEventListener( CollectionEvent.SORT , _modelChange );	
			}
			
			clearSelection();
			
			_dataProvider = dataProvider || new DataProvider( null );
			
			_dataProvider.addEventListener( CollectionEvent.ADD , _modelChange , false , 0 , true );	
			_dataProvider.addEventListener( CollectionEvent.REMOVE , _modelChange , false , 0 , true );	
			_dataProvider.addEventListener( CollectionEvent.REPLACE , _modelChange , false , 0 , true );	
			_dataProvider.addEventListener( CollectionEvent.CLEAR , _modelChange , false , 0 , true );	
			_dataProvider.addEventListener( CollectionEvent.SORT , _modelChange , false , 0 , true );	
			
			invalidate( InvalidationType.DATA );
		}
		
		/**
		 * @private
		 */
		protected var _labelField : String = "label";
		
		[Inspectable(defaultValue="label")] 
		/**
		 * @inheritDoc
		 */
		public function get labelField() : String
		{
			return _labelField;
		}
		
		public function set labelField( s : String ) : void
		{
			if( _inspector && !_isLivePreview && _labelField != "label" ) return;
			
			_labelField = s;
			
			invalidate( InvalidationType.DATA );
		}
		
		/**
		 * @private
		 */
		protected var _dataField : String = "data";
		
		[Inspectable(defaultValue="data")] 
		/**
		 * @inheritDoc
		 */
		public function get dataField() : String
		{
			return _dataField;
		}
		
		public function set dataField( s : String ) : void
		{
			if( _inspector && !_isLivePreview && _dataField != "data" ) return;
			
			_dataField = s;
		}
		
		/**
		 * @private
		 */
		protected var _iconField : String = "icon";

		[Inspectable(defaultValue="icon")] 
		/**
		 * @inheritDoc
		 */
		public function get iconField() : String
		{
			return _iconField;
		}
		
		public function set iconField( s : String ) : void
		{
			if( _inspector && !_isLivePreview && _iconField != "icon" ) return;
			
			_iconField = s;
			
			invalidate( InvalidationType.DATA );
		}
		
		/**
		 * @private
		 */
		protected var _selectedIndex : int = -1;
		
		/**
		 * @inheritDoc
		 */
		public function get selectedIndex() : int
		{
			return _selectedIndex;
		}
		
		public function set selectedIndex( index : int ) : void
		{
			var oldIndex : int = _selectedIndex;
			
			_selectedIndex = index >= 0 && index < _dataProvider.length ? index : -1;
			_selectedItem = _dataProvider.getItemAt( _selectedIndex );
			
			if( _selectedIndex == oldIndex ) return;
			
			_refreshSelection();
		}
		
		/**
		 * @private
		 */
		protected var _selectedItem : *;
		
		/**
		 * @inheritDoc
		 */
		public function get selectedItem() : *
		{
			return _selectedItem;
		}
		
		public function set selectedItem( item : * ) : void
		{
			selectedIndex = _dataProvider.getItemIndex( item );
		}
		
		/**
		 * @private
		 */
		protected var _selectedData : *;
		
		/**
		 * @inheritDoc
		 */
		public function get selectedData() : *
		{
			return _selectedData;
		}
		
		public function set selectedData( data : * ) : void
		{
			selectedIndex = _dataProvider.getItemIndex( _dataProvider.getItemFrom( _dataField , data ) );
		}

		/**
		 * Build a new Stepper instance. Default size is 100*20.
		 * @param parentContainer The parent DisplayObjectContainer where add this Stepper.
		 * @param initStyle The initial style object for Stepper initialization.
		 * @param skin The IStepperSkin to use instead of default skin.
		 * 
		 * @see myLib.styles.StyleManager
		 */
		public function Stepper( parentContainer : DisplayObjectContainer = null , initStyle : Object = null , skin : IStepperSkin = null )
		{
			super( parentContainer , initStyle , skin );
		}

		/**
		 * @inheritDoc
		 */
		public function clearSelection(  ) : void
		{
			var change : Boolean = _selectedIndex != -1;
			
			_selectedIndex = -1;
			_selectedItem = null;			_selectedData = null;
			
			if( change ) _refreshSelection();
		}
		
		/**
		 * @inheritDoc
		 */
		public override function getValue(  ) : *
		{
			return _selectedItem != null ? _selectedItem[ _dataField ] : _textInput.text;
		}
		
		/**
		 * @inheritDoc
		 */
		public override function setValue( value : * ) : void
		{
			var item : * = _dataProvider.getItemFrom( _dataField , value );
			
			if( item != null )
			{
				selectedIndex = _dataProvider.getItemIndex( item );
				
				return;
			}
			
			switch( true )
			{
				case value is Number : selectedIndex = uint( value ); break;
				case value is String : _textInput.text = value as String; break;
				
				default : selectedIndex = -1;
			}
		}
		
		/**
		 * @private
		 */
		protected override function _init(  ) : void
		{
			super._init();
			
			_dataProvider = _dataProvider == null ? new DataProvider( null ) : _dataProvider;
		}
		
		/**
		 * @private
		 */
		protected override function _next( e : Event = null ) : void
		{			if( !_selectionLoop && _invertNextPrevious && _selectedIndex == 0 ) return;
			if( !_selectionLoop && !_invertNextPrevious && _selectedIndex == _dataProvider.length - 1 ) return;
			
			if( _invertNextPrevious ) selectedIndex = _selectedIndex == -1 || _selectedIndex == 0 ? _dataProvider.length - 1 : _selectedIndex - 1;
			else selectedIndex = _selectedIndex == -1 || _selectedIndex == _dataProvider.length - 1 ? 0 : _selectedIndex + 1;
			
			super._next( e );
		}

		/**
		 * @private
		 */
		protected override function _previous( e : Event = null ) : void
		{
			if( !_selectionLoop && !_invertNextPrevious && _selectedIndex == 0 ) return;
			if( !_selectionLoop && _invertNextPrevious && _selectedIndex == _dataProvider.length - 1 ) return;
			
			if( _invertNextPrevious ) selectedIndex = _selectedIndex == -1 || _selectedIndex == _dataProvider.length - 1 ? 0 : _selectedIndex + 1;
			else selectedIndex = _selectedIndex == -1 || _selectedIndex == 0 ? _dataProvider.length - 1 : _selectedIndex - 1;
			
			super._previous( e );
		}
		
		/**
		 * @private
		 */
		protected function _modelChange( e : CollectionEvent ) : void
		{
			var type : String  = e.type;
			
			switch( true )
			{
				case type == CollectionEvent.CLEAR :
					
					clearSelection();
				
					break;
					
				case type == CollectionEvent.ADD :
					
					if( _selectedIndex >= e.fromIndex )
						_selectedIndex++;	
	
					break;
					
				case type == CollectionEvent.REMOVE :
					
					if( _selectedIndex > e.fromIndex )
						_selectedIndex--;
					else if( _selectedIndex == e.fromIndex )
						clearSelection();
					
					break;
				
				case type == CollectionEvent.REPLACE :
					
					if( _selectedItem == e.item )
						clearSelection();
					
					break;
				
				case type == CollectionEvent.SORT :
					
					_selectedIndex = _dataProvider.getItemIndex( _selectedItem );
					
					break;
			}
		}
		
		/**
		 * @private
		 */
		protected override function _labelChanged ( e : Event = null ) : void
		{
			clearSelection( );
		}
		
		/**
		 * @private
		 */
		protected function _refreshSelection(  ) : void
		{
			var item : * = _dataProvider.getItemAt( _selectedIndex );
			
			if( item != null )
			{
				_textInput.text = item[ _labelField ];
				_textInput.icon = item[ _iconField ];
			}
			else
			{
				_textInput.text = "";
				_textInput.icon = null;
			}
			
			dispatchEvent( new ComponentEvent( ComponentEvent.VALUE_CHANGE ) );
		}
		
		/**
		 * @private
		 */
		protected override function _keyDown( e : KeyboardEvent ) : void
		{
			switch( true ) 
			{
				case e.keyCode == Keyboard.HOME : selectedIndex = 0; break;
				case e.keyCode == Keyboard.END : selectedIndex = _dataProvider.length; break;
				
				default : super._keyDown( e );
			}
		}
	}
}
