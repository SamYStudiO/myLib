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
	import myLib.core.MyTextField;
	import myLib.displayUtils.TextFieldGutter;
	import myLib.styles.TextStyle;

	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	/**
	 * MovieTextFieldAsset is the base class for all components textField children. 
	 * MovieTextFieldAsset inherit from MovieClip, for static textField assets use TextFieldAsset class instead.
	 * 
	 * <p>When creating assets in flash library using auto generation class add this class to base class field.</p>
	 *  
	 * @author SamYStudiO ( contact@samystudio.net )
	 */
	public class MovieTextFieldAsset extends MovieAsset implements IMovieTextFieldAsset
	{
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
		protected var _textFieldHandler : Sprite;
		
		/**
		 * Get the TextField DisplayObjectContainer.
		 */
		public function get textFieldHandler () : Sprite
		{
			return _textFieldHandler;
		}
		
		/**
		 * @inheritDoc
		 */	 
		public override function get width() : Number
		{
			return _textField.width;
		}
		
		/**
		 * @inheritDoc
		 */	 
		public override function get height() : Number
		{
			return _textField.height;
		}
		
		/**
		 * @inheritDoc
		 */	 
		public override function set enabled( b : Boolean ) : void
		{
			super.enabled = b;
			
			_textField.selectable = b && _textField.type == TextFieldType.INPUT;
		}
		
		/**
		 * 
		 */
		public function MovieTextFieldAsset ( textStyle : TextStyle = null )
		{
			var oHandler : DisplayObject = numChildren > 0 ? getChildAt( 0 ) : null;
			
			if( oHandler != null && oHandler is Sprite ) _textFieldHandler = oHandler as Sprite;	
			else
			{
				_textFieldHandler = new Sprite();
				addChild( _textFieldHandler );	
			}
			
			var oTextField : DisplayObject = _textFieldHandler.numChildren > 0 ? _textFieldHandler.getChildAt( 0 ) : null;
			
			if( oTextField is TextField )
			{
				_textField = oTextField as TextField;
				
				var fo : TextFormat = _textField.defaultTextFormat;
				
				_textFieldHandler.removeChild( _textField );
				
				_textField = MyTextField.build( 100 , 22 , textStyle != null ? textStyle : new TextStyle( fo ) , _textField );
				
				_textFieldHandler.addChild( _textField );	
			}
			else
			{
				_textField = MyTextField.build( 100 , 22 , textStyle );
				_textFieldHandler.addChild( _textField );
			}
		}
		
		/**
		 * @inheritDoc
		 */
		public override function draw(  ) : void
		{
			_textField.width = _width;
			_textField.height = _textField.textHeight + TextFieldGutter.VSIZE;
		}
	}
}
