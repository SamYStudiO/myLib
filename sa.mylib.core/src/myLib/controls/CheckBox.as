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
	import myLib.controls.skins.IButtonSkin;
	import myLib.controls.skins.my_skinset;
	import myLib.core.AToggleButton;

	import flash.display.DisplayObjectContainer;
	/**
	 * CheckBox is a selectable Button.
	 * 
	 * @author SamYStudiO ( contact@samystudio.net )
	 */
	public class CheckBox extends AToggleButton implements ICheckBox
	{
		/**
		 * @inheritDoc
		 */
		public override function get groupOwner() : String
		{
			return super.groupOwner;
		}
		
		public override function set groupOwner( group : String ) : void
		{
			throw new Error( this + " CheckBox cannot be part of a group" );
		}
		
		[Inspectable(defaultValue="CheckBox")]
		/**
		 * @inheritDoc
		 */
		public override function get text() : String
		{
			return _textField != null ? _textField.text : null;
		}
		
		public override function set text( s : String ) : void
		{
			if( _textField == null || ( _inspector && !_isLivePreview && text != "CheckBox" ) ) return;
			
			if( !_html )
			{
				_textField.text = _text = s;
				_htmlText = "";
			
				_invalidateSize( );
			}
			else htmlText = s;
		}
		
		/**
		 * Build a new CheckBox instance. Default size is 100*20.
		 * @param parentContainer The parent DisplayObjectContainer where add this CheckBox.
		 * @param initStyle The initial style object for CheckBox initialization.
		 * @param skin The IButtonSkin to use instead of default skin.
		 * 
		 * @see myLib.styles.StyleManager
		 */
		public function CheckBox ( parentContainer : DisplayObjectContainer = null , initStyle : Object = null , skin : IButtonSkin = null )
		{
			super( parentContainer , initStyle , skin == null ? my_skinset.getCheckBoxSkin() : skin );
		}
		
		/**
		 * @private
		 */
		protected override function _init(  ) : void
		{
			if( _textField != null && _textField.text == "" )
				_textField.text = "CheckBox";
				
			super._init();
		}
	}
}
