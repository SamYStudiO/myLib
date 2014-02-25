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
	import myLib.controls.skins.ITextAreaSkin;
	import myLib.controls.skins.my_skinset;
	import myLib.core.IScroll;
	import myLib.core.InvalidationType;
	import myLib.displayUtils.TextFieldGutter;
	import myLib.events.ComponentEvent;

	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.FocusEvent;
	import flash.events.MouseEvent;
	import flash.events.TextEvent;
	import flash.geom.Rectangle;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFieldType;
	import flash.text.TextLineMetrics;
	import flash.utils.clearInterval;
	import flash.utils.setInterval;
	/**
	 * TextArea consist of a multiline TextInput which can display Scroll control if needed.
	 * 
	 * @author SamYStudiO ( contact@samystudio.net )
	 */
	public class TextArea extends TextInput implements ITextArea
	{
		/**
		 * @private
		 */
		protected var _boundingBox : Sprite = new Sprite();
		
		/**
		 * @private
		 */
		protected var _lastSelectionBeginIndex : int = -1;
		
		/**
		 * @private
		 */
		protected var _lastSelectionEndIndex : int = -1;
		
		/**
		 * @private
		 */
		protected var _selectionScrollIntervalID : int = -1;
		
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
		protected var _horizontalScroll : IScroll;
		
		/**
		 * @inheritDoc
		 */
		public function get horizontalScroll() : IScroll
		{
			return _horizontalScroll;
		}
		
		/**
		 * @private
		 */
		protected var _verticalScroll : IScroll;
		
		/**
		 * @inheritDoc
		 */
		public function get verticalScroll() : IScroll
		{
			return _verticalScroll;
		}
		
		/**
		 * @private
		 */
		protected var _useHorizontalScroll : Boolean;
		
		[Inspectable]
		/**
		 * @inheritDoc
		 */
		public function get useHorizontalScroll() : Boolean
		{
			return _useHorizontalScroll;
		}
		
		public function set useHorizontalScroll( b : Boolean ) : void
		{
			if( _inspector && !_isLivePreview && _useHorizontalScroll ) return;
			
			_useHorizontalScroll = b;
			_textField.wordWrap = !b;
		}
		
		/**
		 * @private
		 */
		protected var _scrollBarOverlapBackground : Boolean = true;
		
		[Inspectable] 
		/**
		 * @inheritDoc
		 */
		public function get scrollBarOverlapBackground() : Boolean
		{
			return _scrollBarOverlapBackground;
		}
		
		public function set scrollBarOverlapBackground( b : Boolean ) : void
		{
			if( _scrollBarOverlapBackground == b || ( _inspector && !_isLivePreview && _scrollBarOverlapBackground ) ) return;
			
			_scrollBarOverlapBackground = b;
			
			invalidate( InvalidationType.SIZE );
		}
		
		/**
		 * @inheritDoc
		 */
		public override function get multiline() : Boolean
		{
			return _multiline;
		}
		
		public override function set multiline( b : Boolean ) : void
		{
			if( !b ) throw new Error( this + " multiline cannot be changed" );
		}
		
		/**
		 * @private
		 */
		protected var _scrollRenderer : * = ScrollBar;
		
		[Inspectable(defaultValue="myLib.controls.ScrollBar",enumeration="myLib.controls.ScrollBar,myLib.controls.MouseScroll,myLib.controls.PanoramaScroll,off")] 
		/**
		 * @inheritDoc
		 */
		public function get scrollRenderer() : *
		{
			return _scrollRenderer;
		}
		
		public function set scrollRenderer( definition : * ) : void
		{
			if( _isLivePreview ) return;
			
			if( _scrollRenderer == definition || ( _inspector && !_isLivePreview && _scrollRenderer != ScrollBar ) ) return;
			
			_scrollRenderer = definition;
			
			_initScrolls();
			
			invalidate( InvalidationType.SIZE );
		}
		
		/**
		 * @private
		 */
		protected var _scrollUseTextFieldContainer : Boolean = false;
		
		[Inspectable] 
		/**
		 * @inheritDoc
		 */
		public function get scrollUseTextFieldContainer() : Boolean
		{
			return _scrollUseTextFieldContainer;
		}
		
		public function set scrollUseTextFieldContainer( b : Boolean ) : void
		{
			if( _scrollUseTextFieldContainer == b || ( _inspector && !_isLivePreview && _scrollUseTextFieldContainer ) ) return;
			
			_scrollUseTextFieldContainer = b;
			
			_textField.scrollH = 0;
			_textField.scrollV = 0;
			_textFieldAsset.scrollRect = null;
			
			_textField.autoSize = _scrollUseTextFieldContainer ? TextFieldAutoSize.LEFT : TextFieldAutoSize.NONE;
			
			_verticalScroll.scrollTarget = _scrollUseTextFieldContainer ? _textFieldAsset as DisplayObject : _textField;
			_horizontalScroll.scrollTarget = _scrollUseTextFieldContainer ? _textFieldAsset as DisplayObject : _textField;
			
			_verticalScroll.keyboardEnabled = !b;
			_horizontalScroll.keyboardEnabled = !b;
			
			invalidate( InvalidationType.SIZE );
		}
		
		/**
		 * @private
		 */
		protected var _editable : Boolean = true;
		
		[Inspectable] 
		/**
		 * @inheritDoc
		 */
		public function get editable() : Boolean
		{
			return _editable;
		}
		
		public function set editable( b : Boolean ) : void
		{
			if( _editable == b || ( _inspector && !_isLivePreview && !_editable ) ) return;
			
			_editable = _textField.selectable = b;
		}
		/**
		 * Build a new TextArea instance. Default size is 100*2.
		 * @param parentContainer The parent DisplayObjectContainer where add this TextArea.
		 * @param initStyle The initial style object for TextArea initialization.
		 * @param skin The ITextAreaSkin to use instead of default skin.
		 * 
		 * @see myLib.styles.StyleManager
		 */
		public function TextArea ( parentContainer : DisplayObjectContainer = null , initStyle : Object = null , skin : ITextAreaSkin = null )
		{
			super( parentContainer , initStyle , skin == null ? my_skinset.getTextAreaSkin() : skin );
		}

		/**
		 * @private
		 */
		protected override function _createChildren () : void
		{
			super._createChildren( );
			
			var g : Graphics = _boundingBox.graphics;
			g.beginFill( 0x000000 , 0 );
			g.drawRect( 0 , 0 , 10 , 10 );
			
			_textFieldAsset.addChildAt( _boundingBox , 0 );
			
			_initScrolls();
		}
		
		/**
		 * @private
		 */
		protected function _initScrolls () : void
		{
			if( _horizontalScroll != null )
			{
				_horizontalScroll.scrollTarget = null;
				removeChild( _horizontalScroll as DisplayObject );
			}
			
			if( _verticalScroll != null )
			{
				_verticalScroll.scrollTarget = null;
				removeChild( _verticalScroll as DisplayObject );
			}
			
			var skin : ITextAreaSkin = _labelSkin as ITextAreaSkin;
			
			_horizontalScroll = skin.getScrollAsset( _scrollRenderer );
			_verticalScroll = skin.getScrollAsset( _scrollRenderer );
			
			_horizontalScroll.owner = this;
			_verticalScroll.owner = this;
			
			_horizontalScroll.direction = ScrollDirection.HORIZONTAL;
			_verticalScroll.scrollTarget = _scrollUseTextFieldContainer ? _textFieldAsset as DisplayObject : _textField;
			
			_horizontalScroll.scrollTarget = _scrollUseTextFieldContainer ? _textFieldAsset as DisplayObject : _textField;
			
			_horizontalScroll.addEventListener( ComponentEvent.VISIBLE_CHANGED , _updateScroll , false , 0 , true );
			_verticalScroll.addEventListener( ComponentEvent.VISIBLE_CHANGED , _updateScroll , false , 0 , true );
			
			addChild( _horizontalScroll as DisplayObject );
			addChild( _verticalScroll as DisplayObject );
		}

		/**
		 * @private
		 */
		protected override function _init(  ) : void
		{
			_textField.multiline = _multiline = true;
			_textField.wordWrap = !_useHorizontalScroll;
			_textField.type = TextFieldType.INPUT;
			_textField.addEventListener( Event.CHANGE , _passEvent , false , 0 , true );
			_textField.addEventListener( TextEvent.TEXT_INPUT , _passEvent , false , 0 , true );
			_textField.scrollH = 0;
			_textField.scrollV = 0;
			_textField.selectable = _editable;
			_textField.autoSize = _scrollUseTextFieldContainer ? TextFieldAutoSize.LEFT : TextFieldAutoSize.NONE;
			
			_textFieldAsset.scrollRect = null;
			
			_enabledTextColor = uint( _textField.defaultTextFormat.color );
			
			_focusTarget = _textField;
			
			addEventListener( FocusEvent.FOCUS_IN , _focusIn , false , 0 , true );
			addEventListener( FocusEvent.FOCUS_OUT , _focusOut , false , 0 , true );
		}
		
		/**
		 * @private
		 */
		protected override function _draw(  ) : void
		{
			if( isInvalidate( InvalidationType.SIZE ) )
			{
				if( _backgroundAsset != null )
				{
					_backgroundAsset.setSize( _scrollBarOverlapBackground  ? _width : _width - _verticalScroll.width , _scrollBarOverlapBackground ? _height : height - _horizontalScroll.height );
					_backgroundAsset.draw();
				}
				
				var iconWidth : Number = this.iconWidth;
				var iconHeight : Number = this.iconHeight;
				
				if( _iconAsset != null )
				{
					_iconAsset.setSize( iconWidth , iconHeight );
					_iconAsset.draw();
				}

				var removeText : Boolean;
				
				// useful for retrieve textHeight since textHeight value of empty textfield is 0
				if( _textField.text == "" ) 
				{
					_textField.text = "a";
					removeText = true;
				}
				
				var padLeftRight : Number = _padding.left + _padding.right;
				var padTopBottom : Number = _padding.top + _padding.bottom;
				var labelIconSpacing : Number = _iconAsset == null || iconWidth == 0 || iconHeight == 0 ? 0 : _labelIconSpacing;
				var singleLineTextHeight : Number = _textField.getLineMetrics( 0 ).height + TextFieldGutter.VSIZE;
				var horizontalScrollHeight : Number = !_horizontalScroll.visible || _horizontalScroll.wrapTarget ? 0 : _horizontalScroll.height;
				var verticalScrollWidth : Number = !_verticalScroll.visible|| _verticalScroll.wrapTarget ? 0 : _verticalScroll.width;
				var w : Number;
				var h : Number;
				
				_boundingBox.width = 0;
				_boundingBox.height = 0;
				
				switch( _labelPlacement )
				{
					case LabelPlacement.LEFT :
						
						w = _width - iconWidth - padLeftRight - labelIconSpacing - verticalScrollWidth;
						h = _height - padTopBottom - horizontalScrollHeight;
						
						_textField.width = _horizontalScroll.width = w;
						_textField.height = _verticalScroll.height = h;
						
						_textFieldAsset.x = _horizontalScroll.x = _padding.left;					
						_textFieldAsset.y = _verticalScroll.y = _padding.top;
						
						_verticalScroll.x = _verticalScroll.wrapTarget ? _padding.left : _scrollUseTextFieldContainer ? _width - iconWidth - _padding.right - labelIconSpacing - verticalScrollWidth : _textFieldAsset.x + _textFieldAsset.width;						_horizontalScroll.y = _horizontalScroll.wrapTarget ? _padding.top : _scrollUseTextFieldContainer ? _height - _padding.bottom - horizontalScrollHeight : _textFieldAsset.y + _textFieldAsset.height;
						
						if( _verticalScroll.wrapTarget ) _verticalScroll.width = w;
						if( _horizontalScroll.wrapTarget ) _horizontalScroll.height = h;
						
						if( _iconAsset != null )
						{	
							_iconAsset.x = _verticalScroll.x + _verticalScroll.width + labelIconSpacing;
							
							_iconAsset.y = Math.round( 	_verticalAlignment == LabelAlignment.TOP ? ( singleLineTextHeight - iconHeight ) / 2 + _textFieldAsset.y - 1 :
														_verticalAlignment == LabelAlignment.BOTTOM ? _height - ( singleLineTextHeight - iconHeight ) / 2 - iconHeight - 1 :
														( _height - iconHeight ) / 2 );
						}
						
						break;
						
					case LabelPlacement.TOP :
						
						w = _width - padLeftRight - verticalScrollWidth;
						h = _height - iconHeight - padTopBottom - labelIconSpacing - horizontalScrollHeight;
						
						_textField.width = _horizontalScroll.width = w;
						_textField.height = _verticalScroll.height = h;
						
						_textFieldAsset.x = _horizontalScroll.x = _padding.left;						
						_textFieldAsset.y = _verticalScroll.y = _padding.top;
						
						_verticalScroll.x = _verticalScroll.wrapTarget ? _padding.left : _textFieldAsset.x + _textFieldAsset.width;
						_horizontalScroll.y = _horizontalScroll.wrapTarget ? _padding.top : _textFieldAsset.y + _textFieldAsset.height;
						
						_verticalScroll.x = _verticalScroll.wrapTarget ? _padding.left : _scrollUseTextFieldContainer ? _width - _padding.right - verticalScrollWidth : _textFieldAsset.x + _textFieldAsset.width;
						_horizontalScroll.y = _horizontalScroll.wrapTarget ? _padding.top : _scrollUseTextFieldContainer ? height - iconHeight - _padding.bottom - labelIconSpacing - horizontalScrollHeight : _textFieldAsset.y + _textFieldAsset.height;
						
						if( _verticalScroll.wrapTarget ) _verticalScroll.width = w;
						if( _horizontalScroll.wrapTarget ) _horizontalScroll.height = h;
						
						if( _iconAsset != null )
						{				
							_iconAsset.x = Math.round( 	_horizontalAlignment == LabelAlignment.LEFT ? _padding.left :
														_horizontalAlignment == LabelAlignment.RIGHT ? _width - iconWidth - _padding.right :
														( _width - iconWidth ) / 2 );
																			
							_iconAsset.y = _horizontalScroll.y + _horizontalScroll.height + labelIconSpacing;
						}
						
						break;
				
					case LabelPlacement.BOTTOM :
						
						w = _width - padLeftRight - verticalScrollWidth;
						h = _height - iconHeight - padTopBottom - labelIconSpacing - horizontalScrollHeight;
						
						_textField.width = _horizontalScroll.width = w;
						_textField.height = _verticalScroll.height = h;
						
						_textFieldAsset.x = _horizontalScroll.x = _padding.left;			
						_textFieldAsset.y = _verticalScroll.y = _padding.top + iconHeight + labelIconSpacing;
						
						_verticalScroll.x = _verticalScroll.wrapTarget ? _padding.left : _scrollUseTextFieldContainer ? _width - _padding.right - verticalScrollWidth : _textFieldAsset.x + _textFieldAsset.width;
						_horizontalScroll.y = _horizontalScroll.wrapTarget ? _padding.top : _scrollUseTextFieldContainer ? height - iconHeight - _padding.bottom - labelIconSpacing - horizontalScrollHeight : _textFieldAsset.y + _textFieldAsset.height;
						
						if( _verticalScroll.wrapTarget ) _verticalScroll.width = w;
						if( _horizontalScroll.wrapTarget ) _horizontalScroll.height = h;
						
						if( _iconAsset != null )
						{
							_iconAsset.x = Math.round( 	_horizontalAlignment == LabelAlignment.LEFT ? _padding.left :
														_horizontalAlignment == LabelAlignment.RIGHT ? _width - iconWidth - _padding.right :
														( _width - iconWidth ) / 2 );
														
							_iconAsset.y = _padding.top;
						}
						
						break;
						
					default :
					
						w = _width - iconWidth - padLeftRight - labelIconSpacing - verticalScrollWidth;
						h = _height - padTopBottom - horizontalScrollHeight;
					
						_textField.width = _horizontalScroll.width = w;
						_textField.height = _verticalScroll.height = h;
						
						_textFieldAsset.x = _horizontalScroll.x = _padding.left + iconWidth + labelIconSpacing;						
						_textFieldAsset.y = _verticalScroll.y = _padding.top;
						
						_verticalScroll.x = _verticalScroll.wrapTarget ? _padding.left : _scrollUseTextFieldContainer ? _width - iconWidth - _padding.right - labelIconSpacing - verticalScrollWidth : _textFieldAsset.x + _textFieldAsset.width;
						_horizontalScroll.y = _horizontalScroll.wrapTarget ? _padding.top : _scrollUseTextFieldContainer ? _height - _padding.bottom - horizontalScrollHeight : _textFieldAsset.y + _textFieldAsset.height;
						
						if( _verticalScroll.wrapTarget ) _verticalScroll.width =  w;
						if( _horizontalScroll.wrapTarget ) _horizontalScroll.height = h;
						
						if( _iconAsset != null )
						{						
							_iconAsset.x = _padding.left;
							
							_iconAsset.y = Math.round( 	_verticalAlignment == LabelAlignment.TOP ? ( singleLineTextHeight - iconHeight ) / 2 + _textFieldAsset.y - 1 :
														_verticalAlignment == LabelAlignment.BOTTOM ? _height - ( singleLineTextHeight - iconHeight ) / 2 - iconHeight - 1 :
														( _height - iconHeight ) / 2 );
						}
									
						_labelPlacement = LabelPlacement.RIGHT;
						
						break;
				}
				
				if( removeText ) _textField.text = "";
				
				_verticalScroll.validate( InvalidationType.SIZE | InvalidationType.DATA );				_horizontalScroll.validate( InvalidationType.SIZE | InvalidationType.DATA );
				
				_boundingBox.width = w;
				_boundingBox.height = h;
			}
			
			if( _isLivePreview )
			{
				_verticalScroll.visible = _horizontalScroll.visible = false;
			}
		}
		
		/**
		 * @private
		 */
		protected override function _focusIn ( e : FocusEvent ) : void
		{
			super._focusIn( e );
			
			if( _scrollUseTextFieldContainer && _editable )
			{
				addEventListener( Event.ENTER_FRAME , _captureCaret , false , 0 , true );
				_textField.addEventListener( MouseEvent.MOUSE_DOWN , _textFieldDown , false , 0 , true );
			}
		}
		
		/**
		 * @private
		 */
		protected override function _focusOut ( e : FocusEvent ) : void
		{
			super._focusOut( e );
			
			if( _scrollUseTextFieldContainer && _editable )
			{
				removeEventListener( Event.ENTER_FRAME , _captureCaret );
				_textField.removeEventListener( MouseEvent.MOUSE_DOWN , _textFieldDown );
			}
		}
		
		/**
		 * @private
		 */
		protected function _captureCaret ( e : Event ) : void
		{
			if( _lastSelectionBeginIndex != _textField.selectionBeginIndex || _lastSelectionEndIndex != _textField.selectionEndIndex )
			{
				if( _textField.selectionBeginIndex - _textField.selectionEndIndex == 0 ) _updateFromCaret();
			}
			
			_lastSelectionBeginIndex = _textField.selectionBeginIndex;
			_lastSelectionEndIndex = _textField.selectionEndIndex;
		}
		
		/**
		 * @private
		 */
		protected function _textFieldDown( e : MouseEvent ) : void
		{
			_textField.type = TextFieldType.DYNAMIC;
			
			stage.addEventListener( MouseEvent.MOUSE_UP , _textFieldUp , false , 0 , true );
			stage.addEventListener( MouseEvent.MOUSE_MOVE , _captureSelection , false , 0 , true );
		}
		
		/**
		 * @private
		 */
		protected function _textFieldUp( e : MouseEvent ) : void
		{
			_textField.type = TextFieldType.INPUT;
			
			clearInterval( _selectionScrollIntervalID );
			
			stage.removeEventListener( MouseEvent.MOUSE_UP , _textFieldUp );
			stage.removeEventListener( MouseEvent.MOUSE_MOVE , _captureSelection );
		}
		
		/**
		 * @private
		 */
		protected function _captureSelection( e : MouseEvent ) : void
		{
			if( _textField.getLineIndexOfChar( _textField.selectionBeginIndex ) == _textField.getLineIndexOfChar( _textField.selectionEndIndex ) )
			{
				if( mouseX < _textFieldAsset.x )
				{
					clearInterval( _selectionScrollIntervalID );
					_selectionScroll( _horizontalScroll , -_horizontalScroll.scrollSize );
					_selectionScrollIntervalID = setInterval( _selectionScroll , 50 , _horizontalScroll , -_horizontalScroll.scrollSize );
				}
				else if( mouseX > _textFieldAsset.x + _horizontalScroll.pageSize )
				{
					clearInterval( _selectionScrollIntervalID );
					
					var tlm : TextLineMetrics = _textField.getLineMetrics( _textField.getLineIndexOfChar( _textField.caretIndex ) );
					
					if( _horizontalScroll.getScrollPosition() < tlm.width + 10 - _horizontalScroll.pageSize )
					{
						_selectionScroll( _horizontalScroll , _horizontalScroll.scrollSize );
						_selectionScrollIntervalID = setInterval( _selectionScroll , 50 , _horizontalScroll , _horizontalScroll.scrollSize );
					}
				}
			}
			else if( mouseY < _textFieldAsset.y )
			{
				clearInterval( _selectionScrollIntervalID );
				_selectionScroll( _verticalScroll , -_verticalScroll.scrollSize );
				_selectionScrollIntervalID = setInterval( _selectionScroll , 50 , _verticalScroll , -_verticalScroll.scrollSize );
			}
			else if( mouseY > _textFieldAsset.y + _verticalScroll.pageSize )
			{
				clearInterval( _selectionScrollIntervalID );
				_selectionScroll( _verticalScroll , _verticalScroll.scrollSize );
				_selectionScrollIntervalID = setInterval( _selectionScroll , 50 , _verticalScroll , _verticalScroll.scrollSize );
			}
			else clearInterval( _selectionScrollIntervalID );
		}
		
		/**
		 * @private
		 */
		protected function _selectionScroll( scroll : IScroll , size : Number ) : void
		{
			scroll.scroll( size );
			
			if( scroll == _horizontalScroll )
			{
				var tlm : TextLineMetrics = _textField.getLineMetrics( _textField.getLineIndexOfChar( _textField.caretIndex ) );
				
				if( scroll.getScrollPosition() >= tlm.width + 10 - scroll.pageSize )
				{
					scroll.setScrollPosition( tlm.width + 10 - scroll.pageSize );
					
					clearInterval( _selectionScrollIntervalID );	
				}
			}
		}
		
		/**
		 * @private
		 */
		protected override function _passEvent( e : Event ) : void
		{
			super._passEvent( e );
			
			if( _scrollUseTextFieldContainer && e.type == Event.CHANGE )
			{
				_verticalScroll.update( );
				_horizontalScroll.update( );
				
				_verticalScroll.draw();
				_horizontalScroll.draw();
				
				if( _editable ) _updateFromCaret();
			}
		}
		
		/**
		 * @private
		 */
		protected function _updateFromCaret( ) : void
		{
			var r : Rectangle = _textField.getCharBoundaries( _textField.caretIndex );
				
				if( r == null ) r = _textField.getCharBoundaries( _textField.caretIndex - 1 );
				
				if( r != null )
				{
					if( ( r.y + r.height ) - verticalScroll.getScrollPosition() > _verticalScroll.pageSize )
						_verticalScroll.setScrollPosition( r.y + r.height - verticalScroll.pageSize );
					else if( r.y - verticalScroll.getScrollPosition() < 0 )
						_verticalScroll.setScrollPosition( r.y );
					
					if( ( r.x + r.width ) - _horizontalScroll.getScrollPosition() > _horizontalScroll.pageSize )
						_horizontalScroll.setScrollPosition( r.x + r.width * 20 - _horizontalScroll.pageSize );
					else if(  r.x - _horizontalScroll.getScrollPosition() < 0 )
						_horizontalScroll.setScrollPosition( r.x - r.width * 20 );
				}
		}
		
		/**
		 * @private
		 */
		protected function _updateScroll ( e : ComponentEvent ) : void
		{
			if( _isLivePreview ) return;
			
			validate( InvalidationType.SIZE );
		}
	}
}
