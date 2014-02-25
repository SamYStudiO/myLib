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
 * The Original Code is myLib Framework.
 *
 * The Initial Developer of the Original Code is
 * Samuel EMINET (aka SamYStudiO) contact@samystudio.net.
 * Portions created by the Initial Developer are Copyright (C) 2008-2011
 * the Initial Developer. All Rights Reserved.
 *
 */
package myLib.display 
{
	import flash.display.DisplayObject;
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	import flash.media.SoundTransform;	
	/**
	 * @author SamYStudiO ( contact@samystudio.net )
	 */
	public interface ISprite extends IDisplayObjectContainer 
	{
		/**
		 * @see http://help.adobe.com/en_US/AS3LCR/Flash_10.0/flash/display/Sprite.html#buttonMode flash.display.Sprite.buttonMode
		 */
		function get buttonMode () : Boolean;
		function set buttonMode ( value : Boolean ) : void;
		
		/**
		 * @see http://help.adobe.com/en_US/AS3LCR/Flash_10.0/flash/display/Sprite.html#dropTarget flash.display.Sprite.dropTarget
		 */
		function get dropTarget () : DisplayObject;
		
		/**
		 * @see http://help.adobe.com/en_US/AS3LCR/Flash_10.0/flash/display/Sprite.html#graphics flash.display.Sprite.graphics
		 */
		function get graphics () : Graphics;
		
		/**
		 * @see http://help.adobe.com/en_US/AS3LCR/Flash_10.0/flash/display/Sprite.html#hitArea flash.display.Sprite.hitArea
		 */
		function get hitArea () : Sprite;
		function set hitArea ( value : Sprite ) : void;
		
		/**
		 * @see http://help.adobe.com/en_US/AS3LCR/Flash_10.0/flash/display/Sprite.html#soundTransform flash.display.Sprite.soundTransform
		 */
		function get soundTransform () : SoundTransform;
		function set soundTransform ( sndTransform : SoundTransform ) : void;
		
		/**
		 * @see http://help.adobe.com/en_US/AS3LCR/Flash_10.0/flash/display/Sprite.html#useHandCursor flash.display.Sprite.useHandCursor
		 */
		function get useHandCursor () : Boolean;
		function set useHandCursor ( value : Boolean ) : void;
		
		/**
		 * @see http://help.adobe.com/en_US/AS3LCR/Flash_10.0/flash/display/Sprite.html#stopDrag() flash.display.Sprite.stopDrag()
		 */
		function stopDrag () : void;
		
		/**
		 * @see http://help.adobe.com/en_US/AS3LCR/Flash_10.0/flash/display/Sprite.html#startDrag() flash.display.Sprite.startDrag()
		 */
		function startDrag (lockCenter : Boolean = false , bounds : Rectangle = null) : void;
	}
}
