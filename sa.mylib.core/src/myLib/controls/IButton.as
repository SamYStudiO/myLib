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
package myLib.controls 
{
	import flash.display.Sprite;
	/**
	 * @author SamYStudiO ( contact@samystudio.net )
	 */
	public interface IButton extends ILabel
	{
		/**
		 * Get or set a Boolean that indicates if a drag out action from Button keep over state or change to out state.
		 * 
		 * @default false
		 */
		function get disabledDragOutState() : Boolean;
		function set disabledDragOutState( b : Boolean ) : void;
		
		/**
		 * Get or set a Boolean that indicates if a drag over action from Button act as an over state or not.
		 * 
		 * @default true
		 */
		function get disabledDragOverState() : Boolean;
		function set disabledDragOverState( b : Boolean ) : void;
		
		/**
		 * Get or set a Boolean that indicates if Button accept selected states.
		 * 
		 * @default false
		 */
		function get selectable() : Boolean;
		function set selectable( b : Boolean ) : void;
		
		/**
		 * Get or set the data associate with this Button. data is useful for grouped Button or to merge data to a list cell.
		 */
		function get data() : *;
		function set data( data : * ) : void;
		
		/**
		 * Get or set the group associate with this Button. Only one Button from a group can be selected. Selected a Button from a group will unselect the old one.
		 * 
		 * @see ButtonGroup
		 * @see ButtonGroupManager
		 */
		function get groupOwner() : String;
		function set groupOwner( groupName : String ) : void;
		
		/**
		 * Get or set a Boolean that indicates if Button is selected. This has no effect if selectable property is false.
		 * 
		 * @default false
		 */
		function get selected() : Boolean;
		function set selected( b : Boolean ) : void;
		
		/**
		 * Get or set the text color when mouse is over Button.
		 * 
		 * @default -1
		 */
		function get overTextColor() : int;
		function set overTextColor( n : int ) : void;
		
		/**
		 * Get or set the text color when mouse is down.
		 * 
		 * @default -1
		 */
		function get downTextColor() : int;
		function set downTextColor( n : int ) : void;
		
		/**
		 * Get or set the text color when Button is disabled.
		 * 
		 * @default 0xCCCCCC
		 */
		function get disabledTextColor() : int;
		function set disabledTextColor( n : int ) : void;
		
		/**
		 * Get or set the text color when button is selected.
		 * 
		 * @default -1
		 */
		function get selectedTextColor() : int;
		function set selectedTextColor( n : int ) : void;
		
		/**
		 * Get or set the text color when mouse is over and Button is selected.
		 * 
		 * @default -1
		 */
		function get overSelectedTextColor() : int;
		function set overSelectedTextColor( n : int ) : void;
		
		/**
		 * Get or set the text color when mouse is down and Button is selected.
		 * 
		 * @default -1
		 */
		function get downSelectedTextColor() : int;
		function set downSelectedTextColor( n : int ) : void;
		
		/**
		 * Get or set the text color when Button is disabled and selected.
		 * 
		 * @default -1
		 */
		function get disabledSelectedTextColor() : int;
		function set disabledSelectedTextColor( n : int ) : void;
		
		/**
		 * Get or set the icon up state string definition, BitmapData object or external URL.
		 */
		function get iconUp() : *;
		function set iconUp( icon : * ) : void;
		
		/**
		 * Get or set the icon up selected state string definition, BitmapData object or external URL.
		 */
		function get iconUpSelected() : *;
		function set iconUpSelected( icon : * ) : void;
		
		/**
		 * Get or set the icon over state string definition, BitmapData object or external URL.
		 */
		function get iconOver() : *;
		function set iconOver( icon : * ) : void;
		
		/**
		 * Get or set the icon over selected state string definition, BitmapData object or external URL.
		 */
		function get iconOverSelected() : *;
		function set iconOverSelected( icon : * ) : void;
		
		/**
		 * Get or set the icon down state string definition, BitmapData object or external URL.
		 */
		function get iconDown() : *;
		function set iconDown( icon : * ) : void;
		
		/**
		 * Get or set the icon over state string definition, BitmapData object or external URL.
		 */
		function get iconDownSelected() : *;
		function set iconDownSelected( icon : * ) : void;
		
		/**
		 * Get or set the icon disabled state string definition, BitmapData object or external URL.
		 */
		function get iconDisabled() : *;
		function set iconDisabled( icon : * ) : void;
		
		/**
		 * Get or set the icon disabled selected state string definition, BitmapData object or external URL.
		 */
		function get iconDisabledSelected() : *;
		function set iconDisabledSelected( icon : * ) : void;
		
		/**
		 * Get or set a Boolan that indicates if ButtonEvent.REPEAT_MOUSE_DOWN event is active and so repeat while mouse id down.
		 * 
		 * @default false
		 * @see myLib.events.ButtonEvent#REPEAT_MOUSE_DOWN
		 */
		function get autoRepeat() : Boolean;
		function set autoRepeat( b : Boolean ) : void;
		
		/**
		 * Get or set a delay before first autoReapeat is dispatched.
		 * 
		 * @default 0
		 * @see #autoRepeat
		 */
		function get autoRepeatDelay() : uint;
		function set autoRepeatDelay( n : uint ) : void;
		
		/**
		 * Get or set interval between each events when autoReapeat is active. If 0 interval is framerate.
		 * 
		 * @default 0
		 * @see #autoRepeat
		 */
		function get autoRepeatInterval() : uint;
		function set autoRepeatInterval( n : uint ) : void;
		
		/**
		 * Get or set the Button current state as defined in ButtonStates constants.
		 * 
		 * @see ButtonStates
		 */
		function get currentState() : String;
		function set currentState( state : String ) : void;
		
		/**
         * Get background asset container.
         */
        function get backgroundAssetContainer() : Sprite;
		
		/**
         * Get icon asset container.
         */
        function get iconAssetContainer() : Sprite;
		
		/**
		 * Get the ButtonGroup instance when a group owner is defined.
		 */
		function getGroup ( ) : ButtonGroup;
	}
}
