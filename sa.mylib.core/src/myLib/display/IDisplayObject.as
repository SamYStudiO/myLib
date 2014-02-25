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
	import flash.accessibility.AccessibilityProperties;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.IBitmapDrawable;
	import flash.display.LoaderInfo;
	import flash.display.Stage;
	import flash.events.IEventDispatcher;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.geom.Transform;		
	/**
	 * @author SamYStudiO ( contact@samystudio.net )
	 */
	public interface IDisplayObject extends IEventDispatcher , IBitmapDrawable
	{
		/**
		 * @see http://help.adobe.com/en_US/AS3LCR/Flash_10.0/flash/display/DisplayObject.html#accessibilityProperties flash.display.DisplayObject.accessibilityProperties
		 */
		function get accessibilityProperties () : AccessibilityProperties;
		function set accessibilityProperties ( value : AccessibilityProperties ) : void;
		
		/**
		 * @see http://help.adobe.com/en_US/AS3LCR/Flash_10.0/flash/display/DisplayObject.html#alpha flash.display.DisplayObject.alpha
		 */
		function get alpha () : Number;
		function set alpha ( n : Number ) : void;
		
		/**
		 * @see http://help.adobe.com/en_US/AS3LCR/Flash_10.0/flash/display/DisplayObject.html#blendMode flash.display.DisplayObject.blendMode
		 */
		function get blendMode () : String;
		function set blendMode ( s : String ) : void;
		
		/**
		 * @see http://help.adobe.com/en_US/AS3LCR/Flash_10.0/flash/display/DisplayObject.html#cacheAsBitmap flash.display.DisplayObject.cacheAsBitmap
		 */
		function get cacheAsBitmap () : Boolean;
		function set cacheAsBitmap ( b : Boolean ) : void;
		
		/**
		 * @see http://help.adobe.com/en_US/AS3LCR/Flash_10.0/flash/display/DisplayObject.html#filters flash.display.DisplayObject.filters
		 */
		function get filters () : Array;
		function set filters ( a : Array ) : void;
		
		/**
		 * @see http://help.adobe.com/en_US/AS3LCR/Flash_10.0/flash/display/DisplayObject.html#height flash.display.DisplayObject.height
		 */
		function get height() : Number;
		function set height( h : Number ) : void;
		
		/**
		 * @see http://help.adobe.com/en_US/AS3LCR/Flash_10.0/flash/display/DisplayObject.html#loaderInfo flash.display.DisplayObject.loaderInfo
		 */
		function get loaderInfo () : LoaderInfo;
		
		/**
		 * @see http://help.adobe.com/en_US/AS3LCR/Flash_10.0/flash/display/DisplayObject.html#mask flash.display.DisplayObject.mask
		 */
		function get mask () : DisplayObject;
		function set mask ( o : DisplayObject ) : void;
		
		/**
		 * @see http://help.adobe.com/en_US/AS3LCR/Flash_10.0/flash/display/DisplayObject.html#mouseX flash.display.DisplayObject.mouseX
		 */
		function get mouseX () : Number;
		
		/**
		 * @see http://help.adobe.com/en_US/AS3LCR/Flash_10.0/flash/display/DisplayObject.html#mouseY flash.display.DisplayObject.mouseY
		 */
		function get mouseY () : Number;
		
		/**
		 * @see http://help.adobe.com/en_US/AS3LCR/Flash_10.0/flash/display/DisplayObject.html#name flash.display.DisplayObject.name
		 */
		function get name () : String;
		function set name ( s : String ) : void;
		
		/**
		 * @see http://help.adobe.com/en_US/AS3LCR/Flash_10.0/flash/display/DisplayObject.html#opaqueBackground flash.display.DisplayObject.opaqueBackground
		 */
		function get opaqueBackground () : Object;
		function set opaqueBackground ( o : Object ) : void;
		
		/**
		 * @see http://help.adobe.com/en_US/AS3LCR/Flash_10.0/flash/display/DisplayObject.html#parent flash.display.DisplayObject.parent
		 */
		function get parent () : DisplayObjectContainer;
		
		/**
		 * @see http://help.adobe.com/en_US/AS3LCR/Flash_10.0/flash/display/DisplayObject.html#root flash.display.DisplayObject.root
		 */
		function get root () : DisplayObject;
		
		/**
		 * @see http://help.adobe.com/en_US/AS3LCR/Flash_10.0/flash/display/DisplayObject.html#rotation flash.display.DisplayObject.rotation
		 */
		function get rotation () : Number;
		function set rotation ( b : Number ) : void;
		
		/**
		 * @see http://help.adobe.com/en_US/AS3LCR/Flash_10.0/flash/display/DisplayObject.html#scale9Grid flash.display.DisplayObject.scale9Grid
		 */
		function get scale9Grid () : Rectangle;
		function set scale9Grid ( innerRectangle : Rectangle ) : void;
		
		/**
		 * @see http://help.adobe.com/en_US/AS3LCR/Flash_10.0/flash/display/DisplayObject.html#scaleX flash.display.DisplayObject.scaleX
		 */
		function get scaleX() : Number;
		function set scaleX( scale : Number ) : void;
		
		/**
		 * @see http://help.adobe.com/en_US/AS3LCR/Flash_10.0/flash/display/DisplayObject.html#scaleY flash.display.DisplayObject.scaleY
		 */
		function get scaleY() : Number;
		function set scaleY( scale : Number ) : void;
		
		/**
		 * @see http://help.adobe.com/en_US/AS3LCR/Flash_10.0/flash/display/DisplayObject.html#scrollRect flash.display.DisplayObject.scrollRect
		 */
		function get scrollRect () : Rectangle;
		function set scrollRect ( r : Rectangle ) : void;
		
		/**
		 * @see http://help.adobe.com/en_US/AS3LCR/Flash_10.0/flash/display/DisplayObject.html#stage flash.display.DisplayObject.stage
		 */
		function get stage () : Stage;
		
		/**
		 * @see http://help.adobe.com/en_US/AS3LCR/Flash_10.0/flash/display/DisplayObject.html#transform flash.display.DisplayObject.transform
		 */
		function get transform () : Transform;
		function set transform ( t : Transform ) : void;
		
		/**
		 * @see http://help.adobe.com/en_US/AS3LCR/Flash_10.0/flash/display/DisplayObject.html#visible flash.display.DisplayObject.visible
		 */
		function get visible() : Boolean;
		function set visible( b : Boolean ) : void;

		/**
		 * @see http://help.adobe.com/en_US/AS3LCR/Flash_10.0/flash/display/DisplayObject.html#width flash.display.DisplayObject.width
		 */
		function get width() : Number;
		function set width( w : Number ) : void;
		
		/**
		 * @see http://help.adobe.com/en_US/AS3LCR/Flash_10.0/flash/display/DisplayObject.html#x flash.display.DisplayObject.x
		 */
		function get x() : Number;
		function set x( x : Number ) : void;
		
		/**
		 * @see http://help.adobe.com/en_US/AS3LCR/Flash_10.0/flash/display/DisplayObject.html#y flash.display.DisplayObject.y
		 */
		function get y() : Number;
		function set y( y : Number ) : void;
		
		/**
		 * @see http://help.adobe.com/en_US/AS3LCR/Flash_10.0/flash/display/DisplayObject.html#getBounds() flash.display.DisplayObject.getBounds()
		 */
		function getBounds ( targetCoordinateSpace : DisplayObject ) : Rectangle;
		
		/**
		 * @see http://help.adobe.com/en_US/AS3LCR/Flash_10.0/flash/display/DisplayObject.html#getRect() flash.display.DisplayObject.getRect()
		 */
		function getRect ( targetCoordinateSpace : DisplayObject ) : Rectangle;
		
		/**
		 * @see http://help.adobe.com/en_US/AS3LCR/Flash_10.0/flash/display/DisplayObject.html#globalToLocal() flash.display.DisplayObject.globalToLocal()
		 */
		function globalToLocal ( point : Point ) : Point;

		/**
		 * @see http://help.adobe.com/en_US/AS3LCR/Flash_10.0/flash/display/DisplayObject.html#hitTestObject() flash.display.DisplayObject.hitTestObject()
		 */
		function hitTestObject ( o : DisplayObject ) : Boolean;
		
		/**
		 * @see http://help.adobe.com/en_US/AS3LCR/Flash_10.0/flash/display/DisplayObject.html#hitTestPoint() flash.display.DisplayObject.hitTestPoint()
		 */
		function hitTestPoint ( x : Number , y : Number , shapeFlag : Boolean = false ) : Boolean;

		/**
		 * @see http://help.adobe.com/en_US/AS3LCR/Flash_10.0/flash/display/DisplayObject.html#localToGlobal() flash.display.DisplayObject.localToGlobal()
		 */
		function localToGlobal ( point : Point ) : Point;
	}
}
