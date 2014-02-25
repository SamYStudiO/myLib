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
	import myLib.assets.IAsset;	import myLib.styles.Padding;	
	/**
	 * @author SamYStudiO
	 */
	public interface IComponent extends IAsset 
	{
		/**
		 * Get or set x coordinate using stage coordinate space insteadof component parents.
		 */
		function get stageX() : Number;
		function set stageX( x : Number ) : void;
		
		/**
		 * Get or set y coordinate using stage coordinate space insteadof component parents.
		 */
		function get stageY() : Number;
		function set stageY( y : Number ) : void;
		
		/**
		 * Get or set component alignment point as defined in AlignmentPoint constants.
		 * Changing alignement point move component to reflect current coordinate with the specified alignment point.
		 * 
		 * @see myLib.displayUtils.AlignmentPoint
		 */	
		function get alignmentPoint() : String;
		function set alignmentPoint( alignmentPoint : String ) : void;
		
		/**
		 * Get or set component minimum width.
		 */
		function get minWidth() : Number;
		function set minWidth( mw : Number ) : void;
		
		/**
		 * Get or set component maximum width.
		 */	 
		function get maxWidth() : Number;
		function set maxWidth( mw : Number ) : void;
		
		/**
		 * Get or set component minimum height.
		 */	 
		function get minHeight() : Number;
		function set minHeight( mh : Number ) : void;
		
		/**
		 * Get or set component maximum height.
		 */	 
		function get maxHeight() : Number;
		function set maxHeight( mh : Number ) : void;
		
		/**
		 * Get or set the focus rectangle Padding object for its drawing.
		 */
		function get focusRectPadding() : Padding;
		function set focusRectPadding( padding : Padding ) : void;
		
		/**
		 * Get or set focus rectangle depth.
		 * 
		 * @default 0
		 */	
		function get focusRectDepth() : int;
		function set focusRectDepth( n : int ) : void;
		
		/**
		 * Get IAsset use to render focus rectangle.
		 */	
		function get focusRectAsset() : IAsset;
		
		/**
		 * Invalidate component so all invalidation type specified will be validate on next stage render.
		 * 
		 * @param types The invalidation types to invalidate as defined in InvalidationType constants and separate with "|".
		 * @see myLib.core.InvalidationType
		 */
		function invalidate( types : uint = 7 ) : void;
		
		/**
		 * Immediatly validate component with the specified types.
		 * 
		 * @param types The invalidation types to invalidate as defined in InvalidationType constants and separate with "|".
		 * @see myLib.core.InvalidationType
		 */
		function validate( types : uint = 7 ) : void;
		
		/**
		 * Check if one of the specified invalidation types are currently invalidate and need to be validate on next stage render.
		 * @param types The invalidation types to invalidate as defined in InvalidationType constants to check. If no arguments are specified this will return true if any invalidation type is active.
		 * @return A Boolean that indicates if at least one of the specified invalidation types are invalidate.
		 * @see myLib.core.InvalidationType
		 */	
		function isInvalidate( ...types : Array ) : Boolean;
		
		/**
		 * Apply a style Object to this component.
		 * @see myLib.styles.StyleManager
		 */	
		function setStyle( style : Object ) : void;
		
		/**
		 * Get last style Object applied to this component.
		 * @return The last style Object applied to this component.
		 */
		function getStyle(  ) : Object;
	}
}
