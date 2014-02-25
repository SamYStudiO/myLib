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
	 * CheckBoxSkin is the default skin for CheckBox component.
	 * Like all other components, default skin use string definition, BitmapData object or external URL to build assets.
	 * To use other values or for complexe skin make your own IButtonSkin implementation.
	 * 
	 * @see myLib.controls.CheckBox
	 * @see myLib.controls.skins.IButtonSkin
	 * @author SamYStudiO ( contact@samystudio.net )
	 */
	public class CheckBoxSkin extends ButtonSkin
	{
		/**
		 * Buid a new CheckBoxSkin instance.
		 * @param textField The textfield asset string definition.
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
		public function CheckBoxSkin ( textField : * = null ,
											iconUp : * = null ,
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
			super( textField == null ? CheckBoxTextField : textField ,
						up == null ? CheckBoxUp : up ,
						over == null ? CheckBoxOver : over ,
						down == null ? CheckBoxDown : down ,
						disabled == null ? CheckBoxDisabled : disabled ,
						upSelected == null ? CheckBoxUpSelected : upSelected ,
						overSelected == null ? CheckBoxOverSelected : overSelected ,
						downSelected == null ? CheckBoxDownSelected : downSelected ,
						disabledSelected == null ? CheckBoxDisabledSelected : disabledSelected ,
							null ,
							iconUp == null ? CheckBoxUp : iconUp ,
							iconOver == null ? CheckBoxOver : iconOver ,
							iconDown == null ? CheckBoxDown : iconDown ,
							iconDisabled == null ? CheckBoxDisabled : iconDisabled ,
							iconUpSelected == null ? CheckBoxUpSelected : iconUpSelected ,
							iconOverSelected == null ? CheckBoxOverSelected : iconOverSelected ,
							iconDownSelected == null ? CheckBoxDownSelected : iconDownSelected ,
							iconDisabledSelected == null ? CheckBoxDisabledSelected : iconDisabledSelected ,
								focusRect == null ? CheckBoxFocusRect : focusRect ,
								errorRect == null ? null : errorRect );
		}
	}
}
