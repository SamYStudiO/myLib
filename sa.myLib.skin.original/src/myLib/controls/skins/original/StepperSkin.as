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
	import myLib.controls.Button;
	import myLib.controls.ITextInput;
	import myLib.controls.TextInput;
	import myLib.controls.skins.AFieldSkin;
	import myLib.controls.skins.IButtonSkin;
	import myLib.controls.skins.IStepperSkin;
	import myLib.controls.skins.ITextInputSkin;
	/**
	 * @author SamYStudiO
	 */
	public class StepperSkin extends AFieldSkin implements IStepperSkin 
	{
		/**
		 * Get or set the IButtonSkin for next asset.
		 */
		public var nextButtonSkin : IButtonSkin;

		/**
		 * Get or set the IButtonSkin for previous asset.
		 */
		public var previousButtonSkin : IButtonSkin;
		
		/**
		 * Get or set the ITextInputSkin for TextInput asset.
		 */
		public var textInputSkin : ITextInputSkin;
		
		/**
		 * Get or set the initial style for next asset.
		 */
		public var nextButtonInitStyle : Object;
		
		/**
		 * Get or set the initial style for previous asset.
		 */
		public var previousButtonInitStyle : Object;
		
		/**
		 * Get or set the initial style for TextInput asset.
		 */
		public var textInputInitStyle : Object;
		
		/**
		 * Build a new StepperSkin instance.
		 * @param nextButtonSkin The IButtonSkin for next button asset.
		 * @param previousButtonSkin The IButtonSkin for previous button asset.
		 * @param textInputSkin The IListSkin for List asset.
		 * @param focusRect The focus rectangle asset string definition, BitmapData object or external URL.
		 * @param nextButtonInitStyle istInitStyle The The initial style for next button asset.
		 * @param previousButtonInitStyle istInitStyle The The initial style for previous button asset.		 * @param textInputInitStyle istInitStyle The The initial style for textInput asset.
		 */
		public function StepperSkin ( 	nextButtonSkin : IButtonSkin = null , previousButtonSkin : IButtonSkin = null ,
										textInputSkin : ITextInputSkin = null , focusRect : * = null , errorRect : * = null ,
										nextButtonInitStyle : Object = null , previousButtonInitStyle : Object = null , textInputInitStyle : Object = null )
		{
			this.nextButtonSkin = nextButtonSkin || new ButtonSkin( null , StepperNextUp , StepperNextOver , StepperNextDown , StepperNextDisabled , null , null , null , null , null , StepperNextIconUp , StepperNextIconOver , StepperNextIconDown , StepperNextIconDisabled, null , null , null , null );
			this.previousButtonSkin = previousButtonSkin || new ButtonSkin( null , StepperPreviousUp , StepperPreviousOver , StepperPreviousDown , StepperPreviousDisabled , null , null , null , null , null , StepperPreviousIconUp , StepperPreviousIconOver , StepperPreviousIconDown , StepperPreviousIconDisabled , null , null , null );
			this.textInputSkin = textInputSkin || new TextInputSkin( StepperTextField );
			this.focusRect = focusRect == null ? StepperFocusRect : focusRect;
			this.errorRect = errorRect == null ? null : errorRect;
			
			if( nextButtonInitStyle != null )
			{
				nextButtonInitStyle.autoRepeat = true;				nextButtonInitStyle.autoRepeatDelay = 250;
				nextButtonInitStyle.autoRepeatInterval = 50;			}
			
			if( previousButtonInitStyle != null )
			{
				previousButtonInitStyle.autoRepeat = true;
				previousButtonInitStyle.autoRepeatDelay = 250;
				previousButtonInitStyle.autoRepeatInterval = 50;
			}
			
			this.nextButtonInitStyle = nextButtonInitStyle || { autoRepeat : true , autoRepeatDelay : 250 , autoRepeatInterval : 50 };
			this.previousButtonInitStyle = previousButtonInitStyle || { autoRepeat : true , autoRepeatDelay : 250 , autoRepeatInterval : 50 };			this.textInputInitStyle = textInputInitStyle;
		}

		/**
		 * @inheritDoc
		 */
		public function getNextAsset(  ) : IAsset
		{
			return new Button( null , nextButtonInitStyle , nextButtonSkin );
		}
		
		/**
		 * @inheritDoc
		 */
		public function getPreviousAsset(  ) : IAsset
		{
			return new Button( null , previousButtonInitStyle , previousButtonSkin );
		}
		
		/**
		 * @inheritDoc
		 */
		public function getTextInputAsset(  ) : ITextInput
		{
			return new TextInput( null , textInputInitStyle , textInputSkin );
		}
	}
}
