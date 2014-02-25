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
package myLib.styles 
{
	import flash.text.FontStyle;
	import flash.text.Font;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	/**
	 * The TextStyle class contains all style informations for a TextField.
	 * When a TextStyle is associated with a TextField all its properties are merged with that TextField.
	 * TextStyle is dynamic so you can add any properties that match a TextField property.
	 * 
	 * @see myLib.styles.StyleManager
	 * 
	 * @author SamYStudiO ( contact@samystudio.net )
	 */
	public dynamic class TextStyle 
	{
		/**
		 * Get the default TextFormat object apply to TextField instance.
		 */
		public static var DEFAULT_TEXT_FORMAT : TextFormat = new TextFormat( 	"_sans" ,
																				11 ,
																				0x000000 ,
																				false ,
																				false ,
																				false ,
																				null ,
																				null ,
																				TextFormatAlign.LEFT ,
																				0 ,
																				0 ,
																				0 ,
																				0 );
																				
		
		
		/**
		 * @private
		 */
		protected var _embedFonts : Boolean;
		
		/**
		 * A Boolean that indicates if embed fonts are used with this style object.
		 * while bitmapFonts is true embedFonts will always return true since bitmap fonts only displayed when embeded
		 * 
		 * @default false
		 */
		public function get embedFonts() : Boolean
		{
			return _embedFonts || _bitmapFonts;
		}
		
		public function set embedFonts( b : Boolean ) : void
		{
			_embedFonts = b;
		}
		
		
		/**
		 * @private
		 */
		protected var _bitmapFonts : Boolean;
		
		/**
		 * A Boolean that indicates if bitmap fonts are used with this style object.
		 * 
		 * @default false
		 */
		public function get bitmapFonts() : Boolean
		{
			return _bitmapFonts;
		}
		
		public function set bitmapFonts( b : Boolean ) : void
		{
			if( _bitmapFonts == b ) return;
			
			_bitmapFonts = b;
			
			_updateTextFormat();
		}
		
		/**
		 * Get or set the TextFormat object associated with this style object.
		 */
		/**
		 * @private
		 */
		protected var _textFormat : TextFormat;
		
		/**
		 *
		 */
		public function get textFormat() : TextFormat
		{
			if( bitmapFonts && _textFormat.font.indexOf( "pt_st" ) < 0 )
			{
				var embedFonts : Array = Font.enumerateFonts();
				var l : uint = embedFonts.length;
				
				for( var i : uint = 0; i < l; i++ )
				{
					var font : Font = embedFonts[ i ] as Font;
					var fontName : String = font.fontName;
					var fontBold : Boolean = font.fontStyle == FontStyle.BOLD || FontStyle.BOLD_ITALIC;
					var fontItalic : Boolean = font.fontStyle == FontStyle.ITALIC || FontStyle.BOLD_ITALIC;
					
					var bitmapFontName : String = _textFormat.font + "_" + _textFormat.size + "pt_st";
					
					if( fontName == bitmapFontName && fontBold == _textFormat.bold && fontItalic == _textFormat.italic )
					{
						_textFormat.font = bitmapFontName;
					}
				}
			}
			
			return _textFormat;
		}
		
		/**
		 * Build a new TextStyle instance.
		 * @param textFormat The TextFormat object associated with this style object.		 * @param embedFonts A Boolean that indicates if embed fonts are used with this style object.
		 */
		public function TextStyle( textFormat : TextFormat = null , bitmapFonts : Boolean = false , useEmbedFonts : * = null )
		{
			setTextFormat( textFormat || DEFAULT_TEXT_FORMAT , bitmapFonts , useEmbedFonts );
		}
		
		/**
		 * 
		 */
		public function setTextFormat( fo : TextFormat , bitmapFonts : Boolean = false , useEmbedFonts : * = null ) : void
		{
			_textFormat = fo;
			_bitmapFonts = bitmapFonts;
			
			if( fo != null && useEmbedFonts == null )
			{
				var embedFonts : Array = Font.enumerateFonts();
				var l : uint = embedFonts.length;
				
				for( var i : uint = 0; i < l; i++ )
				{
					if( embedFonts[ i ].fontName == textFormat.font )
					{
						_embedFonts = true;
						return;
					}
				}
				
				_embedFonts = false;
			}
			else _embedFonts = Boolean( useEmbedFonts );
		}
		
		/**
		 * @private
		 */
		protected function _updateTextFormat(  ) : void
		{
			//TODO complete this
		}
	}
}
