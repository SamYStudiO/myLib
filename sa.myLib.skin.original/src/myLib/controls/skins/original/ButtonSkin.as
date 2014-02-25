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
package myLib.controls.skins.original 
{
	import myLib.assets.IAsset;
	import myLib.assets.ITextFieldAsset;
	import myLib.controls.skins.AFieldSkin;
	import myLib.controls.skins.IButtonSkin;
	/**
	 * ButtonSkin is the default skin for Button component.
	 * Like all other components, default skin use string definition, BitmapData object or external URL to build assets.
	 * To use other values or for complexe skin make your own IButtonSkin implementation.
	 * 
	 * @see myLib.controls.Button	 * @see myLib.controls.skins.IButtonSkin
	 * @author SamYStudiO ( contact@samystudio.net )
	 */
	public class ButtonSkin extends AFieldSkin implements IButtonSkin
	{
		/**
		 * Get or set the textfield asset string definition.
		 */
		public var textField : *;

		/**
		 * Get or set the up state asset string definition, BitmapData object or external URL.
		 */
		public var up : *;

		/**
		 * Get or set the up selected state asset string definition, BitmapData object or external URL.
		 */
		public var upSelected : *;

		/**
		 * Get or set the over state asset string definition, BitmapData object or external URL.
		 */
		public var over : *;

		/**
		 * Get or set the over selected state asset string definition, BitmapData object or external URL.
		 */
		public var overSelected : *;

		/**
		 * Get or set the down state asset string definition, BitmapData object or external URL.
		 */
		public var down : *;

		/**
		 * Get or set the down selected state asset string definition, BitmapData object or external URL.
		 */
		public var downSelected : *;

		/**
		 * Get or set the disabled state asset string definition, BitmapData object or external URL.
		 */
		public var disabled : *;

		/**
		 * Get or set the disabled selected state asset string definition, BitmapData object or external URL.
		 */
		public var disabledSelected : *;
		
		/**
		 * Get or set icon (common for all states) asset string definition, BitmapData object or external URL.
		 */
		public var icon : *;

		/**
		 * Get or set the icon up state asset string definition, BitmapData object or external URL.
		 */
		public var iconUp : *;

		/**
		 * Get or set the icon up selected state asset string definition, BitmapData object or external URL.
		 */
		public var iconUpSelected : *;

		/**
		 * Get or set the icon over state asset string definition, BitmapData object or external URL.
		 */
		public var iconOver : *;

		/**
		 * Get or set the icon over selected state asset string definition, BitmapData object or external URL.
		 */
		public var iconOverSelected : *;

		/**
		 * Get or set the icon down state asset string definition, BitmapData object or external URL.
		 */
		public var iconDown : *;

		/**
		 * Get or set the icon down selected state asset string definition, BitmapData object or external URL.
		 */
		public var iconDownSelected : *;

		/**
		 * Get or set the icon disabled state asset string definition, BitmapData object or external URL.
		 */
		public var iconDisabled : *;

		/**
		 * Get or set the icon disabled selected state asset string definition, BitmapData object or external URL.
		 */
		public var iconDisabledSelected : *;

		/**
		 * Buid a new ButtonSkin instance.
		 * @param textField The textfield asset string definition.		 * @param up The up state asset string definition, BitmapData object or external URL.		 * @param over The over state asset string definition, BitmapData object or external URL.		 * @param down The down state asset string definition, BitmapData object or external URL.		 * @param disabled The disabled state asset string definition, BitmapData object or external URL.		 * @param upSelected The upSelected state asset string definition, BitmapData object or external URL.		 * @param overSelected The overSelected state asset string definition, BitmapData object or external URL.		 * @param downSelected The downSelected state asset string definition, BitmapData object or external URL.		 * @param disabledSelected The disabledSelected state asset string definition, BitmapData object or external URL.		 * @param icon The icon (common for all states) asset string definition, BitmapData object or external URL.		 * @param iconUp The icon up state asset string definition, BitmapData object or external URL.		 * @param iconOver The icon over state asset string definition, BitmapData object or external URL.		 * @param iconDown The icon down state asset string definition, BitmapData object or external URL.		 * @param iconDisabled The icon disabled state asset string definition, BitmapData object or external URL.		 * @param iconUpSelected The icon up selected state asset string definition, BitmapData object or external URL.		 * @param iconOverSelected The icon over selected state asset string definition, BitmapData object or external URL.		 * @param iconDownSelected The icon down selected state asset string definition, BitmapData object or external URL.		 * @param iconDisabledSelected The icon disabled selected state asset string definition, BitmapData object or external URL.
		 * @param focusRect The focus rectangle asset string definition, BitmapData object or external URL.
		 */
		public function ButtonSkin ( textField : * = null ,
										up : * = null ,
										over : * = null ,
										down : * = null ,										disabled : * = null ,
										upSelected : * = null ,										overSelected : * = null ,
										downSelected : * = null ,
										disabledSelected : * = null ,
											icon : * = null ,
 											iconUp : * = null ,											iconOver : * = null ,
											iconDown : * = null ,											iconDisabled : * = null ,
											iconUpSelected : * = null ,											iconOverSelected : * = null ,
											iconDownSelected : * = null ,
											iconDisabledSelected : * = null ,
												focusRect : * = null ,
												errorRect : * = null )
		{
			this.textField = textField == null ? ButtonTextField : textField;						this.up = up == null ? ButtonUp : up;
			this.over = over == null ? ButtonOver : over;			this.down = down == null ? ButtonDown : down;
			this.disabled = disabled == null ? ButtonDisabled : disabled;
			this.upSelected = upSelected == null ? ButtonUpSelected : upSelected;
			this.overSelected = overSelected == null ? ButtonUp : overSelected;
			this.downSelected = downSelected == null ? ButtonDownSelected : downSelected;
			this.disabledSelected = disabledSelected == null ? ButtonDisabledSelected : disabledSelected;						this.iconUp = iconUp == null ? icon == null ? ButtonIconUp : ButtonIcon : iconUp;			this.iconOver = iconOver == null ? icon == null ? ButtonIconOver : ButtonIcon : iconOver;			this.iconDown = iconDown == null ? icon == null ? ButtonIconDown : ButtonIcon : iconDown;			this.iconDisabled = iconDisabled == null ? icon == null ? ButtonIconDisabled : ButtonIcon : iconDisabled;
			this.iconUpSelected = iconUpSelected == null ? icon == null ? ButtonIconUpSelected : ButtonIcon : iconUpSelected;			this.iconOverSelected = iconOverSelected == null ? icon == null ? ButtonIconOverSelected : ButtonIcon : iconOverSelected;			this.iconDownSelected = iconDownSelected == null ? icon == null ? ButtonIconDownSelected : ButtonIcon : iconDownSelected;			this.iconDisabledSelected = iconDisabledSelected == null ? icon == null ? ButtonIconDisabledSelected : ButtonIcon : iconDisabledSelected;
			
			this.focusRect = focusRect == null ? ButtonFocusRect : focusRect;
			this.errorRect = errorRect == null ? null : errorRect;
		}

		/**
		 * @inheritDoc
		 */
		public function getTextFieldAsset (  ) : ITextFieldAsset
		{
			return _getTextFieldAsset( textField );
		}

		/**
		 * @inheritDoc
		 */
		public function getUpAsset (  ) : IAsset
		{
			return _getAsset( up );
		}

		/**
		 * @inheritDoc
		 */
		public function getUpSelectedAsset (  ) : IAsset
		{
			return _getAsset( upSelected );
		}

		/**
		 * @inheritDoc
		 */
		public function getOverAsset (  ) : IAsset
		{
			return _getAsset( over );
		}

		/**
		 * @inheritDoc
		 */
		public function getOverSelectedAsset (  ) : IAsset
		{
			return _getAsset( overSelected );
		}

		/**
		 * @inheritDoc
		 */
		public function getDownAsset (  ) : IAsset
		{
			return _getAsset( down );
		}

		/**
		 * @inheritDoc
		 */
		public function getDownSelectedAsset (  ) : IAsset
		{
			return _getAsset( downSelected );
		}

		/**
		 * @inheritDoc
		 */
		public function getDisabledAsset (  ) : IAsset
		{
			return _getAsset( disabled );
		}

		/**
		 * @inheritDoc
		 */
		public function getDisabledSelectedAsset (  ) : IAsset
		{
			return _getAsset( disabledSelected );
		}

		/**
		 * @inheritDoc
		 */
		public function getIconUpAsset ( ) : IAsset
		{
			return _getAsset( iconUp );
		}

		/**
		 * @inheritDoc
		 */
		public function getIconUpSelectedAsset ( ) : IAsset
		{
			return _getAsset( iconUpSelected );
		}

		/**
		 * @inheritDoc
		 */
		public function getIconOverAsset ( ) : IAsset
		{
			return _getAsset( iconOver );
		}

		/**
		 * @inheritDoc
		 */
		public function getIconOverSelectedAsset ( ) : IAsset
		{
			return _getAsset( iconOverSelected );
		}

		/**
		 * @inheritDoc
		 */
		public function getIconDownAsset ( ) : IAsset
		{
			return _getAsset( iconDown );
		}

		/**
		 * @inheritDoc
		 */
		public function getIconDownSelectedAsset ( ) : IAsset
		{
			return _getAsset( iconDownSelected );
		}

		/**
		 * @inheritDoc
		 */
		public function getIconDisabledAsset ( ) : IAsset
		{
			return _getAsset( iconDisabled );
		}

		/**
		 * @inheritDoc
		 */
		public function getIconDisabledSelectedAsset ( ) : IAsset
		{
			return _getAsset( iconDisabledSelected );
		}		
	}
}
