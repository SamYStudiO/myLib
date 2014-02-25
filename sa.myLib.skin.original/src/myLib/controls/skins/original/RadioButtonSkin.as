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
	/**
	 * RadioButtonSkin is the default skin for RadioButton component.
	 * Like all other components, default skin use string definition, BitmapData object or external URL to build assets.
	 * To use other values or for complexe skin make your own IButtonSkin implementation.
	 * 
	 * @see myLib.controls.RadioButton
	 * @see myLib.controls.skins.IButtonSkin
	 * @author SamYStudiO ( contact@samystudio.net )
	 */
	public class RadioButtonSkin extends ButtonSkin
	{
		/**
		 * Buid a new RadioButtonSkin instance.
		 * @param textField The textfield asset string definition.
		 * @param iconUp The icon up state asset string definition, BitmapData object or external URL.
		 * @param iconOver The icon over state asset string definition, BitmapData object or external URL.
		 * @param iconDown The icon down state asset string definition, BitmapData object or external URL.
		 * @param iconDisabled The icon disabled state asset string definition, BitmapData object or external URL.
		 * @param iconUpSelected The icon up selected state asset string definition, BitmapData object or external URL.
		 * @param iconOverSelected The icon over selected state asset string definition, BitmapData object or external URL.
		 * @param iconDownSelected The icon down selected state asset string definition, BitmapData object or external URL.
		 * @param iconDisabledSelected The icon disabled selected state asset string definition, BitmapData object or external URL.
		 * @param up The up state asset string definition, BitmapData object or external URL.
		 * @param over The over state asset string definition, BitmapData object or external URL.
		 * @param down The down state asset string definition, BitmapData object or external URL.
		 * @param disabled The disabled state asset string definition, BitmapData object or external URL.
		 * @param upSelected The upSelected state asset string definition, BitmapData object or external URL.
		 * @param overSelected The overSelected state asset string definition, BitmapData object or external URL.
		 * @param downSelected The downSelected state asset string definition, BitmapData object or external URL.
		 * @param disabledSelected The disabledSelected state asset string definition, BitmapData object or external URL.
		 * @param focusRect The focus rectangle asset string definition, BitmapData object or external URL.
		 */
		public function RadioButtonSkin ( textField : * = null,											iconUp : * = null ,
											iconOver : * = null ,
											iconDown : * = null ,
											iconDisabled : * = null ,
											iconUpSelected : * = null ,
											iconOverSelected : * = null ,
											iconDownSelected : * = null ,
											iconDisabledSelected : * = null , 
												up : * = null ,
												over : * = null ,
												down : * = null ,
												disabled : * = null ,
												upSelected : * = null ,
												overSelected : * = null ,
												downSelected : * = null ,
												disabledSelected : * = null ,
													focusRect : * = null ,
													errorRect : * = null )
		{
			super( textField == null ? RadioButtonTextField : textField ,
						up == null ? RadioButtonUp : up ,
						over == null ? RadioButtonOver : over ,
						down == null ? RadioButtonDown : down ,
						disabled == null ? RadioButtonDisabled : disabled ,
						upSelected == null ? RadioButtonUpSelected : upSelected ,
						overSelected == null ? RadioButtonOverSelected : overSelected ,
						downSelected == null ? RadioButtonDownSelected : downSelected ,
						disabledSelected == null ? RadioButtonDisabledSelected : disabledSelected ,
							null ,
							iconUp == null ? RadioButtonUp : iconUp ,
							iconOver == null ? RadioButtonOver : iconOver ,
							iconDown == null ? RadioButtonDown : iconDown ,
							iconDisabled == null ? RadioButtonDisabled : iconDisabled ,
							iconUpSelected == null ? RadioButtonUpSelected : iconUpSelected ,
							iconOverSelected == null ? RadioButtonOverSelected : iconOverSelected ,
							iconDownSelected == null ? RadioButtonDownSelected : iconDownSelected ,
							iconDisabledSelected == null ? RadioButtonDisabledSelected : iconDisabledSelected ,
								focusRect == null ? RadioButtonFocusRect : focusRect ,
								errorRect == null ? null : errorRect );
		}
	}
}
