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
package myLib.assets 
{
	import myLib.display.IFocusable;
	import myLib.display.ISprite;

	import flash.display.DisplayObjectContainer;
	/**
	 * IAsset must be implemented by all components children assets.
	 * 
	 * @author SamYStudiO ( contact@samystudio.net )
	 */
	public interface IAsset extends ISprite , IFocusable
	{
		/**
		 * Indicates if component is enabled and user may interact with it.
		 */
		function get enabled() : Boolean;
		function set enabled( b : Boolean ) : void;
		
		/**
		 * @private
		 */
		function get owner() : IAsset;
		function set owner( owner : IAsset ) : void;
		
		/**
		 * Move asset to the specified x and y position according alignmentPoint and targetCoordinateSpace.
		 * By default asset is moved with top left alignment point and parent coordinate space.
		 * You can use alignmentPoint and targetCoordinateSpace arguments for advanced layout.
		 * 
		 * @param x	the x coordinate in pixel.
		 * @param y	the y corrdinate in pixel.
		 * @param alignmentPoint A alignment point as defined in AlignmentPoint constants that defined the refered point where move asset.
		 * @param targetCoordinateSpace	The coordinate space to used. By default coordinates are affected within asset parent DisplayObjectContainer. Use this argument to move asset as it would be within the specific target.
		 * 
		 * @see myLib.displayUtils.AlignmentPoint
		 */
		function move( x : Number , y : Number , alignmentPoint : String = "TL" , targetCoordinateSpace : DisplayObjectContainer = null ) : void;
		
		/**
		 * Set asset width and height.
		 * 
		 * @param w	asset width in pixels.
		 * @param h	asset height in pixels.
		 * 
		 * @see #width
		 * @see #height
		 */
		function setSize( w : Number , h : Number ) : void;
		
		/**
		 * Draw is called after a resize or component invalidation to layout asset.
		 * If you have any layout problems with assets/components you should try to call draw() or validate().
		 * 
		 * @see myLib.core.Invalidation
		 * @see myLib.core.AComponent#validate()
		 */
		function draw() : void;
	}
}
