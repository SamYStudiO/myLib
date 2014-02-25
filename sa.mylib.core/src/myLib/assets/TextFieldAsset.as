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
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	/**
	 * TextFieldAsset is the base class for all components textField children. 
	 * TextFieldAsset inherit from Sprite, for animated textField assets or button textField use MovieTextFieldAsset class instead.
	 * 
	 * <p>When creating assets in flash library using auto generation class add this class to base class field.</p>
	 *  
	 * @author SamYStudiO ( contact@samystudio.net )
	 */
	public class TextFieldAsset extends Asset implements ITextFieldAsset
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
			_enabled = b;
			
			_textField.selectable = b && _textField.type == TextFieldType.INPUT;
		}

		/**
		 * 
		 */
		public function TextFieldAsset ( textStyle : TextStyle = null )
		{
			var oTextField : DisplayObject = numChildren > 0 ? getChildAt( 0 ) : null;
			
			if( oTextField is TextField )
			{
				_textField = oTextField as TextField;
				
				var fo : TextFormat = _textField.defaultTextFormat;
				
				removeChild( _textField );
				
				_textField = MyTextField.build( 100 , 22 , textStyle != null ? textStyle : new TextStyle( fo ) , _textField );
				
				addChild( _textField );
			}
			else
			{
				_textField = MyTextField.build( 100 , 22 , textStyle );
				addChild( _textField );
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
