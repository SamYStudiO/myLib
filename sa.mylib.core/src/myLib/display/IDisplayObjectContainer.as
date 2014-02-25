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
	import myLib.display.IInteractiveObject;
	
	import flash.display.DisplayObject;
	import flash.geom.Point;
	import flash.text.TextSnapshot;	
	/**
	 * @author SamYStudiO ( contact@samystudio.net )
	 */
	public interface IDisplayObjectContainer extends IInteractiveObject 
	{
		/**
		 * @see http://help.adobe.com/en_US/AS3LCR/Flash_10.0/flash/display/DisplayObjectContainer.html#mouseChildren flash.display.DisplayObjectContainer.mouseChildren
		 */
		function get mouseChildren () : Boolean;
		function set mouseChildren ( enable : Boolean ) : void;
		
		/**
		 * @see http://help.adobe.com/en_US/AS3LCR/Flash_10.0/flash/display/DisplayObjectContainer.html#numChildren flash.display.DisplayObjectContainer.numChildren
		 */
		function get numChildren () : int;
		
		/**
		 * @see http://help.adobe.com/en_US/AS3LCR/Flash_10.0/flash/display/DisplayObjectContainer.html#tabChildren flash.display.DisplayObjectContainer.tabChildren
		 */
		function get tabChildren () : Boolean;
		function set tabChildren ( enable : Boolean ) : void;
		
		/**
		 * @see http://help.adobe.com/en_US/AS3LCR/Flash_10.0/flash/display/DisplayObjectContainer.html#textSnapshot flash.display.DisplayObjectContainer.textSnapshot
		 */
		function get textSnapshot () : TextSnapshot;
		
		/**
		 * @see http://help.adobe.com/en_US/AS3LCR/Flash_10.0/flash/display/DisplayObjectContainer.html#addChild() flash.display.DisplayObjectContainer.addChild()
		 */
		function addChild ( child : DisplayObject ) : DisplayObject;
		
		/**
		 * @see http://help.adobe.com/en_US/AS3LCR/Flash_10.0/flash/display/DisplayObjectContainer.html#addChildAt() flash.display.DisplayObjectContainer.addChildAt()
		 */
		function addChildAt ( child : DisplayObject , index : int ) : DisplayObject;
		
		/**
		 * @see http://help.adobe.com/en_US/AS3LCR/Flash_10.0/flash/display/DisplayObjectContainer.html#areInaccessibleObjectsUnderPoint() flash.display.DisplayObjectContainer.areInaccessibleObjectsUnderPoint()
		 */
		function areInaccessibleObjectsUnderPoint ( point : Point ) : Boolean;
		
		/**
		 * @see http://help.adobe.com/en_US/AS3LCR/Flash_10.0/flash/display/DisplayObjectContainer.html#contains() flash.display.DisplayObjectContainer.contains()
		 */
		function contains ( child : DisplayObject ) : Boolean;
		
		/**
		 * @see http://help.adobe.com/en_US/AS3LCR/Flash_10.0/flash/display/DisplayObjectContainer.html#getChildAt() flash.display.DisplayObjectContainer.getChildAt()
		 */
		function getChildAt ( index : int ) : DisplayObject;
		
		/**
		 * @see http://help.adobe.com/en_US/AS3LCR/Flash_10.0/flash/display/DisplayObjectContainer.html#getChildByName() flash.display.DisplayObjectContainer.getChildByName()
		 */
		function getChildByName ( name : String ) : DisplayObject;
		
		/**
		 * @see http://help.adobe.com/en_US/AS3LCR/Flash_10.0/flash/display/DisplayObjectContainer.html#getChildIndex() flash.display.DisplayObjectContainer.getChildIndex()
		 */
		function getChildIndex ( child : DisplayObject ) : int;
		
		/**
		 * @see http://help.adobe.com/en_US/AS3LCR/Flash_10.0/flash/display/DisplayObjectContainer.html#getObjectsUnderPoint() flash.display.DisplayObjectContainer.getObjectsUnderPoint()
		 */
		function getObjectsUnderPoint ( point : Point ) : Array;
		
		/**
		 * @see http://help.adobe.com/en_US/AS3LCR/Flash_10.0/flash/display/DisplayObjectContainer.html#removeChild() flash.display.DisplayObjectContainer.removeChild()
		 */
		function removeChild ( child : DisplayObject ) : DisplayObject;
		
		/**
		 * @see http://help.adobe.com/en_US/AS3LCR/Flash_10.0/flash/display/DisplayObjectContainer.html#removeChildAt() flash.display.DisplayObjectContainer.removeChildAt()
		 */
		function removeChildAt ( index : int ) : DisplayObject;
		
		/**
		 * @see http://help.adobe.com/en_US/AS3LCR/Flash_10.0/flash/display/DisplayObjectContainer.html#setChildIndex() flash.display.DisplayObjectContainer.setChildIndex()
		 */
		function setChildIndex ( child : DisplayObject , index : int ) : void;
		
		/**
		 * @see http://help.adobe.com/en_US/AS3LCR/Flash_10.0/flash/display/DisplayObjectContainer.html#swapChildren() flash.display.DisplayObjectContainer.swapChildren()
		 */
		function swapChildren ( child1 : DisplayObject , child2 : DisplayObject ) : void;
		
		/**
		 * @see http://help.adobe.com/en_US/AS3LCR/Flash_10.0/flash/display/DisplayObjectContainer.html#swapChildrenAt() flash.display.DisplayObjectContainer.swapChildrenAt()
		 */
		function swapChildrenAt ( index1 : int , index2 : int ) : void;
	}
}
