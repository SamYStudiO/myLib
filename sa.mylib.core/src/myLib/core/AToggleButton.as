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
package myLib.core 
{
	import myLib.assets.IAsset;
	import myLib.controls.Button;
	import myLib.controls.LabelAlignment;
	import myLib.controls.skins.IButtonSkin;

	import flash.display.DisplayObjectContainer;
	import flash.utils.getQualifiedClassName;
	/**
	 * AToggleButton is the abstract base class for CheckBox and RadioButton.
	 * 
	 * @author SamYStudiO ( contact@samystudio.net )
	 */
	public class AToggleButton extends Button
	{
		/**
		 * @inheritDoc
		 */
		public override function get selectable() : Boolean
		{
			return _selectable;
		}
		
		public override function set selectable( b : Boolean ) : void
		{
			if( !b ) throw new Error( this + " ToggleButton cannot be non selectable" );
		}
		
		[Inspectable(defaultValue="left",enumeration="left,center,right")]
		/**
		 * @inheritDoc
		 */
		public override function get horizontalAlignment() : String
		{
			return _horizontalAlignment;
		}
		
		public override function set horizontalAlignment( s : String ) : void
		{
			if( _horizontalAlignment == s || ( _inspector && !_isLivePreview && _horizontalAlignment != LabelAlignment.LEFT ) ) return;
			
			_horizontalAlignment = s;
			
			_invalidateSize( );
		}
		
		/**
		 * @private
		 */
		public function AToggleButton ( parentContainer : DisplayObjectContainer = null , initStyle : Object = null , skin : IButtonSkin = null )
		{
			super( parentContainer , initStyle , skin );
			
			if( getQualifiedClassName( this ) == "myLib.core::AToggleButton" )
				throw new Error( this + " Abstract class cannot be instantiated" );
		}
		
		/**
		 * @private
		 */
		protected override function _init(  ) : void
		{
			super._init();
			
			_horizontalAlignment = LabelAlignment.LEFT;
			_selectable = true;
		}
		
		/**
		 * @private
		 */
		protected override function _addIcon( asset : IAsset ) : void
		{
			super._addIcon( asset );
			
			_focusRectTarget = asset;
			_errorRectTarget = asset;
		}
	}
}