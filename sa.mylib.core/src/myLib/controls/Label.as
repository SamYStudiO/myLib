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
	import myLib.assets.IAsset;
	import myLib.assets.ITextFieldAsset;
	import myLib.assets.TextFieldAsset;
	import myLib.assets.getAsset;
	import myLib.controls.skins.ILabelSkin;
	import myLib.controls.skins.my_skinset;
	import myLib.core.AComponent;
	import myLib.core.InvalidationType;
	import myLib.displayUtils.TextFieldGutter;
	import myLib.styles.Padding;
	import myLib.styles.StyleManager;
	import myLib.styles.TextStyle;

	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	/**
	 * Label component consist of a textfield, icon and background asset which arre all optional. You can dispaly a simple textfield or icon textfield or simple icon, etc...
	 * Most of textfield propeties are available with Label component, you should never apply this properties to textfield and prefer used label properties.
	 * 
	 * @author SamYStudiO ( contact@samystudio.net )
	 */
	public class Label extends AComponent implements ILabel
	{
		/**
		 * @private
		 */
		protected var _labelSkin : ILabelSkin;
		
		/**
		 * @private
		 */
		protected var _lastWidth : Number;
		
		/**
		 * @private
		 */
		protected var _multiline : Boolean;

		[Inspectable]
		/**
		 * @inheritDoc
		 */
		public function get multiline() : Boolean
		{
			return _multiline;
		}
		
		public function set multiline( b : Boolean ) : void
		{
			if( _textField == null || _multiline == b || ( _inspector && !_isLivePreview && _multiline ) ) return;
			
			var h : Number = _textField.height;
			
			_multiline = _textField.multiline = _textField.wordWrap = b;
			
			if( _textField.height != h ) _invalidateSize( );
		}
		
		/**
		 * @private
		 */
		protected var _autoSize : Boolean;
		
		[Inspectable]
		/**
		 * @inheritDoc
		 */
		public function get autoSize() : Boolean
		{
			return _autoSize;
		}
		
		public function set autoSize( b : Boolean ) : void
		{
			if( _textField == null || _autoSize == b || ( _inspector && !_isLivePreview && _autoSize ) ) return;
			
			_autoSize = b;
			
			_invalidateSize( true );
		}
		
		/**
		 * @private
		 */
		protected var _autoFit : Boolean;
		
		[Inspectable]
		/**
		 * @inheritDoc
		 */
		public function get autoFit () : Boolean
		{
			return _autoFit;
		}
		
		public function set autoFit ( b : Boolean ) : void
		{
			if( _textField == null || _autoFit == b || ( _inspector && !_isLivePreview && _autoFit ) ) return;
			
			_autoFit = b;
			_autoSize = false;
			
			_invalidateSize( );
		}
		
		/**
		 * @private
		 */
		protected var _autoAdjustLeading : Boolean = true;
		
		[Inspectable]
		/**
		 * @inheritDoc
		 */
		public function get autoAdjustLeading () : Boolean
		{
			return _autoAdjustLeading;
		}
		
		public function set autoAdjustLeading ( b : Boolean ) : void
		{
			if( _textField == null || _autoAdjustLeading == b || ( _inspector && !_isLivePreview && !_autoAdjustLeading ) ) return;
			
			_autoAdjustLeading = b;
			
			_invalidateSize( );
		}
		
		/**
		 * @private
		 */
		protected var _autoFitMinSize : uint = 8;
		
		[Inspectable(defaultValue=8)]
		/**
		 * @inheritDoc
		 */
		public function get autoFitMinSize () : uint
		{
			return _autoFitMinSize;
		}
		
		public function set autoFitMinSize ( n : uint ) : void
		{
			if( _textField == null || _autoFitMinSize == n || ( _inspector && !_isLivePreview && _autoFitMinSize != 8 ) ) return;
			
			_autoFitMinSize = n;
			
			if( _textField.getTextFormat( ).size < n && _autoFit ) _invalidateSize( );
		}
		
		/**
		 * @private
		 */
		protected var _overflowTextIndicator : String = "...";
		
		[Inspectable(defaultValue=8)]
		/**
		 * @inheritDoc
		 */
		public function get overflowTextIndicator () : String
		{
			return _overflowTextIndicator;
		}
		
		public function set overflowTextIndicator ( s : String ) : void
		{
			if( _textField == null || _overflowTextIndicator == s || ( _inspector && !_isLivePreview && _overflowTextIndicator != "..." ) ) return;
			
			_overflowTextIndicator = s;
			
			_invalidateSize( );
		}
		
		
		/**
		 * @private
		 */
		protected var _maximizeTextWidth : Boolean;
		
		[Inspectable]
		/**
		 * @inheritDoc
		 */
		public function get maximizeTextWidth () : Boolean
		{
			return _maximizeTextWidth;
		}
		
		public function set maximizeTextWidth ( b : Boolean ) : void
		{
			if( _textField == null || _maximizeTextWidth == b || ( _inspector && !_isLivePreview && _maximizeTextWidth ) ) return;
			
			_maximizeTextWidth = b;
			
			_invalidateSize( );
		}
		
		[Inspectable]
		/**
		 * @inheritDoc
		 */
		public function get embedFonts() : Boolean
		{
			return _textField != null ? _textField.embedFonts : false;
		}
		
		public function set embedFonts( b : Boolean ) : void
		{
			if( _textField == null || _textField.embedFonts == b || _isLivePreview || ( _inspector && !_isLivePreview && _textField.embedFonts ) ) return;
			
			_textField.embedFonts = b;
			
			_invalidateSize( true );
		}
		
		/**
		 * @private
		 */
		protected var _labelPlacement : String = LabelPlacement.RIGHT;
		
		[Inspectable(defaultValue="right",enumeration="left,top,right,bottom")]
		/**
		 * @inheritDoc
		 */
		public function get labelPlacement() : String
		{
			return _labelPlacement;
		}
		
		public function set labelPlacement( s : String ) : void
		{
			if( _textField == null || _labelPlacement == s || ( _inspector && !_isLivePreview && _labelPlacement != LabelPlacement.RIGHT ) ) return;
			
			_labelPlacement = s;
			
			_invalidateSize( );
		}
		
		/**
		 * @private
		 */
		protected var _horizontalAlignment : String = LabelAlignment.LEFT;
		
		[Inspectable(defaultValue="left",enumeration="left,center,right")]
		/**
		 * @inheritDoc
		 */
		public function get horizontalAlignment() : String
		{
			return _horizontalAlignment;
		}
		
		public function set horizontalAlignment( s : String ) : void
		{
			if( _horizontalAlignment == s || ( _inspector && !_isLivePreview && _horizontalAlignment != LabelAlignment.LEFT ) ) return;
			
			_horizontalAlignment = s;
			
			_invalidateSize( );
		}
		
		/**
		 * @private
		 */
		protected var _verticalAlignment : String = LabelAlignment.CENTER;
		
		[Inspectable(defaultValue="center",enumeration="top,center,bottom")]
		/**
		 * @inheritDoc
		 */
		public function get verticalAlignment() : String
		{
			return _verticalAlignment;
		}
		
		public function set verticalAlignment( s : String ) : void
		{
			if( _verticalAlignment == s || ( _inspector && !_isLivePreview && _verticalAlignment != LabelAlignment.CENTER ) ) return;
			
			_verticalAlignment = s;
			
			_invalidateSize( );
		}
		
		/**
		 * @private
		 */
		protected var _icon : *;
		
		[Inspectable]
		/**
		 * @inheritDoc
		 */
		public function get icon() : *
		{
			return _icon;
		}
		
		public function set icon( icon : * ) : void
		{
			if( icon == "" ) icon = null;
			if( _icon == icon || ( _inspector && !_isLivePreview && _icon != null ) ) return;
			
			_icon = icon;
			
			if( _iconAsset != null ) removeChild( _iconAsset as DisplayObject );
			
			_iconAsset = getAsset( icon );
			
			if( _iconAsset != null )
			{
				_iconAsset.owner = this;
				addChild( _iconAsset as DisplayObject );
			}
			
			_invalidateSize( );
		}
		
		/**
		 * @private
		 */
		protected var _iconWidth : Number;
		
		/**
		 *
		 */
		public function get iconWidth() : Number
		{
			return isNaN( _iconWidth ) || _iconAsset == null ? _iconAsset != null ? _iconAsset.width : 0 : _iconWidth;
		}
		
		public function set iconWidth( w : Number ) : void
		{
			_iconWidth = w;
			
			_invalidateSize( );
		}
		
		/**
		 * @private
		 */
		protected var _iconHeight : Number;
		
		/**
		 *
		 */
		public function get iconHeight() : Number
		{
			return isNaN( _iconHeight ) || _iconAsset == null ? _iconAsset != null ? _iconAsset.height : 0 : _iconHeight;
		}
		
		public function set iconHeight( h : Number ) : void
		{
			_iconHeight = h;
			
			_invalidateSize( );
		}
		
		/**
		 * @private
		 */
		protected var _labelIconSpacing : Number = 2;
		
		[Inspectable(defaultValue=2)]
		/**
		 * @inheritDoc
		 */
		public function get labelIconSpacing() : Number
		{
			return _labelIconSpacing;
		}
		
		public function set labelIconSpacing( n : Number ) : void
		{
			if( _labelIconSpacing == n || _textField == null || _iconAsset == null || ( _inspector && !_isLivePreview && _labelIconSpacing != 2 ) ) return;
			
			_labelIconSpacing = n;
			
			_invalidateSize( );
		}
		
		/**
		 * @private
		 */
		protected var _padding : Padding = new Padding( 2 , 2 , 2 , 2 );
		
		/**
		 * @inheritDoc
		 */
		public function get padding() : Padding
		{
			return _padding;
		}
		
		public function set padding( padding : Padding ) : void
		{
			_padding = padding || new Padding();
			
			_invalidateSize( );
		}
		
		[Inspectable(name="padding",type="Object",defaultValue="left:2,top:2,right:2,bottom:2")]
		/**
		 * @private
		 */
		public function set inspectablePadding( padding : Object ) : void
		{
			if( !_inspector && !_isLivePreview ) throw new Error( this + " inspectablePadding property is internal and used by Flash component inspector panel , use padding property instead" );
			
			if( _inspector && !_isLivePreview && ( _padding.left != 2 || _padding.top != 2 || _padding.right != 2 || _padding.bottom != 2 ) ) return;
			
			this.padding = new Padding( padding.left , padding.top , padding.right , padding.bottom );
		}
		
		/**
		 * @inheritDoc
		 */
		public function get textColor () : uint
		{
			return _textField != null ? _textField.textColor : 0x000000;
		}
		
		public function set textColor ( color : uint ) : void
		{
			if( _textField != null ) _textField.textColor = color;
		}
		
		/**
		 * @private
		 */
		protected var _textStyle : TextStyle;
		
		/**
		 * @inheritDoc
		 */
		public function get textStyle () : TextStyle
		{
			return _textStyle;
		}
		
		public function set textStyle ( style : TextStyle ) : void
		{
			_textStyle  = style;
			
			StyleManager.setTextStyle( _textField , style );
			
			_invalidateSize( true );
		}
		
		/**
		 * @private
		 */
		protected var _text : String = "Label";
		 
		[Inspectable(defaultValue="Label")]
		/**
		 * @inheritDoc
		 */
		public function get text() : String
		{
			return _textField != null ? _text : "";
		}
		
		public function set text( s : String ) : void
		{
			if( _textField == null || ( _inspector && !_isLivePreview && _text != "Label" ) ) return;
			
			if( !_html )
			{
				_textField.text = _text = s;
				_htmlText = "";
			
				_invalidateSize( );
			}
			else htmlText = s;
		}
		
		/**
		 * @private
		 */
		protected var _html : Boolean;
		
		[Inspectable]
		/**
		 * @inheritDoc
		 */
		public function get html() : Boolean
		{
			return _html;
		}
		
		public function set html( b : Boolean ) : void
		{
			if( _html == b || ( _inspector && !_isLivePreview && _html ) ) return;
			
			_html = b;
		}
		
		/**
		 * @private
		 */
		protected var _htmlText : String = "";
		
		/**
		 * @inheritDoc
		 */
		public function get htmlText () : String
		{
			return _textField != null ? _htmlText : "";
		}
		
		public function set htmlText ( s : String ) : void
		{
			if( _textField == null ) return;
			
			_textField.htmlText = s;
			
			_htmlText = s;
			_text = "";
			_html = true;
			
			_invalidateSize( );
		}
		
		/**
		 * @private
		 */
		protected var _textField : TextField;
		
		/**
		 * @inheritDoc
		 */
		public function get textField () : TextField
		{
			return _textField;
		}

		/**
		 * @private
		 */
		protected var _textFieldAsset : ITextFieldAsset;
		
		/**
		 * @inheritDoc
		 */
		public function get textFieldAsset () : ITextFieldAsset
		{
			return _textFieldAsset;
		}
		
		/**
		 * @private
		 */
		protected var _iconAsset : IAsset;
		
		/**
		 * @inheritDoc
		 */
		public function get iconAsset () : IAsset
		{
			return _iconAsset;
		}
		
		/**
		 * @private
		 */
		protected var _backgroundAsset : IAsset;
		
		/**
		 * @inheritDoc
		 */
		public function get backgroundAsset () : IAsset
		{
			return _backgroundAsset;
		}

		/**
		 * Build a new Label instance. Default size is 100*20.
		 * @param parentContainer The parent DisplayObjectContainer where add this Label.
		 * @param initStyle The initial style object for Label initialization.
		 * @param skin The ILabelSkin to use instead of default skin.
		 * 
		 * @see myLib.styles.StyleManager
		 */
		public function Label ( parentContainer : DisplayObjectContainer = null , initStyle : Object = null , skin : ILabelSkin = null )
		{
			_labelSkin = skin == null ? my_skinset.getLabelSkin() : skin;
			
			super( parentContainer , initStyle , _labelSkin );
		}
		
		/**
		 * @inheritDoc
		 */
		public override function setSize( w : Number , h : Number ) : void
		{
			_lastWidth = isNaN( w ) ? _lastWidth : w;
			
			if( !_autoSize ) super.setSize( w , h );
			else _invalidateSize( );
		}
		
		/**
		 * @inheritDoc
		 */
		public override function validate( types : uint = 7 ) : void
		{
			if( ( ( types | InvalidationType.SIZE ) == types ) && _autoSize && _textField != null ) _adjustForAutoSize();
			
			super.validate( types );
		}
		
		/**
		 * @private
		 */
		protected override function _createChildren(  ) : void
		{
			if( _labelSkin != null )
			{
				_textFieldAsset = _labelSkin.getTextFieldAsset();
				_iconAsset = _labelSkin.getIconUpAsset();
				_backgroundAsset = _labelSkin.getUpAsset();
			}
			else _textFieldAsset = new TextFieldAsset();
			
			_textField = _textFieldAsset != null ? _textFieldAsset.textField : null;
			
			if( _backgroundAsset != null )
			{
				_backgroundAsset.owner = this;
				addChild( _backgroundAsset as DisplayObject );
			}
			if( _iconAsset != null )
			{
				_iconAsset.owner = this;
				addChild( _iconAsset as DisplayObject );
			}
			if( _textFieldAsset != null )
			{
				_textFieldAsset.owner = this;
				addChild( _textFieldAsset as DisplayObject );
			}
		}
			
		/**
		 * @private
		 */
		protected override function _init(  ) : void
		{
			if( _textField != null && _textField.text == "" )
				_textField.text = "Label";
				
			_focusEnabled = false;
		}

		/**
		 * @private
		 */
		protected override function _draw(  ) : void
		{
			if( isInvalidate( InvalidationType.SIZE ) )
			{
				// restore text and format in case autofit is used and text is cropped, only for non html since no crop occured with htmlText
				if( !_html ) text = _text;
				
				var hasTextField : Boolean = _textField != null && ( _textField.text != "" || _textField.type == TextFieldType.INPUT );
				var iconWidth : Number = this.iconWidth;
				var iconHeight : Number = this.iconHeight;
				
				if( hasTextField )
				{
					var fo : TextFormat = _textField.getTextFormat();
					
					if( _textStyle != null && ( fo.size != _textStyle.textFormat.size || fo.leading != _textStyle.textFormat.leading ) )
					{
						var textColor : Number = _textField.textColor;
						textStyle = _textStyle;
						_textField.textColor = textColor;
					}
				    
				}
				
				if( _backgroundAsset != null )
				{
					_backgroundAsset.setSize( _width , _height );
					_backgroundAsset.draw();
				}
				
				if( _iconAsset != null )
				{
					_iconAsset.setSize( iconWidth , iconHeight );
					_iconAsset.draw();
				}
				
				// nothing to draw
				if( _iconAsset == null && !hasTextField ) return;
				
				// no textfield avoid complex drawing and draw only icon
				if( !hasTextField )
				{
					_drawStandaloneIcon();
					
					if( _textField != null ) _textField.width = _textField.height = 0;
					
					return;	
				}
				
				var removeText : Boolean;
				
				// useful for retrieve textHeight since textHeight value of empty textfield is 0
				if( _textField != null && _textField.text == "" ) 
				{
					_textField.text = "a";
					removeText = true;
				}
				
				var input : Boolean = _textField.type == TextFieldType.INPUT;
				var totalWidth : Number;
				var totalHeight : Number;
				var padLeftRight : Number = _padding.left + _padding.right;
				var padTopBottom : Number = _padding.top + _padding.bottom;
				var labelIconSpacing : Number = _iconAsset == null || !hasTextField || iconWidth == 0 || iconHeight == 0 ? 0 : _labelIconSpacing;
				var textHeight : Number;
				var singleLineTextHeight : Number = !hasTextField ? 0 : _textField.getLineMetrics( 0 ).height + TextFieldGutter.VSIZE;
				var maximizeTextWidth : Boolean = _maximizeTextWidth || input;
				
				_adjustTextFieldAlignment();
				
				if( removeText && !input )
				{
					_textField.width = 0;	
					_textField.height = 0;
				}
				
				if( _autoFit ) _prepareForAutoFit();
				
				switch( _labelPlacement )
				{
					case LabelPlacement.LEFT :
						
						if( !removeText || input )
						{
							_textField.width = _width - iconWidth - padLeftRight - labelIconSpacing;
							
							if( !maximizeTextWidth ) _html ? htmlText = _htmlText : text = _text; // to refresh numLines 
							
							if( !maximizeTextWidth && _textField.numLines == 1 )
								_textField.width = Math.min( _textField.width , _textField.textWidth + TextFieldGutter.HSIZE );
							
							textHeight = _textField.textHeight + TextFieldGutter.VSIZE;
							
							_textField.height = _textField.numLines == 1 ? textHeight : Math.min( textHeight , _height - padTopBottom );
						}
						
						if( _autoFit ) _adjustForAutoFit( );
						
						totalWidth = _textField.width + iconWidth + labelIconSpacing;
						
						_textFieldAsset.x = Math.round( _horizontalAlignment == LabelAlignment.LEFT ? _padding.left :
														_horizontalAlignment == LabelAlignment.RIGHT ? _width - iconWidth - _padding.right - labelIconSpacing - _textField.width :
														( _width - totalWidth ) / 2 );
														
						_textFieldAsset.y = Math.round( _verticalAlignment == LabelAlignment.TOP ? _padding.top :
														_verticalAlignment == LabelAlignment.BOTTOM ? _height - _textField.height - _padding.bottom :
														( _height - _textField.height ) / 2 );
						
						if( _iconAsset != null )
						{	
							_iconAsset.x = Math.round( _textFieldAsset.x + _textFieldAsset.width + labelIconSpacing );
							
							_iconAsset.y = Math.round( 	_verticalAlignment == LabelAlignment.TOP ? Math.max( _padding.top , ( singleLineTextHeight - iconHeight ) / 2 + _textFieldAsset.y - 1 ) :
														_verticalAlignment == LabelAlignment.BOTTOM ? Math.min( _height - iconHeight - _padding.bottom , _height - ( singleLineTextHeight - iconHeight ) / 2 - iconHeight - 1 ) :
														( _height - iconHeight ) / 2 );
						}
						
						break;
						
					case LabelPlacement.TOP :
						
						if( !removeText || input )
						{
							_textField.width = _width - padLeftRight;
							
							if( !maximizeTextWidth ) _html ? htmlText = _htmlText : text = _text; // to refresh numLines 
							
							if( !maximizeTextWidth && _textField.numLines == 1 ) 
								_textField.width = Math.min( _textField.width , _textField.textWidth + TextFieldGutter.HSIZE );
							
							textHeight = _textField.textHeight + TextFieldGutter.VSIZE;
							
							_textField.height = _textField.numLines == 1 ? textHeight : Math.min( textHeight , _height - iconHeight - padTopBottom - labelIconSpacing );
						}
						
						if( _autoFit ) _adjustForAutoFit( );
					
						totalHeight = _textField.height + labelIconSpacing + iconHeight;
						
						_textFieldAsset.x = Math.round( _horizontalAlignment == LabelAlignment.LEFT ? _padding.left :
														_horizontalAlignment == LabelAlignment.RIGHT ? _width - _textField.width - _padding.right :
														( _width - _textField.width ) / 2 );
														
						_textFieldAsset.y = Math.round( _verticalAlignment == LabelAlignment.TOP ? _padding.top :
														_verticalAlignment == LabelAlignment.BOTTOM ? _height - iconHeight - _textField.height - _padding.bottom - labelIconSpacing :
														( _height - totalHeight ) / 2 );
						
						if( _iconAsset != null )
						{				
							_iconAsset.x = Math.round( 	_horizontalAlignment == LabelAlignment.LEFT ? _padding.left :
														_horizontalAlignment == LabelAlignment.RIGHT ? _width - iconWidth - _padding.right :
														( _width - iconWidth ) / 2 );
																			
							_iconAsset.y = Math.round( _textFieldAsset.y + _textFieldAsset.height + labelIconSpacing );
						}
						
						break;
				
					case LabelPlacement.BOTTOM :
						
						if( !removeText || input )
						{
							_textField.width = _width - padLeftRight;
							
							if( !maximizeTextWidth ) _html ? htmlText = _htmlText : text = _text; // to refresh numLines 
							
							if( !maximizeTextWidth && _textField.numLines == 1 ) 
								_textField.width = Math.min( _textField.width , _textField.textWidth + TextFieldGutter.HSIZE );
							
							textHeight = _textField.textHeight + TextFieldGutter.VSIZE;
							
							_textField.height = _textField.numLines == 1 ? textHeight : Math.min( textHeight , _height - iconHeight - padTopBottom - labelIconSpacing );
						}
						
						if( _autoFit ) _adjustForAutoFit( );
						
						totalHeight = _textField.height + labelIconSpacing + iconHeight;
							
						_textFieldAsset.x = Math.round( _horizontalAlignment == LabelAlignment.LEFT ? _padding.left :
														_horizontalAlignment == LabelAlignment.RIGHT ? _width - _textField.width - _padding.right :
														( _width - _textField.width ) / 2 );
														
						_textFieldAsset.y = Math.round( _verticalAlignment == LabelAlignment.TOP ? _padding.top + iconHeight + labelIconSpacing :
														_verticalAlignment == LabelAlignment.BOTTOM ? _height - _textField.height - _padding.bottom :
														_height - ( _height - totalHeight ) / 2 - iconHeight + labelIconSpacing );
						
						if( _iconAsset != null )
						{
							_iconAsset.x = Math.round( 	_horizontalAlignment == LabelAlignment.LEFT ? _padding.left :
														_horizontalAlignment == LabelAlignment.RIGHT ? _width - iconWidth - _padding.right :
														( _width - iconWidth ) / 2 );
														
							_iconAsset.y = Math.round( 	_verticalAlignment == LabelAlignment.TOP ? _padding.top :
														_verticalAlignment == LabelAlignment.BOTTOM ? _textFieldAsset.y - iconHeight - labelIconSpacing :
														( _height - totalHeight ) / 2 );
						}
						
						break;
						
					default :
					
						if( !removeText || input )
						{
							_textField.width = _width - iconWidth - padLeftRight - labelIconSpacing;
							if( !maximizeTextWidth ) _html ? htmlText = _htmlText : text = _text; // to refresh numLines 
							
							if( !maximizeTextWidth && _textField.numLines == 1 ) 
								_textField.width = Math.min( _textField.width , _textField.textWidth + TextFieldGutter.HSIZE );
								
							textHeight = _textField.textHeight + TextFieldGutter.VSIZE;
							
							_textField.height = _textField.numLines == 1 ? textHeight : Math.min( textHeight , _height - padTopBottom );
						}
						
						if( _autoFit ) _adjustForAutoFit( );
						
						totalWidth = _textField.width + iconWidth + labelIconSpacing;
						
						_textFieldAsset.x = Math.round( _horizontalAlignment == LabelAlignment.LEFT ? _padding.left + iconWidth + labelIconSpacing :
														_horizontalAlignment == LabelAlignment.RIGHT ? _width - _padding.right - _textField.width :
														_width - ( _width - totalWidth ) / 2 - _textField.width );
													
						_textFieldAsset.y = Math.round( _verticalAlignment == LabelAlignment.TOP ? _padding.top :
														_verticalAlignment == LabelAlignment.BOTTOM ? _height - _textField.height - _padding.bottom :
														( _height - _textField.height ) / 2 );
						
						if( _iconAsset != null )
						{						
							_iconAsset.x = Math.round( _textFieldAsset.x - labelIconSpacing - iconWidth );
							
							_iconAsset.y = Math.round( 	_verticalAlignment == LabelAlignment.TOP ? Math.max( _padding.top , ( singleLineTextHeight - iconHeight ) / 2 + _textFieldAsset.y - 1 ) :
														_verticalAlignment == LabelAlignment.BOTTOM ? Math.min( _height - iconHeight - _padding.bottom , _height - ( singleLineTextHeight - iconHeight ) / 2 - iconHeight - 1 ) :
														( _height - iconHeight ) / 2 );
						}
						
									
						_labelPlacement = LabelPlacement.RIGHT;
						
						break;
				}
				
				if( removeText ) _textField.text = "";
			}
		}
		
		/**
		 * @private
		 */
		protected function _drawStandaloneIcon(  ) : void
		{
			_iconAsset.x = Math.round( 	_horizontalAlignment == LabelAlignment.LEFT ? _padding.left : 
										_horizontalAlignment == LabelAlignment.RIGHT ? _width - iconWidth - _padding.right :
										( _width - iconWidth ) / 2 );
			_iconAsset.y = Math.round( 	_verticalAlignment == LabelAlignment.TOP ? _padding.top :
										_verticalAlignment == LabelAlignment.BOTTOM ? _height - iconHeight - _padding.bottom :
										( _height - iconHeight ) / 2 );																								
		}
		
		/**
		 * @private
		 */
		protected function _adjustTextFieldAlignment(  ) : void
		{
			var fo : TextFormat = _textField.getTextFormat();
				
			if( fo.align != _horizontalAlignment )
			{
				fo.align = _horizontalAlignment;
				_textField.defaultTextFormat = fo;	
				_textField.setTextFormat( fo );	
			}
		}
		
		/**
		 * @private
		 */
		protected function _adjustForAutoSize(  ) : void
		{
			var padLeftRight : Number = _padding.left + _padding.right;
			var padTopBottom : Number = _padding.top + _padding.bottom;
			var iconWidth : Number = this.iconWidth;
			var iconHeight : Number = this.iconHeight;
			var labelIconSpacing : Number = _iconAsset == null || _textField.text == "" || iconWidth == 0 || iconHeight == 0 ? 0 : _labelIconSpacing;
			
			if( _textField.multiline )
			{
				if( _labelPlacement == LabelPlacement.LEFT || _labelPlacement == LabelPlacement.RIGHT )
					_textField.width = _lastWidth - padLeftRight - labelIconSpacing - iconWidth;
				else
					_textField.width = _lastWidth - padLeftRight;
			}
			
			var textWidth : Number = _textField.text == "" ? 0 : _textField.multiline ? _textField.width : _textField.textWidth + TextFieldGutter.HSIZE;
			var textHeight : Number = _textField.text == "" ? 0 : _textField.textHeight + TextFieldGutter.VSIZE;
			
			switch( _labelPlacement )
			{
				case LabelPlacement.LEFT :
					
					_width = Math.max( Math.min( _maxWidth , textWidth + padLeftRight + iconWidth + labelIconSpacing ) , _minWidth );
					_height = Math.max( Math.min( _maxHeight , Math.max( textHeight + padTopBottom , iconHeight + padTopBottom ) ) , _minHeight );
					break;
					
				case LabelPlacement.TOP :
				
					_width = Math.max( Math.min( _maxWidth , Math.max( textWidth + padLeftRight , iconWidth + padLeftRight ) ) , _minWidth );
					_height = Math.max( Math.min( _maxHeight , textHeight + padTopBottom + iconHeight + labelIconSpacing ) , _minHeight );
					break;
			
				case LabelPlacement.BOTTOM :
					
					_width = Math.max( Math.min( _maxWidth , Math.max( textWidth + padLeftRight , iconWidth + padLeftRight ) ) , _minWidth );
					_height = Math.max( Math.min( _maxHeight , textHeight + padTopBottom + iconHeight + labelIconSpacing ) , _minHeight );
					break;
					
				default :
					
					_width = Math.max( Math.min( _maxWidth , textWidth + padLeftRight + iconWidth + labelIconSpacing ) , _minWidth );
					_height = Math.max( Math.min( _maxHeight , Math.max( textHeight + padTopBottom , iconHeight + padTopBottom ) ) , _minHeight );
					break;
			}
		}
		
		/**
		 * @private
		 */
		protected function _prepareForAutoFit () : void
		{
			if( _textField == null || _textField.width == 0 || _textField.height == 0 ) return;
			
			var fo : TextFormat = _textField.getTextFormat( );
			var rLeading : Number;
			
			if( fo.size < _autoFitMinSize )
			{	
				rLeading = Number( fo.size ) / Number( fo.leading );
				
				fo.size = _autoFitMinSize;
				
				if( _autoAdjustLeading ) fo.leading = Number( fo.size ) / rLeading;
				
				_textField.defaultTextFormat = fo;
				_textField.setTextFormat( fo );
			}
		}
		
		/**
		 * @private
		 */
		protected function _adjustForAutoFit () : void
		{
			if( _textField == null || _textField.width == 0 || _textField.height == 0 ) return;
			
			var fo : TextFormat = _textField.getTextFormat( );
			var rLeading : Number;
			
			if( fo.size > _autoFitMinSize )
			{
				rLeading = Number( fo.size ) / Number( fo.leading );
				
				while( ( _textField.maxScrollH > 0 || _textField.textHeight + TextFieldGutter.VSIZE > _textField.height ) && fo.size > _autoFitMinSize )
				{
					fo.size = uint( fo.size ) - 1;
					_textField.defaultTextFormat = fo;
					_textField.setTextFormat( fo );
					
					if( _autoAdjustLeading ) fo.leading = Number( fo.size ) / rLeading;
				}
			}
			
			if( !_html && fo.size == _autoFitMinSize && ( _textField.maxScrollH > 0 || _textField.textHeight + TextFieldGutter.VSIZE > _textField.height ) )
			{
				var reg : RegExp = new RegExp( /\s/g );
				var a : Array = new Array();
				var result : Object = reg.exec( _text );
				
				while( result != null ) 
				{
					a.push( result );
					result = reg.exec( _textField.text );
				}
				
				while( ( _textField.maxScrollH > 0 || _textField.textHeight + TextFieldGutter.VSIZE > _textField.height ) && _textField.text.length > _overflowTextIndicator.length )
				{
					if( a.length > 1 )
					{
    					_textField.text = _text.substr( 0 , a.pop().index ) + _overflowTextIndicator;
					}
					else
					{
						_textField.text = _textField.text.substr( 0 , _textField.text.length - _overflowTextIndicator.length - 1 ) + _overflowTextIndicator;
					}
				}
			}
			
			var topBottom : Boolean = _labelPlacement == LabelPlacement.TOP || _labelPlacement == LabelPlacement.BOTTOM;
			var padTopBottom : Number = topBottom ? _padding.top + _padding.bottom : 0;
			var iconHeight : Number = topBottom ? this.iconHeight : 0;
			var labelIconSpacing : Number = topBottom ? _iconAsset == null || _textField.text == "" ? 0 : _labelIconSpacing : 0;
			
			var h : Number = _labelPlacement == LabelPlacement.LEFT || _labelPlacement == LabelPlacement.RIGHT ?
									_height - padTopBottom : _height - padTopBottom - iconHeight - labelIconSpacing;
			
			var textHeight : Number = _textField.textHeight + TextFieldGutter.VSIZE;
			
			_textField.height = !_multiline ? textHeight : Math.min( textHeight , h );
			
			var input : Boolean = _textField.type == TextFieldType.INPUT;
			var maximizeTextWidth : Boolean = _maximizeTextWidth || input;
			
			if( !maximizeTextWidth && _textField.numLines == 1 )
				_textField.width = Math.min( _textField.width , _textField.textWidth + TextFieldGutter.HSIZE );
		}
				
		/**
		 * @private
		 */
		protected function _invalidateSize( onlyIfAutoSize : Boolean = false ) : void
		{
			if( _autoSize && _textField != null ) _adjustForAutoSize();
			else if( _autoFit && _textField != null ) {}
			else if( onlyIfAutoSize ) return;
			
			invalidate( InvalidationType.SIZE );
		}
	}
}
