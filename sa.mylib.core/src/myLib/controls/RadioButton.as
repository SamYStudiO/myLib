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
	 * RadioButton is a selectable Button.
	 * 
	 * @author SamYStudiO ( contact@samystudio.net )
	 */
	public class RadioButton extends AToggleButton implements IRadioButton
	{
		[Inspectable(defaultValue="RadioButton")]
		/**
		 * @inheritDoc
		 */
		public override function get text() : String
		{
			return super.text;
		}
		
		public override function set text( s : String ) : void
		{
			if( _textField == null || ( _inspector && !_isLivePreview && text != "RadioButton" ) ) return;
			
			if( !_html )
			{
				_textField.text = _text = s;
				_htmlText = "";
			
				_invalidateSize( );
			}
			else htmlText = s;
		}
		
		[Inspectable(defaultValue="default")]
		/**
		 * @inheritDoc
		 */
		public override function get groupOwner() : String
		{
			return super.groupOwner;
		}
		
		public override function set groupOwner( groupName : String ) : void
		{
			if( groupName == _groupOwner || ( _inspector && !_isLivePreview && _groupOwner != "default" ) ) return;
			
			if( _groupOwner != null && ( groupName == "" || groupName == null ) )
			{
				var g : ButtonGroup = ButtonGroup.getGroup( _groupOwner );
			
				if( g != null )
					g.removeItem( this );
			}
			
			if( groupName != "" && groupName != null && parent != null )
				ButtonGroup.getGroup( groupName , true ).addItem( this );
			
			mouseEnabled = ( groupName == ""  || groupName == null || !_selected ) && _enabled;

			_groupOwner = groupName;
		}
		
		/**
		 * Build a new RadioButton instance. Default size is 100*20.
		 * @param parentContainer The parent DisplayObjectContainer where add this RadioButton.
		 * @param initStyle The initial style object for RadioButton initialization.
		 * @param skin The IButtonSkin to use instead of default skin.
		 * 
		 * @see myLib.styles.StyleManager
		 */
		public function RadioButton ( parentContainer : DisplayObjectContainer = null , initStyle : Object = null , skin : IButtonSkin = null )
		{
			super( parentContainer , initStyle , skin == null ? my_skinset.getRadioButtonSkin() : skin );
		}
		
		/**
		 * @private
		 */
		protected override function _init(  ) : void
		{
			if( _textField != null && _textField.text == "" )
				_textField.text = "RadioButton";
				
			super._init();
			
			groupOwner = "default";
		}
	}
}
